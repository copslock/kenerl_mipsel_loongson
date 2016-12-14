Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2016 17:06:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51706 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992155AbcLNQGOgvGQT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Dec 2016 17:06:14 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id uBEG69N5007935;
        Wed, 14 Dec 2016 17:06:09 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id uBEG690L007934;
        Wed, 14 Dec 2016 17:06:09 +0100
Date:   Wed, 14 Dec 2016 17:06:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org
Subject: Re: next build: 198 builds: 4 failed, 194 passed, 7 errors, 82
 warnings (next-20161214)
Message-ID: <20161214160609.GA15191@linux-mips.org>
References: <58510536.04c7190a.4a2fb.ae5c@mx.google.com>
 <20161214135214.osrlldhxvxzfwial@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161214135214.osrlldhxvxzfwial@sirena.org.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56048
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

> On Wed, Dec 14, 2016 at 12:39:18AM -0800, kernelci.org bot wrote:
> 
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

I wonder if these are also toolchain-related issues.  allnoconfig and
tinyconfig do build fine for me with GCC 6.1.0 and binutils 2.26.20160125.

generic_defconfig requires mkimage of uboot-tools or it will fail like this:

  ITB     arch/mips/boot/vmlinux.gz.itb
"mkimage" command not found - U-Boot images will not be built
arch/mips/boot/Makefile:159: recipe for target 'arch/mips/boot/vmlinux.gz.itb' failed
make[1]: *** [arch/mips/boot/vmlinux.gz.itb] Error 1
arch/mips/Makefile:365: recipe for target 'vmlinux.gz.itb' failed
make: *** [vmlinux.gz.itb] Error 2

ip27_defconfig indeed has a build issue but it's new for 4.9 (commit
3ffc17d8768be705e292ac4c2e3ab1f18dc06047 ("MIPS: Adjust MIPS64 CAC_BASE to
reflect Config.K0")).  And with that patch reverted GCC 6.1.0 blows up with
an internal compilter error:

  CC [M]  drivers/net/ethernet/qlogic/qlge/qlge_main.o
drivers/net/ethernet/qlogic/qlge/qlge_main.c: In function ‘qlge_probe’:
drivers/net/ethernet/qlogic/qlge/qlge_main.c:4812:1: error: insn does not satisfy its constraints:
 }
 ^
(insn 1373 1371 1361 79 (parallel [
            (set (reg/f:DI 3 $3 [490])
                (symbol_ref:DI ("delayed_work_timer_fn") [flags 0x241] <function_decl 0x7fdb8658ed20 delayed_work_timer_fn>))
            (clobber (scratch:DI))
        ]) drivers/net/ethernet/qlogic/qlge/qlge_main.c:4690 287 {*lea64}
     (nil))
drivers/net/ethernet/qlogic/qlge/qlge_main.c:4812:1: internal compiler error: in extract_constrain_insn, at recog.c:2190
Please submit a full bug report,
with preprocessed source if appropriate.
See <http://gcc.gnu.org/bugs.html> for instructions.

GCC 6.2.0 dies the same way.

What binutils are you using and can you send me the build errors messages?

Thanks,

  Ralf
