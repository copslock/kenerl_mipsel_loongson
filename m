Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2004 11:06:17 +0100 (BST)
Received: from RT-soft-2.Moscow.itn.ru ([IPv6:::ffff:80.240.96.70]:26244 "HELO
	mail.dev.rtsoft.ru") by linux-mips.org with SMTP
	id <S8225852AbUFBKGN>; Wed, 2 Jun 2004 11:06:13 +0100
Received: (qmail 10310 invoked from network); 2 Jun 2004 10:06:06 -0000
Received: from unknown (HELO dev.rtsoft.ru) (192.168.1.199)
  by mail.dev.rtsoft.ru with SMTP; 2 Jun 2004 10:06:06 -0000
Message-ID: <40BDA692.50606@dev.rtsoft.ru>
Date: Wed, 02 Jun 2004 14:06:10 +0400
From: Pavel Kiryukhin <savl@dev.rtsoft.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Pavel Kiryukhin <savl@dev.rtsoft.ru>
Subject: input_event for 64-bit kernel and 32-bit userland.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <savl@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: savl@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

Hi all,
I stuck in simple situation:
USB mouse (or keyboard). n64 kernel (2.4.20), n32 userland.

Userspace application tries to read "input_event" (16 bytes) from 
"/dev/input/event0" [ read(fd,&key_ev, sizeof(key_ev)) ],
input core driver treats "input_event" as 24 bytes structure. It is due 
to different size of  "timeval" (and finally  "long") in n64 kernel and 
n32 userland.

Application gets some garbage as mouse events . No solutions like "ioctl 
wrappers" applicable in this case.

I don't want to change any arch independent files, but can not find any
acceptable solution. It looks like headers "/usr/include/linux/input.h" 
in root file system and "/include/linux/input.h" in kernel should be the 
same,
 (All works fine as soon as I declare a new "input_event" structure in 
user application that corresponds in size to kernel
structure - but this is not acceptable).

Can anybody advice me what to do with the difference in "input_event"
structure sizes in o32/n32 userland and n64 kernel? Just a general 
approach that can be used when  driver's read/write operation treat some 
values as 64 bit while user application tries to read/write 32-bit 
values (based on the same headers).

Please, don't kick me if solution is simple and obvious.
---
Thanks,
Pavel Kiryukhin.
