Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3JGEK8d006800
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Apr 2002 09:14:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3JGEK17006799
	for linux-mips-outgoing; Fri, 19 Apr 2002 09:14:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from coplin09.mips.com ([80.63.7.130])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3JGEF8d006795
	for <linux-mips@oss.sgi.com>; Fri, 19 Apr 2002 09:14:15 -0700
Received: (from hartvige@localhost)
	by coplin09.mips.com (8.11.6/8.11.6) id g3JGDpG02449;
	Fri, 19 Apr 2002 18:13:51 +0200
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200204191613.g3JGDpG02449@coplin09.mips.com>
Subject: Re: FYI: release of snow toolchain builder 1.4
To: js@convergence.de (Johannes Stezenbach)
Date: Fri, 19 Apr 2002 18:13:51 +0200 (CEST)
Cc: nop@nop.com (Jay Carlson), linux-mips@oss.sgi.com
In-Reply-To: <20020419150716.GA6686@convergence.de> from "Johannes Stezenbach" at Apr 19, 2002 05:07:16 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

We're doing a test-project with Algorithmics, implementing MIPS16 and
MIPS16e PIC support in SDE. I'll post results on the list when we have some.

/Hartvig


Johannes Stezenbach writes:
> 
> On Thu, Apr 18, 2002 at 09:05:39AM -0400, Jay Carlson wrote:
> > Snow could be the basis for MIPS16 work, since -fpic MIPS16 looks 
> > difficult.  However, the compiler I currently use, Debian gcc 2.95.4, is 
> > completely broken for -mips16.  (I'd say "can't compile dhrystone" is a 
> > good metric.  :-)  If anybody sends me a known-good MIPS16 platform, I'd 
> > be delighted to make snow work on it.  (At this point, getting MIPS16 
> > working under Linux is a matter of personal honor to me.)
> 
> I've just asked on the gcc mailing list, and someone at
> Redhat is currently working on mips16 support on the
> CVS trunk, i.e. it won't be in gcc-3.1. If it receives
> sufficient testing, gcc-3.2 might work for mips16 stuff.
> GNU-Pro from Redhat and the Algorithmics toolchain should
> work, too.
> 
> 
> Regards,
> Johannes


-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
