#!/usr/bin/env escript

main([File]) ->
    Dir = filename:dirname(File),
    Defs = [
            %strong_validation,
            warn_export_all,
            %warn_export_vars,
            warn_shadow_vars,
            warn_obsolete_guard,
            warn_unused_import,
            report,
            debug_info,
            export_all,
            {i, Dir ++ "/include"},
            {i, Dir ++ "/../include"},
            {i, "include"},
            {outdir, "ebin"}],
    case file:consult("rebar.config") of
        {ok, Terms} ->
            RebarDeps = proplists:get_value(deps_dir, Terms, "deps"),
            code:add_paths(filelib:wildcard(RebarDeps ++ "/*/ebin")),
            RebarOpts = proplists:get_value(erl_opts, Terms, []);
        _ ->
            RebarOpts = []
    end,
    code:add_patha(filename:absname("ebin")),
    compile:file(File, Defs ++ RebarOpts);
main(_) ->
    io:format("Usage: ~s <file>~n", [escript:script_name()]),
    halt(1).
