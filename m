Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Sep 2004 01:25:19 +0100 (BST)
Received: from 64-60-250-34.cust.telepacific.net ([IPv6:::ffff:64.60.250.34]:38956
	"EHLO panta-1.pantasys.com") by linux-mips.org with ESMTP
	id <S8225236AbUINAZO>; Tue, 14 Sep 2004 01:25:14 +0100
Received: from [10.1.40.165] ([10.1.40.1]) by panta-1.pantasys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 13 Sep 2004 17:18:08 -0700
Message-ID: <41463A54.1030401@pantasys.com>
Date: Mon, 13 Sep 2004 17:24:52 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] fix mips atomic_lock declaration
References: <41462025.9070607@pantasys.com> <20040914002237.GA21739@linux-mips.org>
In-Reply-To: <20040914002237.GA21739@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2004 00:18:08.0890 (UTC) FILETIME=[50232DA0:01C499F0]
Return-Path: <peter@pantasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@pantasys.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> No.  atomic_lock is intentionally undefined, so this patch seems very
> broken.

if i don't change it to static it won't compile correctly. so obviously 
i don't get something.

it seems that the bcm1250 needs atomic_lock to be defined for the fall 
through case for smp. either that or i need to figure out how to write 
the assemble code for the SB1 case...

what do you think needs to be done?

peter
