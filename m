Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2004 07:25:25 +0000 (GMT)
Received: from mistral-243-146-ban.mistralsoftware.com ([IPv6:::ffff:203.196.146.243]:9795
	"EHLO Mistralsoftware.com") by linux-mips.org with ESMTP
	id <S8224954AbUAPHZY>; Fri, 16 Jan 2004 07:25:24 +0000
Received: from mistralsoftware.com ([192.168.13.230])
	(authenticated user suresh@mistralsoftware.com)
	by mistralsoftware.com (mistralsoftware.com [192.168.10.12])
	(MDaemon.PRO.v6.8.5.R)
	with ESMTP id 40-md50000000011.tmp
	for <linux-mips@linux-mips.org>; Fri, 16 Jan 2004 13:11:46 +0530
Message-ID: <40079391.7080301@mistralsoftware.com>
Date: Fri, 16 Jan 2004 13:02:33 +0530
From: "Suresh. R" <suresh@mistralsoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: VR4131 - MQ1132 - UPD63335
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: suresh@mistralsoftware.com
X-Spam-Processed: mistralsoftware.com, Fri, 16 Jan 2004 13:11:46 +0530
	(not processed: message from valid local sender)
X-MDRemoteIP: 192.168.13.230
X-Return-Path: suresh@mistralsoftware.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Return-Path: <suresh@mistralsoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: suresh@mistralsoftware.com
Precedence: bulk
X-list: linux-mips

Hi,
   This might be a very basic question, but I am very new to this field. 
So please help me.

I am writing a linux device driver for UPD63335 audio codec. Its 
controlled through the MQ1132 co-processor. The VR4131 is the processor. 
The memory of MQ1132 is mapped to the processor memory in Kseg1 (0xA000 
0000 onwards) which the manual says is TLB Unmapped region. Now my 
question is is it necessary to map this region before using it in Linux. 
Actually I have WinCE code for my reference. In that code the programmer 
is mapping the region using Virtual Cpoy and Virtual Alloc. Is it 
necessary to do that or Can I directly address the memory locatoin.

Please help

Thanks in advance

Regards
Suresh
