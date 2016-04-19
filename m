Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 10:22:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26951 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006653AbcDSIWH3NhT6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 10:22:07 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id DAF12A7DE0788;
        Tue, 19 Apr 2016 09:21:58 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 19 Apr 2016 09:22:01 +0100
Received: from localhost (10.100.200.185) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 19 Apr
 2016 09:22:00 +0100
Date:   Tue, 19 Apr 2016 09:22:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle
        <ralf@linux-mips.org>, James Hogan <james.hogan@imgtec.com>, "# v4 . 1+"
        <stable@vger.kernel.org>, David Daney <david.daney@cavium.com>, Huacai Chen
        <chenhc@lemote.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, "Paul
 Gortmaker" <paul.gortmaker@windriver.com>, Aneesh Kumar K.V
        <aneesh.kumar@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, David Hildenbrand
        <dahi@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Jerome
 Marchand <jmarchan@redhat.com>, Markos Chandras <markos.chandras@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>, "Kirill A. Shutemov"
        <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 07/13] MIPS: mm: Fix MIPS32 36b physical addressing
 (alchemy, netlogic)
Message-ID: <20160419082200.GA24943@NP-P-BURTON>
References: <1460972133-16973-1-git-send-email-paul.burton@imgtec.com>
 <1460972133-16973-8-git-send-email-paul.burton@imgtec.com>
 <CAOLZvyGWBuUoo3C5V3L9g6Lbswf1cj6=6TSdgehuGeJch8-V=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAOLZvyGWBuUoo3C5V3L9g6Lbswf1cj6=6TSdgehuGeJch8-V=Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.185]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Mon, Apr 18, 2016 at 04:34:10PM +0200, Manuel Lauss wrote:
> On Mon, Apr 18, 2016 at 11:35 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> > There are 2 distinct cases in which a kernel for a MIPS32 CPU
> > (CONFIG_CPU_MIPS32=y) may use 64 bit physical addresses
> > (CONFIG_PHYS_ADDR_T_64BIT=y):
> >
> >   - 36 bit physical addressing as used by RMI Alchemy & Netlogic XLP/XLR
> >     CPUs.
> >
> >   - MIPS32r5 eXtended Physical Addressing (XPA).
> 
> This hunk here gives me a build failure on Alchemy:
> 
> /home/mano/dev/db1200/kernel/linux/arch/mips/mm/init.c: In function
> '__kmap_pgprot':
> /home/mano/dev/db1200/kernel/linux/arch/mips/mm/init.c:116:28: error:
> '_PFNX_MASK' undeclared (first use in this function)
>    entrylo = (pte.pte_low & _PFNX_MASK);

Hi Manuel,

Sorry, I was trying to avoid #ifdef's too much in patch 12... v3 coming
shortly.

Thanks,
    Paul
