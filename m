Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FD8onC031945
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 06:08:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FD8oTp031944
	for linux-mips-outgoing; Wed, 15 May 2002 06:08:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FD8hnC031936
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 06:08:46 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 177ypv-0001up-00; Wed, 15 May 2002 14:28:59 +0100
Subject: Re: RAMDISK problem on 79s334A board.
To: rajeshbv@intotoinc.com (Venkata Rajesh Bikkina)
Date: Wed, 15 May 2002 14:28:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-mips@oss.sgi.com
In-Reply-To: <Pine.LNX.4.10.10205151729240.22271-100000@brahma.intotoind.com> from "Venkata Rajesh Bikkina" at May 15, 2002 05:30:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177ypv-0001up-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> But the same module is working fine and kernel is also fine if i use NFS
> and insert the module.
> Any further info ?

Not really. The fact it works with NFS and not ramdisk may simply be that
in one case it corrupts memory that is used, and the other it corrupts
memory that isnt
