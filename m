Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6N0sXRw008770
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 17:54:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6N0sXou008769
	for linux-mips-outgoing; Mon, 22 Jul 2002 17:54:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft19-f32.dialo.tiscali.de [62.246.19.32])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6N0sQRw008760
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 17:54:28 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6N0t3208564;
	Tue, 23 Jul 2002 02:55:03 +0200
Date: Tue, 23 Jul 2002 02:55:03 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: David Hansen <hansen@phys.ufl.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: Linux support for Origin 2000
Message-ID: <20020723025503.B28380@dea.linux-mips.net>
References: <Pine.SOL.4.44.0207181045490.6712-100000@neptune.phys.ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.4.44.0207181045490.6712-100000@neptune.phys.ufl.edu>; from hansen@phys.ufl.edu on Mon, Jul 22, 2002 at 10:49:39AM -0400
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 22, 2002 at 10:49:39AM -0400, David Hansen wrote:

>   Is anyone on this list currently running Linux on an Origin 2000? I am
> looking into setting up an Origin 2000 (16p (R4400 195Mhz)) for my
> department and I'm looking for information on Origin 2000 support (i.e.-
> which kernels have stable support for it, can I do a native installation
> of Linux on the Origin 2000?, etc...).

The Origin kernel is suffering a bit from bit rot; checkout a copy of
2.4.9 as of November 1 and use the tools that are provided on
ftp.linux-mips.org in /pub/linux/mips/crossdev/ for mips64-linux targets to
build the kernel.  Then boot from nfs root.

Four line quick installation howto :)

  Ralf
