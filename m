Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Dec 2004 10:24:23 +0000 (GMT)
Received: from mailfe10.tele2.se ([IPv6:::ffff:212.247.155.33]:59078 "EHLO
	mailfe10.swip.net") by linux-mips.org with ESMTP
	id <S8224943AbULSKYS>; Sun, 19 Dec 2004 10:24:18 +0000
X-T2-Posting-ID: g63wq726D5fsXb2UbU6LU0KOXzHnTHjCzHZ35sC2MDs=
Received: from [213.103.212.108] (HELO [192.168.0.32])
  by mailfe10.swip.net (CommuniGate Pro SMTP 4.2.7)
  with ESMTP id 43305559 for linux-mips@linux-mips.org; Sun, 19 Dec 2004 11:23:22 +0100
Message-ID: <41C556C3.401@laposte.net>
Date: Sun, 19 Dec 2004 11:24:03 +0100
From: Frederic TEMPORELLI <frederic.temporelli@laposte.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: SGI O2 - RAM 320MBytes - linux reports 245MBytes  (/proc/meminfo)
References: <20041219023850Z8225215-1340+5@linux-mips.org>
In-Reply-To: <20041219023850Z8225215-1340+5@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <frederic.temporelli@laposte.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frederic.temporelli@laposte.net
Precedence: bulk
X-list: linux-mips

Hello,

no way to see (use ?) all available RAM (320MB) on SGI O2 with 
2.6.10-rc3 (latest cvs)

Hardware => SGI O2 with 320MBytes in this way:
dimm 1: 32MBytes - dimm2: 32MBytes
dimm 3: 32MBytes - dimm4: 32MBytes
dimm 5: 32MBytes - dimm6: 32MBytes
dimm 7: 64MBytes - dimm8: 64MBytes

Firmware => "hinv" is reporting 320MBytes (OK, match hardware)

Linux Kernel (32 and 64 bits) => /proc/meminfo is reporting a MemTotal 
of 245436KB
"top" command is reporting same wrong value (more than 64MB missing)

where can I look for in sources to report/use all available RAM ?
can you help me ?
 
Regards

--
Frederic TEMPORELLI
