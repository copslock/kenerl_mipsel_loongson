Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBBB6Y914074
	for linux-mips-outgoing; Tue, 11 Dec 2001 03:06:34 -0800
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBBB6Uo14068
	for <linux-mips@oss.sgi.com>; Tue, 11 Dec 2001 03:06:31 -0800
Received: from gate.mgnet.de (pD957B530.dip.t-dialin.net [217.87.181.48])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id LAA29161
	for <linux-mips@oss.sgi.com>; Tue, 11 Dec 2001 11:02:06 +0100 (MET)
Received: (qmail 25285 invoked from network); 11 Dec 2001 10:05:12 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by gate.mgnet.de with SMTP; 11 Dec 2001 10:05:12 -0000
Date: Tue, 11 Dec 2001 11:06:22 +0100 (CET)
From: Klaus Naumann <spock@mgnet.de>
To: Florian Lohoff <flo@rfc822.org>
cc: Guido Guenther <agx@sigxcpu.org>, Linux/MIPS list <linux-mips@oss.sgi.com>,
   klaus@mgnet.de
Subject: Re: [PATCH] sgiwd93.c fix for multiple disks
In-Reply-To: <20011211095548.GB399@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.21.0112111103580.2714-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 11 Dec 2001, Florian Lohoff wrote:

> It looks like this is statistical distortion as some numbers went up.
> It looks at least that there is no real difference ...

Yeah it looks the same to me (BTW, before someone asks - the machine
was bootet freshly before each test ;) )

> I would commit that too with some additional comments that the HPC
> is capable of doing scatter-gather but this does not mix with the wd33
> framwork which has no support for that.

While you're at it could you also change the wrong comment in wd33c93
stating that the first interrupt after DMA init is always the DMA
complete int ?
Also killing the Amiga reference might be good as more drivers depend
on this framework - not only amiga (i.e. ppc-something).

	Cya, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
