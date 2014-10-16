# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/15/2014 - WonSong (http://wys.io)
# - Created initial file.
# ==========================================================================

'use strict'

###
fastCollapse directive uses UI Bootstrap's implementation for Collapsing, but without transition
@module {Directive} fastCollapse
###
angular.module 'jsonifyApp'
.directive 'fastCollapse', ->
  link: (scope, element, attrs) ->
    expand = () ->
      element.removeClass 'collapse'
      expandDone()

    expandDone = () ->
      element.addClass 'collapse in'
      element.css {height: 'auto'}

    collapse = () ->
      element.css {height: 0}
      element.removeClass 'collapse in'
      collapseDone()

    collapseDone = () ->
      element.addClass 'collapse'

    scope.$watch attrs.fastCollapse, (should_collapse) ->
      if should_collapse
        collapse()
      else
        expand()
