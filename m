Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FBKmd13051
	for linux-mips-outgoing; Tue, 15 Jan 2002 03:20:48 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FBKjP13048
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 03:20:45 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16QQhb-0005u0-00; Tue, 15 Jan 2002 11:20:23 +0100
Date: Tue, 15 Jan 2002 11:20:22 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@oss.sgi.com
Subject: Re: [OT] NFS locking with NFS-Root
In-Reply-To: <20020115100503.K15285@lug-owl.de>
Message-ID: <Pine.LNX.4.21.0201151118470.22103-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 15 Jan 2002, Jan-Benedict Glaw wrote:

> I've got an Indy now, and I want to make it install (with the current
> debian dbootstrap) on a NFS root. So I first go to mount the NFS server
> to /target and then proceed with the installation. All .deb's get
> downloaded, but they cannot be extracted because dpkg can't lock
> /var/lib/dpkg/lock .
> 
> Dumb question: How do I make file locking (via fcntl(F_SETLK))
> functional?

place your lock files into the ramdisk.

	ladis
