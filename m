Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 06:02:49 +0100 (BST)
Received: from host73.ipowerweb.com ([IPv6:::ffff:66.235.218.254]:1959 "EHLO
	host73.ipowerweb.com") by linux-mips.org with ESMTP
	id <S8224908AbUJEFCp>; Tue, 5 Oct 2004 06:02:45 +0100
Received: from cpanel by host73.ipowerweb.com with local (Exim 3.36 #1)
	id 1CEhT6-0001UV-00
	for linux-mips@linux-mips.org; Mon, 04 Oct 2004 22:02:32 -0700
Received: from 61.11.17.87 ( [61.11.17.87])
	as user gautam@koperasw.com@localhost by koperasw.com with HTTP;
	Mon,  4 Oct 2004 22:02:32 -0700
Message-ID: <1096952552.41622ae805589@koperasw.com>
Date: Mon,  4 Oct 2004 22:02:32 -0700
From: gautam@koperasw.com
To: linux-mips@linux-mips.org
Subject: Stuck with booting from IDE
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 61.11.17.87
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host73.ipowerweb.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 32001] / [32001 32001]
X-AntiAbuse: Sender Address Domain - host73.ipowerweb.com
Return-Path: <cpanel@host73.ipowerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gautam@koperasw.com
Precedence: bulk
X-list: linux-mips



Hi,
I am trying to get MALTA boot from IDE by reserving a partition on the IDE for
the kernel binary.
I found a relevant post on the forum:
"
If you feel lucky, you can also reserve space on your disk for the kernel -
either in a separate partition, or outside the area used by your current
partitions. The YAMON 02.02 or later can read the kernel directly from disk
and execute it.

I do this on my Malta board with one disk.

/Hartvig
"
I have been trying to do the same on my MALTA board but am somehow goofing up in
getting the sector no and the count right.In short ...its not happening.I have a
hard disk with a dedicated partition for the kernel binary.Its the first primary
partition  so I suppose the sector no should be 63.
 
I need to know the actual command for "disk write" (YAMON 2.02 and later) that
anybody might have used successfully with YAMON and the subsequent "disk read"
to get the binary from IDE instead of TFTP.
There is lack of documentation regarding this .

Thanks and regards,
Gautam Morey
Design and Dev.Engineer
Kopera Software Inc.
Pune,India
www.koperasw.com
