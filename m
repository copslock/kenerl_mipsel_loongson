Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA03104; Thu, 14 Aug 1997 08:33:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA09359 for linux-list; Thu, 14 Aug 1997 08:32:05 -0700
Received: from wolfi (wolfi.munich.sgi.com [144.253.193.137]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA09334 for <linux@cthulhu.engr.sgi.com>; Thu, 14 Aug 1997 08:32:00 -0700
Received: by wolfi (951211.SGI.8.6.12.PATCH1502/911001.SGI)
	 id RAA08015; Thu, 14 Aug 1997 17:31:50 +0200
From: "Wolfgang Szoecs" <wolfi@wolfi.munich.sgi.com>
Message-Id: <9708141731.ZM8013@wolfi.munich.sgi.com>
Date: Thu, 14 Aug 1997 17:31:49 -0600
In-Reply-To: Eric Kimminau <eak@cygnus.detroit.sgi.com>
        "Re: linus accessible from within SGI" (Aug 13,  4:44pm)
References: <199708132022.NAA27369@oz.engr.sgi.com> 
	<33F21CB2.7464B074@cygnus.detroit.sgi.com>
X-Face: #LcK<jh]~&dSf9/9`e^boi!,v*y*;p%X(Us-`/l9'y8-:K-^v8nDd!{fKBt>OH<uvJep=4C
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  x<f0jh~RTX\W$n:r_k@-Yh>(|K{8#|+m.SSjuj71\l:E^{2CLF!F)@?@6@?mZ>v6P"_ZI6<#a~5Di%
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  9pd"U4Ul3mE33osz@b^@kn;y@1r-)cE6mFo?\wtp$kF*
X-Mailer: Z-Mail-SGI (3.2S.2 10apr95 MediaMail)
To: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: linus accessible from within SGI
Cc: comm-tech@rock.csd.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

...that's not true.
even today i got routed from the office in Munich to nirvana:

$ /usr/etc/traceroute linus.linux.sgi.com
traceroute to linus.linux.sgi.com (192.48.153.197), 30 hops max, 40 byte
packets
 1  gate-wanmunich.munich.sgi.com (144.253.193.1)  2 ms  1 ms  2 ms
 2  169.238.216.2 (169.238.216.2)  267 ms  286 ms  275 ms
 3  b20wanring.corp.sgi.com (155.11.108.2)  265 ms  266 ms  266 ms
 4  b1wanring.corp.sgi.com (155.11.108.1)  263 ms (ttl=253!)  264 ms (ttl=253!)
 268 ms (ttl=253!)
 5  b1dco-cisco1-141.corp.sgi.com (150.166.141.40)  287 ms (ttl=252!)  268 ms
(ttl=252!)  266 ms (ttl=252!)
 6  gate2-dumpty.corp.sgi.com (150.166.100.61)  336 ms (ttl=251!)  272 ms
(ttl=251!)  262 ms (ttl=251!)
 7  gate2-dumpty.corp.sgi.com (150.166.100.61)  265 ms (ttl=251!) !H  280 ms
(ttl=251!) !H  292 ms (ttl=251!) !H


That's it.

BTW, i'm searching for a kernel image for booting a linux-NFS-root.
Does anybody have one, and could give me that ?
(a root-fs i already have)

Regards Wolfgang

-- 
\------------------------------------------------\        _         ______ |
 \  Wolfgang Szoecs   Software Support Engineer   \     /SGI\____-=0`/|0`/__|
  \  Silicon Graphics GmbH, Munich / Germany       \____\Munich     / | /    )
  /         SMTP: wolfi@munich.sgi.com             /     `/-==_____/__|/__=-|
 / Phone: 0130/112550     | Fax: 089/46108 190    /      *             \ | |
/------------------------------------------------/                     (o)
Redistribution of this message via the Microsoft Network is prohibited
