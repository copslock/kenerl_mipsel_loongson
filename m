Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 08:20:39 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbdCAHUbiOOHy convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Mar 2017 08:20:31 +0100
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v217ERHG044122
        for <linux-mips@linux-mips.org>; Wed, 1 Mar 2017 02:20:28 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28wsq70mw2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 01 Mar 2017 02:20:26 -0500
Received: from localhost
        by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <sachinp@linux.vnet.ibm.com>;
        Wed, 1 Mar 2017 12:42:26 +0530
Received: from d28dlp01.in.ibm.com (9.184.220.126)
        by e28smtp09.in.ibm.com (192.168.1.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 1 Mar 2017 12:42:22 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
        by d28dlp01.in.ibm.com (Postfix) with ESMTP id C817CE005F;
        Wed,  1 Mar 2017 12:44:05 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
        by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v217BFOl8323146;
        Wed, 1 Mar 2017 12:41:15 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
        by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v217CIgq028934;
        Wed, 1 Mar 2017 12:42:20 +0530
Received: from sachins-mbp.in.ibm.com (sachins-mbp.in.ibm.com [9.124.35.163] (may be forged))
        by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id v217CIME028931;
        Wed, 1 Mar 2017 12:42:18 +0530
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <23989c10-7b47-3fda-f790-25b539704bec@akamai.com>
Date:   Wed, 1 Mar 2017 12:42:18 +0530
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        Zhigang Lu <zlu@ezchip.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Transfer-Encoding: 8BIT
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
 <20170228112144.65455de5@gandalf.local.home>
 <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
 <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com>
 <999e2c3f-698c-703c-67a9-26aea3c97dc0@caviumnetworks.com>
 <d10e986c-7f6a-3935-88e2-ba39708f79ad@caviumnetworks.com>
 <542488db-5c59-afa5-6d1d-a437c87bc613@akamai.com>
 <912fa97a-aa1d-c0e4-dc83-fc5c745db1c1@caviumnetworks.com>
 <23989c10-7b47-3fda-f790-25b539704bec@akamai.com>
To:     Jason Baron <jbaron@akamai.com>,
        David Daney <ddaney@caviumnetworks.com>
X-Mailer: Apple Mail (2.3259)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 17030107-0032-0000-0000-000001F162E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17030107-0033-0000-0000-000012236654
Message-Id: <B9D0B041-6C5A-42D7-AF8C-FA618003AEF8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-01_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1612050000
 definitions=main-1703010072
Return-Path: <sachinp@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sachinp@linux.vnet.ibm.com
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


> I also checked all the other .ko files and they were properly aligned. So I think this should hopefully work, and I like that its not a per-arch fix.
> 
> Sachin, sorry to bother you again, but I'm hoping you can try David's latest patch to scripts/module-common.lds, just to test in your setup.

I tested the patch on 2 different systems where I ran into this problem. In both cases
the system boots without any warning. A quick module load/unload test also worked
correctly.

Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

Thanks
-Sachin
