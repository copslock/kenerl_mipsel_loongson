Received:  by oss.sgi.com id <S553826AbRCJUeG>;
	Sat, 10 Mar 2001 12:34:06 -0800
Received: from natmail2.webmailer.de ([192.67.198.65]:18628 "EHLO
        post.webmailer.de") by oss.sgi.com with ESMTP id <S553822AbRCJUeA>;
	Sat, 10 Mar 2001 12:34:00 -0800
Received: from scotty.mgnet.de (pD4B89498.dip.t-dialin.net [212.184.148.152])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id VAA12100
	for <linux-mips@oss.sgi.com>; Sat, 10 Mar 2001 21:33:57 +0100 (MET)
Received: (qmail 30521 invoked from network); 10 Mar 2001 20:33:56 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 10 Mar 2001 20:33:56 -0000
Date:   Sat, 10 Mar 2001 21:34:00 +0100 (CET)
From:   Klaus Naumann <spock@mgnet.de>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux-mips@oss.sgi.com
Subject: Re: Failure 2.4.2 + glibc 2.2 still illegal instruction
In-Reply-To: <20010310205028.B16121@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.21.0103102131450.24319-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 10 Mar 2001, Florian Lohoff wrote:

> 
> Hi,
> i am still seeing illegal instruction stuff with current cvs kernel
> and glibc 2.2 
> 

I can confirm this on my Indigo2. Altough not every binary
crashes. From my dmesg:

[ls:38] Illegal instruction 0100017c at 2ac9388c ra=00000000
[ls:39] Illegal instruction 0100017c at 2ac9388c ra=00000000
[find:88] Illegal instruction 7fff7ccc at 2ac97c60 ra=2ab136c4
[find:91] Illegal instruction 00000003 at 2ac9673c ra=2ab136c4
[find:93] Illegal instruction 00000017 at 2ac97c5c ra=2ab136c4
[ls:144] Illegal instruction 0100017c at 2ac9388c ra=00000000
[ls:145] Illegal instruction 0100017c at 2ac9388c ra=00000000

I have also seen these things with tar and other stuff.
Anyway - Keith said that it went away after he compiled
glibc against 2.4.X (X > 1) kernel sources. Can
anyone confirm that ?

> strace shows that the last system call called is
> "sysmips(MIPS_ATOMIC_SET, ...)"

I have tried building strace but failed. What is your code base ? 


		CU, Klaus


-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
