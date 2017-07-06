<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    exclude-result-prefixes="msxsl"
>

  
  <!--xmlns:ndepend="http://jarchitect.com"-->
 <xsl:param name="ParamBoolApplicationMetrics"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolAssembliesMetrics"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolTreemapMetricView"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolAssembliesAbstractnessVSInstability"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolAssembliesDependencies"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolAssembliesDependencyGraph"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolAssembliesDependencyMatrix"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolBuildOrder"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolAnalysisLog"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolCodeRules"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolCodeQueries"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolTrendCharts"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolTypesMetrics"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolTypesDependencies"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolNamespacesMetrics"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolNamespacesDependencies"><xsl:value-of select="true()"/></xsl:param>

  <xsl:param name="ParamBoolComparisonAvailable"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolCoverageAvailable"><xsl:value-of select="true()"/></xsl:param>

  <xsl:param name="ParamBoolZeroNamespacesMetricsWarning"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolZeroNamespacesDependenciesWarning"><xsl:value-of select="true()"/></xsl:param>

  <xsl:param name="ParamBoolZeroTypesMetricsWarning"><xsl:value-of select="true()"/></xsl:param>
  <xsl:param name="ParamBoolZeroTypesDependenciesWarning"><xsl:value-of select="true()"/></xsl:param>

  <xsl:param name="ParamBoolRecentViolationsOnly"></xsl:param>




  <!--<xsl:output method="html" indent="no" encoding="utf-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" ></xsl:output>-->
  <xsl:output method="html" indent="no" encoding="utf-8"></xsl:output>
  <!--Constants-->
  <!--<xsl:variable name="maxRows" select="5000" />-->

  <!--Image Files-->
  <xsl:variable name="AbstractnessVSInstabilityFile" select="'.\JArchitectReportFiles\AbstractnessVSInstability.png'"/>
  <xsl:variable name="ComponentDependenciesDiagramFile" select="'.\JArchitectReportFiles\ComponentDependenciesDiagram.png'"/>
  <xsl:variable name="ComponentDependenciesMatrixFile" select="'.\JArchitectReportFiles\ComponentDependenciesMatrix.png'"/>
  <xsl:variable name="VisualNDependViewFile" select="'.\JArchitectReportFiles\VisualNDependView.png'"/>


  <xsl:variable name="SampleReportUrl" select="'http://www.jarchitect.com/SampleReports.aspx'"/>

  <xsl:template match="/">
    <!--MOTW should be after doctype-->
    <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">]]></xsl:text>
    <!--<xsl:text><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"></xsl:text>-->
    <xsl:comment> saved from url=(0014)about:internet </xsl:comment>
    <xsl:text>&#x0d;&#x0a;</xsl:text>
    <html lang="en">
      <head>
        <title>JArchitect Report</title>

        <link rel="stylesheet" type="text/css" href="./JArchitectReportFiles/NDependReport.css"/>
        <!--<link rel="stylesheet" type="text/css" href="lib/css/ndepend.css"/>
        <link rel="stylesheet" type="text/css" href="lib/css/superfish.css" />
        <link rel="stylesheet" type="text/css" href="lib/css/demo_page.css" />
        <link rel="stylesheet" type="text/css" href="lib/css/demo_table_jui.css" />
        <link rel="stylesheet" type="text/css" href="lib/css/jquery-ui-1.8.4.custom.css" />
        <link rel="stylesheet" type="text/css" href="lib/css/superfish-vertical.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="lib/css/colorbox.css" />-->

      </head>
      <body>

        <noscript>
          <style type="text/css">
            div.ndependScreen { display: block; }
          </style>
        </noscript>


        <!-- This contains the hidden content for inline calls -->
        <div style='display:none'>

          <div id='inline_DependenciesDiagram' class='inlineHelp'>
            <p>
              <strong>Dependency Graph</strong>
            </p>
            <ul>
              <li>
              This diagram represents the Graph of Dependencies beetween the Java Projects of your application.
              </li><li>
              This static diagram can be useful but it is just a coarse view of your application architecture.
              </li><li>
              It is recommended to use the JArchitect <b>interactive</b> dependency Graph and interactive Dependency Matrix for an in-depth exploration of the actual architecture of your code.<br/>
              </li>
            </ul>
            <p>
              Online documentation:
            </p>
            <ul>
              <li>
                <a href="http://www.jarchitect.com/Doc_VS_Arch.aspx" target="_blank">JArchitect Interactive Dependency Graph</a>
              </li>
              <li>
                <a href="http://www.jarchitect.com/Doc_Matrix.aspx" target="_blank">JArchitect Interactive Dependency Matrix</a>
              </li>
            </ul>
          </div>

          <div id='inline_DependenciesMatrix' class='inlineHelp'>
            <p>
              <strong>Dependency Matrix</strong>
            </p>
            <ul>
              <li>This diagram represents the DSM (Dependency Structure Matrix) beetween the Java Projects of your application.</li>
              <li>The Dependency Matrix is a compact way to represent and navigate across dependencies between components.</li>
              <li>The number on cells of the Dependency Matrix included in the report, represent the number of types involved in the coupling</li>
              <li>It is recommended to use the JArchitect <b>interactive</b> dependency Graph and interactive Dependency Matrix for an in-depth exploration of the actual architecture of your code.</li>
            </ul>
            
            <p>
              Online documentation:
            </p>
            <ul>
              <li>
                <a href="http://www.jarchitect.com/Doc_Matrix.aspx" target="_blank">JArchitect Interactive Dependency Matrix</a>
              </li>
              <li>
                <a href="http://www.jarchitect.com/Doc_VS_Arch.aspx" target="_blank">JArchitect Interactive Dependency Graph</a>
              </li>
            </ul>
          </div>

          <div id='inline_Treemap' class='inlineHelp'>
            <p>
              <strong>Visualizing Code Metrics through Treemaping</strong>
            </p>
            <ul>
              <li>In this Metric View, the code base is represented through a Treemap.</li>
              <li>Treemapping is a method for displaying tree-structured data by using nested rectangles.</li>
              <li>In the present treemap, each rectangle represents a method and the area of a rectangle is proportional to the number of lines of code of the corresponding method.</li>
            </ul>
            <p>
              With the Online documentation, understand how Treemaping can help you see patterns in your code base, that would be hard to spot with other ways. <br/>
            </p>
            <ul>
              <li>
                <a href="http://www.jarchitect.com/Doc_Treemap.aspx" target="_blank">Visualizing Code Metrics with Treemap</a>
              </li>
            </ul>
          </div>

          <div id='inline_AbstractnessVersusInstability' class='inlineHelp'>
            <p>
              <strong>Abstractness versus Instability Diagram</strong>
            </p>
            <p>
              The <i>Abstractness versus Instability Diagram</i> helps to detect which projects are potentially painful to maintain (i.e concrete and stable) and which projects are potentially useless (i.e abstract and instable).
            </p>
            <ul>
              <li>
                <strong>Abstractness</strong>:
                If an project contains many abstract types (i.e interfaces and abstract classes) and few concrete types, it is considered as abstract.<br/>
              </li>
              <li>
                <strong>Stability</strong>:
                An project is considered stable if its types are used by a lot of types of tier projects. In this conditions <i>stable</i> means <i>painful to modify</i>.
              </li>
            </ul>
            <p>
              Online documentation:
            </p>
            <ul>
              <li>
                <a href="http://www.jarchitect.com/Metrics.aspx#MetricsOnAssemblies" target="_blank">Definitions of related Code Metrics</a>
              </li>
            </ul>
          </div>
          
          <div id='inline_ForBeginnersMain' class='inlineHelp'>
            <p>
              <strong>For beginners: Where to start</strong>
            </p>
            <ul>
              <li>
                Search for unwanted dependencies.
              </li>
              <li>
                Look for complex methods listed through the standard Rule <b>Quick Summary of methods to refactor</b>.
              </li>
              <li>
                Inspect other standard Rules that were violated.
              </li>
              <li>
                See how standard Rules are written and customize some Rules to your needs.
              </li>
              <li>
                Look at <a href="http://www.jarchitect.com/Metrics.aspx" target="_blank">Code Metrics definitions</a> to see how Code Metrics can help increase code quality.
              </li>
              <li>
                Use the <a href="http://www.jarchitect.com/Doc_VS_Diff.aspx" target="_blank">Code Diff feature</a> to review code changes (pro edition only).
              </li>
              <li>
                <a href="http://www.jarchitect.com/Coverage.aspx" target="_blank">Import test coverage data</a> to assess possible improvements in your testing strategy (pro edition only).
              </li>
            </ul>
          </div>
          

          <div id='inline_TruncatedQueryResult' class='inlineHelp'>
            <p>
              <strong>Code queries and rules results are truncated to list a maximum of 100 code elements in this report</strong>
            </p>
            <ul>
              <li>
                It is recommended to use the JArchitect interactive UI capabilities to browse a large list of code elements matched.
              </li>
              <li>
                To enable or disable this setting, there is a tickbox labelled <i>Don't show more than 100 matched items for a Rule violated</i>
                in the <i>JArchitect Project Properties panel &gt; Report tab &gt; Avoid too big report for large code base section</i>
              </li>
              <li>
                This setting is enabled by default to avoid to have too large reports when analyzing large code bases.
              </li>
            </ul>
          </div>
          
          <div id='inline_NONTruncatedQueryResult' class='inlineHelp'>
            <p>
              <strong>Does this report gets too large?</strong>
            </p>
            <ul>
              <li>
                There is a setting enabled by default to avoid to have too large reports when analyzing large code bases.
              </li>
              <li>
                To enable or disable this setting, there is a tickbox labelled <i>Don't show more than 100 matched items for a Rule violated</i>
                in the <i>JArchitect Project Properties panel &gt; Report tab &gt; Avoid too big report for large code base section</i>
              </li>
              <li>
                It is recommended to use the JArchitect interactive UI capabilities to browse a large list of code elements matched.
              </li>
            </ul>
          </div>
          
          <div id='inline_RecentViolationsONLY' class='inlineHelp'>
            <p>
              <strong>The list contains only code elements refactored or added since the baseline for comparison.</strong>
            </p>
            <ul>
              <li>
                This is because the setting <b>Recent Violations Only</b> is enabled.
              </li>
              <li>
                This setting reduces the violations set of code rules violated, to match only code elements refactored or added since the <a href="http://www.jarchitect.com/Doc_VS_Diff.aspx#Baseline" target="_blank">baseline for comparison</a>.
              </li>
              <li>
                Typically, when running code rules on an existing code base, thousands of violations are shown.
                It is not practicable to stop the development for days or weeks to fix all violations.
                Focusing on fixing recent violations only, represents a convenient way to prioritize violations, and fix the most relevant ones without stopping the development.
              </li>
              <li>
                To enable or disable the setting <b>Recent Violations Only</b> there is a tick box labelled <i>Recent Violations Only</i> on the <i>JArchitect Dashboard panel &gt; Code Rules</i>
              </li>
            </ul>
          </div>

          <div id='inline_RecentViolationsOnlyONHelp' class='inlineHelp'>
            <p>
              <strong>The setting Recent Violations Only is enabled</strong>
            </p>
            <ul>
              <li>
                This setting reduces the violations set of code rules violated, to match only code elements refactored or added since the <a href="http://www.jarchitect.com/Doc_VS_Diff.aspx#Baseline" target="_blank">baseline for comparison</a>.
              </li>
              <li>
                Typically, when running code rules on an existing code base, thousands of violations are shown.
                It is not practicable to stop the development for days or weeks to fix all violations.
                Focusing on fixing recent violations only, represents a convenient way to prioritize violations, and fix the most relevant ones without stopping the development.
              </li>
              <li>
                To disable the setting <b>Recent Violations Only</b> there is a tick box labelled <i>Recent Violations Only</i> on the <i>JArchitect Dashboard panel &gt; Code Rules</i>
              </li>
            </ul>
          </div>

          <div id='inline_RecentViolationsOnlyOFFHelp' class='inlineHelp'>
            <p>
              <strong>Why should I enable the setting Recent Violations Only ?</strong>
            </p>
            <ul>
              <li>
                The setting <b>Recent Violations Only</b> reduces the violations set of code rules violated, to match only code elements refactored or added since the <a href="http://www.jarchitect.com/Doc_VS_Diff.aspx#Baseline" target="_blank">baseline for comparison</a>.
              </li>
              <li>
                Typically, when running code rules on an existing code base, thousands of violations are shown.
                It is not practicable to stop the development for days or weeks to fix all violations.
                Focusing on fixing recent violations only, represents a convenient way to prioritize violations, and fix the most relevant ones without stopping the development.
              </li>
              <li>
                To enable the setting <b>Recent Violations Only</b> there is a tick box labelled <i>Recent Violations Only</i> on the <i>JArchitect Dashboard panel &gt; Code Rules</i>
              </li>
            </ul>
          </div>

          <div id='inline_QuickTipsMain' class='inlineHelp'>
            <p>
              <strong>Quick Tips</strong>
            </p>
            <ul>
              <li>
                In addition to the JArchitect report, use the <b>interactive UI</b> through the standalone executable <b>VisualJArchitect.exe</b>.
              </li>
              <li>
                With the interactive UI, browse more detailed data and have Rules checking updated each time the code is modified and recompiled.
              </li>
              <li>
                The analysis execution and the report options are configurable through the interactive UI, in the panel <b>Project Properties</b>.
              </li>
              <li>
                Plain HTML report (single HTML page, no javascript, no menu) is also available.
              </li>
              <li>
                Full JArchitect documentation is available on the <a href="http://www.jarchitect.com/Coverage.aspx" target="_blank">JArchitect website</a> under the <b>Documentation menu</b>.
              </li>
            </ul>
          </div>
       </div>


        <div id="divNavBars">
          <xsl:apply-templates select="./NDepend" mode="navbar"/>
        </div>


        <div id="header-wrap">


          <div id="header-container">

            <div id="header">
              <xsl:apply-templates select="./NDepend" mode="menu"/>
            </div>
          </div>
        </div>

        <div id="container">

          <noscript>
            <div class="ndependScreen warning" id="jscriptWarning2">
              WARNING: JavaScript is currently disabled in your browser. All the data will still be displayed, as single page, but several functionalities will be missing (Grid search, etc.).
            </div>
          </noscript>

          <div id="content">

            <div class="ndependScreen" id="Main">

              <xsl:apply-templates select="./NDepend/ReportInfo"/>

              <xsl:if test="$ParamBoolAssembliesDependencyGraph or $ParamBoolAssembliesDependencyMatrix or $ParamBoolTreemapMetricView or $ParamBoolAssembliesAbstractnessVSInstability">

                <div id="Diagrams" class="diagrams">
                  <h4>Diagrams</h4>
                  
                  <xsl:if test="$ParamBoolAssembliesDependencyGraph">
                    <div class="diagramCell">
                      <a href="{$ComponentDependenciesDiagramFile}" target="_blank" class="diagramImage cboxElement" title="Java Projects Dependency Graph">
                        <img src="{$ComponentDependenciesDiagramFile}" alt="Java Projects Dependency Graph" title="Java Projects Dependency Graph" height="152" width="223"/>
					            </a>
                      <div class="diagramTitle">Dependency Graph</div>
                      <div class='diagramButtons'>
                        View as
                        <a id="DependenciesDiagramHelp" href="#" class="help cboxElement">?</a>
                        <a href="{$ComponentDependenciesDiagramFile}" target="_blank" class='fullImage' title="Component Dependency Graph">full</a>
                        <a href="{$ComponentDependenciesDiagramFile}" target="_blank" class="diagramImage cboxElement" title="Java Projects Dependency Graph">scaled</a>
                      </div>
                    </div>
                  </xsl:if>

                  <xsl:if test="$ParamBoolAssembliesDependencyMatrix">
                    <div class="diagramCell">
                      <a href="{$ComponentDependenciesMatrixFile}" target="_blank" class="diagramImage cboxElement" title="Java Projects Dependency Matrix">
                        <img src="{$ComponentDependenciesMatrixFile}" alt="Java Projects Dependency Matrix" title="Java Projects Dependency Matrix" height="152" width="223"/>
					            </a>
                      <div class="diagramTitle">Dependency Matrix</div>
                      <div class='diagramButtons'>
                        View as
                        <a id="DependenciesMatrixHelp" href="#" class="help cboxElement">?</a>
                        <a href="{$ComponentDependenciesMatrixFile}" target="_blank" class='fullImage' title="Component Dependency Graph">full</a>
                        <a href="{$ComponentDependenciesMatrixFile}" target="_blank" class="diagramImage cboxElement" title="Java Projects Dependency Matrix">scaled</a>
                      </div>
                    </div>
                  </xsl:if>

                  <xsl:if test="$ParamBoolTreemapMetricView">
                    <div class="diagramCell">
                      <a href="{$VisualNDependViewFile}" target="_blank" class="diagramImage cboxElement" title="Treemap View">
                        <img src="{$VisualNDependViewFile}" alt="Treemap View" title="Treemap View" height="152" width="223"/>
					            </a>
                      <div class="diagramTitle">Treemap Metric View</div>
                      <div class='diagramButtons'>
                        View as
                        <a id="TreemapHelp" href="#" class="help cboxElement">?</a>
                        <a href="{$VisualNDependViewFile}" target="_blank" class='fullImage' title="Treemap View">full</a>
                        <a href="{$VisualNDependViewFile}" target="_blank" class="diagramImage cboxElement" title="Treemap View">scaled</a>
                      </div>
                    </div>
                  </xsl:if>

                  <xsl:if test="$ParamBoolAssembliesAbstractnessVSInstability">
                    <div class="diagramCell last">
                      <a href="{$AbstractnessVSInstabilityFile}" target="_blank" class="diagramImage cboxElement" title="Abstractness versus Instability">
                        <img src="{$AbstractnessVSInstabilityFile}" alt="Abstractness versus Instability" title="Abstractness versus Instability" height="152" width="223"/>
					            </a>
                      <div class="diagramTitle">Abstractness vs. Instability</div>
                      <div class='diagramButtons'>
                        View as
                        <a id="AbstractnessVersusInstabilityHelp" href="#" class="help cboxElement">?</a>
                        <a href="{$AbstractnessVSInstabilityFile}" target="_blank" class='fullImage' title="Abstractness versus Instability">full</a>
                        <a href="{$AbstractnessVSInstabilityFile}" target="_blank" class="diagramImage cboxElement" title="Abstractness versus Instability">scaled</a>
                      </div>
                    </div>
                  </xsl:if>
                </div>
                <div class='separatorLine'></div>
              </xsl:if>

              
              
              

              <!--Display metrics summary-->
              <xsl:if test="$ParamBoolApplicationMetrics">
                <xsl:apply-templates select="./NDepend/Dashboard" mode="metrics"/>
                <xsl:apply-templates select="./NDepend/ApplicationMetrics" mode="metrics"/>
              </xsl:if>

              <!--Display rules summary-->
              <xsl:if test="$ParamBoolCodeRules">
                <xsl:apply-templates select="./NDepend/RuleResult" mode="summary"/>
              </xsl:if>

              <!--<h4> DEBUG Info </h4>
                <ul>
                  <li>
                    ParamBoolApplicationMetrics:

                    <xsl:value-of select="$ParamBoolApplicationMetrics"/>
                  </li>
                  <li>
                    ParamBoolAssembliesMetrics: <xsl:value-of select="$ParamBoolAssembliesMetrics"/>
                  </li>
                  <li>
                    ParamBoolTreemapMetricView: <xsl:value-of select="$ParamBoolTreemapMetricView"/>
                  </li>
                  <li>
                    ParamBoolAssembliesAbstractnessVSInstability: <xsl:value-of select="$ParamBoolAssembliesAbstractnessVSInstability"/>
                  </li>
                  <li>
                    ParamBoolAssembliesDependencies: <xsl:value-of select="$ParamBoolAssembliesDependencies"/>
                  </li>
                  <li>
                    ParamBoolAssembliesDependencyGraph: <xsl:value-of select="$ParamBoolAssembliesDependencyGraph"/>
                  </li>
                  <li>
                    ParamBoolAssembliesDependencyMatrix: <xsl:value-of select="$ParamBoolAssembliesDependencyMatrix"/>
                  </li>
                  <li>
                    ParamBoolBuildOrder: <xsl:value-of select="$ParamBoolBuildOrder"/>
                  </li>
                  <li>
                    ParamBoolAnalysisLog: <xsl:value-of select="$ParamBoolAnalysisLog"/>
                  </li>
                  <li>
                    ParamBoolCodeRules: <xsl:value-of select="$ParamBoolCodeRules"/>
                  </li>
                  <li>
                    ParamBoolCodeQueries: <xsl:value-of select="$ParamBoolCodeQueries"/>
                  </li>
                  <li>
                    ParamBoolTypesMetrics: <xsl:value-of select="$ParamBoolTypesMetrics"/>
                  </li>
                  <li>
                    ParamBoolTypesDependencies: <xsl:value-of select="$ParamBoolTypesDependencies"/>
                  </li>
                  <li>
                    ParamBoolNamespacesMetrics: <xsl:value-of select="$ParamBoolNamespacesMetrics"/>
                  </li>
                  <li>
                    ParamBoolNamespacesDependencies: <xsl:value-of select="$ParamBoolNamespacesDependencies"/>
                  </li>
                </ul>-->
              <!--

              </div>-->

            </div>

            <!--Generates screens depending on the users parameters as set in the JArchitect project-->

            <xsl:if test="$ParamBoolApplicationMetrics">
              <xsl:apply-templates select="./NDepend/ApplicationMetrics" mode="stats"/>
            </xsl:if>
            <xsl:if test="$ParamBoolAssembliesMetrics">
              <xsl:apply-templates select="./NDepend/AssembliesMetrics" mode="facts"/>
            </xsl:if>
            <xsl:if test="$ParamBoolTypesMetrics">
              <xsl:apply-templates select="./NDepend/TypesMetrics" mode="facts"/>
            </xsl:if>
            <xsl:if test="$ParamBoolNamespacesMetrics">
              <xsl:apply-templates select="./NDepend/NamespacesMetrics" mode="facts"/>
            </xsl:if>
            <xsl:if test="$ParamBoolCodeRules">
              <xsl:apply-templates select="./NDepend/RuleResult" mode="body"/>
            </xsl:if>
            <xsl:if test="$ParamBoolCodeQueries">
              <xsl:apply-templates select="./NDepend/QueryResult" mode="body"/>
            </xsl:if>
            <xsl:if test="$ParamBoolTrendCharts">
              <xsl:apply-templates select="./NDepend/TrendCharts" mode="body"/>
            </xsl:if>
            <xsl:if test="$ParamBoolAssembliesDependencies">
              <xsl:apply-templates select="./NDepend/AssemblyDependencies"/>
            </xsl:if>
            <xsl:if test="$ParamBoolTypesDependencies">
              <xsl:apply-templates select="./NDepend/TypeReferencement"/>
            </xsl:if>
            <xsl:if test="$ParamBoolNamespacesDependencies">
              <xsl:apply-templates select="./NDepend/NamespaceDependencies"/>
            </xsl:if>
            <xsl:if test="$ParamBoolBuildOrder">
              <xsl:choose>
                <xsl:when test="not(./NDepend/AssemblySortForCompilOrObfusk)">
                  <div class="ndependScreen" id="AssembliesBuildOrder">
                    <div class="info">
                      <h4>Projects Build Order</h4>
                      <div class="explanations if-js-on">
          Some dependency cycles exist between Java Projects of your application.<br/>
          Dependency cycles between Java Projects is a major code smell and it is recommended to refactor the code to avoid cycles.<br/>
          Also, dependency cycles between Java Projects prevent from finding a build order between Java Projects
                      </div>
                    </div>
                  </div>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="./NDepend/AssemblySortForCompilOrObfusk" mode="order"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
            <xsl:if test="$ParamBoolAnalysisLog">
              <xsl:apply-templates select="./NDepend/InfoWarnings"/>
            </xsl:if>
          </div>
        </div>

        <script type="text/javascript" src="./JArchitectReportFiles/NDependReport.js"></script>

        <!--<script type="text/javascript" src="lib/js/jquery.js"></script>-->
        <!--<script type="text/javascript" src="lib/js/hoverIntent.js"></script>-->
        <!--<script type="text/javascript" src="lib/js/superfish.js"></script>-->
        <!--<script type="text/javascript" src="lib/js/supersubs.js"></script>-->
        <!--<script type="text/javascript" src="lib/js/supposition.js"></script>-->
        <!--<script type="text/javascript" src="lib/js/jquery.dataTables.js"></script>-->
        <!--<script type="text/javascript" src="lib/js/jquery.address.github.js?strict=true"></script>-->
        <!--<script type="text/javascript" src="lib/js/jquery.scrollTo-1.4.2-min.js"></script>-->
        <!--<script type="text/javascript" src="lib/js/jquery-ui-1.8.4.custom.min.js"></script>-->
        <!--<script type="text/javascript" src="lib/js/jquery.colorbox.js"></script>-->
        <!--<script type="text/javascript" src="lib/js/ndepend.js"></script>-->
      </body>
    </html>
  </xsl:template>

  
  
  
  
  
  <!--**************************************************************************************
      ***********                           NAVBARS                            *************
      **************************************************************************************-->
  <xsl:template match="NDepend" mode="navbar">

    <xsl:variable name="mainPath">
      <a rel="address:/" href="#Main">
        Main
      </a>
    </xsl:variable>

    <xsl:variable name="rulesPath">
      <xsl:copy-of select="$mainPath"/> \ Rules
    </xsl:variable>

    <xsl:variable name="queriesPath">
      <xsl:copy-of select="$mainPath"/> \ Group of Queries
    </xsl:variable>

    <xsl:variable name="miscPath">
      <xsl:copy-of select="$mainPath"/> \ Misc
    </xsl:variable>

    <xsl:variable name="metricsPath">
      <xsl:copy-of select="$mainPath"/> \ Metrics
    </xsl:variable>

    <div class="ndependNavbar" id="ndependNavbar-Main">
      <xsl:copy-of select="$mainPath"/>
    </div>

    <div class="ndependNavbar" id="ndependNavbar-Rules">
      <xsl:copy-of select="$rulesPath"/>
    </div>

    <xsl:apply-templates select="./RuleResult/Group[descendant::Query/@Status!='Ok']" mode="navbar">
      <xsl:with-param name="path" select="$rulesPath"/>
    </xsl:apply-templates>

    <xsl:apply-templates select="./QueryResult/Group" mode="navbarQuery">
      <xsl:with-param name="path" select="$queriesPath"/>
    </xsl:apply-templates>


    
    <div class="ndependNavbar" id="ndependNavbar-ApplicationMetrics">
      <xsl:copy-of select="$metricsPath"/> \
      <a rel="address:/?screen=ApplicationMetrics" href="#ApplicationMetrics">
        Application Statistics
      </a>
    </div>

    <div class="ndependNavbar" id="ndependNavbar-AssembliesMetrics">
      <xsl:copy-of select="$metricsPath"/> \
      <a rel="address:/?screen=AssembliesMetrics" href="#AssembliesMetrics">
        Projects Metrics
      </a>
    </div>

    <div class="ndependNavbar" id="ndependNavbar-NamespacesMetrics">
      <xsl:copy-of select="$metricsPath"/> \
      <a rel="address:/?screen=NamespacesMetrics" href="#NamespacesMetrics">
        Packages Metrics
      </a>
    </div>

    <div class="ndependNavbar" id="ndependNavbar-TypesMetrics">
      <xsl:copy-of select="$metricsPath"/> \
      <a rel="address:/?screen=TypesMetrics" href="#TypesMetrics">
        Types Metrics
      </a>
    </div>

    <xsl:variable name="dependenciesPath">
      <xsl:copy-of select="$mainPath"/> \ Dependencies
    </xsl:variable>

    <div class="ndependNavbar" id="ndependNavbar-AssembliesDependencies">
      <xsl:copy-of select="$mainPath"/> \
      <a rel="address:/?screen=AssembliesDependencies" href="#AssembliesDependencies">
        Projects Dependencies
      </a>
    </div>

    <div class="ndependNavbar" id="ndependNavbar-NamespacesDependencies">
      <xsl:copy-of select="$mainPath"/> \
      <a rel="address:/?screen=NamespacesDependencies" href="#NamespacesDependencies">
        Packages Dependencies
      </a>
    </div>

    <div class="ndependNavbar" id="ndependNavbar-TypesDependencies">
      <xsl:copy-of select="$mainPath"/> \
      <a rel="address:/?screen=TypesDependencies" href="#TypesDependencies">
        Types Dependencies
      </a>
    </div>

    <div class="ndependNavbar" id="ndependNavbar-AssembliesBuildOrder">
      <xsl:copy-of select="$mainPath"/> \
      <a rel="address:/?screen=AssembliesBuildOrder" href="#AssembliesBuildOrder">
        Build Order
      </a>
    </div>

    <div class="ndependNavbar" id="ndependNavbar-InfoWarnings">
      <xsl:copy-of select="$mainPath"/> \
      <a rel="address:/?screen=InfoWarnings" href="#InfoWarnings">
        Analysis Log
      </a>
    </div>
  
    <div class="ndependNavbar" id="ndependNavbar-TrendCharts">
      <xsl:copy-of select="$mainPath"/> \
      <a rel="address:/?screen=TrendCharts" href="#TrendCharts">
        Trend Charts
      </a>
    </div>
  </xsl:template>


  <xsl:template match="Group" mode="navbar">
    <xsl:param name="path"/>

    <xsl:variable name="groupId" select="@GroupId"/>
    <xsl:variable name="groupName" select="@Name"/>
    <xsl:variable name="newPath">

      <xsl:copy-of select="$path"/>
      \
      <a rel="address:/?screen={$groupId}" href="#{$groupId}">
        <xsl:value-of select="@Name"/>
      </a>
    </xsl:variable>

    <div class="ndependNavbar" id="ndependNavbar-{$groupId}">
      <xsl:copy-of select="$newPath"/>
    </div>

    <xsl:apply-templates select="./Group[descendant::Query/@Status!='Ok']" mode="navbar">
      <xsl:with-param name="path" select="$newPath"/>
    </xsl:apply-templates>
  </xsl:template>



  <xsl:template match="Group" mode="navbarQuery">
    <xsl:param name="path"/>

    <xsl:variable name="groupId" select="@GroupId"/>
    <xsl:variable name="groupName" select="@Name"/>
    <xsl:variable name="newPath">
      <xsl:copy-of select="$path"/>
      \
      <a rel="address:/?screen={$groupId}" href="#{$groupId}">
        <xsl:value-of select="@Name"/>
      </a>
    </xsl:variable>

    <div class="ndependNavbar" id="ndependNavbar-{$groupId}">
      <xsl:copy-of select="$newPath"/>
    </div>
  </xsl:template>





  <!--**************************************************************************************
      ***********                           Print Counts                       *************
      **************************************************************************************-->
 
  <xsl:template match="Group" mode="printGroupNameAndCounts">
    <table cellpadding="0" cellspacing="0" >
      <tr>
        <td><xsl:value-of select="@Name"/></td>
        <td><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;</xsl:text></td>
        <span class="okCount"><xsl:apply-templates select="." mode="printOkCount"/></span>
        <span class="warnCount"><xsl:apply-templates select="." mode="printWarnCount"/></span>
        <span class="errorCount"><xsl:apply-templates select="." mode="printErrorCount"/></span>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="Group" mode="printOkCount">
    <xsl:value-of select="@NbQueries - @NbWarns - @NbErrors"/>
  </xsl:template>

  <xsl:template match="Group" mode="printWarnCount">
    <xsl:value-of select="@NbWarns"/>
  </xsl:template>

  <xsl:template match="Group" mode="printErrorCount">
    <xsl:value-of select="@NbErrors"/>
  </xsl:template>


  
  
  
  <!--******************************************************************************************
      ***********                      Print QueriesSet Counts                     *************
      ******************************************************************************************-->

  <xsl:template match="RuleResult" mode="printQueriesSetCounts">
    <span class="okCount"><xsl:apply-templates select="." mode="printQueriesSetOkCount"/></span>
    <span class="warnCount"><xsl:apply-templates select="." mode="printQueriesSetWarnCount"/></span>
    <span class="errorCount"><xsl:apply-templates select="." mode="printQueriesSetErrorCount"/></span>      
  </xsl:template>

  <xsl:template match="RuleResult" mode="printQueriesSetOkCount">
    <xsl:value-of select="@NbQueries - @NbWarns - @NbErrors"/>
  </xsl:template>

  <xsl:template match="RuleResult" mode="printQueriesSetWarnCount">
    <xsl:value-of select="@NbWarns"/>
  </xsl:template>

  <xsl:template match="RuleResult" mode="printQueriesSetErrorCount">
    <xsl:value-of select="@NbErrors"/>
  </xsl:template>





  <!--**************************************************************************************
      ***********                             MENU                             *************
      **************************************************************************************-->
  
  <xsl:template match="NDepend" mode="menu">
		<div id="header">
		<div id='MenuArrow'></div>
		<div id='MenuLabel'>menu</div>
		<div class="menu" id="Menu">
			<ul class="sf-menu sf-vertical sf-js-enabled sf-shadow">
				<li class="current"><a href="#Main" >Main</a></li>

        <xsl:if test="$ParamBoolCodeRules">
          <li>
            <a href="#">
              <table cellpadding="0" cellspacing="4">
                <tr><td>Rules</td></tr>
                <tr><td><xsl:apply-templates select="./RuleResult" mode="printQueriesSetCounts" /></td></tr>
              </table>
            </a>
            <ul>
              <xsl:apply-templates select="./RuleResult/Group[descendant::Query/@Status!='Ok']" mode="menuRule"/>
            </ul>
          </li>
        </xsl:if>

        <xsl:if test="$ParamBoolTrendCharts">
          <li>
            <a  rel="address:/?screen=TrendCharts" href="#TrendCharts">Trend Charts</a>
          </li>
        </xsl:if>

        <xsl:if test="$ParamBoolApplicationMetrics or $ParamBoolAssembliesMetrics or $ParamBoolTypesMetrics">
          <li>
            <a href="#">Metrics</a>
            <ul>
              <xsl:if test="$ParamBoolApplicationMetrics">
                <li>
                  <a rel="address:/?screen=ApplicationMetrics" href="#ApplicationMetrics">Application Statistics</a>
                </li>
              </xsl:if>
              <xsl:if test="$ParamBoolAssembliesMetrics">
                <li>
                  <a rel="address:/?screen=AssembliesMetrics" href="#AssembliesMetrics">Projects Metrics</a>
                </li>
              </xsl:if>
              <xsl:if test="$ParamBoolNamespacesMetrics">
                <li>
                  <a rel="address:/?screen=NamespacesMetrics" href="#NamespacesMetrics">Packages Metrics</a>
                </li>
              </xsl:if>
              <xsl:if test="$ParamBoolTypesMetrics">
                <li>
                  <a rel="address:/?screen=TypesMetrics" href="#TypesMetrics">Types Metrics</a>
                </li>
              </xsl:if>
            </ul>
          </li>
        </xsl:if>

        <xsl:if test="$ParamBoolAssembliesDependencies or $ParamBoolTypesDependencies">
          <li>
            <a href="#">Dependencies</a>
            <ul>
              <xsl:if test="$ParamBoolAssembliesDependencies">
                <li>
                  <a rel="address:/?screen=AssembliesDependencies" href="#AssembliesDependencies">Projects Dependencies</a>
                </li>
              </xsl:if>
              <xsl:if test="$ParamBoolNamespacesDependencies">
                <li>
                  <a rel="address:/?screen=NamespacesDependencies" href="#NamespacesDependencies">Packages Dependencies</a>
                </li>
              </xsl:if>
              <xsl:if test="$ParamBoolTypesDependencies">
                <li>
                  <a rel="address:/?screen=TypesDependencies" href="#TypesDependencies">Types Dependencies</a>
                </li>
              </xsl:if>
            </ul>
          </li>
        </xsl:if>

        <xsl:if test="$ParamBoolCodeQueries">
          <xsl:apply-templates select="./QueryResult/Group" mode="menuQuery"/>
        </xsl:if>

        <xsl:if test="$ParamBoolBuildOrder">
          <li>
            <a  rel="address:/?screen=AssembliesBuildOrder" href="#AssembliesBuildOrder">Build Order</a>
          </li>
        </xsl:if>
        <xsl:if test="$ParamBoolAnalysisLog">
          <li>
            <a  rel="address:/?screen=InfoWarnings" href="#InfoWarnings">Analysis Log</a>
          </li>
        </xsl:if>
      </ul>
    </div></div>
  </xsl:template>

  <xsl:template match="Group" mode="menuRule">
    <li>
      <xsl:variable name="groupId" select="@GroupId"/>
      <a rel="address:/?screen={$groupId}" href="#{$groupId}">
       <xsl:apply-templates select="." mode="printGroupNameAndCounts"/>
      </a>
      <xsl:variable name="groupCount" select="count(./Group[descendant::Query])"/>
      <xsl:if test="$groupCount &gt; 0">
        <ul>
          <xsl:apply-templates select="./Group[descendant::Query]" mode="menuRule"/>
        </ul>
      </xsl:if>
    </li>
  </xsl:template>

  <xsl:template match="Group" mode="menuQuery">
    <li>
      <xsl:variable name="groupId" select="@GroupId"/>
      <a rel="address:/?screen={$groupId}" href="#{$groupId}">
        <xsl:value-of select="@Name"/>
      </a>
    </li>
  </xsl:template>







  <!--**************************************************************************************
      ***********                      Rules summary                           *************
      **************************************************************************************-->

  <xsl:template match="RuleResult" mode="summary">

    <div class="info" id='divRulesSummary'>
      <h4>Rules summary</h4>
      <span class='score'>
        <xsl:apply-templates select="." mode="printQueriesSetCounts"/>
      </span>

      <xsl:variable name="errors" select=".//Query[@Status='Error']"/>
      <xsl:variable name="warns" select=".//Query[@Status='Warn']"/>

      <xsl:variable name="errorCount" select="count($errors)"/>
      <xsl:variable name="warnCount" select="count($warns)"/>
      
      <span class='counthead'>This section lists all Rules violated, and Rules or Queries with Error</span>
      <ul class='countlist'>
        <li>
          Number of Rules or Queries with Error (syntax error, exception thrown, time-out): <span class='count'><xsl:value-of select="$errorCount"/></span>
        </li>
        <li>
          Number of Rules violated: <span class='count'><xsl:value-of select="$warnCount"/></span>
        </li>
      </ul>
      
      <xsl:if test="$errorCount &gt; 0">
        <h4>Summary of Rules or Queries with Error (syntax error, exception thrown, time-out)</h4>
        <div class="divGrid">
          <table class="ndependGrid" cellpadding="0" cellspacing="0" border="0" >
            <thead>
              <tr>
                <th>Name</th>
                <th>Group</th>
              </tr>
            </thead>

            <tbody>
              <xsl:apply-templates select="$errors" mode="summaryError"/>
            </tbody>
          </table>
        </div>
        <br/>
      </xsl:if>

      <xsl:if test="$warnCount &gt; 0">
        <h4>Summary of Rules violated</h4>
        <div class="rules-explanations explanations if-js-on" >
          
          <div>
            <img src="./JArchitectReportFiles/JArchitectLogo.png" alt="graphHelp" title="graphHelp"/>
            <span>
              Rules can be checked live at<br/>
              development-time, from within <br/>
              JArchitect. <a href="http://www.jarchitect.com/Doc_VS_CQL.aspx" target="_blank">Online documentation</a>.
            </span>
          </div>

          <xsl:choose>
            <xsl:when test="$ParamBoolRecentViolationsOnly">
              <div>
                <img src="./JArchitectReportFiles/FilterBlueBig.png" />
                <span>
                  The setting <a id="RecentViolationsOnlyONHelp" href="#" class="cboxElement">Recent Violations Only</a> is<br/>
                  enabled. Only violations on added<br/>
                  or refactored code elements are shown.
                </span>
              </div>
            </xsl:when>
            <xsl:otherwise>
              <div>
                <img src="./JArchitectReportFiles/idea.png" alt="graphHelp" title="graphHelp"/>
                <span>
                  JArchitect rules report too many flaws on<br/>
                  existing code base? Use the option <br/>
                  <a id="RecentViolationsOnlyOFFHelp" href="#" class="cboxElement">Recent Violations Only</a>!
                </span>
              </div>
            </xsl:otherwise>
          </xsl:choose> 
          
          
          <xsl:if test="../RuleCriticalResult">
            <div class='critical'>
              <img src="./JArchitectReportFiles/WarningCritical.png" alt="warningCritical" title="warningCritical"/>
              <span>
                Some Critical Rules are violated. Critical Rules<br/>
                can be used to break the build process if<br/>
                violated. <a href="http://www.jarchitect.com/Doc_CI_CriticalRule.aspx" target="_blank">Online documentation</a>.
              </span>
            </div>
          </xsl:if>
        </div>

    

        <div class="divGrid">
          <table class="ndependGrid unEnhanced" cellpadding="4" cellspacing="0" border="0">
            <thead>
              <tr>
                <th width="55%">
                  Name
                </th>
                <th width="10%">
                  # Matches
                </th>
                <th width="15%">
                  Elements
                </th>
                <th width="30%">
                  Group
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="$warns" mode="summaryWarn"/>
            </tbody>
          </table>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  
    

  <xsl:template match="Query" mode="summaryError">
    <xsl:variable name="groupId" select="../@GroupId"/>
    <xsl:variable name="queryId" select="@QueryId"/>
    <tr class="gD{position() mod 2}">
      <td>
        <img src="JArchitectReportFiles\StatusError.PNG" alt="error" title="error"  style="border:0px" height="16" width="16"/>
        <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
        <a rel="address:/{$queryId}?screen={$groupId}" href="#{$queryId}">
          <xsl:value-of select="@Name"/>
        </a>
      </td>
      <td>
        <xsl:value-of select="../@Name"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="Query" mode="summaryWarn">
    <xsl:variable name="groupId" select="../@GroupId"/>
    <xsl:variable name="queryId" select="@QueryId"/>
    <tr class="gD{position() mod 2}">
      <td>
        <xsl:choose>
          <xsl:when test="//NDepend/RuleCriticalResult/RuleCritical/@QueryId = $queryId">
            <table cellpadding="0px" cellspacing="0px">
              <tr>
                <td>
                  <img src="JArchitectReportFiles\StatusWarningCritical.png" alt="warningCritical" title="warningCritical"  style="border:0px" height="16" width="16"/>
                </td>
                <td>
                  <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
                </td>
                <td>
                  <a rel="address:/{$queryId}?screen={$groupId}" href="#{$queryId}">
                    <b>
                      <xsl:value-of select="@Name"/>
                    </b>
                  </a>
                </td>
              </tr>
            </table>
          </xsl:when>
          <xsl:otherwise>
            <table cellpadding="0px" cellspacing="0px">
              <tr>
                <td>
                  <img src="JArchitectReportFiles\StatusWarning.png" alt="warning" title="warning"  style="border:0px" height="16" width="16"/>
                </td>
                <td>
                  <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
                </td>
                <td>
                  <a rel="address:/{$queryId}?screen={$groupId}" href="#{$queryId}">
                    <xsl:value-of select="@Name"/>
                  </a>
                </td>
              </tr>
            </table>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:value-of select="@NbNodeMatched"/>
      </td>
      <td>
        <xsl:value-of select="@KindOfNode"/>
      </td>
      <td>
        <xsl:value-of select="../@Name"/>
      </td>
    </tr>
  </xsl:template>





  <!--**************************************************************************************
      ***********                      RuleResult                              *************
      **************************************************************************************-->

  <xsl:template match="RuleResult" mode="body">
    <div id="Groups">
      <xsl:apply-templates select="./Group[descendant::Query]" mode="body"/>
    </div>
  </xsl:template>

  <xsl:template match="Group" mode="listWarnQueries">
    <xsl:variable name="queries" select="./Query[@Status='Warn']"/>

    <xsl:if test="count($queries) &gt; 0">
      <ul>
        <xsl:apply-templates select="$queries" mode="queryLi"/>
      </ul>
    </xsl:if>
  </xsl:template>

  <xsl:template match="Group" mode="listErrorQueries">
    <xsl:variable name="queries" select="./Query[@Status='Error']"/>
    <xsl:if test="count($queries) &gt; 0">
      <ul>
        <xsl:apply-templates select="$queries" mode="queryLi"/>
      </ul>
    </xsl:if>
  </xsl:template>

  <xsl:template match="Group" mode="listOkQueries">
    <xsl:variable name="queries" select="./Query[@Status='Ok']"/>

    <xsl:if test="count($queries) &gt; 0">
      <ul>
        <xsl:apply-templates select="$queries" mode="queryLi"/>
      </ul>
    </xsl:if>
  </xsl:template>

  <xsl:template match="Query" mode="queryLi">
    <xsl:variable name="groupId" select="../@GroupId"/>
    <xsl:variable name="queryId" select="@QueryId"/>
    <li>
      <a rel="address:/{$queryId}?screen={$groupId}" href="#{$queryId}">
        <xsl:value-of select="@Name"/>
      </a>
    </li>
  </xsl:template>

  
  <xsl:template match="Group" mode="body">
    <xsl:variable name="groupId" select="@GroupId"/>
    <div class="ndependScreen rules" id="{$groupId}">
      <div class="divGroup">
        <h4>
          <xsl:apply-templates select="." mode="printGroupNameAndCounts"/>
        </h4>
        <table cellpadding="0" cellspacing="0">
          <tr>
            <td>
              <div class="divGroupSummary">
                <ul>
                  <li>
                    <xsl:apply-templates select="." mode="printOkCount"/> validated Rule(s)
                    <xsl:apply-templates select="." mode="listOkQueries"/>
                  </li>
                  <li>
                    <xsl:apply-templates select="." mode="printWarnCount"/> Rule(s) violated
                    <xsl:apply-templates select="." mode="listWarnQueries"/>
                    <br/>
                  </li>
                  <li>
                    <xsl:apply-templates select="." mode="printErrorCount"/> Rules or Queries with Error (syntax error, exception thrown, time-out)
                    <xsl:apply-templates select="." mode="listErrorQueries"/>
                  </li>
                </ul>
              </div>
            </td>
          </tr>
        </table>

        <xsl:apply-templates select="./Query" mode="RuleSection"/>
      </div>
    </div>
    <xsl:apply-templates select="./Group[descendant::Query]" mode="body"/>
  </xsl:template>

  
  <xsl:template match="Query[@Status='Error']" mode="RuleSection">
    <xsl:variable name="queryId" select="@QueryId"/>
    <div class="divCqlResultError" id="{$queryId}">
      <div class="divCqlResultErrorHeader">
        <span class="errorHeaderColor">
          <table cellpadding="0px" cellspacing="0px">
            <tr>
              <td>
                <img src="JArchitectReportFiles\Error.png" alt="error" title="error"  style="border:0px" height="32" width="32"/>
              </td>
              <td>
                <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
              </td>
              <td>
                Query error: <xsl:value-of select="@Name"/>
              </td>
            </tr>
          </table>
        </span>
      </div>
      <div class="divCqlResultErrorBody">
        <div class="divCqlErrorDescription">
          <xsl:value-of select="@ErrorDesc"/>
        </div>
        <h3>Content of the Rule or Query</h3>
        <div class="codequery_code">
          <xsl:value-of select="QueryHtml" disable-output-escaping="yes"/>
        </div>
      </div>
    </div>
  </xsl:template>

  
  <xsl:template match="Query[@Status='Ok']" mode="RuleSection">
  </xsl:template>

  <xsl:template match="Query[@Status='Warn']" mode="RuleSection">
    <xsl:variable name="queryId" select="@QueryId"/>
    <div class="divCqlResultWarn" id="{$queryId}">
      <div class="divCqlResultWarnHeader">
        <span class="warnHeaderColor">
          <xsl:choose>
            <xsl:when test="//NDepend/RuleCriticalResult/RuleCritical/@QueryId = $queryId">
              <table cellpadding="0px" cellspacing="0px">
                <tr>
                  <td>
                    <img src="JArchitectReportFiles\WarningCritical.png" alt="warningCritical" title="warningCritical"  style="border:0px" height="32" width="32"/>
                  </td>
                  <td>
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
                  </td>
                  <td>
                      Critical Rule warning: <xsl:value-of select="@Name"/>
                  </td>
                </tr>
              </table>
            </xsl:when>
            <xsl:otherwise>
              <table cellpadding="0px" cellspacing="0px">
                <tr>
                  <td>
                    <img src="JArchitectReportFiles\Warning.png" alt="warningCritical" title="warningCritical"  style="border:0px" height="32" width="32"/>
                  </td>
                  <td>
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
                  </td>
                  <td>
                    Rule warning: <xsl:value-of select="@Name"/>
                  </td>
                </tr>
              </table>
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </div>
      <div class="divCqlResultWarnBody">
        <xsl:apply-templates select="." mode="QueryBody"/>
      </div>
    </div>
  </xsl:template>





  <!--**************************************************************************************
      ***********                      QueryResult                             *************
      **************************************************************************************-->
  
  <xsl:template match="QueryResult" mode="body">
    <div id="Groups">
      <xsl:apply-templates select="./Group" mode="bodyQuery"/>
    </div>
  </xsl:template>


  <xsl:template match="Group" mode="listQueries">
    <xsl:variable name="queries" select="./Query"/>
    <xsl:if test="count($queries) &gt; 0">
      <ul>
        <xsl:apply-templates select="$queries" mode="queryListItem"/>
      </ul>
    </xsl:if>
  </xsl:template>

  <xsl:template match="Query" mode="queryListItem">
    <xsl:variable name="groupId" select="../@GroupId"/>
    <xsl:variable name="queryId" select="@QueryId"/>
    <li>
      <a rel="address:/GroupOfQueries{$queryId}?screen={$groupId}" href="#{$queryId}">
        <xsl:value-of select="@Name"/>
      </a>
    </li>
  </xsl:template>

  <xsl:template match="Group" mode="bodyQuery">
    <xsl:variable name="groupId" select="@GroupId"/>
    <div class="ndependScreen rules" id="{$groupId}">
      <div class="divGroup">
        <h4>
          <xsl:value-of select="@Name"/>
        </h4>
        <table cellpadding="0" cellspacing="0">
          <tr>
            <td>

              <!-- ********** Special text for group Code Diff ***********-->
              <xsl:if test="@Name = 'Code Diff'">
                <xsl:choose>
                  <xsl:when test="../../ReportInfo/@ComparisonAvailable = 'False'">
                    <div class="restrictions if-js-on" style="display: block; visibility: visible; ">
                      Code Diff section won't display any data because the Baseline for Comparison is not defined.<br/>
                      To define a Baseline for Comparison use the <b>interactive UI</b> through the standalone executable <b>VisualJArchitect.exe</b>, go to:<br />
                      <i>JArchitect Project Properties Panel &gt; Analysis &gt; Baseline for Comparison  &gt; During Analysis</i><br/>
                    </div>
                  </xsl:when>
                  <xsl:otherwise>
                    &#187; Baseline for comparison : <xsl:value-of select="../../ReportInfo/@ComparedWith" />
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>


              <!-- ********** Special text for group Code Coverage ***********-->
              <xsl:if test="@Name = 'Code Coverage'">
                
                <xsl:if test="../../ReportInfo/@CoverageAvailable = 'False'">
                  <div class="restrictions if-js-on" style="display: block; visibility: visible; ">
                    Code Coverage section won't display any data because no Code Coverage file to import is defined.<br/><br/>
                    To define Code Coverage files from the tool Cobertura, read the online documentation <a href="http://www.jarchitect.com/Coverage.aspx" target="_blank">Coverage Data FAQ</a>. <br/><br/>
                    To set Code Coverage files from which, JArchitect imports Code Coverage data at analysis time, use the <b>interactive UI</b> through the standalone executable <b>VisualJArchitect.exe</b>, go to:<br />
                    <i>JArchitect Project Properties Panel &gt; Analysis &gt; Code Coverage</i><br/>
                  </div>
                </xsl:if>
 
              </xsl:if>

            </td>
          </tr>
          <tr>
            <td>
              <div class="divGroupSummary">
                <ul>
                  <xsl:variable name="NbQueriesReported" select="count(./Query)" />
                  <xsl:value-of select="$NbQueriesReported"/> Queries Reported
                  <xsl:apply-templates select="." mode="listQueries"/>
                </ul>
                <br/>
              </div>
            </td>
          </tr>
        </table>

        <xsl:apply-templates select="./Query" mode="QuerySection"/>
      </div>
    </div>
  </xsl:template>




  <xsl:template match="Query" mode="QuerySection">
    <xsl:variable name="queryId" select="@QueryId"/>
    <div class="divCqlResultWarn" id="GroupOfQueries{$queryId}">
      <div class="divCqlResultWarnHeader">
        <span class="queryHeaderColor">
          <xsl:value-of select="@Name"/>
        </span>
      </div>

      <div class="divCqlResultQueryBody">
        <xsl:apply-templates select="." mode="QueryBody"/>
      </div>
    </div>
  </xsl:template>





  <!--******************************************************************************
      *********** Query Body, used both for Rules and Queries Reported *************
      ******************************************************************************-->

  <xsl:template match="Query" mode="QueryBody">
    <xsl:variable name="queryId" select="@QueryId"/>
    
    <!-- Show Code Query code with syntax highlight-->
    <div class="codequery_code">
      <xsl:value-of select="QueryHtml" disable-output-escaping="yes"/>
    </div>


    <!-- Show: nb XXX matched-->
    <xsl:variable name="rowCount" select="count(./Rows/Row[not(@FullName='Stat')])"/>
    <xsl:variable name="columnCount" select="count(./Columns/Column)"/>
    <xsl:variable name="treemap" select="@SelectionViewFileName"/>


    <xsl:choose>
      <xsl:when test="@KindOfNode = ''">
        <!-- If KindOfNode is null or empty it means we have a scalar query or a trend metric! -->
        <xsl:if test="$rowCount &gt; 0">
          <xsl:if test="$columnCount &gt; 0">
            <h3>
            Scalar Result: <b><xsl:value-of select="./Rows/Row[position()=1]/@Name"/></b>
            </h3>
          </xsl:if>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise> 
        <!-- If KindOfNode is NOT null or empty : We have a regular query or rule!-->
      
        <h3>
          <p> 
            <xsl:choose>
              <xsl:when test="@NbNodeMatched &gt; 0">
                <xsl:value-of select='format-number(@NbNodeMatched, "###,###.###")' /> <xsl:value-of select="@KindOfNode"/> matched
              </xsl:when>
              <xsl:otherwise>
                No <xsl:value-of select="@KindOfNode"/> matched
              </xsl:otherwise>
            </xsl:choose>
          </p>
      
     
          <!-- Eventually show the treemap picture selection of matched -->
          <xsl:if test="$treemap">
              <a href=".\JArchitectReportFiles\{$treemap}" class="diagramImage" title="Treemap">
                <img src=".\JArchitectReportFiles\{$treemap}" alt="Treemap" title="Treemap" height="100" width="300"/>
              </a>
              <p>          
                Matched code elements on treemap
                [ <a href=".\JArchitectReportFiles\{$treemap}" class="diagramImage" title="Treemap">scaled</a> ] <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text> 
                [ <a href=".\JArchitectReportFiles\{$treemap}" target="_blank" title="Treemap">full</a> ]
              </p>
          </xsl:if>
    
        </h3>

 
    
        <!-- Eventually why the list of XXX is not shown because of options -->
        <xsl:if test="@NbNodeMatched &gt; 0 and $rowCount = 0">
          <div class="explanations if-js-on">
            Matched <xsl:value-of select="@KindOfNode"/> are not listed because the option <i>Display list of items in report</i> is disabled for the present Rule.
            This option can be activated when editing the Rule in the <i>Code Query Edition panel</i> in <i>VisualJArchitect.exe</i>.
          </div>
        </xsl:if>


          
        <!-- Share the same div explanations, for all explanations, if any! -->
        <xsl:if test="(@NbNodeMatched > @NbNodeListed and @NbNodeListed = @ContentTruncatedThreshold) or (@NbNodeListed > @ContentTruncatedThreshold) or (@RecentViolationsOnly != '') or (@NbNodeMatched = 0 and not($ParamBoolComparisonAvailable) and @RelyOnCompareContext='True') or (@NbNodeMatched = 0 and not($ParamBoolCoverageAvailable) and @RelyOnCodeCoverageData='True')">
          <div class="explanations if-js-on">
            <ul>
          
              <!-- Eventually explain that the list fo XXX is truncated because of options -->
              <xsl:if test="@NbNodeMatched > @NbNodeListed and @NbNodeListed = @ContentTruncatedThreshold">
                <li>
                  <a data-ref="TruncatedQueryResult" href="#" class="cboxElement">
                    The following list of <xsl:value-of select="@KindOfNode"/> is truncated and contains only the first <xsl:value-of select="@ContentTruncatedThreshold"/> <xsl:value-of select="@KindOfNode"/> of the <xsl:value-of select="@NbNodeMatched"/> <xsl:value-of select="@KindOfNode"/> matched. 
                  </a>
                </li>
              </xsl:if>

              <!-- Eventually explain that there are too many XXX listed and that the user should consider using the option to truncate Code Queries results in report -->
              <xsl:if test="@NbNodeListed > @ContentTruncatedThreshold">
                <li>
                  <a data-ref="NONTruncatedQueryResult" href="#" class="cboxElement">
                    The following list contains all <xsl:value-of select="@NbNodeMatched"/> <xsl:value-of select="@KindOfNode"/> matched.
                  </a>
                </li>
              </xsl:if>
        
              <!-- Eventually explain that the report contains only recent violations! -->
              <xsl:if test="@RecentViolationsOnly != ''">
                <li>
                  <img src="./JArchitectReportFiles/filterblue.png"/>
                  <a data-ref="RecentViolationsONLY" href="#" class="cboxElement">
                    The following list contains only matched <xsl:value-of select="@KindOfNode"/> refactored or added since the baseline for comparison.
                  </a>
                </li>
              </xsl:if>

              <xsl:if test="@NbNodeMatched = 0 and not($ParamBoolComparisonAvailable) and @RelyOnCompareContext='True'">
                <li>
                   <a href="http://www.jarchitect.com/Doc_CI_Diff.aspx" target="_blank">To run this query define a Baseline for Comparison.</a>
                </li>
              </xsl:if>
              
              <xsl:if test="@NbNodeMatched = 0 and not($ParamBoolCoverageAvailable) and @RelyOnCodeCoverageData='True'">
                <li>
                  <a href="http://www.jarchitect.com/Coverage.aspx" target="_blank">To run this query import some Code Coverage Data.</a>.
                </li>
              </xsl:if>
            </ul>
          </div>
        </xsl:if>
        
        <div class="spacer"></div>
    
        <!-- Eventually show the list of matched -->
        <xsl:if test="$rowCount &gt; 0">
          <xsl:if test="$columnCount &gt; 0">
            <div class="divGrid">
              <table class="ndependGrid unEnhanced smallGrid" cellpadding="4" cellspacing="0" border="0">
                <thead>
                  <xsl:apply-templates select="./Columns" mode="result"/>
                </thead>
                <tbody>
                  <xsl:apply-templates select="./Rows" mode="result" />
                </tbody>
              </table>
            </div>
          </xsl:if>
        </xsl:if>

    
        <!-- Eventually show the statistics -->
        <xsl:if test="$columnCount &gt; 0 and count(./Rows/Row[@FullName='Stat']) &gt; 0">
          <h3>Statistics</h3>
          <div class="divStat">
            <table class="ndependStatGrid" cellpadding="0" cellspacing="0">
              <thead>
                <xsl:apply-templates select="./Columns" mode="stat"/>
              </thead>
              <tbody>
                <xsl:apply-templates select="./Rows"  mode="stat"/>
              </tbody>
            </table>
          </div>
        </xsl:if>
        
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  

  <xsl:template match="Columns" mode="result">
    <tr>
      <xsl:apply-templates select="./Column" mode="result"/>
      <th class="html">Full Name</th>
    </tr>
  </xsl:template>

  <xsl:template match="Columns" mode="stat">
    <tr>
      <th class="statColumn">Stat</th>
      <xsl:apply-templates select="./Column[position()>1]" mode="stat"/>
    </tr>
  </xsl:template>

  <xsl:template match="Column" mode="result">
    <th>
      <xsl:value-of select="."/>
    </th>
  </xsl:template>

  <xsl:template match="Column" mode="stat">
    <th class="statColumn">
      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
      <xsl:value-of select="."/>
    </th>
  </xsl:template>

  <xsl:template match="Rows" mode="result">
    <!--<xsl:apply-templates select="./Row[position() &lt;= $maxRows and not(@FullName='Stat')]" mode="result"/>-->
    <xsl:apply-templates select="./Row[not(@FullName='Stat')]" mode="result"/>
  </xsl:template>

  <xsl:template match="Rows" mode="stat">
    <xsl:apply-templates select="./Row[@FullName='Stat']" mode="stat"/>
  </xsl:template>

  <xsl:template match="Row" mode="result">
    <tr class="gD{position() mod 2}">
      <td>
        <xsl:value-of select="@Name"/>
      </td>
      <xsl:apply-templates select="./Val"/>
      <td>
        <xsl:value-of select="@FullName"/>
      </td>
    </tr>
  </xsl:template>

  
  <xsl:template match="Row" mode="stat">
    <tr class="stat{position() mod 2}">
      <td>
        <xsl:value-of select="@Name"/>
      </td>
      <xsl:apply-templates select="./Val"/>
    </tr>
  </xsl:template>

  <xsl:template match="Val">
    <td>
      <xsl:value-of select="." />
    </td>
  </xsl:template>



  <!--**************************************************************************************
      ***********                          Main Screen                         *************
      **************************************************************************************-->

  <xsl:template match="ReportInfo">
    <div class="info" id="ReportInfo">
      <span class='heading'>
        <span class='ndepend'>
          <span class='then'>j</span>architect
        </span> report summary
      </span>
      <span class='line'>
        <span class='name'>application name</span><xsl:value-of select="@AppName" />
      </span>
      <span class='line'>
        <span class='name'>report build date</span><xsl:value-of select="@NDependDate" />
      </span>
      <span class='line'>
        <span class='name'>analysis duration</span><xsl:value-of select="@BuiltDuration" />
      </span>
      <span class='line'>
        <span class='name'>
          <span class='ndepend'>
            <span class='then'>j</span>architect
          </span> version
        </span><xsl:value-of select="@NDependVersion" />
      </span>
      <span class='line'>
        <span class='name'>baseline for comparison</span>
        <xsl:choose>
          <xsl:when test="@ComparisonAvailable = 'True'">
            <xsl:value-of select="@ComparedWith" />
          </xsl:when>
          <xsl:otherwise>
            Not Defined. To define a Baseline for Comparison, please read this <a href="http://www.jarchitect.com/Doc_CI_Diff.aspx" target="_blank">online documentation</a>.
          </xsl:otherwise>
        </xsl:choose>
      </span>
      <span class='line'>
        <span class='name'>code coverage data</span>
        <xsl:choose>
          <xsl:when test="@CoverageAvailable = 'True'">
            Loaded! Code Coverage metrics, Queries and Rules relative to code Coverage, can be used.
          </xsl:when>
          <xsl:otherwise>
            Not Defined. To import Code Coverage Data, please read this <a href="http://www.jarchitect.com/Coverage.aspx" target="_blank">online documentation</a>.
          </xsl:otherwise>
        </xsl:choose>
      </span>
      <div class="explanations if-js-on">
        <span class='links'>
          <a id="ForBeginnersMain" href="#" class="cboxElement">Get started.</a>
          <a id="QuickTipsMain" href="#" class="cboxElement">Quick tips.</a>
          <a id="BackToSite" href="http://www.jarchitect.com/" target="_blank">Back to JArchitect.</a>
        </span>
        <span class='text'>
          The present HTML report is a summary of data gathered by the analysis.<br/>
           It is recommended to use the JArchitect interactive UI capabilities<br/>
					to make the most of JArchitect by mastering all aspects of your code.
				</span>
      </div>
    </div>
  </xsl:template>



  <!--**************************************************************************************
      ***********                      Dashboard                              *************
      **************************************************************************************-->
  <xsl:template match="Dashboard" mode="metrics">
    <div id="divDashboardHeader" class="info">
      <h4>Application Metrics</h4>
      <span class='note'>
        Note: Further <a rel="address:/?screen=ApplicationMetrics" href="#ApplicationMetrics" address="true">Application Statistics</a> are available.
      </span>
    </div>
    <div id="divDashboard" class="info">
      <xsl:apply-templates select="Table" mode="dashboard"/>
    </div>
  </xsl:template>


  <xsl:template match="Table" mode="dashboard">
    <xsl:choose>
      <xsl:when test='@IsVisible'>
        <table class='tableVisible' cellpadding="0px" cellspacing="0px">
          <tbody>
            <xsl:apply-templates select="Row" mode="dashboard"/>
          </tbody>
        </table>
      </xsl:when>
      <xsl:otherwise>
        <table cellpadding="0px" cellspacing="0px" >
          <tbody>
            <xsl:apply-templates select="Row" mode="dashboard"/>
          </tbody>
        </table>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="Table" mode="dashboardTable">
    <table class="table" cellpadding="0px" cellspacing="0px">
      <tbody>
        <xsl:apply-templates select="Row" mode="dashboard"/>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="Row" mode="dashboard">
    <tr class="tableNotVisible">
      <xsl:apply-templates select="Cell" mode="dashboard"/>
    </tr>
  </xsl:template>

  <xsl:template match="Cell" mode="dashboard">
    <xsl:choose>
      <xsl:when test="Separator">
        <td class="separator" ></td>
      </xsl:when>
      <xsl:otherwise>
        <td class="tableNotVisible">
          <xsl:apply-templates select="Table" mode="dashboard"/>
          <xsl:apply-templates select="ItemMetricSub" mode="dashboard"/>
          <xsl:apply-templates select="ItemMetricTitle" mode="dashboard"/>
          <xsl:apply-templates select="ItemMetricNotMyCode" mode="dashboard"/>
          <xsl:apply-templates select="ItemMetricImage" mode="dashboard"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="ItemMetricSub" mode="dashboard">
    <span class="sub">
      <xsl:if test='@Value'>
        <xsl:value-of select='@Value'/>
      </xsl:if>
      <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
      <xsl:if test='@Name'>
        <xsl:value-of select='@Name'/>
      </xsl:if>
    
      <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
      <xsl:if test='@DiffImage'>
        <xsl:if test='@DiffImage = "Up"'>
          <img src="./JArchitectReportFiles/DashboardDiffUp.png" />
        </xsl:if>
        <xsl:if test='@DiffImage = "Down"'>
          <img src="./JArchitectReportFiles/DashboardDiffDown.png" />
        </xsl:if>
        <xsl:if test='@DiffImage = "Equals"'>
          <img src="./JArchitectReportFiles/DashboardDiffEquals.png" />
        </xsl:if>
      </xsl:if>

      <span class="diff">
      <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
      <xsl:if test='@DiffDesc'>
        <xsl:value-of select='@DiffDesc'/>
      </xsl:if>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="ItemMetricTitle" mode="dashboard">
    <span class="title">
      <xsl:value-of select='@Name'/>
    </span>
    <xsl:if test='@Error'>
      <span class="error">
        <xsl:value-of select='@Error'/>
      </span> 
      <xsl:if test='contains(@Error, "coverage")'>
        <!-- HACK: add a bit of hight when the error 'no coverage data available' is show, just for good Y alignment! -->
        <br/>
      </xsl:if>
    </xsl:if>
    <xsl:if test='@Value'>
      <table>
        <tr>
          <td>
            <span class="title">
              <xsl:value-of select='@Value'/>
            </span>
          </td>
          <td>
            <span class="sub">
              <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
              <xsl:if test='@DiffImage'>
                <xsl:if test='@DiffImage = "Up"'>
                  <img src="./JArchitectReportFiles/DashboardDiffUp.png" />
                </xsl:if>
                <xsl:if test='@DiffImage = "Down"'>
                  <img src="./JArchitectReportFiles/DashboardDiffDown.png" />
                </xsl:if>
                <xsl:if test='@DiffImage = "Equals"'>
                  <img src="./JArchitectReportFiles/DashboardDiffEquals.png" />
                </xsl:if>
              </xsl:if>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
              <span class="diff">
                <xsl:if test='@DiffDesc'>
                  <xsl:value-of select='@DiffDesc'/>
                </xsl:if>
              </span>
            </span>
          </td>
        </tr>
      </table>
    </xsl:if>
  </xsl:template>


  <xsl:template match="ItemMetricNotMyCode" mode="dashboard">
    <span class="sub">
      <xsl:value-of select='@Value'/>
    </span>
  </xsl:template>


  <xsl:template match="ItemMetricImage" mode="dashboard">
    <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
    <xsl:element name="img">
      <xsl:attribute name="src">
        <xsl:value-of select='@Path'/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>

    
   


  <!--**************************************************************************************
      ***********                      Application stats                       *************
      **************************************************************************************-->

  <xsl:template match="ApplicationMetrics" mode="stats">

    <div class="ndependScreen" id="ApplicationMetrics">

      <div class="info">
        <h4>Application Statistics</h4>


        <div class="divTable">
          <table class="ndependTable" id="ApplicationMetricsStatsTable">
            <thead>
              <tr>
                <th>
                  Stat
                </th>
                <th>
                  # Occurences
                </th>
                <th>
                  Avg
                </th>
                <th>
                  StdDev
                </th>
                <th>
                  Max
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="PropertyOnInterface" />
              <xsl:apply-templates select="MethodOnInterface" />
              <xsl:apply-templates select="ArgOnMethodOnInterface" />
              <xsl:apply-templates select="PublicPropertyOnClass" />
              <xsl:apply-templates select="PublicMethodOnClass" />
              <xsl:apply-templates select="ArgOnPublicMethodOnClass" />
              <xsl:apply-templates select="ILInstructionInNonAbstractMethods" />
              <!--<xsl:apply-templates select="ILInstructionInType" />
              <xsl:apply-templates select="ResponseForType" />-->
              <xsl:apply-templates select="MethodCC" />
            </tbody>
          </table>
        </div>

      </div>

    </div>

  </xsl:template>

  <xsl:template match="PropertyOnInterface">
    <tr class="data0">
      <td class="firstColumn">
        Properties on interfaces
      </td>
      <td>
        <xsl:value-of select='format-number(@Occ, "###,###.###")' /> interfaces
      </td>
      <td>
        <xsl:value-of select="@Avg"/>
      </td>
      <td>
        <xsl:value-of select="@StdDev"/>
      </td>
      <td>
        <font color="#FF0000">
          <xsl:value-of select="@MaxVal"/>
        </font> properties on <font color="#FF0000">
          <xsl:value-of select="@MaxName"/>
        </font>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="MethodOnInterface">
    <tr class="data1">
      <td class="firstColumn">
        Methods on interfaces
      </td>
      <td>
        <xsl:value-of select='format-number(@Occ, "###,###.###")' /> interfaces
      </td>
      <td>
        <xsl:value-of select="@Avg"/>
      </td>
      <td>
        <xsl:value-of select="@StdDev"/>
      </td>
      <td>
        <font color="#FF0000">
          <xsl:value-of select="@MaxVal"/>
        </font> methods on <font color="#FF0000">
          <xsl:value-of select="@MaxName"/>
        </font>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="ArgOnMethodOnInterface">
    <tr class="data0">
      <td class="firstColumn">
        Arguments on methods on interfaces
      </td>
      <td>
        <xsl:value-of select='format-number(@Occ, "###,###.###")' /> methods
      </td>
      <td>
        <xsl:value-of select="@Avg"/>
      </td>
      <td>
        <xsl:value-of select="@StdDev"/>
      </td>
      <td>
        <font color="#FF0000">
          <xsl:value-of select="@MaxVal"/>
        </font> arguments on <font color="#FF0000">
          <xsl:value-of select="@MaxName"/>
        </font>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="PublicPropertyOnClass">
    <tr class="data1">
      <td class="firstColumn">
        Public properties on classes
      </td>
      <td>
        <xsl:value-of select='format-number(@Occ, "###,###.###")' /> Classes
      </td>
      <td>
        <xsl:value-of select="@Avg"/>
      </td>
      <td>
        <xsl:value-of select="@StdDev"/>
      </td>
      <td>
        <font color="#FF0000">
          <xsl:value-of select="@MaxVal"/>
        </font> public properties on <font color="#FF0000">
          <xsl:value-of select="@MaxName"/>
        </font>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="PublicMethodOnClass">
    <tr class="data0">
      <td class="firstColumn">
        Public methods on classes
      </td>
      <td>
        <xsl:value-of select='format-number(@Occ, "###,###.###")' /> classes
      </td>
      <td>
        <xsl:value-of select="@Avg"/>
      </td>
      <td>
        <xsl:value-of select="@StdDev"/>
      </td>
      <td>
        <font color="#FF0000">
          <xsl:value-of select="@MaxVal"/>
        </font> public methods on <font color="#FF0000">
          <xsl:value-of select="@MaxName"/>
        </font>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="ArgOnPublicMethodOnClass">
    <tr class="data1">
      <td class="firstColumn">
        Arguments on public methods on classes
      </td>
      <td>
        <xsl:value-of select='format-number(@Occ, "###,###.###")' /> methods
      </td>
      <td>
        <xsl:value-of select="@Avg"/>
      </td>
      <td>
        <xsl:value-of select="@StdDev"/>
      </td>
      <td>
        <font color="#FF0000">
          <xsl:value-of select="@MaxVal"/>
        </font> arguments on <font color="#FF0000">
          <xsl:value-of select="@MaxName"/>
        </font>
      </td>
    </tr>
  </xsl:template>


  <xsl:template match="ILInstructionInNonAbstractMethods">
    <tr class="data0">
      <td class="firstColumn">
        BC instructions in non-abstract methods
      </td>
      <td>
        <xsl:value-of select='format-number(@Occ, "###,###.###")' /> methods
      </td>
      <td>
        <xsl:value-of select="@Avg"/>
      </td>
      <td>
        <xsl:value-of select="@StdDev"/>
      </td>
      <td>
        <font color="#FF0000">
          <xsl:value-of select="@MaxVal"/>
        </font> BC instructions in <font color="#FF0000">
          <xsl:value-of select="@MaxName"/>
        </font>
      </td>
    </tr>
  </xsl:template>

  <!--<xsl:template match="ILInstructionInType">
    <tr class="data1">
      <td class="firstColumn">
        Number of IL instructions par non-abstract Types
      </td>
      <td>
        <xsl:value-of select="@Occ"/> Types
      </td>
      <td>
        <xsl:value-of select="@Avg"/>
      </td>
      <td>
        <xsl:value-of select="@StdDev"/>
      </td>
      <td>
        <font color="#FF0000">
          <xsl:value-of select="@MaxVal"/>
        </font> IL instructions in <font color="#FF0000">
          <xsl:value-of select="@MaxName"/>
        </font>
      </td>
    </tr>
  </xsl:template>-->


  <xsl:template match="MethodCC">
    <tr class="data1">
      <td class="firstColumn">
        Cyclomatic complexity on non abstract Methods
      </td>
      <td>
        <!--<xsl:value-of select="@Occ"/>-->
        <xsl:value-of select='format-number(@Occ, "###,###.###")' /> Methods
      </td>
      <td>
        <xsl:value-of select="@Avg"/>
      </td>
      <td>
        <xsl:value-of select="@StdDev"/>
      </td>
      <td>
        CC = <font color="#FF0000">
          <xsl:value-of select="@MaxVal"/>
        </font> for <font color="#FF0000">
          <xsl:value-of select="@MaxName"/>
        </font>
      </td>
    </tr>
  </xsl:template>

  <!--<xsl:template match="ResponseForType">
    <tr class="data1">
      <td class="firstColumn">
        Response for types (IL instructions)
      </td>
      <td>
        <xsl:value-of select="@Occ"/> types
      </td>
      <td>
        <xsl:value-of select="@Avg"/>
      </td>
      <td>
        <xsl:value-of select="@StdDev"/>
      </td>
      <td>
        RFT = <font color="#FF0000">
          <xsl:value-of select="@MaxVal"/>
        </font> IL instructions on <font color="#FF0000">
          <xsl:value-of select="@MaxName"/>
        </font>
      </td>
    </tr>
  </xsl:template>-->





  <!--**************************************************************************************
      ***********                      Assemblies Metrics Screen               *************
      **************************************************************************************-->
 
  <xsl:template match="AssembliesMetrics" mode="facts">
    <div class="ndependScreen" id="AssembliesMetrics">

      <div class="info">
        <h4>Projects Metrics</h4>

        <div class="explanations if-js-on" style="display: block; visibility: visible; ">
            If you wish to define thresholds on projects' Code Metrics, consider writing some Rules.<br/>
            Clicking column header arrows sorts values.<br/>
            Clicking column header title text redirect to the online Code Metric definition.<br/>
        </div>
        <div class="spacer"></div>

        <div class="divGrid">
          <table class="ndependGrid unEnhanced" cellpadding="4" cellspacing="0" border="0">
            <thead>
              <tr>
                <th>
                  Projects
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbLinesOfCode" target="_blank"># lines of code</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbILInstructions" target="_blank"># BC instruction</a>
                </th>
                <th>
                  # Types
                </th>
                <th>
                  # Abstract Types
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbLinesOfComment" target="_blank"># lines of comment</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#PercentageComment" target="_blank">% Comment</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#PercentageCoverage" target="_blank">% Coverage</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#AfferentCoupling" target="_blank">Afferent Coupling</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#EfferentCoupling" target="_blank">Efferent Coupling</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#RelationalCohesion" target="_blank">Relational Cohesion</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#Instability" target="_blank">Instability</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#Abstracness" target="_blank">Abstractness</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#DitFromMainSeq" target="_blank">Distance</a>
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="./Assembly" mode="assemblyMetrics"/>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="Assembly" mode="assemblyMetrics">
    <tr class="gD{position() mod 2}">
      <td>
        <xsl:value-of select="@Assembly"/>
      </td>
      <td>
        <xsl:value-of select="@NbLinesOfCodeInAsm"/>
      </td>
      <td>
        <xsl:value-of select="@NILInstructionInAsm"/>
      </td>
      <td>
        <xsl:value-of select="@NTypes"/>
      </td>
      <td>
        <xsl:value-of select="@NAbstractTypes"/>
      </td>
      <td>
        <xsl:value-of select="@NbLinesOfCommentInAsm"/>
      </td>
      <td>
        <xsl:value-of select="@PercentageCommentInAsm"/>
      </td>
      <td>
        <xsl:value-of select="@PercentageCoverageInAsm"/>
      </td>
      <td>
        <xsl:value-of select="@AfferentCoupling"/>
      </td>
      <td>
        <xsl:value-of select="@EfferentCoupling"/>
      </td>
      <td>
        <xsl:value-of select="@RelationalCohesion"/>
      </td>
      <td>
        <xsl:value-of select="@Instability"/>
      </td>
      <td>
        <xsl:value-of select="@Abstractness"/>
      </td>
      <td>
        <xsl:value-of select="@DistFrMainSeq"/>
      </td>
    </tr>
  </xsl:template>






  <!--**************************************************************************************
      ***********                      Namespaces Metrics Screen               *************
      **************************************************************************************-->

  <xsl:template match="NamespacesMetrics" mode="facts">
    <div class="ndependScreen" id="NamespacesMetrics">

      <div class="info">
        <h4>Packages Metrics</h4>

        <div class="explanations if-js-on" style="display: block; visibility: visible; ">
          If you wish to define thresholds on packages' Code Metrics, consider writing some Rules.<br/>
          Clicking column header arrows sorts values.<br/>
          Clicking column header title text redirect to the online Code Metric definition.<br/>
        </div>
        <div class="spacer"></div>

        <xsl:if test="$ParamBoolZeroNamespacesMetricsWarning">
          <xsl:variable name="namespacesCount" select="count(./NamespaceMetric)" />
          <xsl:if test="$namespacesCount=0">
            <div class="restrictions if-js-on">
              If the code base analyzed has too many packages, JArchitect doesn't list Packages Metrics to avoid a too big report. The section Packages Metrics can be activated by unchecking the option: <br/>
              <i>JArchitect Project Properties &gt; Report &gt; Avoid too big report for large code base  &gt; Hide section Packages Metrics if...</i><br/>
              It is recommended to use the JArchitect interactive UI capabilities to browse large applications.<br/>
            </div>
          </xsl:if>
        </xsl:if>
        <div class="spacer"></div>

        <div class="divGrid">
          <table class="ndependGrid unEnhanced" cellpadding="4" cellspacing="0" border="0">
            <thead>
              <tr>
                <th>
                  Packages
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbLinesOfCode" target="_blank"># lines of code</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbILInstructions" target="_blank"># BC instruction</a>
                </th>
                <th>
                  # Types
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbLinesOfComment" target="_blank"># lines of comment</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#PercentageComment" target="_blank">% Comment</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#PercentageCoverage" target="_blank">% Coverage</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#AfferentCoupling" target="_blank">Afferent Coupling</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#EfferentCoupling" target="_blank">Efferent Coupling</a>
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="./Namespace" mode="namespaceMetrics"/>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="Namespace" mode="namespaceMetrics">
    <tr class="gD{position() mod 2}">
      <td>
        <xsl:value-of select="@Namespace"/>
      </td>
      <td>
        <xsl:value-of select="@NbLinesOfCode"/>
      </td>
      <td>
        <xsl:value-of select="@NILInstruction"/>
      </td>
      <td>
        <xsl:value-of select="@NTypes"/>
      </td>
      <td>
        <xsl:value-of select="@NbLinesOfComment"/>
      </td>
      <td>
        <xsl:value-of select="@PercentageComment"/>
      </td>
      <td>
        <xsl:value-of select="@PercentageCoverage"/>
      </td>
      <td>
        <xsl:value-of select="@AfferentCoupling"/>
      </td>
      <td>
        <xsl:value-of select="@EfferentCoupling"/>
      </td>
    </tr>
  </xsl:template>




  <!--**************************************************************************************
      ***********                      Type Metrics                            *************
      **************************************************************************************-->

  <xsl:template match="TypesMetrics" mode="facts">

    <div class="ndependScreen" id="TypesMetrics">

      <div class="info">
        <h4>Types Metrics : Code Quality</h4>

        <div class="explanations if-js-on" style="display: block; visibility: visible; ">
           For a particular Code Metric defined for types, values in red represent the 15% highest values.<br/>
           If you wish to define thresholds on types' Code Metrics, consider writing some Rule.<br/>
           Clicking column header arrows sorts values.<br/>
           Clicking column header title text redirect to the online Code Metric definition.<br/>
        </div>
        <div class="spacer"></div>

        <xsl:if test="$ParamBoolZeroTypesMetricsWarning">
          <xsl:variable name="typesCount" select="count(./TypeMetric)" />
          <xsl:if test="$typesCount=0">
            <div class="restrictions if-js-on">
              If the code base analyzed has too many types, JArchitect doesn't list Types Metrics to avoid a too big report. The section Types Metrics can be activated by unchecking the option: <br/>
              <i>JArchitect Project Properties &gt; Report &gt; Avoid too big report for large code base  &gt; Hide section Types Metrics if...</i><br/>
              It is recommended to use the JArchitect interactive UI capabilities to browse large applications.<br/>
            </div>
          </xsl:if>
        </xsl:if>
        <div class="spacer"></div>

        <div class="divGrid">
          <table class="ndependGrid unEnhanced" cellpadding="4" cellspacing="0" border="0">
            <thead>
              <tr>
                <th>
                  Type Name
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#TypeRank" target="_blank">Type Rank</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbLinesOfCode" target="_blank"># Lines Of Code</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbILInstructions" target="_blank"># BC Instructions</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbLinesOfComment" target="_blank"># Lines Of Comment</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#PercentageComment" target="_blank">% Comment</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#CC" target="_blank">Cyclomatic Complexity</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#ILCC" target="_blank">BC Cyclomatic Complexity</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#PercentageCoverage" target="_blank">% Coverage</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#TypeCa" target="_blank">Afferent Coupling</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#TypeCe" target="_blank">Efferent Coupling</a>
                </th>
                <th>
                  Type Package
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="./TypeMetric" mode="qualityMetrics"/>
            </tbody>
          </table>
        </div>
      </div>

      


      <div class="info">
        <h4>Types Metrics : Code Members and Inheritance</h4>
        <div class="divGrid">
          <table class="ndependGrid unEnhanced" cellpadding="4" cellspacing="0" border="0">
            <thead>
              <tr>
                <th>
                  Type Name
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbMethods" target="_blank"># Instance Methods</a>
                </th>
                <th>
                  Nb Static Methods
                </th>
                <th>
                  Nb Properties
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NbFields" target="_blank"># Fields</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#NOC" target="_blank"># Children Classes</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#DIT" target="_blank">Depth Of Inheritance Tree</a>
                </th>
                <th>
                  Type Package
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="./TypeMetric" mode="membersMetrics"/>
            </tbody>
          </table>
        </div>
      </div>

      
      

      <div class="info">
        <h4>Types Metrics : Lack Of Cohesion Of Methods and Association Between Classes</h4>
        <div class="divGrid">
          <table class="ndependGrid unEnhanced" cellpadding="4" cellspacing="0" border="0">
            <thead>
              <tr>
                <th>
                  Type Name
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#LCOM" target="_blank">Lack Of Cohesion Of Methods</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#LCOM" target="_blank">Lack Of Cohesion Of Methods HS</a>
                </th>
                <th>
                  <a href="http://www.jarchitect.com/Metrics.aspx#ABC" target="_blank">Association Between Classes</a>
                </th>
                <th>
                  Type Package
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="./TypeMetric" mode="academicMetrics"/>
            </tbody>
          </table>
        </div>
      </div>
      
      
      
    </div>
  </xsl:template>

  <xsl:template match="TypeMetric" mode="qualityMetrics">
    <tr class="gD{position() mod 2}">
      <td>
        <xsl:value-of select="@TypeName"/>
      </td>
      <xsl:choose>
        <xsl:when test="@IsBadTypeRank='True'">
          <td class="ndA">
            <xsl:value-of select="@TypeRank"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@TypeRank"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>


      <xsl:choose>
        <xsl:when test="@IsBadNbLinesOfCode='True'">
          <td class="ndA">
            <xsl:value-of select="@NbLinesOfCode"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@NbLinesOfCode"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadNILInstructionOnType='True'">
          <td class="ndA">
            <xsl:value-of select="@NILInstructionOnType"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@NILInstructionOnType"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadNbLinesOfComment='True'">
          <td class="ndA">
            <xsl:value-of select="@NbLinesOfComment"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@NbLinesOfComment"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadPercentageComment='True'">
          <td class="ndA">
            <xsl:value-of select="@PercentageComment"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@PercentageComment"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      
      
      <xsl:choose>
        <xsl:when test="@IsBadCyclomaticComplexity='True'">
          <td class="ndA">
            <xsl:value-of select="@CyclomaticComplexity"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@CyclomaticComplexity"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadILCyclomaticComplexity='True'">
          <td class="ndA">
            <xsl:value-of select="@ILCyclomaticComplexity"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td class="ndA">
            <xsl:value-of select="@ILCyclomaticComplexity"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadPercentageCoverage='True'">
          <td class="ndA">
            <xsl:value-of select="@PercentageCoverage"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@PercentageCoverage"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadAfferentCoupling='True'">
          <td class="ndA">
            <xsl:value-of select="@AfferentCoupling"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@AfferentCoupling"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadEfferentCoupling='True'">
          <td class="ndA">
            <xsl:value-of select="@EfferentCoupling"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@EfferentCoupling"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <td>
        <xsl:value-of select="@TypeNamespace"/>
      </td>
    </tr>
  </xsl:template>

  
 
  
  <xsl:template match="TypeMetric" mode="membersMetrics">
    <tr class="gD{position() mod 2}">
      <td>
        <xsl:value-of select="@TypeName"/>
      </td>
      <xsl:choose>
        <xsl:when test="@IsBadNInstanceMethods='True'">
          <td class="ndA">
            <xsl:value-of select="@NInstanceMethods"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@NInstanceMethods"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadNStaticMethods='True'">
          <td class="ndA">
            <xsl:value-of select="@NStaticMethods"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@NStaticMethods"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadNProperties='True'">
          <td class="ndA">
            <xsl:value-of select="@NProperties"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@NProperties"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadNFields='True'">
          <td class="ndA">
            <xsl:value-of select="@NFields"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@NFields"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadNChildren='True'">
          <td class="ndA">
            <xsl:value-of select="@NChildren"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@NChildren"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadDepthOfInheritanceTree='True'">
          <td class="ndA">
            <xsl:value-of select="@DepthOfInheritanceTree"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@DepthOfInheritanceTree"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <td>
        <xsl:value-of select="@TypeNamespace"/>
      </td>
    </tr>
  </xsl:template>




  <xsl:template match="TypeMetric" mode="academicMetrics">
    <tr class="gD{position() mod 2}">
      <td>
        <xsl:value-of select="@TypeName"/>
      </td>
      <xsl:choose>
        <xsl:when test="@IsBadLackOfCohesionOfMethods='True'">
          <td class="ndA">
            <xsl:value-of select="@LackOfCohesionOfMethods"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@LackOfCohesionOfMethods"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadLackOfCohesionOfMethods_HS='True'">
          <td class="ndA">
            <xsl:value-of select="@LackOfCohesionOfMethods_HS"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@LackOfCohesionOfMethods_HS"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@IsBadAssociationBetweenClasses='True'">
          <td class="ndA">
            <xsl:value-of select="@AssociationBetweenClasses"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <xsl:value-of select="@AssociationBetweenClasses"/>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <td>
        <xsl:value-of select="@TypeNamespace"/>
      </td>
    </tr>
  </xsl:template>



  <!--**************************************************************************************
      ***********                     Assemblies dependencies                  *************
      **************************************************************************************-->
 
  <xsl:template match="AssemblyDependencies">

    <div class="ndependScreen" id="AssembliesDependencies">
      <div class="info">
        <h4>Projects Dependencies</h4>

        <div class="divTable">
          <table class="ndependTable" id="ndependAssembliesDependencies" cellpadding="3" cellspacing="0">
            <thead>
              <tr>
                <th>
                  Assembly
                </th>
                <th>
                  Depends on
                </th>
                <th>
                  Is referenced by
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="Dependencies_For" mode="Assembly"/>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="Dependencies_For" mode="Assembly">
    <tr class="data{position() mod 2}">
      <td>
        <xsl:value-of select="@Assembly"/>
      </td>

      <td>
        <xsl:choose>
          <xsl:when test="DependsOn">
            <xsl:apply-templates select="DependsOn" />
          </xsl:when>
          <xsl:otherwise> - </xsl:otherwise>
        </xsl:choose>
      </td>

      <td>
        <xsl:choose>
          <xsl:when test="ReferencedBy">
            <xsl:apply-templates select="ReferencedBy" />
          </xsl:when>
          <xsl:otherwise> - </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="DependsOn">
    <xsl:for-each select="DependsOn_Name">
      <xsl:apply-templates/> ;
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="ReferencedBy">
    <xsl:for-each select="ReferencedBy_Name">
      <xsl:apply-templates/> ;
    </xsl:for-each>
  </xsl:template>

  <!-- Types dependencies -->
  <xsl:template match="TypeReferencement">
    <div class="ndependScreen" id="TypesDependencies">
      <div class="info">
        <h4>Types Dependencies</h4>

        <xsl:if test="$ParamBoolZeroTypesDependenciesWarning">
          <xsl:variable name="typesCount" select="count(./Type)" />
          <xsl:if test="$typesCount=0">
            <table  cellpadding="0" cellspacing="0">
              <tr>
                <td>
                  <div class="restrictions if-js-on">
                    If the code base analyzed has too many types, JArchitect doesn't list Types Dependencies to avoid a too big report. The section Types Dependencies can be activated by unchecking the option: <br/>
                    <i>JArchitect Project Properties &gt; Report &gt; Avoid too big report for large code base  &gt; Hide section Types Dependencies if...</i><br/>
                    It is recommended to use the JArchitect interactive UI capabilities to browse large applications.<br/>
                  </div>
                </td>
              </tr>
            </table>
            <br/>
          </xsl:if>
        </xsl:if>

        <div class="divTable">
          <table class="ndependTable" id="ndependTypesDependencies" cellpadding="3" cellspacing="0">
            <thead>
              <tr>
                <th>
                  Type
                </th>
                <th>
                  Depends on
                </th>
                <th>
                  Is referenced by
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="Type" />
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="Type">
    <tr class="data{position() mod 2}">
      <td>
        <xsl:element name="a">
          <xsl:attribute name="Name">
            <xsl:value-of select="@Name"/>
          </xsl:attribute>
          <xsl:value-of select="@Name"/>
        </xsl:element>
      </td>

      <td>
        <xsl:choose>
          <xsl:when test="Use">
            <xsl:apply-templates select="Use" />
          </xsl:when>
          <xsl:otherwise> - </xsl:otherwise>
        </xsl:choose>
      </td>

      <td>
        <xsl:choose>
          <xsl:when test="UsedBy">
            <xsl:apply-templates select="UsedBy" />
          </xsl:when>
          <xsl:otherwise> - </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="UsedBy">
    <xsl:for-each select="Name">
      <xsl:apply-templates/> ;
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="Use">
    <xsl:for-each select="Name">
      <xsl:apply-templates/> ;
    </xsl:for-each>
  </xsl:template>



  <!-- Namespaces dependencies -->
  <xsl:template match="NamespaceDependencies">
    <div class="ndependScreen" id="NamespacesDependencies">
      <div class="info">
        <h4>Packages Dependencies</h4>

        <xsl:if test="$ParamBoolZeroNamespacesDependenciesWarning">
          <xsl:variable name="namespacesCount" select="count(./Namespace)" />
          <xsl:if test="$namespacesCount=0">
            <table  cellpadding="0" cellspacing="0">
              <tr>
                <td>
                  <div class="restrictions if-js-on">
                    If the code base analyzed has too many packages, JArchitect doesn't list Packages Dependencies to avoid a too big report. The section Packages Dependencies can be activated by unchecking the option: <br/>
                    <i>JArchitect Project Properties &gt; Report &gt; Avoid too big report for large code base  &gt; Hide section Packages Dependencies if...</i><br/>
                    It is recommended to use the JArchitect interactive UI capabilities to browse large applications.<br/>
                  </div>
                </td>
              </tr>
            </table>
          </xsl:if>
        </xsl:if>

        <div class="divTable">
          <table class="ndependTable" id="ndependNamespacesDependencies" cellpadding="3" cellspacing="0">
            <thead>
              <tr>
                <th>
                  Package
                </th>
                <th>
                  Depends on
                </th>
                <th>
                  Is referenced by
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="Dependencies_For" mode="Namespace" />
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="Dependencies_For" mode="Namespace">
    <tr class="data{position() mod 2}">
      <td>
        <xsl:value-of select="@Namespace"/>
      </td>

      <td>
        <xsl:choose>
          <xsl:when test="DependsOn">
            <xsl:apply-templates select="DependsOn" />
          </xsl:when>
          <xsl:otherwise> - </xsl:otherwise>
        </xsl:choose>
      </td>

      <td>
        <xsl:choose>
          <xsl:when test="ReferencedBy">
            <xsl:apply-templates select="ReferencedBy" />
          </xsl:when>
          <xsl:otherwise> - </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="DependsOn">
    <xsl:for-each select="DependsOn_Name">
      <xsl:apply-templates/> ;
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="ReferencedBy">
    <xsl:for-each select="ReferencedBy_Name">
      <xsl:apply-templates/> ;
    </xsl:for-each>
  </xsl:template>






  <!--**************************************************************************************
      ***********                     Assemblies Build Order                   *************
      **************************************************************************************-->
  <xsl:template match="AssemblySortForCompilOrObfusk" mode="order">
    <div class="ndependScreen" id="AssembliesBuildOrder">
      <div class="info">
        <h4>Projects Build Order</h4>
          <ol>
            <xsl:apply-templates select="./Assembly" mode="order"/>
          </ol>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="Assembly" mode="order">
    <li>
      <xsl:value-of select="@Assembly"/>
    </li>
  </xsl:template>


  
  
  

  <!--**************************************************************************************
      ***********                     Analysis Log                             *************
      **************************************************************************************-->
  
  <xsl:template match="InfoWarnings">
    <div class="ndependScreen" id="InfoWarnings">
      <div class="info">
        <h4>Analysis Log : Information and Warnings</h4>

        <div class="explanations if-js-on">
          Here are Logs emitted during JArchitect analysis.<br/>
          The <b>Warnings</b> can reveal potential flaws concerning the <a href="http://www.jarchitect.com/Doc_CI_Details.aspx#Warns" target="_blank">health of the build process</a>.<br/>
          A particular <b>warn</b> can be disabled through the JArchitect interactive UI, panel <i>Error List</i>, tick the checkbox <i>Disabled</i> corresponding to the <b>warn</b> to disable.
        </div>
        <br/>
        <br/>
        <div class="divGrid">
          <table class="ndependGrid unEnhanced" cellpadding="4" cellspacing="0">
            <thead>
              <tr>
                <th>
                  Kind
                </th>
                <th>
                  Message
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="child::node()"/>
            </tbody>
          </table>

        </div>
      </div>
    </div>
  </xsl:template>

  
  <xsl:template match="Info">
    <tr style="color:#505050;">
      <td>Info</td>
      <td>
        <xsl:value-of select="."/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="Warning">
    <tr style="color:#773300; font-weight:bold;">
      <td>Warning</td>
      <td>
        <xsl:value-of select="."/>
      </td>
    </tr>
  </xsl:template>




  <!--**************************************************************************************
      ***********                     Trend CHARTS                             *************
      **************************************************************************************-->
  <xsl:template match="TrendCharts" mode="body">
    <div class="ndependScreen" id="TrendCharts">
      <h4>Trend Charts</h4>
      <script type="text/javascript" src="https://www.google.com/jsapi"></script>

      <script>
        <xsl:value-of select="./TrendChart"/>
      </script>

      <div id='gchart_offline'>
        <p>
          Unfortunately, Google Terms of Service prohibit saving the Chart API on your machine for offline use
          as stated at <a target='_blank' href='https://developers.google.com/chart/interactive/faq#localdownload'>https://developers.google.com/chart/interactive/faq#localdownload</a>
        </p>
        <p>
          We could not connect to <a target='_blank' href='https://www.google.com/jsapi'>https://www.google.com/jsapi</a> to retrieve the script. We will display chart data in a table instead.
        </p>
        <p>Please connect to the internet and reload the page to display the chart.</p>
      </div>

      <xsl:if test="./TrendChartError">
        <img src="./JArchitectReportFiles/StatusError.png" />
        <xsl:value-of disable-output-escaping="yes" select="./TrendChartError"/>
      </xsl:if>

      <div class='gchart_wrap'>
        <xsl:value-of disable-output-escaping="yes" select="./TrendChartElements"/>
      </div>
    </div>
  </xsl:template>


</xsl:stylesheet>
