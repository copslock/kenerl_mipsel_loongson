Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 02:02:17 +0100 (BST)
Received: from bay2-f148.bay2.hotmail.com ([IPv6:::ffff:65.54.247.148]:8966
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225203AbTDCBCR>; Thu, 3 Apr 2003 02:02:17 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 2 Apr 2003 17:02:08 -0800
Received: from 157.165.41.125 by by2fd.bay2.hotmail.msn.com with HTTP;
	Thu, 03 Apr 2003 01:02:08 GMT
X-Originating-IP: [157.165.41.125]
X-Originating-Email: [linux_linux_2003@hotmail.com]
From: "Mike K." <linux_linux_2003@hotmail.com>
To: linux-mips@linux-mips.org
Subject: __asm__  C code in mips-Linux
Date: Wed, 02 Apr 2003 17:02:08 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F148jSQU0d0uub000985dc@hotmail.com>
X-OriginalArrivalTime: 03 Apr 2003 01:02:08.0894 (UTC) FILETIME=[A6C451E0:01C2F97C]
Return-Path: <linux_linux_2003@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux_linux_2003@hotmail.com
Precedence: bulk
X-list: linux-mips

extern __inline__ void atomic_add(int i, atomic_t * v)
{
	unsigned long temp;

	__asm__ __volatile__(
		"1:   ll      %0, %1      # atomic_add\n"
		"     addu    %0, %2                  \n"
		"     sc      %0, %1                  \n"
		"     beqz    %0, 1b                  \n"
		: "=&r" (temp), "=m" (v->counter)
		: "Ir" (i), "m" (v->counter));
}


Beginner questions on the above code:
1. what is %0 %1 %2?
2. what is the details meaning of the last two line of the above code?
3. Very thanksful if you can comment each line with detail description  for 
me, thanks a lot!


_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail
