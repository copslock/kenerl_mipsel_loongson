Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2016 00:30:57 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:47943 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993269AbcKAXauDHNA1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Nov 2016 00:30:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=BD1hnzRE6R3Z+k4WrtSwYiTM46ZgFwYWLOJ0vycfuQs=; b=sQCbpqNAstyvLLrirQ866eFDwB
        /Q7X1HKNXz/F6H2EKb/leleeRQ4v+UD30flGHuz5bcDMGx+d3r3ylVRLrGP2OeSCGH1CApTCI5VQS
        ryPOpFUDNoPJvNyGBrStEoyGN8J5v1PJ59AAwrcNlSySdTIYEp5nX8+/mNOSHpXxCT7Dkd3UuFzyp
        dSAV+RoT1Az/7k1BdEtm7Cy+iBf4D5Dmzq5JmGfxDxLBsdMtVNkZLDi/ftNxtaYXjentsHP1i0rSL
        g0SEPcmFJL5JBtgF8QKoN1UUJj8d5alOyKKocw0xDwMxohsBGUQpBFwIcgyxvVPd+jeYAxxOBuHZp
        RHi9Yx1g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:60312 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1c1iVo-002lP4-K3; Tue, 01 Nov 2016 23:30:37 +0000
Date:   Tue, 1 Nov 2016 16:30:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] MIPS: VDSO: Always select -msoft-float
Message-ID: <20161101233038.GA25472@roeck-us.net>
References: <1477843551-21813-1-git-send-email-linux@roeck-us.net>
 <alpine.DEB.2.00.1611012208400.24498@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1611012208400.24498@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Tue, Nov 01, 2016 at 10:40:24PM +0000, Maciej W. Rozycki wrote:
> On Sun, 30 Oct 2016, Guenter Roeck wrote:
> 
> > Some toolchains fail to build mips images with the following build error.
> > 
> > arch/mips/vdso/gettimeofday.c:1:0: error: '-march=r3000' requires '-mfp32'
> > 
> > This is seen, for example, with the 'mipsel-linux-gnu-gcc (Debian 6.1.1-9)
> > 6.1.1 20160705' toolchain as used by the 0Day build robot when building
> > decstation_defconfig.
> > 
> > Comparison of compile flags suggests that the major difference is a missing
> > '-soft-float', which is otherwise defined unconditionally.
> > 
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Cc: James Hogan <james.hogan@imgtec.com>
> > Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> 
>  Using `-msoft-float' changes the floating-point ABI with the result being 
> incompatible with the rest of the userland.  I think the dynamic loader 
> may not be currently enforcing ABI compatibility here, but this may change 
> in the future.
> 
>  Using `-mno-float' in place of `-msoft-float' might be a safer option, 
> because even if we start enforcing floating-point ABI checks in dynamic 
> loading, then `-mno-float' DSOs will surely remain compatible with 
> everything else, because they guarantee no floating-point code or data 
> even to be ever produced by the compiler, be it using the software or the 
> hardware ABI.  One problem with that option is however that it is 
> apparently not universally accepted, for reasons unclear to me offhand.
> 
>  That written not so long ago I actually explicitly tried the config file 
> sent by the build bot reporting this issue and I built a kernel thus 
> configured with current upstream top-of-tree toolchain components, which 
> went just fine.  So what I suspect you've observied is just another sign 
> of a bug which has been already fixed, maybe even the very same binutils 
> bug I referred to recently.
> 
>  If you send me the generated assembly, i.e. `gettimeofday.s', that is 
> causing you trouble, then I'll see if I can figure out what is going on 
> here.  We may decide to paper a particularly nasty toolchain bug over from 

The problem is seen in 0Day builds, with the toolchain mentioned above.
I don't see the problem myself; I used to see it but switched toolchains
instead of trying to nail down the problem.

I don't think that generated assembly is going to help, though, since the
compiler fails to compile the code in the first place because, as it says,
it doesn't like '-march=r3000' without '-mfp32'.

Guenter
