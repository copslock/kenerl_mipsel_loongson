Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7HLWJA13531
	for linux-mips-outgoing; Fri, 17 Aug 2001 14:32:19 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HLWHj13528
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 14:32:17 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7HLavA20056;
	Fri, 17 Aug 2001 14:36:57 -0700
Message-ID: <3B7D8C06.D2DBC18C@mvista.com>
Date: Fri, 17 Aug 2001 14:26:30 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hua Wen <wenh@taec.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Upgrade kernel from release 2.2 to 2.4.?
References: <Pine.SOL.4.31.0105061221330.1956-100000@fury.csh.rit.edu> <3B7D5513.F10F35A1@taec.com> <3B7D57E4.D7B14D63@mvista.com> <3B7D6E7B.9994255@taec.com>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hua Wen wrote:
> 
> Thank you very much, Jun.
> 
> One more thing -- we've made quite some changes in
> 2.2.1 so I wonder what would be the best way to
> upgrade. I'm thinking:
> 
> 1> check out new kernel, use "merge directories"
> function from emacs, or
> 
> 2> use "cvs import" to import the new kernel to
> our local cvs repository, then merge with our
> local changes by "cvs update/co -j"..
> 
> Any comments/suggestions?
> 

Hmm, there is so much difference between 2.2.x and 2.4.x. I would think any
merging effort would be a nightmare.  Let alone later debugging effort.

The best thing is probably to extract what you *have* changed, and apply those
changes back to the current tree.

Jun

> Thanks!
> -Hua
> 
> > >
> > > We made changes to linux/MIPS kernel 2.2.1 for our
> > > system and it's been running well so far. We now
> > > plan to upgrade the kernel to 2.4.X. The question
> > > is:
> > >
> > > Which sub release of 2.4 is more stable and is
> > > recommended to use?
> > >
> >
> > I suggest you use the latest CVS head.  So far it is usually the head that has
> > the most bug fixes, and really not much dramatic stuff introduced.
> >
> > Jun
