Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 17:22:16 +0000 (GMT)
Received: from pop.gmx.net ([IPv6:::ffff:213.165.64.20]:16576 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225366AbUAORWP>;
	Thu, 15 Jan 2004 17:22:15 +0000
Received: (qmail 3654 invoked by uid 65534); 15 Jan 2004 17:22:09 -0000
Received: from p62.246.39.146.tisdip.tiscali.de (EHLO localhost) (62.246.39.146)
  by mail.gmx.net (mp021) with SMTP; 15 Jan 2004 18:22:09 +0100
X-Authenticated: #6306349
Received: by localhost (Postfix, from userid 1002)
	id 1D3132A98D; Thu, 15 Jan 2004 18:19:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP
	id EFA742A98C; Thu, 15 Jan 2004 18:19:36 +0100 (CET)
Date: Thu, 15 Jan 2004 18:19:36 +0100 (CET)
From: Martin Boehme <martyausmainz@gmx.de>
X-Sender: martyausmainz@www.marty44.net
To: Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: Current 2.4 CVS (2.4.24-pre2) doesn't boot on SGI Indy
In-Reply-To: <20040115141427.GA28546@icm.edu.pl>
Message-ID: <Pine.LNX.4.21.0401151816540.3511-100000@www.marty44.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <martyausmainz@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martyausmainz@gmx.de
Precedence: bulk
X-list: linux-mips

Hello,

is your indy a R4k?
If so, I had the same problems. On R5k it works.
There was some talking and some updates of R4k last two weeks. Look in the archives.
Well, let's wait for the next commit to the offical kernel tree.

marty


On Thu, 15 Jan 2004, Dominik 'Rathann' Mierzejewski wrote:
> I've just compiled it and it won't boot properly. It hangs at
> ...
> Freeing unused kernel memory (72k)
