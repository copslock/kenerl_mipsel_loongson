Received:  by oss.sgi.com id <S553738AbRAUCEm>;
	Sat, 20 Jan 2001 18:04:42 -0800
Received: from [194.73.73.176] ([194.73.73.176]:49372 "EHLO protactinium")
	by oss.sgi.com with ESMTP id <S553722AbRAUCEg>;
	Sat, 20 Jan 2001 18:04:36 -0800
Received: from [213.122.217.168] (helo=tardis)
	by protactinium with esmtp (Exim 3.03 #83)
	id 14K9rt-0005Av-00
	for linux-mips@oss.sgi.com; Sun, 21 Jan 2001 02:04:34 +0000
Date:   Sun, 21 Jan 2001 02:01:15 +0000 (GMT)
From:   Dave Gilbert <gilbertd@treblig.org>
X-Sender: gilbertd@tardis.home.dave
To:     linux-mips@oss.sgi.com
Subject: Trying to boot an Indy
Message-ID: <Pine.LNX.4.10.10101210150410.964-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
  I'm trying to boot my Indy into Linux for the first time and not having
any luck.

1) I tried bootp - bootp()vmlinux - it says 'no server for vmlinux'.  The
bootp server is a Linux/Alpha box running 2.4.0-ac9 - I've already done
the trick with no_pmtu.  tcpdump shows bootp sending a packet with
apparently the correct mac address.

2) So I ftp'd the file over under Irix, gzip -d'd it and then rebooted and
from sash did boot indyvmlinux - this immediatly after starting gave
'Exception: <vector=UTLB Miss>' plus details (available on request).
(This is kernel vmlinux=001027-test9-r4x00.gz off
download.ichilton.co.uk/pub/ichilton/linux-mips/kernels).

This is an Indy R4600PC with 64MB RAM.

Ideas appreciated.

Dave

P.S. I've got a lead wired here to do the 13w3 but it doesn't seem to be
spot on - I don't get any green, but it is sync'd - this is going to an
Iiyama 8617 (original 17") monitor. Ideas on that would also be
appreciated.

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on m68k, |  Happy  \ 
\   gro.gilbert @ treblig.org |  Alpha, x86, ARM and SPARC |  In Hex /
 \ ___________________________|___ http://www.treblig.org  |________/
