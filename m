Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7AFv7r16554
	for linux-mips-outgoing; Fri, 10 Aug 2001 08:57:07 -0700
Received: from the-village.bc.nu (router-100M.swansea.linux.org.uk [194.168.151.17])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7AFv5V16550
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 08:57:06 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 15VEgt-0001Di-00; Fri, 10 Aug 2001 16:59:15 +0100
Subject: Re: about mips IDE DMA disk problem
To: wqb123@yahoo.com (Barry Wu)
Date: Fri, 10 Aug 2001 16:59:15 +0100 (BST)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <no.id> from "Barry Wu" at Aug 10, 2001 08:39:44 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VEgt-0001Di-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> We port linux-2.2.12 to our mipsel evaluation board.

2.2.12 is ancient including remotely exploitable security holes. If you
update to a vaguely recent 2.2 kernel you'll also find there are ali1535
drivers although I dont think anyone has verified them on mips
