Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7HJKdE10102
	for linux-mips-outgoing; Fri, 17 Aug 2001 12:20:39 -0700
Received: from artilemicro.com ([209.243.128.35])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HJKbj10099
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 12:20:37 -0700
Received: from taec.com (sunrise [209.243.129.241])
	by artilemicro.com (8.9.3+Sun/8.9.3) with ESMTP id MAA13055;
	Fri, 17 Aug 2001 12:20:27 -0700 (PDT)
Message-ID: <3B7D6E7B.9994255@taec.com>
Date: Fri, 17 Aug 2001 12:20:27 -0700
From: Hua Wen <wenh@taec.com>
Organization: Artile Microsystems, Inc.
X-Mailer: Mozilla 4.74 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: zh-CN, en, zh, zh-TW
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Upgrade kernel from release 2.2 to 2.4.?
References: <Pine.SOL.4.31.0105061221330.1956-100000@fury.csh.rit.edu> <3B7D5513.F10F35A1@taec.com> <3B7D57E4.D7B14D63@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Thank you very much, Jun.

One more thing -- we've made quite some changes in
2.2.1 so I wonder what would be the best way to
upgrade. I'm thinking:

1> check out new kernel, use "merge directories"
function from emacs, or

2> use "cvs import" to import the new kernel to
our local cvs repository, then merge with our
local changes by "cvs update/co -j"..

Any comments/suggestions?

Thanks!
-Hua

> >
> > We made changes to linux/MIPS kernel 2.2.1 for our
> > system and it's been running well so far. We now
> > plan to upgrade the kernel to 2.4.X. The question
> > is:
> >
> > Which sub release of 2.4 is more stable and is
> > recommended to use?
> >
> 
> I suggest you use the latest CVS head.  So far it is usually the head that has
> the most bug fixes, and really not much dramatic stuff introduced.
> 
> Jun
