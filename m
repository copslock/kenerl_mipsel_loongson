Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 11:59:33 +0100 (BST)
Received: from H42.C233.tor.velocet.net ([IPv6:::ffff:216.138.233.42]:55459
	"EHLO copper.vtnet.vjbtlw") by linux-mips.org with ESMTP
	id <S8225240AbTFLK7b>; Thu, 12 Jun 2003 11:59:31 +0100
Received: from silicon.vtint.vjbtlw (silicon.vtint.vjbtlw [192.168.141.14])
	by copper.vtnet.vjbtlw (Postfix) with ESMTP id A419939AFE
	for <linux-mips@linux-mips.org>; Thu, 12 Jun 2003 06:59:26 -0400 (EDT)
Content-Type: text/plain;
  charset="us-ascii"
From: Trevor Woerner <mips081@vtnet.ca>
Reply-To: mips081@vtnet.ca
To: linux-mips@linux-mips.org
Subject: 64-bit sysinfo
Date: Thu, 12 Jun 2003 06:59:26 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200306120659.26501.mips081@vtnet.ca>
Return-Path: <mips081@vtnet.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips081@vtnet.ca
Precedence: bulk
X-list: linux-mips

Hi everyone,

(good to see some familiar and friendly faces from the PPC list! :-)

I ran into a problem yesterday and I just don't know how I'm going to 
approach solving it.

I compiled a 64-bit MIPS kernel, then built a busybox-based ramdisk. At 
first I couldn't get busybox's 'init' to work but later solved it by 
disabling the 'check_memory()' call.

Further investigation into why the 'check_memory()' call was failing 
revealed a problem with the 'sysinfo()' system call. The kernel is 
64-bit, therefore when it fills in the 'struct sysinfo' (as it does 
when 'sys_meminfo()' is called) unsigned int's are 64 bits. But back in 
userspace, the 'struct sysinfo' that gets allocated thinks that 
unsigned int's are 32 bits.

This causes a crash if the 'struct sysinfo' is allocated on the stack 
back in userspace, and causes seg faults if it's allocated in the .data 
section (globally).

I'm crossing my fingers and hoping that my solution is to build all 
user-space apps with some switch that will set the sizes of data types 
to be the same between user space and kernel space. Does some such 
option exist?

	Trevor
