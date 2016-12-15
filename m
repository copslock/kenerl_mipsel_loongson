Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2016 04:22:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52248 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990519AbcLODWniYSNk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Dec 2016 04:22:43 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id uBF3Mg7e028683;
        Thu, 15 Dec 2016 04:22:42 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id uBF3MfaO028682;
        Thu, 15 Dec 2016 04:22:41 +0100
Date:   Thu, 15 Dec 2016 04:22:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org
Subject: Re: next build: 198 builds: 4 failed, 194 passed, 7 errors, 82
 warnings (next-20161214)
Message-ID: <20161215032241.GB15191@linux-mips.org>
References: <58510536.04c7190a.4a2fb.ae5c@mx.google.com>
 <20161214135214.osrlldhxvxzfwial@sirena.org.uk>
 <20161214160609.GA15191@linux-mips.org>
 <20161214174539.h3xsugswlq576g7b@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214174539.h3xsugswlq576g7b@sirena.org.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56053
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

On Wed, Dec 14, 2016 at 05:45:39PM +0000, Mark Brown wrote:
> Date:   Wed, 14 Dec 2016 17:45:39 +0000
> From: Mark Brown <broonie@kernel.org>
> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org
> Subject: Re: next build: 198 builds: 4 failed, 194 passed, 7 errors, 82
>  warnings (next-20161214)
> Content-Type: multipart/signed; micalg=pgp-sha256;
>         protocol="application/pgp-signature"; boundary="pme7352aoyqgs7t5"
> 
> On Wed, Dec 14, 2016 at 05:06:09PM +0100, Ralf Baechle wrote:
> > On Wed, Dec 14, 2016 at 01:52:14PM +0000, Mark Brown wrote:
> > > On Wed, Dec 14, 2016 at 12:39:18AM -0800, kernelci.org bot wrote:
> 
> > > > mips:    gcc version 5.3.0 (Sourcery CodeBench Lite 2016.05-8)
> 
> > > These MIPS builds have been failing in kernelci ever since MIPS was
> > > added.  This means that we've got a constant level of noise in the
> > > results which makes them less useful for everyone - people get used to
> > > ignoring errors.  Is there any plan to get these fixed?
> 
> > I wonder if these are also toolchain-related issues.  allnoconfig and
> > tinyconfig do build fine for me with GCC 6.1.0 and binutils 2.26.20160125.
> 
> > generic_defconfig requires mkimage of uboot-tools or it will fail like this:
> 
> >   ITB     arch/mips/boot/vmlinux.gz.itb
> > "mkimage" command not found - U-Boot images will not be built
> > arch/mips/boot/Makefile:159: recipe for target 'arch/mips/boot/vmlinux.gz.itb' failed
> > make[1]: *** [arch/mips/boot/vmlinux.gz.itb] Error 1
> > arch/mips/Makefile:365: recipe for target 'vmlinux.gz.itb' failed
> > make: *** [vmlinux.gz.itb] Error 2
> 
> Ah, you don't have a separate uImage target?
> 
> > What binutils are you using and can you send me the build errors messages?
> 
> You can see logs for all the trees we build via the web interface:
> 
>    https://kernelci.org/job/
> 
> I don't have access to the builders to check the binutils version
> without going and finding/downloading the CodeSourcery release.  Where
> did your toolchain come from, is there something specific recommended
> for MIPS?

I specifically avoid non-standard toolchains, that is I stick to the
vanilla FSF releases with no feature patches.

Some configurations, in particular new cores or architecture variants
may require vendor tool- chains or patches until support makes it upstream.
I wonder if for the benefit of automated build testing we should tag
kernel configurations with a special CONFIG_ symbol to indicate they need
non-standard tools?  That would allow build testing to detect and
possibly skip such configuration.

  Ralf
