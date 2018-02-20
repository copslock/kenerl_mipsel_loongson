Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 23:15:14 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:57775 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994696AbeBTWPEYsA1S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 23:15:04 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Feb 2018 22:14:51 +0000
Received: from [10.20.78.55] (10.20.78.55) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Tue, 20 Feb 2018 14:14:49 -0800
Date:   Tue, 20 Feb 2018 22:14:39 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <jhogan@kernel.org>
CC:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 08/12] MIPS: Align kernel load address to 64KB
In-Reply-To: <20180219230719.GC6245@saruman>
Message-ID: <alpine.DEB.2.00.1802202206490.3553@tp.orcam.me.uk>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com> <1517023336-17575-1-git-send-email-chenhc@lemote.com> <1517023336-17575-2-git-send-email-chenhc@lemote.com> <20180219230719.GC6245@saruman>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1519164889-298552-32213-36277-6
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190238
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
X-archive-position: 62659
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

On Mon, 19 Feb 2018, James Hogan wrote:

> > KEXEC assume kernel align to PAGE_SIZE, and 64KB is the largest
> > PAGE_SIZE.
> 
> Please expand, maybe referring to sanity_check_segment_list() which does
> the actual check. Maybe something like this:
> 
>  Kexec needs the new kernel's load address to be aligned on a page
>  boundary (see sanity_check_segment_list()), but on MIPS the default
>  vmlinuz load address is only explicitly aligned to 16 bytes.
> 
>  Since the largest PAGE_SIZE supported by MIPS kernels is 64KB, increase
>  the alignment calculated by calc_vmlinuz_load_addr to 64KB.

 But why does it have to be hardcoded?  Shouldn't it be inherited from 
the image being loaded?  I'm missing bits of context here, but that 
would be either CONFIG_PAGE_SIZE_* settings or the ELF program header's 
`p_align' value, depending on how this code operates.  Wasting say 60kB 
of memory on smaller systems due to excessive alignment might not be a 
good idea.

  Maciej
