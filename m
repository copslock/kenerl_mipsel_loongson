Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 14:43:39 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993041AbeIFMngZ5thZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 14:43:36 +0200
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86Ccn6t092617
        for <linux-mips@linux-mips.org>; Thu, 6 Sep 2018 08:43:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mb2cj5w0k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 06 Sep 2018 08:43:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 6 Sep 2018 13:43:31 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 13:43:25 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w86ChOYp43319318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 12:43:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A977FA4055;
        Thu,  6 Sep 2018 15:43:16 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80CFEA4040;
        Thu,  6 Sep 2018 15:43:15 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Sep 2018 15:43:15 +0100 (BST)
Date:   Thu, 6 Sep 2018 15:43:21 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
        paul.burton@mips.com, Thomas Gleixner <tglx@linutronix.de>,
        tony.luck@intel.com, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 07/29] memblock: remove _virt from APIs returning
 virtual address
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-8-git-send-email-rppt@linux.vnet.ibm.com>
 <CABGGiswdb1x-=vqrgxZ9i2dnLdsgtXq4+5H9Y1JRd90YVMW69A@mail.gmail.com>
 <20180905172017.GA2203@rapoport-lnx>
 <20180906072800.GN14951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906072800.GN14951@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090612-4275-0000-0000-000002B63863
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090612-4276-0000-0000-000037BF5782
Message-Id: <20180906124321.GD27492@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060129
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66055
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

On Thu, Sep 06, 2018 at 09:28:00AM +0200, Michal Hocko wrote:
> On Wed 05-09-18 20:20:18, Mike Rapoport wrote:
> > On Wed, Sep 05, 2018 at 12:04:36PM -0500, Rob Herring wrote:
> > > On Wed, Sep 5, 2018 at 11:00 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > > >
> > > > The conversion is done using
> > > >
> > > > sed -i 's@memblock_virt_alloc@memblock_alloc@g' \
> > > >         $(git grep -l memblock_virt_alloc)
> > > 
> > > What's the reason to do this? It seems like a lot of churn even if a
> > > mechanical change.
> > 
> > I felt that memblock_virt_alloc_ is too long for a prefix, e.g:
> > memblock_virt_alloc_node_nopanic, memblock_virt_alloc_low_nopanic.
> > 
> > And for consistency I've changed the memblock_virt_alloc as well.
> 
> I would keep the current API unless the name is terribly misleading or
> it can be improved a lot. Neither seems to be the case here. So I would
> rather stick with the status quo.

I'm ok with the memblock_virt_alloc by itself, but having 'virt' in
'memblock_virt_alloc_try_nid_nopanic' and 'memblock_virt_alloc_low_nopanic'
reduces code readability in my opinion.

Besides, from what I've seen, many users of memblock_phys_alloc can be
converted to the virtual variant and then we can just have memblock_alloc
everywhere in the end.

Currently there are ~70 users of memblock_virt_alloc*, but with the
bootmem -> memblock conversion we'll be adding ~140 more.

> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.
