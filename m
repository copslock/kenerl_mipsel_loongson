Received:  by oss.sgi.com id <S42295AbQFSUWG>;
	Mon, 19 Jun 2000 13:22:06 -0700
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:40345 "EHLO
        obelix.hrz.tu-chemnitz.de") by oss.sgi.com with ESMTP
	id <S42186AbQFSUV4>; Mon, 19 Jun 2000 13:21:56 -0700
Received: from sunnyboy.informatik.tu-chemnitz.de by obelix.hrz.tu-chemnitz.de 
          with Local SMTP (PP); Mon, 19 Jun 2000 22:21:29 +0200
Received: from scotty.mgnet.de (sulu.csn.tu-chemnitz.de [134.109.96.105]) 
          by sunnyboy.informatik.tu-chemnitz.de (8.8.8/8.8.8) with SMTP 
          id WAA27036 for <linux-mips@oss.sgi.com>;
          Mon, 19 Jun 2000 22:21:27 +0200 (MET DST)
Received: (qmail 28409 invoked from network); 19 Jun 2000 20:21:26 -0000
Received: from spock.mgnet.de (HELO scotty.mgnet.de) (192.168.1.4) 
          by scotty.mgnet.de with SMTP; 19 Jun 2000 20:21:26 -0000
Date:   Mon, 19 Jun 2000 22:22:15 +0200
From:   Klaus Naumann <spock@mgnet.de>
To:     Paul Jakma <paul@clubi.ie>
Cc:     Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: linux/mips on cd?
Message-ID: <20000619222215.A23089@spock>
Reply-To: spock@mgnet.de
References: <Pine.LNX.4.21.0006192034060.8536-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.21.0006192034060.8536-100000@fogarty.jakma.org>; from paul@clubi.ie on Mon, Jun 19, 2000 at 21:39:16 +0200
X-Mailer: Balsa 0.8.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Mon, 19 Jun 2000 21:39:16 Paul Jakma wrote:
> i know, i know.. I've read parts of the archive, and have lurked on
> the list for a few months. However, it seems to me the Indy (little
> endian linux/mips, right?) does at least boot and run some userspace

No, big endian ;)

Yes, it boots and it's possible to run most of the usual stuffs ...
Also X is working now (at snail speed but working) because
Guido Guenter made a X server.

> i'm here more for the fun factor. (i've run linux on x86, Alpha
> and PPC. Love to see it just booting on MIPS :) )

If you just want to see it booting you might want to get a vmlinux-indy
from oss.sgi.com and boot it up - it should work.

> incidentally, i tried booting the 2.2.13 kernel from the website. It
> appeared to work as the PROM downloaded it and didn't complain, but
> it produced absolutely no output. and when i pressed a key it booted
> back to PROM.

This is not the default behaviour - The PROM should freeze after it
boots up the kernel if you use serial console - otherwise you will
see the newport console ...

If there is a running distribution I could make a CD and send it to
you ... so this is not the problem - but it's not worth it until
we have a system which is running more stable ...

	Cu, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
