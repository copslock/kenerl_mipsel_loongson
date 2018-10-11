Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2018 08:09:16 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992501AbeJKGJOA2yuz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Oct 2018 08:09:14 +0200
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9B69AA7146386
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2018 02:09:12 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n1yqr2njb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2018 02:09:11 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 11 Oct 2018 07:09:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 07:08:56 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9B68sIf1376738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 06:08:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA939AE053;
        Thu, 11 Oct 2018 09:07:37 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5101AE057;
        Thu, 11 Oct 2018 09:07:35 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.69])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Oct 2018 09:07:35 +0100 (BST)
Date:   Thu, 11 Oct 2018 09:08:50 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20181005151934.87226fa92825c3002a475413@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005151934.87226fa92825c3002a475413@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18101106-0020-0000-0000-000002D27E1F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101106-0021-0000-0000-00002120F47F
Message-Id: <20181011060850.GA19822@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110060
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66744
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

On Fri, Oct 05, 2018 at 03:19:34PM -0700, Andrew Morton wrote:
> On Fri,  5 Oct 2018 00:07:04 +0300 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > When a memblock allocation APIs are called with align = 0, the alignment is
> > implicitly set to SMP_CACHE_BYTES.
> > 
> > Replace all such uses of memblock APIs with the 'align' parameter explicitly
> > set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
> > memblock internal allocation functions.
> > 
> > For the case when memblock APIs are used via helper functions, e.g. like
> > iommu_arena_new_node() in Alpha, the helper functions were detected with
> > Coccinelle's help and then manually examined and updated where appropriate.
> > 
> > ...
> >
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1298,9 +1298,6 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >  {
> >  	phys_addr_t found;
> >  
> > -	if (!align)
> > -		align = SMP_CACHE_BYTES;
> > -
> 
> Can we add a WARN_ON_ONCE(!align) here?  To catch unconverted code
> which sneaks in later on.

Here it goes:
