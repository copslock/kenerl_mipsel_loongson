Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2018 13:42:32 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:39734 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992618AbeCBMmZUEula (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Mar 2018 13:42:25 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 02 Mar 2018 12:42:08 +0000
Received: from [10.20.78.177] (10.20.78.177) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Fri, 2 Mar 2018
 04:07:58 -0800
Date:   Fri, 2 Mar 2018 12:07:46 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 1/2] MIPS: Loongson64: Select
 ARCH_MIGHT_HAVE_PC_PARPORT
In-Reply-To: <1519871862-14624-1-git-send-email-chenhc@lemote.com>
Message-ID: <alpine.DEB.2.00.1803021204250.10166@tp.orcam.me.uk>
References: <1519871862-14624-1-git-send-email-chenhc@lemote.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1519994526-298555-16341-23882-10
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190597
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
X-archive-position: 62772
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

On Wed, 28 Feb 2018, Huacai Chen wrote:

> diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
> index bc2fdbf..12812a8b 100644
> --- a/arch/mips/loongson64/Kconfig
> +++ b/arch/mips/loongson64/Kconfig
> @@ -7,6 +7,7 @@ choice
>  config LEMOTE_FULOONG2E
>  	bool "Lemote Fuloong(2e) mini-PC"
>  	select ARCH_SPARSEMEM_ENABLE
> +	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select CEVT_R4K
>  	select CSRC_R4K
>  	select SYS_HAS_CPU_LOONGSON2E

 Hmm, I don't think the Fuloong(2e) machine has a parallel port connector.  
The chipset may support the port, but with no external connection I think 
there's no point in enabling it.  Or am I missing something?

  Maciej
