Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2009 20:25:38 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19309 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492856AbZHNSZc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2009 20:25:32 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a85ac0a0000>; Fri, 14 Aug 2009 14:25:14 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Aug 2009 11:24:19 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Aug 2009 11:24:19 -0700
Message-ID: <4A85ABD3.5040801@caviumnetworks.com>
Date:	Fri, 14 Aug 2009 11:24:19 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
CC:	Adam Nemet <anemet@caviumnetworks.com>
Subject: .subsection madness
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Aug 2009 18:24:19.0717 (UTC) FILETIME=[70777350:01CA1D0C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips


In atomic.h for atomic_add we have this gem:

	__asm__ __volatile__(
	"	.set	mips3					\n"
	"1:	ll	%0, %1		# atomic_add		\n"
	"	addu	%0, %2					\n"
	"	sc	%0, %1					\n"
	"	beqz	%0, 2f					\n"
	"	.subsection 2					\n"
	"2:	b	1b					\n"
	"	.previous					\n"
	"	.set	mips0					\n"


What is the purpose of the .subsection here?

It will not affect branch prediction in the beqz as nothing happens in 
.subsection 2.

For spin locks it is clear that this technique can help, but for 
atomic_add I don't think so.  To make matters worse for some code the 
subsection is going out of branch range.

David Daney
