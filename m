Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 00:46:14 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:46435 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990422AbeBTXp4mNAI5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 00:45:56 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Feb 2018 23:45:26 +0000
Received: from [10.20.78.55] (10.20.78.55) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Tue, 20 Feb 2018 15:38:36 -0800
Date:   Tue, 20 Feb 2018 23:38:26 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <james.hogan@mips.com>
CC:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 08/12] MIPS: Align kernel load address to 64KB
In-Reply-To: <20180220225845.GG29460@jhogan-linux.mipstec.com>
Message-ID: <alpine.DEB.2.00.1802202313480.3553@tp.orcam.me.uk>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com> <1517023336-17575-1-git-send-email-chenhc@lemote.com> <1517023336-17575-2-git-send-email-chenhc@lemote.com> <20180219230719.GC6245@saruman> <alpine.DEB.2.00.1802202206490.3553@tp.orcam.me.uk>
 <20180220222542.GF29460@jhogan-linux.mipstec.com> <alpine.DEB.2.00.1802202249410.3553@tp.orcam.me.uk> <20180220225845.GG29460@jhogan-linux.mipstec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1519170324-298553-23596-16781-7
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190242
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn'
        t match header 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62666
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

> >  As I say, I'm missing bits of context.  If you say that a 64kiB-page 
> > kernel loads a 4kiB-page kernel, then the alignment for the latter is 
> > obviously 4kiB.  So I repeat my question: why hardcode the alignment to 
> > 64kiB while we only need 4kiB in this case?
> 
> Because its the 1st kernel which is doing the kexec'ing of the 2nd
> kernel. The 2nd kernel might not even have kexec enabled, but you still
> might want to boot it using kexec.

 Forgive my dumbness, but I don't understand what's preventing the 1st 
kernel from getting the alignment of the 2nd kernel (regardless of 
whether the 2nd kernel has kexec enabled).  What prevents the 1st kernel 
from interpreting the `p_align' value from the relevant program header 
of the 2nd kernel before loading the segment the header describes?  It 
has to load the header anyway or it wouldn't know how much data to load 
and where from into the file, and how much BSS space to initialise.

 Here's an example program header dump from `vmlinux':

$ readelf -l vmlinux

Elf file type is EXEC (Executable file)
Entry point 0x80506e70
There are 3 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  ABIFLAGS       0x4b02e8 0x805ac2e8 0x805ac2e8 0x00018 0x00018 R   0x8
  LOAD           0x004000 0x80100000 0x80100000 0x534650 0x569710 RWE 0x4000
  NOTE           0x4145a8 0x805105a8 0x805105a8 0x00024 0x00024 R   0x4

 Section to Segment mapping:
  Segment Sections...
   00     .MIPS.abiflags
   01     .text __ex_table .notes .rodata .MIPS.abiflags .pci_fixup __ksymtab __ksymtab_gpl __kcrctab __kcrctab_gpl __ksymtab_strings __param __modver .data .init.text .init.data .exit.text .bss
   02     .notes
$ 

As you can see there's only one loadable segment (the usual case) and 
its alignment is 0x4000, that is 16kiB.  So this kernel uses a page size 
of 16kiB.

  Maciej
