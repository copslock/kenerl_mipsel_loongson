Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FBOHnC025952
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 04:24:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FBOHBw025951
	for linux-mips-outgoing; Wed, 15 May 2002 04:24:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FBOBnC025943
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 04:24:15 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 177wWB-0001df-00; Wed, 15 May 2002 12:00:27 +0100
Subject: Re: RAMDISK problem on 79s334A board.
To: rajeshbv@intotoinc.com (Venkata Rajesh Bikkina)
Date: Wed, 15 May 2002 12:00:27 +0100 (BST)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <Pine.LNX.4.10.10205151403260.14414-100000@brahma.intotoind.com> from "Venkata Rajesh Bikkina" at May 15, 2002 02:12:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177wWB-0001df-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> But when i build RAMDISK image and insert the module, insmod is
> doing fine. But after that i could not invoke any other application ( even
> ps -ef is also giving segmentation fault.)

Looks like your module corrupts the kernel.
