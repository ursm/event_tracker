class EventTracker::Mixpanel
  def initialize(key)
    @key = key
  end

  def init
    s = <<-EOD
      (function(c,a){window.mixpanel=a;var b,d,h,e;b=c.createElement("script");
      b.type="text/javascript";b.async=!0;b.src=("https:"===c.location.protocol?"https:":"http:")+
      '//cdn.mxpnl.com/libs/mixpanel-2.1.min.js';d=c.getElementsByTagName("script")[0];
      d.parentNode.insertBefore(b,d);a._i=[];a.init=function(b,c,f){function d(a,b){
      var c=b.split(".");2==c.length&&(a=a[c[0]],b=c[1]);a[b]=function(){a.push([b].concat(
      Array.prototype.slice.call(arguments,0)))}}var g=a;"undefined"!==typeof f?g=a[f]=[]:
      f="mixpanel";g.people=g.people||[];h=['disable','track','track_pageview','track_links',
      'track_forms','register','register_once','unregister','identify','name_tag',
      'set_config','people.identify','people.set','people.increment'];for(e=0;e<h.length;e++)d(g,h[e]);
      a._i.push([b,c,f])};a.__SV=1.1;})(document,window.mixpanel||[]);
      mixpanel.init("#{@key}");
    EOD
  end

  def register(registered_properties)
    %Q{mixpanel.register(#{registered_properties.to_json});}
  end

  def track(event_name, properties)
    p = properties.empty? ? "" : ", #{properties.to_json}"
    %Q{mixpanel.track("#{event_name}"#{p});}
  end

  def name_tag(name_tag)
    %Q{mixpanel.name_tag("#{name_tag}");}
  end

  def identify(distinct_id)
    %Q{mixpanel.identify("#{distinct_id}");}
  end
end
