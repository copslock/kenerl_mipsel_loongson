Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 11:09:41 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:49882 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeBUKJcI1FX- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 11:09:32 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 21 Feb 2018 10:09:20 +0000
Received: from [10.20.78.64] (10.20.78.64) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Wed, 21 Feb 2018 02:09:15 -0800
Date:   Wed, 21 Feb 2018 10:09:06 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <jhogan@kernel.org>
CC:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Introduce and use WAR_LLSC_MB
In-Reply-To: <20180220222153.GG6245@saruman>
Message-ID: <alpine.DEB.2.00.1802202339250.3553@tp.orcam.me.uk>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com> <1517023381-17624-1-git-send-email-chenhc@lemote.com> <1517023381-17624-3-git-send-email-chenhc@lemote.com> <20180220222153.GG6245@saruman>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1519207760-298553-23595-46350-1
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190257
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

On Tue, 20 Feb 2018, James Hogan wrote:

> > diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
> > index 0fce460..3700dcf 100644
> > --- a/arch/mips/loongson64/Platform
> > +++ b/arch/mips/loongson64/Platform
> > @@ -23,6 +23,9 @@ ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
> >  endif
> >  
> >  cflags-$(CONFIG_CPU_LOONGSON3)	+= -Wa,--trap
> > +ifneq ($(call as-option,-Wa$(comma)-mfix-loongson3-llsc,),)
> > +  cflags-$(CONFIG_CPU_LOONGSON3) += -Wa$(comma)-mno-fix-loongson3-llsc
> > +endif
> 
> Could this be a separate patch?
> 
> This needs more explanation.
> - What does this do exactly?
> - Why are you turning *OFF* the compiler fix?
> - Was some fix we don't want already in use by default?

 FYI, support for `-mfix-loongson3-llsc' in GAS has only recently been 
proposed: <https://sourceware.org/ml/binutils/2018-01/msg00303.html> and 
is still pending review.

  Maciej
