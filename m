Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2003 23:00:44 +0100 (BST)
Received: from mail.cyclecc.com ([IPv6:::ffff:66.106.186.120]:33767 "EHLO
	recycle.cyclecc.com") by linux-mips.org with ESMTP
	id <S8225352AbTH2WAM>; Fri, 29 Aug 2003 23:00:12 +0100
Received: from mail.cyclecc.com (recycle [66.106.186.120])
	by recycle.cyclecc.com (8.12.2+Sun/8.12.2) with SMTP id h7TM2LpR023458
	for <linux-mips@linux-mips.org>; Fri, 29 Aug 2003 15:02:21 -0700 (PDT)
Received: from tadpole.com ([66.106.186.2])
 by mail.cyclecc.com (SAVSMTP 3.1.1.32) with SMTP id M2003082915022026519
 for <linux-mips@linux-mips.org>; Fri, 29 Aug 2003 15:02:20 -0700
Message-ID: <3F4FCCD5.1000604@tadpole.com>
Date: Fri, 29 Aug 2003 14:59:49 -0700
From: Steve Madsen <madsen@tadpole.com>
Organization: Tadpole Computer, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Using more than 256 MB of memory on SB1250 in 32-bit mode
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <madsen@tadpole.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: madsen@tadpole.com
Precedence: bulk
X-list: linux-mips

Is it possible to use more than 256 MB of system memory with the Broadcom 
SB1250 in 32-bit mode?  The memory map I'm looking at shows me that the 
second 256 MB of memory is at physical address 0x80000000.  I suspect that 
due to the 2G/2G split in the kernel, I can't use memory this high without 
moving to the 64-bit kernel.

Would someone confirm this for me?

-- 
Steve Madsen <madsen@tadpole.com>
Tadpole Computer, Inc.  http://www.tadpole.com
