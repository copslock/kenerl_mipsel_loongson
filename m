Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 23:18:02 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993032AbeHaVR6xN0Ji (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Aug 2018 23:17:58 +0200
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7VLBBUF007487
        for <linux-mips@linux-mips.org>; Fri, 31 Aug 2018 17:17:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m79m50jq9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 31 Aug 2018 17:17:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 31 Aug 2018 22:17:55 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Aug 2018 22:17:52 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7VLHppQ43647018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Aug 2018 21:17:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 356E2AE04D;
        Sat,  1 Sep 2018 00:17:19 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32171AE051;
        Sat,  1 Sep 2018 00:17:18 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.206.53])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  1 Sep 2018 00:17:18 +0100 (BST)
Date:   Sat, 1 Sep 2018 00:17:48 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mips: switch to NO_BOOTMEM
References: <1535356775-20396-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180830214856.cwqyjksz36ujxydm@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830214856.cwqyjksz36ujxydm@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18083121-0008-0000-0000-0000026A7A30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083121-0009-0000-0000-000021D27FDF
Message-Id: <20180831211747.GA31133@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-31_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808310211
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rppt@linux.vnet.ibm.com
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

Hi Paul,

On Thu, Aug 30, 2018 at 02:48:57PM -0700, Paul Burton wrote:
> Hi Mike,
> 
> On Mon, Aug 27, 2018 at 10:59:35AM +0300, Mike Rapoport wrote:
> > MIPS already has memblock support and all the memory is already registered
> > with it.
> > 
> > This patch replaces bootmem memory reservations with memblock ones and
> > removes the bootmem initialization.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> > 
> >  arch/mips/Kconfig                      |  1 +
> >  arch/mips/kernel/setup.c               | 89 +++++-----------------------------
> >  arch/mips/loongson64/loongson-3/numa.c | 34 ++++++-------
> >  arch/mips/sgi-ip27/ip27-memory.c       | 11 ++---
> >  4 files changed, 33 insertions(+), 102 deletions(-)
> 
> Thanks for working on this. Unfortunately it breaks boot for at least a
> 32r6el_defconfig kernel on QEMU:
> 
>   $ qemu-system-mips64el \
>     -M boston \
>     -kernel arch/mips/boot/vmlinux.gz.itb \
>     -serial stdio \
>     -append "earlycon=uart8250,mmio32,0x17ffe000,115200 console=ttyS0,115200 debug memblock=debug mminit_loglevel=4"
>   [    0.000000] Linux version 4.19.0-rc1-00008-g82d0f342eecd (pburton@pburton-laptop) (gcc version 8.1.0 (GCC)) #23 SMP Thu Aug 30 14:38:06 PDT 2018
>   [    0.000000] CPU0 revision is: 0001a900 (MIPS I6400)
>   [    0.000000] FPU revision is: 20f30300
>   [    0.000000] MSA revision is: 00000300
>   [    0.000000] MIPS: machine is img,boston
>   [    0.000000] Determined physical RAM map:
>   [    0.000000]  memory: 10000000 @ 00000000 (usable)
>   [    0.000000]  memory: 30000000 @ 90000000 (usable)
>   [    0.000000] earlycon: uart8250 at MMIO32 0x17ffe000 (options '115200')
>   [    0.000000] bootconsole [uart8250] enabled
>   [    0.000000] memblock_reserve: [0x00000000-0x009a8fff] setup_arch+0x224/0x718
>   [    0.000000] memblock_reserve: [0x01360000-0x01361ca7] setup_arch+0x3d8/0x718
>   [    0.000000] Initrd not found or empty - disabling initrd
>   [    0.000000] memblock_virt_alloc_try_nid: 7336 bytes align=0x40 nid=-1 from=0x00000000 max_addr=0x00000000 early_init_dt_alloc_memory_arch+0x20/0x2c
>   [    0.000000] memblock_reserve: [0xbfffe340-0xbfffffe7] memblock_virt_alloc_internal+0x120/0x1ec
>   <hang>
> 
> It looks like we took a TLB store exception after calling memset() with
> a bogus address from memblock_virt_alloc_try_nid() or something inlined
> into it.

Memblock tries to allocate from the top and the resulting address ends up
in the high memory. 

With the hunk below I was able to get to "VFS: Cannot open root device"

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4114d3c..4a9b0f7 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -577,6 +577,8 @@ static void __init bootmem_init(void)
         * Reserve initrd memory if needed.
         */
        finalize_initrd();
+
+       memblock_set_bottom_up(true);
 }
 
 #endif /* CONFIG_SGI_IP27 */
 
> This was with your patch applied atop the mips-next branch from [1],
> which is currently at commit 35d017947401 ("MIPS: ralink: Add rt3352
> SPI_CS1 pinmux").
> 
> Thanks,
>     Paul
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
> 

-- 
Sincerely yours,
Mike.
