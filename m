Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1E1Hnn11486
	for linux-mips-outgoing; Wed, 13 Feb 2002 17:17:49 -0800
Received: from spinics.net (IDENT:root@vzn1-22.ce.ftel.net [206.24.95.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1E1Hl911483
	for <linux-mips@oss.sgi.com>; Wed, 13 Feb 2002 17:17:47 -0800
Received: (from ellis@localhost)
	by spinics.net (8.11.6/8.11.6) id g1E0HqT11565
	for linux-mips@oss.sgi.com; Wed, 13 Feb 2002 16:17:52 -0800
From: ellis@spinics.net
Message-Id: <200202140017.g1E0HqT11565@spinics.net>
Subject: Re: NFS ROOT Problem - boot (newbie)
To: linux-mips@oss.sgi.com
Date: Wed, 13 Feb 2002 16:17:52 -0800 (PST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>It seems that it initially finds the root on the nfs box but it
>never get to do an init. It just stops and waits... Do I need
>to modify any setting manually on my NFS image in order for the
>kernel to boot?

I had something like that happen to me. It'd start mounting the
NFS root but would stop sending packets after a while. I thought
it was the ethernet driver but I never did find the problem
before I had to move to other projects.

--
http://www.spinics.net/linux/
