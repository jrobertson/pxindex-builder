# Introducing the pxindex-builder gem

    require 'pxindex-builder'


    s = "
    How are you?
    What's today's date?
    Is it going to rain tomorrow?
    Track my location
    what's Tom's mobile number?
    What's Sally's mobile number?
    Open the door
    How are you?
    Switch the bedroom light on
    Switch the bedroom light off
    Switch the livingroom light on
    How are you?
    Switch the bedroom light on
    Switch the bedroom light off
    Switch the livingroom light off
    Open the door
    "
    s = PhraseLookup.new(s.strip).master.to_h.to_yaml

    xml = PxIndexBuilder.new(s, ignore: %w(is it the are you to)).to_xml
    puts xml

The pxindex-builder gem is intended to create a Polyrex Index document for populating a dynamic tree list on a web page which can either be expanded or collapsed. On average it would take the user 3 clicks to select any of the above statements. 
To open the door the use would click on the letter *o*, followed by click on the word *open* and then click on the *open the door* statement.


Output (extract):

<pre>
&lt;?xml version='1.0' encoding='UTF-8'?&gt;
&lt;items&gt;
  &lt;summary&gt;
    &lt;recordx_type&gt;polyrex&lt;/recordx_type&gt;
    &lt;schema&gt;items/entry[title]/entry[title]/entry[title]&lt;/schema&gt;
  &lt;/summary&gt;
  &lt;records&gt;
    &lt;entry&gt;
      &lt;summary&gt;
        &lt;title&gt;a&lt;/title&gt;
        &lt;schema&gt;entry[title]&lt;/schema&gt;
      &lt;/summary&gt;
      &lt;records&gt;
        &lt;entry&gt;
          &lt;summary&gt;
            &lt;title&gt;are&lt;/title&gt;
            &lt;schema&gt;entry[title]&lt;/schema&gt;
          &lt;/summary&gt;
          &lt;records&gt;
            &lt;entry&gt;
              &lt;summary&gt;
                &lt;title&gt;how are you&lt;/title&gt;
                &lt;schema&gt;entry[title]&lt;/schema&gt;
              &lt;/summary&gt;
            &lt;/entry&gt;
          &lt;/records&gt;
        &lt;/entry&gt;
      &lt;/records&gt;
    &lt;/entry&gt;
    &lt;entry&gt;
      &lt;summary&gt;
        &lt;title&gt;b&lt;/title&gt;
        &lt;schema&gt;entry[title]&lt;/schema&gt;
      &lt;/summary&gt;
      &lt;records&gt;
        &lt;entry&gt;
          &lt;summary&gt;
            &lt;title&gt;bedroom&lt;/title&gt;
            &lt;schema&gt;entry[title]&lt;/schema&gt;
          &lt;/summary&gt;
          &lt;records&gt;
            &lt;entry&gt;
              &lt;summary&gt;
                &lt;title&gt;switch the bedroom light on&lt;/title&gt;
                &lt;schema&gt;entry[title]&lt;/schema&gt;
              &lt;/summary&gt;
            &lt;/entry&gt;
            &lt;entry&gt;
              &lt;summary&gt;
                &lt;title&gt;switch the bedroom light off&lt;/title&gt;
                &lt;schema&gt;entry[title]&lt;/schema&gt;
              &lt;/summary&gt;
            &lt;/entry&gt;
          &lt;/records&gt;
        &lt;/entry&gt;
      &lt;/records&gt;
    &lt;/entry&gt;
    &lt;entry&gt;
      &lt;summary&gt;
        &lt;title&gt;d&lt;/title&gt;
        &lt;schema&gt;entry[title]&lt;/schema&gt;
      &lt;/summary&gt;
      &lt;records&gt;
        &lt;entry&gt;
          &lt;summary&gt;
            &lt;title&gt;door&lt;/title&gt;
            &lt;schema&gt;entry[title]&lt;/schema&gt;
          &lt;/summary&gt;
          &lt;records&gt;
            &lt;entry&gt;
              &lt;summary&gt;
                &lt;title&gt;open the door&lt;/title&gt;
                &lt;schema&gt;entry[title]&lt;/schema&gt;
              &lt;/summary&gt;
            &lt;/entry&gt;
          &lt;/records&gt;
        &lt;/entry&gt;
        &lt;entry&gt;
          &lt;summary&gt;
            &lt;title&gt;date&lt;/title&gt;
            &lt;schema&gt;entry[title]&lt;/schema&gt;
          &lt;/summary&gt;
          &lt;records&gt;
            &lt;entry&gt;
              &lt;summary&gt;
                &lt;title&gt;what's today's date&lt;/title&gt;
                &lt;schema&gt;entry[title]&lt;/schema&gt;
              &lt;/summary&gt;
            &lt;/entry&gt;
          &lt;/records&gt;
        &lt;/entry&gt;
      &lt;/records&gt;
    &lt;/entry&gt;
...
</pre>

Notes:

* This gem is suited a mobile phone user interface where the user finds it more convenient than speech recognition or by manually inputting the text (even with autocompletion)
* The gem is intended to store a relatively large list of user-defined statements.

## Resource

* pxindex-builder https://rubygems.org/gems/pxindex-builder

gem pxindex build builder query bot pxindexbuilder
