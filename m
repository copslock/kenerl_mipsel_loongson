Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 23:54:05 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:35949 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994692AbeBTWx5VSCt5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 23:53:57 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Feb 2018 22:53:42 +0000
Received: from [10.20.78.55] (10.20.78.55) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Tue, 20 Feb 2018 14:53:28 -0800
Date:   Tue, 20 Feb 2018 22:53:19 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <james.hogan@mips.com>
CC:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 08/12] MIPS: Align kernel load address to 64KB
In-Reply-To: <20180220222542.GF29460@jhogan-linux.mipstec.com>
Message-ID: <alpine.DEB.2.00.1802202249410.3553@tp.orcam.me.uk>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com> <1517023336-17575-1-git-send-email-chenhc@lemote.com> <1517023336-17575-2-git-send-email-chenhc@lemote.com> <20180219230719.GC6245@saruman> <alpine.DEB.2.00.1802202206490.3553@tp.orcam.me.uk>
 <20180220222542.GF29460@jhogan-linux.mipstec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1519167221-321457-15748-4175-7
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190241
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62662
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

> > >  Since the largest PAGE_SIZE supported by MIPS kernels is 64KB, increase
> > >  the alignment calculated by calc_vmlinuz_load_addr to 64KB.
> > 
> >  But why does it have to be hardcoded?  Shouldn't it be inherited from 
> > the image being loaded?  I'm missing bits of context here, but that 
> > would be either CONFIG_PAGE_SIZE_* settings or the ELF program header's 
> > `p_align' value, depending on how this code operates.  Wasting say 60kB 
> > of memory on smaller systems due to excessive alignment might not be a 
> > good idea.
> 
> I presume there's nothing to stop a kernel with 64KB pages (and hence
> requiring 64KB alignment of load sections) loading a new kernel with 4KB
> pages (which is the one we're looking at).

 As I say, I'm missing bits of context.  If you say that a 64kiB-page 
kernel loads a 4kiB-page kernel, then the alignment for the latter is 
obviously 4kiB.  So I repeat my question: why hardcode the alignment to 
64kiB while we only need 4kiB in this case?

  Maciej
