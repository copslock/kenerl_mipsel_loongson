Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FC5knC029792
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 05:05:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FC5kwG029791
	for linux-mips-outgoing; Wed, 15 May 2002 05:05:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from brahma.intotoind.com ([202.56.196.162])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FC5anC029787
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 05:05:40 -0700
Received: from localhost (rajeshbv@localhost)
	by brahma.intotoind.com (8.9.3/8.8.7) with ESMTP id RAA22405;
	Wed, 15 May 2002 17:30:50 +0530
X-Authentication-Warning: brahma.intotoind.com: rajeshbv owned process doing -bs
Date: Wed, 15 May 2002 17:30:50 +0530 (IST)
From: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
X-Sender: rajeshbv@brahma.intotoind.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-mips@oss.sgi.com
Subject: Re: RAMDISK problem on 79s334A board.
In-Reply-To: <E177wWB-0001df-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10205151729240.22271-100000@brahma.intotoind.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Alan,

Thankyou for your response.

But the same module is working fine and kernel is also fine if i use NFS
and insert the module.
Any further info ?

--Rajesh

On Wed, 15 May 2002, Alan Cox wrote:

> > But when i build RAMDISK image and insert the module, insmod is
> > doing fine. But after that i could not invoke any other application ( even
> > ps -ef is also giving segmentation fault.)
> 
> Looks like your module corrupts the kernel.
> 
