Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7FJiERw010099
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 15 Aug 2002 12:44:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7FJiDJa010098
	for linux-mips-outgoing; Thu, 15 Aug 2002 12:44:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-116.ka.dial.de.ignite.net [62.180.196.116])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7FJi5Rw010089
	for <linux-mips@oss.sgi.com>; Thu, 15 Aug 2002 12:44:07 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7FJkfn12337
	for linux-mips@oss.sgi.com; Thu, 15 Aug 2002 21:46:41 +0200
Date: Thu, 15 Aug 2002 21:46:41 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20020815214641.A8335@linux-mips.org>
References: <200208151925.g7FJPbfD009802@oss.sgi.com> <20020815193340.GB10730@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020815193340.GB10730@lug-owl.de>; from jbglaw@lug-owl.de on Thu, Aug 15, 2002 at 09:33:40PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 15, 2002 at 09:33:40PM +0200, Jan-Benedict Glaw wrote:

> > 	arch/mips/boot : Tag: linux_2_4 elf2ecoff.c 
> > 
> > Log message:
> > 	Run through indent.  Convert from K&R C to ANSI.  Further crapectomy.
> 
> Only a notice: is by now known what elf2ecoff broke? As an effect, I see
> that modern (TM) elf2ecoffs fail to produce an loadable kernel for my
> indy (which boots fine with ELF, too).
> 
> However, it could also be a problem with changes addresses or so
> somewhere else (eg. ./linux/arch/mips/Makefile)...

Could you try older versions of the elf2ecoff utility from CVS to see
if that is making a difference?

  Ralf

PS: Please obey the reply-to header of linux-cvs postings.  This is not
    a discussion list and I plan to configure the list to send anything
    that isn't a CVS notification to /dev/null in the future.
