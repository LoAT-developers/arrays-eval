<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
    <title>Accelerating Loops with Arrays</title>
    <style>
      table, th, td {border: 1px solid black;}
      td {text-align: center;}
      p {text-align: justify;}
    </style>
  </head>
  <body>

    <p>
      This is the empirical evaluation of the implementation of our techniques from the paper <a href="https://arxiv.org/abs/???"><i>Accelerating Loops with Arrays</i></a> in our tool LoAT.
    </p>

    <h1>Getting LoAT</h1>

    <p>
      We provide a <a href="https://github.com/LoAT-developers/LoAT/releases/tag/ijcar26">pre-compiled binary of LoAT (Linux, 64 bit)</a>.
      Moreover, you can find the source code of LoAT at <a href="https://github.com/loat-developers/LoAT/tree/ijcar26">GitHub</a>.
    </p>
    <p>We refer to the <a href="https://loat-developers.github.io/LoAT/">general LoAT website</a> for further information.</p>

    <h1>Evaluation</h1>

    <h2>Examples</h2>

    <p>
      We used the C programs from the category <tt>ReachSafety-Arrays</tt> from the <a href="https://sv-comp.sosy-lab.org/">Software Verification Competition</a> for our evaluation.
      To this end, we converted them to LoAT's input format (Constrained Horn Clauses, CHCs) using our novel tool <a href="https://github.com/LoAT-developers/HornKlaus">HornKlaus</a>.
      Currently, HornKlaus supports the fragment of C that corresponds to the CHCs supported by LoAT.
      So in particular, it does not support pointers, structs, or bit-wise operations.
      Thus, it can only transform 201 of the 439 SV-COMP benchmarks into CHCs, resulting in our first collection of benchmarks, called <a href="SV.zip">SV</a>.
      However, the majority of these benchmarks is satsifiable, but the main purpose of our approach is proving unsatisfiability.
      To obtain more unsatisfiable instances, we modified HornKlaus so that it negates the assertions that characterize the error states, resulting in our second set of benchmarks, called <a href="SV_neg.zip">SV_neg</a>.
    </p>

    <h2>Tools</h2>

    In our evaluation, we considered the following tools and configurations:
    <ul>
      <li>LoAT's implementation of <i>Accelerated Bounded Model Checking</i>, which uses our novel acceleration technique</li>
      <ul>
        <li><tt>loat-static --mode safety --engine abmc $INPUT</tt></li>
      </ul>
      <li><a href="https://github.com/Z3Prover/z3">Z3</a>'s implementation of <i>Bounded Model Checking</i> (version 4.15.4)</li>
      <ul>
        <li><tt>z3 fp.engine=bmc $INPUT</tt></li>
      </ul>
      <li><a href="https://github.com/usi-verification-and-security/golem">Golem</a>'s implementation of <i>Symbolic Execution</i> (version 0.9.0)</li>
      <ul>
        <li><tt>golem -e se $INPUT</tt></li>
      </ul>
      <li><a href="https://github.com/uuverifiers/eldarica">Eldarica</a>'s default configuration (version 2.2.1)</li>
      <ul>
        <li><tt>eld $INPUT</tt></li>
      </ul>
    </ul>

    <h2>Results</h2>

    <a href="./sv.html">Here</a> you can find a table with the detailed results of our benchmarks on the examples <tt>SV</tt>, and <a href="./sv_neg.html">here</a> you can find a table with the detailed results of our benchmarks on the examples <tt>SV_neg</tt>.
    Unique results (where all but one solver failed) are highlighted in yellow.

    <h1>Running Example from the Paper</h1>

    <p>
      <a href="./leading.smt2">Here</a> you can find a satisfiable version of the running example from our paper, where <tt>i</tt> is initialized with <tt>0</tt> and the following two properties are checked:
      <ul>
        <li><tt>a'[k] = a[0]</tt></li>
        <li><tt>forall 0 <= j < k. a'[j] = a[j+1]</tt></li>
      </ul>
      In the formulas above, <tt>a</tt> refers to the array before execution of the loop, and <tt>a'</tt> refers to the array after execution of the loop.
    </p>

    <p>
      <a href="./leading_unsat1.smt2">Here</a> and <a href="./leading_unsat2.smt2">here</a>, you can find unsatisfiable variants of our running examples, where the first or second of the properties above is negated, respectively.
      LoAT can solve all three variants in less than one second.
    </p>

  </body>
</html>
