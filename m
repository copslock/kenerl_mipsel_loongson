Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6CKh3u03858
	for linux-mips-outgoing; Thu, 12 Jul 2001 13:43:03 -0700
Received: from dvmwest.gt.owl.de (postfix@dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6CKh2V03851
	for <linux-mips@oss.sgi.com>; Thu, 12 Jul 2001 13:43:02 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 0CDF2C4FE; Thu, 12 Jul 2001 22:43:00 +0200 (CEST)
Date: Thu, 12 Jul 2001 22:43:00 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>
Subject: smbfs on DECstations R3k
Message-ID: <20010712224300.C18294@lug-owl.de>
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

I tried to compile smbfs support for DECstations R3k. The compiler
(that one shipping with the make-cross script) fails in
proc.c:smb_proc_setattr_trans2 with normal CFLAGS. Setting -O0
(instead of -O2) lets me compile the source.

Is anybody interested in fixing the compiler? I do definitely not
have the knowhow to do that...

MfG, JBG
