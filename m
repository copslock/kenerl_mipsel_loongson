Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PJO5Rw023585
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 12:24:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PJO5MS023584
	for linux-mips-outgoing; Thu, 25 Jul 2002 12:24:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PJNvRw023575
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 12:23:59 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17XoEF-0002Zk-00; Thu, 25 Jul 2002 21:24:51 +0200
Date: Thu, 25 Jul 2002 21:24:51 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Jun Sun <jsun@mvista.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: LL/SC benchmarking [was: Mipsel libc with LL/SC online anywhere?]
Message-ID: <20020725192451.GB9832@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
	linux-mips@oss.sgi.com
References: <00ce01c229a4$a7d4ed40$10eca8c0@grendel> <20020719123828.GA5521@convergence.de> <20020725162539.GA8804@convergence.de> <3D40302F.40806@mvista.com> <20020725184519.GB9302@convergence.de> <3D4049D7.8090100@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4049D7.8090100@mvista.com>
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 25, 2002 at 11:56:23AM -0700, Jun Sun wrote:
> Johannes Stezenbach wrote:
> >OTOH I doubt it's worth it to add the branch-likely hack to
> >stock glibc. How many people are using Linux/MIPS on embedded
> >CPU's without LL/SC?
> 
> There are probably more than you think.  The popuplar (and notorious) NEC 
> VR41xx family fall into this category.  I think at least one or two other 
> families of CPUs are like this too.

Ok, then maybe we should have /proc/sys/ entries where the kernel
tells glibc about CPU capabilities and kernel support for
userpace atomic operations, like:

- no /proc/sys/mips/* : use ll/sc (maybe emulated)
- have /proc/sys/mips/mips2-without-llsc: use branch-likely, read
  to get MAGIC_COOKIE to use
- have /proc/sys/mips/sony-ps2: whatever
- ...

Or use a sysmips() call to get the information.


Johannes
