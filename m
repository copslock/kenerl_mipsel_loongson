Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 19:29:32 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993945AbeDOR3ZyqF7Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 19:29:25 +0200
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3FHSxHJ092881
        for <linux-mips@linux-mips.org>; Sun, 15 Apr 2018 13:29:24 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hc379513n-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Sun, 15 Apr 2018 13:29:23 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Sun, 15 Apr 2018 18:29:21 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sun, 15 Apr 2018 18:29:15 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w3FHTFuw52822240;
        Sun, 15 Apr 2018 17:29:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2135A4203F;
        Sun, 15 Apr 2018 18:20:51 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12CD942042;
        Sun, 15 Apr 2018 18:20:49 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.148])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 15 Apr 2018 18:20:48 +0100 (BST)
Date:   Sun, 15 Apr 2018 20:29:11 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 00/32] docs/vm: convert to ReST format
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180329154607.3d8bda75@lwn.net>
 <20180401063857.GA3357@rapoport-lnx>
 <20180413135551.0e6d1b12@lwn.net>
 <20180413202108.GA30271@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413202108.GA30271@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18041517-0044-0000-0000-00000548738D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041517-0045-0000-0000-000028887799
Message-Id: <20180415172910.GA31176@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804150176
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63549
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

On Fri, Apr 13, 2018 at 01:21:08PM -0700, Matthew Wilcox wrote:
> On Fri, Apr 13, 2018 at 01:55:51PM -0600, Jonathan Corbet wrote:
> > > I believe that keeping the mm docs together will give better visibility of
> > > what (little) mm documentation we have and will make the updates easier.
> > > The documents that fit well into a certain topic could be linked there. For
> > > instance:
> > 
> > ...but this sounds like just the opposite...?  
> > 
> > I've had this conversation with folks in a number of subsystems.
> > Everybody wants to keep their documentation together in one place - it's
> > easier for the developers after all.  But for the readers I think it's
> > objectively worse.  It perpetuates the mess that Documentation/ is, and
> > forces readers to go digging through all kinds of inappropriate material
> > in the hope of finding something that tells them what they need to know.
> > 
> > So I would *really* like to split the documentation by audience, as has
> > been done for a number of other kernel subsystems (and eventually all, I
> > hope).
> > 
> > I can go ahead and apply the RST conversion, that seems like a step in
> > the right direction regardless.  But I sure hope we don't really have to
> > keep it as an unorganized jumble of stuff...
> 
> I've started on Documentation/core-api/memory.rst which covers just
> memory allocation.  So far it has the Overview and GFP flags sections
> written and an outline for 'The slab allocator', 'The page allocator',
> 'The vmalloc allocator' and 'The page_frag allocator'.  And typing this
> up, I realise we need a 'The percpu allocator'.  I'm thinking that this
> is *not* the right document for the DMA memory allocators (although it
> should link to that documentation).
> 
> I suspect the existing Documentation/vm/ should probably stay as an
> unorganised jumble of stuff.  Developers mostly talking to other MM
> developers.  Stuff that people outside the MM fraternity should know
> about needs to be centrally documented.  By all means convert it to
> ReST ... I don't much care, and it may make it easier to steal bits
> or link to it from the organised documentation.
 
The existing Documentation/vm contains different types of documents. Some
are indeed "Developers mostly talking to other MM developers". Some are
really user/administrator guides. Others are somewhat in between.

I took another look at what's there and I think we can actually move part
of Documentation/vm to Documentation/admin-guide. We can add
Documentation/admin-guide/vm/ and title it "Memory Management Tuning" or
something like that. And several files, e.g. hugetlbpage, ksm, soft-dirty
can be moved there.

-- 
Sincerely yours,
Mike.
