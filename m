Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 14:58:25 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990475AbeIOM6SFAXer (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 14:58:18 +0200
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8FCrXxE138496
        for <linux-mips@linux-mips.org>; Sat, 15 Sep 2018 08:58:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mgx97eqek-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Sat, 15 Sep 2018 08:58:15 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 15 Sep 2018 13:58:14 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 15 Sep 2018 13:58:11 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8FCwAGD65994972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Sep 2018 12:58:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11C7942047;
        Sat, 15 Sep 2018 15:58:00 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B6D242041;
        Sat, 15 Sep 2018 15:57:59 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.116])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 15 Sep 2018 15:57:58 +0100 (BST)
Date:   Sat, 15 Sep 2018 15:58:07 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mips: switch to NO_BOOTMEM
References: <1536571398-29194-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180914195300.7wnmsph2qhpixm7s@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914195300.7wnmsph2qhpixm7s@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18091512-4275-0000-0000-000002BAB631
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091512-4276-0000-0000-000037C3F676
Message-Id: <20180915125806.GH15191@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=598 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809150142
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66331
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

On Fri, Sep 14, 2018 at 12:53:00PM -0700, Paul Burton wrote:
> Hi Mike,
> 
> On Mon, Sep 10, 2018 at 12:23:18PM +0300, Mike Rapoport wrote:
> > MIPS already has memblock support and all the memory is already registered
> > with it.
> > 
> > This patch replaces bootmem memory reservations with memblock ones and
> > removes the bootmem initialization.
> > 
> > Since memblock allocates memory in top-down mode, we ensure that memblock
> > limit is max_low_pfn to prevent allocations from the high memory.
> > 
> > To have the exceptions base in the lower 512M of the physical memory, its
> > allocation in arch/mips/kernel/traps.c::traps_init() is using bottom-up
> > mode.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> > v2:
> > * set memblock limit to max_low_pfn to avoid allocation attempts from high
> > memory
> > * use boottom-up mode for allocation of the exceptions base
> > 
> > Build tested with *_defconfig.
> > Boot tested with qemu-system-mips64el for 32r6el, 64r6el and fuloong2e
> > defconfigs.
> > Boot tested with qemu-system-mipsel for malta defconfig.
> > 
> >  arch/mips/Kconfig                      |  1 +
> >  arch/mips/kernel/setup.c               | 99 ++++++++--------------------------
> >  arch/mips/kernel/traps.c               |  3 ++
> >  arch/mips/loongson64/loongson-3/numa.c | 34 ++++++------
> >  arch/mips/sgi-ip27/ip27-memory.c       | 11 ++--
> >  5 files changed, 46 insertions(+), 102 deletions(-)
> 
> Thanks - applied to mips-next for 4.20.
> 
> Apologies for the delay, my son decided to be born a few weeks early &
> scupper my plans :)

Congratulations! :)
 
> Paul
> 

-- 
Sincerely yours,
Mike.
