Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f71HNq108678
	for linux-mips-outgoing; Wed, 1 Aug 2001 10:23:52 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f71HNpV08675
	for <linux-mips@oss.sgi.com>; Wed, 1 Aug 2001 10:23:51 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f71HNeLh003017;
	Wed, 1 Aug 2001 10:23:40 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f71HNexq003013;
	Wed, 1 Aug 2001 10:23:40 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Wed, 1 Aug 2001 10:23:40 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Paul Kasper <paul@patton.com>
cc: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com
Subject: Re: Mips Cobalt cube distro
In-Reply-To: <3B683788.B48252A8@patton.com>
Message-ID: <Pine.LNX.4.10.10108011022190.925-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > > base-contents.txt <http://loco.pocketlinux.com/%7Esamc/debian-cobalt/base-contents.txt>       31-Jul-2001 13:40     5k
> > > base.tar.bz2 <http://loco.pocketlinux.com/%7Esamc/debian-cobalt/base.tar.bz2>            31-Jul-2001 13:40  19.0M
> > > vmlinux.gz <http://loco.pocketlinux.com/%7Esamc/debian-cobalt/vmlinux.gz>              31-Jul-2001 13:40   824k
> 
> Are the kernel sources and .config for that vmlinuz available
> somewhere?  If so, where?

http://www.sf.net/projects/linux-mips

Just go the CVS section. arch/mips/configs/defconfig-cobalt is the
configuration I used.
