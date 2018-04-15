Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 19:37:23 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993945AbeDORhPhUMzZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 19:37:15 +0200
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3FHYZHj147323
        for <linux-mips@linux-mips.org>; Sun, 15 Apr 2018 13:37:13 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hbvm8h71h-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Sun, 15 Apr 2018 13:37:13 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Sun, 15 Apr 2018 18:37:11 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sun, 15 Apr 2018 18:37:04 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w3FHb3mW12255584;
        Sun, 15 Apr 2018 17:37:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C39D4C044;
        Sun, 15 Apr 2018 18:29:37 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB0C34C040;
        Sun, 15 Apr 2018 18:29:32 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.148])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 15 Apr 2018 18:29:32 +0100 (BST)
Date:   Sun, 15 Apr 2018 20:36:56 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413135551.0e6d1b12@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18041517-0008-0000-0000-000004EAC899
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041517-0009-0000-0000-00001E7EDC3A
Message-Id: <20180415173655.GB31176@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804150177
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63550
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

On Fri, Apr 13, 2018 at 01:55:51PM -0600, Jonathan Corbet wrote:
> Sorry for the silence, I'm pedaling as fast as I can, honest...
> 
> On Sun, 1 Apr 2018 09:38:58 +0300
> Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > My thinking was to start with mechanical RST conversion and then to start
> > working on the contents and ordering of the documentation. Some of the
> > existing files, e.g. ksm.txt, can be moved as is into the appropriate
> > places, others, like transhuge.txt should be at least split into admin/user
> > and developer guides.
> > 
> > Another problem with many of the existing mm docs is that they are rather
> > developer notes and it wouldn't be really straight forward to assign them
> > to a particular topic.
> 
> All this sounds good.
> 
> > I believe that keeping the mm docs together will give better visibility of
> > what (little) mm documentation we have and will make the updates easier.
> > The documents that fit well into a certain topic could be linked there. For
> > instance:
> 
> ...but this sounds like just the opposite...?  
> 
> I've had this conversation with folks in a number of subsystems.
> Everybody wants to keep their documentation together in one place - it's
> easier for the developers after all.  But for the readers I think it's
> objectively worse.  It perpetuates the mess that Documentation/ is, and
> forces readers to go digging through all kinds of inappropriate material
> in the hope of finding something that tells them what they need to know.
> 
> So I would *really* like to split the documentation by audience, as has
> been done for a number of other kernel subsystems (and eventually all, I
> hope).
> 
> I can go ahead and apply the RST conversion, that seems like a step in
> the right direction regardless.  But I sure hope we don't really have to
> keep it as an unorganized jumble of stuff...

I didn't mean we should keep it as unorganized jumble of stuff and I agree
that splitting the documentation by audience is better because developers
are already know how to find it :)

I just thought that putting the doc into the place should not be done
immediately after mechanical ReST conversion but rather after improving the
contents. Although I'd agree that part of the documentation in
Documentation/vm is in pretty good shape already.

 
> Thanks,
> 
> jon
> 

-- 
Sincerely yours,
Mike.
