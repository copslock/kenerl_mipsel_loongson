Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9M7nvh27907
	for linux-mips-outgoing; Mon, 22 Oct 2001 00:49:57 -0700
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9M7nsD27903
	for <linux-mips@oss.sgi.com>; Mon, 22 Oct 2001 00:49:55 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 15vZvr-000138-00; Mon, 22 Oct 2001 08:55:35 +0100
Subject: Re: csum_ipv6_magic()
To: machida@sm.sony.co.jp (Machida Hiroyuki)
Date: Mon, 22 Oct 2001 08:55:35 +0100 (BST)
Cc: ralf@uni-koblenz.de (Ralf Baechle), linux-mips@oss.sgi.com
In-Reply-To: <20011022151606V.machida@sm.sony.co.jp> from "Machida Hiroyuki" at Oct 22, 2001 03:16:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vZvr-000138-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I guess that csum_ipv6_magic() in include/asm-mips/checksum.h 
> needs "addu %0, $1" at the next of "sltu $1, %0, $1".
> Without this, you cannot add a carry of the last addtion.

Is that actually needed. The final end around carry cannot itself cause
a second carry.
