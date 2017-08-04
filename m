Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Aug 2017 00:25:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38034 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995104AbdHDWZCmj0lx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Aug 2017 00:25:02 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v74MP1FP008296;
        Sat, 5 Aug 2017 00:25:01 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v74MP0YD008295;
        Sat, 5 Aug 2017 00:25:00 +0200
Date:   Sat, 5 Aug 2017 00:25:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20170804222500.GA11675@linux-mips.org>
References: <20170803225547.6caa602b@windsurf.lan>
 <20170804000556.GC30597@linux-mips.org>
 <20170804151920.GA11317@linux-mips.org>
 <20170804174151.2eea9af3@windsurf.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804174151.2eea9af3@windsurf.lan>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Aug 04, 2017 at 05:41:51PM +0200, Thomas Petazzoni wrote:

> > > > The bug can be reproduced by building with the toolchain available at
> > > > http://toolchains.free-electrons.com/downloads/2017.08-rc1-fix-binutils/toolchains/mips64r6el-n32/tarballs/mips64r6el-n32--glibc--bleeding-edge-2017.05-1453-ga703fdd-1.tar.bz2
> > > > and building with the attached kernel configuration file.
> > > > 
> > > > It is not clear to me if this is a kernel issue (lack of __multi3 in
> > > > arch/mips/lib/), or a gcc bug in that it shouldn't emit a call to this
> > > > function.
> > > > 
> > > > FWIW, sparc64 had a similar issue, and they added __multi3 in their
> > > > libgcc replacement, see commit
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/sparc/lib?id=1b4af13ff2cc6897557bb0b8d9e2fad4fa4d67aa.  
> > > 
> > > I think these days we've given up the stuborn resistance of the old days
> > > against adding new libgcc1 functions to the kernel, so we should probably
> > > just add it.
> > > 
> > > I'm looking into this but a small wrench into the gear is that I'm still
> > > on GCC 6 so I'm off to building myself a cross-gcc first ...  
> > 
> > I now can reproduce the issue with vanilla FSF binutils 2.28 and GCC 7.1.0.
> 
> Great! However, looking at the functions that end up calling __multi3,
> I'm wondering why suddenly gcc 7.x needs to call such a function, while
> the same code was compiling without __multi3 in libgcc with gcc 6.x.

Chances are it's something specific to MIPS64 R6.  Before trying your
config file I also tried a number of other defconfigs and all built
well.

Here's a test case which generates a reference to __multi3:

unsigned long func(unsigned long a, unsigned long b)
{
        return a > (~0UL) / b;
}

GCC rearanges above statement to:

	return (unsigned __int128)a * (unsigned __int128) b > 0xffffffff;

computing which requires 128 bit intermediate results.  This is the
code generated for MIPS64 R2:

	dmultu	$4,$5
	mfhi	$2
	sltu	$2,$0,$2

And this is for R6:

	move	$2,$4
	move	$7,$5			# $6/$7 contain the second op
	move	$6,$0
	move	$4,$0
	move	$5,$2			# $4/$5 contain the first op
	sd	$31,8($sp)
	balc	__multi3
	sltu	$2,$0,$2

  Ralf
