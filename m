Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 20:38:15 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994630AbeIESiFTzdvl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 20:38:05 +0200
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85IZho2140212
        for <linux-mips@linux-mips.org>; Wed, 5 Sep 2018 14:38:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mam171en6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 05 Sep 2018 14:38:02 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 19:38:00 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 19:37:56 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85IbtpP39976960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 18:37:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20B6F11C050;
        Wed,  5 Sep 2018 21:37:48 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B19111C052;
        Wed,  5 Sep 2018 21:37:47 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.206.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Sep 2018 21:37:47 +0100 (BST)
Date:   Wed, 5 Sep 2018 21:37:52 +0300
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
 <20180831211747.GA31133@rapoport-lnx>
 <20180905174709.pz2rmyt2oob6bxpz@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905174709.pz2rmyt2oob6bxpz@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090518-0008-0000-0000-0000026CCA04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090518-0009-0000-0000-000021D4E8A2
Message-Id: <20180905183751.GA4518@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050185
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65994
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

On Wed, Sep 05, 2018 at 10:47:10AM -0700, Paul Burton wrote:
> Hi Mike,
> 
> On Sat, Sep 01, 2018 at 12:17:48AM +0300, Mike Rapoport wrote:
> > On Thu, Aug 30, 2018 at 02:48:57PM -0700, Paul Burton wrote:
> > > On Mon, Aug 27, 2018 at 10:59:35AM +0300, Mike Rapoport wrote:
> > > > MIPS already has memblock support and all the memory is already registered
> > > > with it.
> > > > 
> > > > This patch replaces bootmem memory reservations with memblock ones and
> > > > removes the bootmem initialization.
> > > > 
> > > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > > > ---
> > > > 
> > > >  arch/mips/Kconfig                      |  1 +
> > > >  arch/mips/kernel/setup.c               | 89 +++++-----------------------------
> > > >  arch/mips/loongson64/loongson-3/numa.c | 34 ++++++-------
> > > >  arch/mips/sgi-ip27/ip27-memory.c       | 11 ++---
> > > >  4 files changed, 33 insertions(+), 102 deletions(-)
> > > 
> > > Thanks for working on this. Unfortunately it breaks boot for at least a
> > > 32r6el_defconfig kernel on QEMU:
> > > 
> > >   $ qemu-system-mips64el \
> > >     -M boston \
> > >     -kernel arch/mips/boot/vmlinux.gz.itb \
> > >     -serial stdio \
> > >     -append "earlycon=uart8250,mmio32,0x17ffe000,115200 console=ttyS0,115200 debug memblock=debug mminit_loglevel=4"
> > >   [    0.000000] Linux version 4.19.0-rc1-00008-g82d0f342eecd (pburton@pburton-laptop) (gcc version 8.1.0 (GCC)) #23 SMP Thu Aug 30 14:38:06 PDT 2018
> > >   [    0.000000] CPU0 revision is: 0001a900 (MIPS I6400)
> > >   [    0.000000] FPU revision is: 20f30300
> > >   [    0.000000] MSA revision is: 00000300
> > >   [    0.000000] MIPS: machine is img,boston
> > >   [    0.000000] Determined physical RAM map:
> > >   [    0.000000]  memory: 10000000 @ 00000000 (usable)
> > >   [    0.000000]  memory: 30000000 @ 90000000 (usable)
> > >   [    0.000000] earlycon: uart8250 at MMIO32 0x17ffe000 (options '115200')
> > >   [    0.000000] bootconsole [uart8250] enabled
> > >   [    0.000000] memblock_reserve: [0x00000000-0x009a8fff] setup_arch+0x224/0x718
> > >   [    0.000000] memblock_reserve: [0x01360000-0x01361ca7] setup_arch+0x3d8/0x718
> > >   [    0.000000] Initrd not found or empty - disabling initrd
> > >   [    0.000000] memblock_virt_alloc_try_nid: 7336 bytes align=0x40 nid=-1 from=0x00000000 max_addr=0x00000000 early_init_dt_alloc_memory_arch+0x20/0x2c
> > >   [    0.000000] memblock_reserve: [0xbfffe340-0xbfffffe7] memblock_virt_alloc_internal+0x120/0x1ec
> > >   <hang>
> > > 
> > > It looks like we took a TLB store exception after calling memset() with
> > > a bogus address from memblock_virt_alloc_try_nid() or something inlined
> > > into it.
> > 
> > Memblock tries to allocate from the top and the resulting address ends up
> > in the high memory. 
> > 
> > With the hunk below I was able to get to "VFS: Cannot open root device"
> > 
> > diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> > index 4114d3c..4a9b0f7 100644
> > --- a/arch/mips/kernel/setup.c
> > +++ b/arch/mips/kernel/setup.c
> > @@ -577,6 +577,8 @@ static void __init bootmem_init(void)
> >          * Reserve initrd memory if needed.
> >          */
> >         finalize_initrd();
> > +
> > +       memblock_set_bottom_up(true);
> >  }
> 
> That does seem to fix it, and some basic tests are looking good.

The bottom up mode has the downside of allocating memory below
MAX_DMA_ADDRESS. 

I'd like to check if memblock_set_current_limit(max_low_pfn) will also fix
the issue, at least with the limited tests I can do with qemu.

> I notice you submitted this as part of your larger series to remove
> bootmem - are you still happy for me to take this one through mips-next?

Sure, I've just posted it as the part of the larger series for completeness.

I believe that in the next few days I'll be able to verify whether
memblock_set_current_limit() can be used instead of
memblock_set_bottom_up() and I'll resend the patch then.

> Thanks,
>     Paul
> 

-- 
Sincerely yours,
Mike.
