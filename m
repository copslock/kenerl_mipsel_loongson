Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2005 17:23:21 +0000 (GMT)
Received: from mailfe07.swip.net ([IPv6:::ffff:212.247.154.193]:42978 "EHLO
	swip.net") by linux-mips.org with ESMTP id <S8226022AbVCFRXH>;
	Sun, 6 Mar 2005 17:23:07 +0000
X-T2-Posting-ID: g63wq726D5fsXb2UbU6LU0KOXzHnTHjCzHZ35sC2MDs=
Received: from [83.177.235.13] (HELO [192.168.0.32])
  by mailfe07.swip.net (CommuniGate Pro SMTP 4.2.9)
  with ESMTP id 116470614 for linux-mips@linux-mips.org; Sun, 06 Mar 2005 18:23:00 +0100
Message-ID: <422B3C74.9090706@laposte.net>
Date:	Sun, 06 Mar 2005 18:23:00 +0100
From:	Frederic TEMPORELLI <frederic.temporelli@laposte.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: SGI IP32 and 2.6.11
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <frederic.temporelli@laposte.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frederic.temporelli@laposte.net
Precedence: bulk
X-list: linux-mips

Hello,

I've just been able to start 2.6.11 from my own compilation on IP32.

Can I have some help about following problems/comments ?

1/ It was really difficult because kernel was falling in breakpoint call 
(BUG macro) in free_bootmem_core.
=> I've successfully try to comment this BUG macro in free_bootmem_core 
(bootmem.c)
Of course, I'm thinking this is really sad... but I've a really poor 
knowledge in kernel development...
may someone can explain how to solve such issue in a better way ?
This breakpoint was boring me since 2.6.10...

2/ There's also a problem with ip32-memory.c, which isn't able to detect 
64MB dimm.
Yet, not enough knowledge for processing bankctl (prom_meminit) in the 
nice way for detecting 64MB dimms...
(All memory slots are used on my O2: slots 1 to 6 with 32MB dimms and 
slots 7 & 8 with  64MB dimms) .

Best regards

Frederic TEMPORELLI
