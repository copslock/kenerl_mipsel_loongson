Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HGC2u22899
	for linux-mips-outgoing; Tue, 17 Jul 2001 09:12:02 -0700
Received: from dvmwest.gt.owl.de (postfix@dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HGBwV22896
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 09:11:59 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 67506C4FE; Tue, 17 Jul 2001 18:11:56 +0200 (CEST)
Date: Tue, 17 Jul 2001 18:11:56 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>
Subject: Oops in serial driver
Message-ID: <20010717181156.A32024@lug-owl.de>
Mail-Followup-To: SGI MIPS list <linux-mips@oss.sgi.com>,
	Debian MIPS list <debian-mips@lists.debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux mail 2.4.5 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi!

I'm currently testing with current CVS kernels and facing some bad
Oopses in DECstation's serial driver:-( Top fafourites are Hi!

I'm currently testing with current CVS kernels and facing some bad
Oopses in DECstation's serial driver:-( Top fafourites are rs_interrupt
and zs_channels. Does anybody already have a fix for this? I fear
noting down all the Oops from framebuffer, as it is for obvious reason
not written to serial console...

MfG, JBG
