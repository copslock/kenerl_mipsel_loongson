Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2016 09:51:52 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36741 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991984AbcHXHvpOqxfb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2016 09:51:45 +0200
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u7O7n7D6084737
        for <linux-mips@linux-mips.org>; Wed, 24 Aug 2016 03:51:43 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 250pg851s3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 24 Aug 2016 03:51:43 -0400
Received: from localhost
        by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <oberpar@linux.vnet.ibm.com>;
        Wed, 24 Aug 2016 08:51:40 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp06.uk.ibm.com (192.168.101.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 24 Aug 2016 08:51:38 +0100
X-IBM-Helo: d06dlp02.portsmouth.uk.ibm.com
X-IBM-MailFrom: oberpar@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 19BE92190023;
        Wed, 24 Aug 2016 08:51:01 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u7O7pbJV8258006;
        Wed, 24 Aug 2016 07:51:37 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u7O7paeD031347;
        Wed, 24 Aug 2016 01:51:37 -0600
Received: from [9.152.212.148] (dyn-9-152-212-148.boeblingen.de.ibm.com [9.152.212.148])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u7O7pZhe031307;
        Wed, 24 Aug 2016 01:51:35 -0600
Subject: Re: [PATCH] treewide: replace config_enabled() with IS_ENABLED() (2nd
 round)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1471970749-24867-1-git-send-email-yamada.masahiro@socionext.com>
Cc:     linux-s390@vger.kernel.org,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Garnier <thgarnie@google.com>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
From:   Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Date:   Wed, 24 Aug 2016 09:51:36 +0200
MIME-Version: 1.0
In-Reply-To: <1471970749-24867-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16082407-0024-0000-0000-00000209B6B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 16082407-0025-0000-0000-00002019D811
Message-Id: <55efa12b-4368-3d1c-c4df-466d920f6de7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-08-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=1
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1604210000
 definitions=main-1608240071
Return-Path: <oberpar@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oberpar@linux.vnet.ibm.com
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

On 23.08.2016 18:45, Masahiro Yamada wrote:
> Commit 97f2645f358b ("tree-wide: replace config_enabled() with
> IS_ENABLED()") mostly killed config_enabled(), but some new users
> have appeared for v4.8-rc1.  They are all used for a boolean option,
> so can be replaced with IS_ENABLED() safely.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

> ---
> 
>  arch/mips/include/asm/page.h | 4 ++--
>  arch/s390/kernel/setup.c     | 6 ++----
>  arch/x86/mm/kaslr.c          | 2 +-
>  3 files changed, 5 insertions(+), 7 deletions(-)

-- 
Peter Oberparleiter
Linux on z Systems Development - IBM Germany
