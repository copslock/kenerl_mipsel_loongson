Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NCGJp25738
	for linux-mips-outgoing; Mon, 23 Jul 2001 05:16:19 -0700
Received: from storm.physik.tu-cottbus.de (storm.physik.TU-Cottbus.De [141.43.75.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NCGIV25734
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 05:16:18 -0700
Received: by storm.physik.tu-cottbus.de (Postfix, from userid 7215)
	id A74356004F; Mon, 23 Jul 2001 14:16:09 +0200 (CEST)
Date: Mon, 23 Jul 2001 14:16:09 +0200
To: Debian boot mailing list <debian-boot@lists.debian.org>
Cc: Linux/MIPS list <linux-mips@oss.sgi.com>, debian-mips@lists.debian.org
Subject: new root.bin and root.tar.gz
Message-ID: <20010723141609.A29649@physik.tu-cottbus.de>
Mail-Followup-To: heinold@physik.tu-cottbus.de,
	Debian boot mailing list <debian-boot@lists.debian.org>,
	Linux/MIPS list <linux-mips@oss.sgi.com>,
	debian-mips@lists.debian.org
References: <20010722155210.A6818@kyllikki.infodorm.north.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010722155210.A6818@kyllikki.infodorm.north.de>
User-Agent: Mutt/1.3.18i
From: heinold@physik.tu-cottbus.de (H.Heinold)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

I made new debian-bootfloppies root.bin and root.tar.gz with the actual cvs including
the patch from Martin Schulze.

Please download and test it when you can 
http://www.physik.tu-cottbus.de/users/heinold/mipsel/root.bin
http://www.physik.tu-cottbus.de/users/heinold/mipsel/root.tar.gz


root.bin is the debian-initrd, which normaly is on the second bootfloppy(1,44 size).

root.tar.gz is a nfs-root enviroment


-- 


Henning Heinold
