Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 09:40:05 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991062AbeKIIi6EipuQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2018 09:38:58 +0100
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA98YLH4101931
        for <linux-mips@linux-mips.org>; Fri, 9 Nov 2018 03:38:56 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nn564kyh3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 09 Nov 2018 03:38:56 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.ibm.com>;
        Fri, 9 Nov 2018 08:38:53 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 9 Nov 2018 08:38:51 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA98codP64684168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 08:38:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0950A405B;
        Fri,  9 Nov 2018 08:38:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAA3AA4054;
        Fri,  9 Nov 2018 08:38:49 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.51])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Nov 2018 08:38:49 +0000 (GMT)
Date:   Fri, 9 Nov 2018 10:38:48 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rppt <rppt@linux.vnet.ibm.com>
Subject: Re: [[PATCH]] mips: Fix switch to NO_BOOTMEM for SGI-IP27/loongons3
 NUMA
References: <20181108144428.28149-1-tbogendoerfer@suse.de>
 <20181108161823.GB15707@rapoport-lnx>
 <20181108175217.f55065d6115edbafd6aa3487@suse.de>
 <43783525-DEC2-46A5-A61E-4C3BF3DDE4A0@linux.ibm.com>
 <tencent_4F1049E7045AD21E19098484@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_4F1049E7045AD21E19098484@qq.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18110908-4275-0000-0000-000002DE3988
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110908-4276-0000-0000-000037EB3B91
Message-Id: <20181109083847.GA7819@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811090081
Return-Path: <rppt@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rppt@linux.ibm.com
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

On Fri, Nov 09, 2018 at 10:54:26AM +0800, 陈华才 wrote:
> Hi,
> 
> It seems the patch below can solve many problems after switched to NO_BOOTMEM, because the memory allocation behavior is more similar as before.

Yes, this should work.
Still, simplifying the max_low_pfn evaluation has it's value regardless.
 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 070234b..7a449d9 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -839,6 +839,7 @@ static void __init arch_mem_init(char **cmdline_p)
> 
>         /* call board setup routine */
>         plat_mem_setup();
> +       memblock_set_bottom_up(true);
> 
>         /*
>          * Make sure all kernel memory is in the maps.  The "UP" and
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 0f852e1..15e103c 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -2260,10 +2260,8 @@ void __init trap_init(void)
>                 unsigned long size = 0x200 + VECTORSPACING*64;
>                 phys_addr_t ebase_pa;
> 
> -               memblock_set_bottom_up(true);
>                 ebase = (unsigned long)
>                         memblock_alloc_from(size, 1 << fls(size), 0);
> -               memblock_set_bottom_up(false);
> 
>                 /*
>                  * Try to ensure ebase resides in KSeg0 if possible.
> @@ -2307,6 +2305,7 @@ void __init trap_init(void)
>         if (board_ebase_setup)
>                 board_ebase_setup();
>         per_cpu_trap_init(true);
> +       memblock_set_bottom_up(false);
> 
>         /*
>          * Copy the generic exception handlers to their final destination.
> 
>  
> ------------------ Original ------------------
> From:  "Mike Rapoport"<rppt@linux.ibm.com>;
> Date:  Fri, Nov 9, 2018 02:01 AM
> To:  "Thomas Bogendoerfer"<tbogendoerfer@suse.de>;
> Cc:  "Ralf Baechle"<ralf@linux-mips.org>; "Paul Burton"<paul.burton@mips.com>; "James Hogan"<jhogan@kernel.org>; "Huacai Chen"<chenhc@lemote.com>; "linux-mips"<linux-mips@linux-mips.org>; "linux-kernel"<linux-kernel@vger.kernel.org>; "rppt"<rppt@linux.vnet.ibm.com>;
> Subject:  Re: [[PATCH]] mips: Fix switch to NO_BOOTMEM for SGI-IP27/loongons3 NUMA
>  
> 
> 
> On November 8, 2018 6:52:17 PM GMT+02:00, Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:
> >On Thu, 8 Nov 2018 18:18:23 +0200
> >Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> >> On Thu, Nov 08, 2018 at 03:44:28PM +0100, Thomas Bogendoerfer wrote:
> >> > Commit bcec54bf3118 ("mips: switch to NO_BOOTMEM") broke SGI-IP27
> >> > and NUMA enabled loongson3 by doing memblock_set_current_limit()
> >> > before max_low_pfn has been evaluated. Both platforms need to do
> >the
> >> > memblock_set_current_limit() in platform specific code. For
> >> > consistency the call to memblock_set_current_limit() is moved
> >> > to the common bootmem_init(), where max_low_pfn is calculated
> >> > for non NUMA enabled platforms.
> >> [..]
> >> 
> >> As for SGI-IP27, the initialization of max_low_pfn as late as in
> >> paging_init() seems to be broken because it's value is used in
> >> arch_mem_init() and in finalize_initrd() anyway.
> >
> >well, the patch is tested on real hardware and the first caller of
> >a memblock_alloc* function is in a function called by
> >free_area_init_nodes().
>  
> Then, apparently, I've missed something else.
> The Onyx2 I worked on is dead for a couple of years now ;-)
> 
> >> AFAIU, both platforms set max_low_pfn to last available pfn, so it
> >seems we
> >> can simply do
> >> 
> >> max_low_pfn = PFN_PHYS(memblock_end_of_DRAM())
> >>
> 
> Should have been PHYS_PFN, sorry.
> 
> >> in the prom_meminit() function for both platforms and drop the loop
> >> evaluating max_low_pfn in paging_init().
> >
> >sounds like a better plan. I'll prepare a new patch.
> >
> >Thomas.
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.

-- 
Sincerely yours,
Mike.
