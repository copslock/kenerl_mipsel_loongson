Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PGOnRw018281
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 09:24:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PGOnXT018280
	for linux-mips-outgoing; Thu, 25 Jul 2002 09:24:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PGOeRw018271
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 09:24:41 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17XlQp-0002IV-00; Thu, 25 Jul 2002 18:25:39 +0200
Date: Thu, 25 Jul 2002 18:25:39 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: LL/SC benchmarking [was: Mipsel libc with LL/SC online anywhere?]
Message-ID: <20020725162539.GA8804@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
References: <00ce01c229a4$a7d4ed40$10eca8c0@grendel> <20020719123828.GA5521@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719123828.GA5521@convergence.de>
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 19, 2002 at 02:38:29PM +0200, Johannes Stezenbach wrote:
> On Fri, Jul 12, 2002 at 03:04:07PM +0200, Kevin D. Kissell wrote:
> > I'm benchmarking some code that does lots of
> > semaphores, and with the libc from the "standard"
> > MIPS/SGI RH 7.1 distribution, those are done using
> > sysmips, in the interest of universality.
> 
> I'm working on a platform without LL/SC, an embedded system/SOC
> with a NEC VR4120A CPU core. To find out the effect of sysmips
> vs. emulated LL/SC vs. the branch-likely trick posted by
> Kevin D. Kissell <kevink@mips.com> on Tue, 22 Jan 2002 18:16:25 +0100
> I created an experimental patch for glibc-2.2.5 which allows
> run-time switching of the _test_and_set() and __compare_and_swap()
> implementation based on the presence of two "switch files" in /etc/.
... 
> For lack of a better benchmark I used some of the examples from
> glibc-2.2.5/linuxthreads/Examples. The numbers are from the third
> of three successive runs of 'time exN >/dev/null'.

I did some more benchmarking with a test application based on
gtk+-directfb (http://directfb.org/). The benchmark does not
include GUI stuff, but rather reading of lots of external data
into internal data structures (which are GLib-2.0 GObjects).
The test application has three threads, but nearly all processing
is done in the main thread.

I think that the numbers are meaningful for our type of application.

sysmips:
        real    1m19.358s
        user    0m28.150s
        sys     0m47.250s

LL/SC emulation:
        real    0m41.246s
        user    0m25.390s
        sys     0m12.240s

branch-likely hack (hm, still without kernel patch...):
        real    0m25.126s
        user    0m17.240s
        sys     0m2.310s


Regards,
Johannes
