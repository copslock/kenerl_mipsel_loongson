Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3ODh3N17398
	for linux-mips-outgoing; Tue, 24 Apr 2001 06:43:03 -0700
Received: from the-village.bc.nu (router-100M.swansea.linux.org.uk [194.168.151.17])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3ODgxM17393;
	Tue, 24 Apr 2001 06:42:59 -0700
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14s36f-00024A-00; Tue, 24 Apr 2001 14:43:53 +0100
Subject: Re: ld.so-1.9.x for mips
To: michaels@jungo.com (Michael Shmulevich)
Date: Tue, 24 Apr 2001 14:43:51 +0100 (BST)
Cc: ralf@oss.sgi.com (Ralf Baechle), linux-mips@oss.sgi.com (Linux/MIPS),
   linux-mips@fnet.fr (FR Linux/MIPS)
In-Reply-To: <3AE52A87.9050403@jungo.com> from "Michael Shmulevich" at Apr 24, 2001 10:25:59 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s36f-00024A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> The whole idea behind uClibc was to get rid of that huge chunk of 
> memory-wasting package, and I do not mean to use any part of it.
> Unless you can tell me how ld.so of glibc can be compiled standalone :-)

You might want to look at newlib instead. That has mips support but not afaik
MIPS linux syscall bindings yet. Its used for things like eCos
