Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 17:52:06 +0000 (GMT)
Received: from zrtps0kp.nortel.com ([47.140.192.56]:57269 "EHLO
	zrtps0kp.nortel.com") by ftp.linux-mips.org with ESMTP
	id S20034613AbXLLRv6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 17:51:58 +0000
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id lBCHiKf28874;
	Wed, 12 Dec 2007 17:44:20 GMT
Received: from [47.9.29.61] ([47.9.29.61] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 12 Dec 2007 12:44:18 -0500
Message-ID: <47601DEE.4090200@nortel.com>
Date:	Wed, 12 Dec 2007 11:44:14 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: questions on struct sigcontext
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2007 17:44:18.0301 (UTC) FILETIME=[9EB732D0:01C83CE6]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips


Hi all,

First, I'm not subscribed to the list so I'd appreciate being cc'd on 
any replies.

We have a project getting started with MIPS, and one of the things that 
we're trying to bring in is some exception-handling code that logs 
various information about the ways that apps fail.

In particular, the guys working on this have asked for the STATUS, 
CAUSE, BADVADDR, and FPC_EIR registers to be made available as part of 
struct sigcontext so that they can determine exactly why the app is failing.

Looking at include/asm-mips/sigcontext.h I can see that these registers 
appear to be in the struct, but are either marked as "unused" or now 
have different names.

Am I correct that these registers are not currently exported to 
userspace on a fault?  If this is the case, why not?  Does anyone have a 
patch to enable this export?

It seems odd that mips app designers wouldn't want this information to 
be made available.

Any information you can provide would be useful.

Chris
