Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2018 12:23:28 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992243AbeDJKXVS8N4U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2018 12:23:21 +0200
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3AAKI0J056178
        for <linux-mips@linux-mips.org>; Tue, 10 Apr 2018 06:23:19 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2h8rac8u80-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Tue, 10 Apr 2018 06:23:19 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 10 Apr 2018 11:23:17 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp10.uk.ibm.com (192.168.101.140) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 10 Apr 2018 11:23:11 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w3AANAVn58458208;
        Tue, 10 Apr 2018 10:23:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B91F42042;
        Tue, 10 Apr 2018 11:14:54 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F181142041;
        Tue, 10 Apr 2018 11:14:52 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.108])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Apr 2018 11:14:52 +0100 (BST)
Date:   Tue, 10 Apr 2018 13:23:07 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180401063857.GA3357@rapoport-lnx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18041010-0040-0000-0000-0000042C893D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041010-0041-0000-0000-0000263097C4
Message-Id: <20180410102306.GB5900@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804100104
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63481
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

Jon, Andrew,

How do you suggest to continue with this?

On Sun, Apr 01, 2018 at 09:38:58AM +0300, Mike Rapoport wrote:
> (added akpm)
> 
> On Thu, Mar 29, 2018 at 03:46:07PM -0600, Jonathan Corbet wrote:
> > On Wed, 21 Mar 2018 21:22:16 +0200
> > Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > 
> > > These patches convert files in Documentation/vm to ReST format, add an
> > > initial index and link it to the top level documentation.
> > > 
> > > There are no contents changes in the documentation, except few spelling
> > > fixes. The relatively large diffstat stems from the indentation and
> > > paragraph wrapping changes.
> > > 
> > > I've tried to keep the formatting as consistent as possible, but I could
> > > miss some places that needed markup and add some markup where it was not
> > > necessary.
> > 
> > So I've been pondering on these for a bit.  It looks like a reasonable and
> > straightforward RST conversion, no real complaints there.  But I do have a
> > couple of concerns...
> > 
> > One is that, as we move documentation into RST, I'm really trying to
> > organize it a bit so that it is better tuned to the various audiences we
> > have.  For example, ksm.txt is going to be of interest to sysadmin types,
> > who might want to tune it.  mmu_notifier.txt is of interest to ...
> > somebody, but probably nobody who is thinking in user space.  And so on.
> > 
> > So I would really like to see this material split up and put into the
> > appropriate places in the RST hierarchy - admin-guide for administrative
> > stuff, core-api for kernel development topics, etc.  That, of course,
> > could be done separately from the RST conversion, but I suspect I know
> > what will (or will not) happen if we agree to defer that for now :)
> 
> Well, I was actually planning on doing that ;-)
> 
> My thinking was to start with mechanical RST conversion and then to start
> working on the contents and ordering of the documentation. Some of the
> existing files, e.g. ksm.txt, can be moved as is into the appropriate
> places, others, like transhuge.txt should be at least split into admin/user
> and developer guides.
> 
> Another problem with many of the existing mm docs is that they are rather
> developer notes and it wouldn't be really straight forward to assign them
> to a particular topic.
> 
> I believe that keeping the mm docs together will give better visibility of
> what (little) mm documentation we have and will make the updates easier.
> The documents that fit well into a certain topic could be linked there. For
> instance:
> 
> -------------------------
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 5bb9161..8f6c6e6 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -63,6 +63,7 @@ configure specific aspects of kernel behavior to your liking.
>     pm/index
>     thunderbolt
>     LSM/index
> +   vm/index
> 
>  .. only::  subproject and html
> 
> diff --git a/Documentation/admin-guide/vm/index.rst b/Documentation/admin-guide/vm/index.rst
> new file mode 100644
> index 0000000..d86f1c8
> --- /dev/null
> +++ b/Documentation/admin-guide/vm/index.rst
> @@ -0,0 +1,5 @@
> +==============================================
> +Knobs and Buttons for Memory Management Tuning
> +==============================================
> +
> +* :ref:`ksm <ksm>`
> -------------------------
> 
> > The other is the inevitable merge conflicts that changing that many doc
> > files will create.  Sending the patches through Andrew could minimize
> > that, I guess, or at least make it his problem.  Alternatively, we could
> > try to do it as an end-of-merge-window sort of thing.  I can try to manage
> > that, but an ack or two from the mm crowd would be nice to have.
> 
> I can rebase on top of Andrew's tree if that would help to minimize the
> merge conflicts.
> 
> > Thanks,
> > 
> > jon
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.
