Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FA5BV10951
	for linux-mips-outgoing; Tue, 15 Jan 2002 02:05:11 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FA58P10947
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 02:05:08 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id D7FBB9F36; Tue, 15 Jan 2002 10:05:03 +0100 (CET)
Date: Tue, 15 Jan 2002 10:05:03 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: [OT] NFS locking with NFS-Root
Message-ID: <20020115100503.K15285@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi!

I've got an Indy now, and I want to make it install (with the current
debian dbootstrap) on a NFS root. So I first go to mount the NFS server
to /target and then proceed with the installation. All .deb's get
downloaded, but they cannot be extracted because dpkg can't lock
/var/lib/dpkg/lock .

Dumb question: How do I make file locking (via fcntl(F_SETLK))
functional?

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
