Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OMM6wJ022991
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 15:22:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OMM6EW022990
	for linux-mips-outgoing; Wed, 24 Apr 2002 15:22:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OMM5wJ022986
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 15:22:05 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g3OMMLNg028624;
	Wed, 24 Apr 2002 15:22:21 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g3OMMKN1028618;
	Wed, 24 Apr 2002 15:22:21 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Wed, 24 Apr 2002 15:22:20 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: vga initialization
In-Reply-To: <200204240111.g3O1BowJ006668@oss.sgi.com>
Message-ID: <Pine.LNX.4.10.10204241520210.19194-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>   I find most code is already there in scitech's x86emu-0.8.
> in one day it is adapted into linux kernel.

Yipes!!! It has been discussed before and no x86 emulator will go into the
kernel. Now what I really love to ses is a way to trace threw the bios
code so we can write video drivers that don't need the BIOS to work. 
