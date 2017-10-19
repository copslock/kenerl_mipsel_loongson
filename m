Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 17:05:32 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990392AbdJSPFYqrpul (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 17:05:24 +0200
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9JF57gF044958
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2017 11:05:20 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dpvu3fe7r-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2017 11:05:18 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <schwidefsky@de.ibm.com>;
        Thu, 19 Oct 2017 16:04:54 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 19 Oct 2017 16:04:50 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9JF4ooH14745706;
        Thu, 19 Oct 2017 15:04:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92DDC11C05B;
        Thu, 19 Oct 2017 16:00:12 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B12811C050;
        Thu, 19 Oct 2017 16:00:12 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.220])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Oct 2017 16:00:12 +0100 (BST)
Date:   Thu, 19 Oct 2017 17:04:48 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Matt Redfearn <matt.redfearn@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clockevents: Retry programming min delta up to 10
 times
In-Reply-To: <alpine.DEB.2.20.1710191527570.1971@nanos>
References: <1508414135-29123-1-git-send-email-matt.redfearn@mips.com>
        <alpine.DEB.2.20.1710191435280.1971@nanos>
        <5b782526-b130-77f2-6d9a-15839e12e065@mips.com>
        <alpine.DEB.2.20.1710191527570.1971@nanos>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 17101915-0040-0000-0000-000004047249
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17101915-0041-0000-0000-000020A6C7E3
Message-Id: <20171019170448.4637f480@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-10-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1710190208
Return-Path: <schwidefsky@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwidefsky@de.ibm.com
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

On Thu, 19 Oct 2017 15:29:28 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 19 Oct 2017, Matt Redfearn wrote:
> > On 19/10/17 13:43, Thomas Gleixner wrote:  
> > > 	delta = 0;
> > > 	for (i = 0; i < 10; i++) {
> > > 		delta += dev->min_delta_ns;
> > > 		dev->next_event = ktime_add_ns(ktime_get(), delta);
> > > 		clc = .....
> > > 	   	.....
> > > 
> > > That makes it more likely to succeed fast. Hmm?  
> > 
> > That will set the target time to increasing multiples of min_delta_ns in the
> > future, right?  
> 
> Yes, but without fiddling with min_delta_ns itself.

Grumpf, more extra code for yet another piece of broken hardware
I guess.
 
> > Sure, it should make it succeed faster - I'll make it like
> > that. Are you OK with the arbitrarily chosen 10 retries?  
> 
> I lost my crystalball so I have to trust yours :)

The alternative implementation would be to do the retries in
the clockevent driver itself. Then that particular driver can
choose the correct number of retries, no?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
