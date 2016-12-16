Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2016 01:56:17 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50470 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993135AbcLPA4KCeuGO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Dec 2016 01:56:10 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id uBG0u7Jx014714;
        Fri, 16 Dec 2016 01:56:07 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id uBG0u72g014713;
        Fri, 16 Dec 2016 01:56:07 +0100
Date:   Fri, 16 Dec 2016 01:56:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org
Subject: Re: next build: 198 builds: 4 failed, 194 passed, 7 errors, 82
 warnings (next-20161214)
Message-ID: <20161216005606.GD15191@linux-mips.org>
References: <58510536.04c7190a.4a2fb.ae5c@mx.google.com>
 <20161214135214.osrlldhxvxzfwial@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214135214.osrlldhxvxzfwial@sirena.org.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56058
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

On Wed, Dec 14, 2016 at 01:52:14PM +0000, Mark Brown wrote:

> > mips:    gcc version 5.3.0 (Sourcery CodeBench Lite 2016.05-8)
> > 
> >     allnoconfig: FAIL
> >     generic_defconfig: FAIL
> >     ip27_defconfig: FAIL
> >     tinyconfig: FAIL
> 
> These MIPS builds have been failing in kernelci ever since MIPS was
> added.  This means that we've got a constant level of noise in the
> results which makes them less useful for everyone - people get used to
> ignoring errors.  Is there any plan to get these fixed?

I had to "bisect" binutils versions to hit the allnoconfig and tinyconfig
build issues.  Turns out it's a problem specific to binutils 2.25 which
when generating 32 bit ELF does not permit the use of 64 bit constants,
not even when explicitly to the 64 bit instruction set, for example:

	.set	mips3
	dli	$1, 0x9000000080000000

The only fix I was able to find that will work with all binutils, is
open coding the dli macro instruction as

	li	$1, 0x9000
	dsll	$1, $1, 48

Which is pretty much what the assembler should have generated from the dli
anyway.

  Ralf
