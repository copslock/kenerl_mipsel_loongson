Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7CDo3s19068
	for linux-mips-outgoing; Sun, 12 Aug 2001 06:50:03 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7CDo2j19065
	for <linux-mips@oss.sgi.com>; Sun, 12 Aug 2001 06:50:02 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA19256
	for <linux-mips@oss.sgi.com>; Sun, 12 Aug 2001 06:49:55 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA13095
	for <linux-mips@oss.sgi.com>; Sun, 12 Aug 2001 06:49:53 -0700 (PDT)
Received: from copsun17.mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7CDmZa05366
	for <linux-mips@oss.sgi.com>; Sun, 12 Aug 2001 15:48:36 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun17.mips.com (8.9.1/8.9.0) id PAA02757
	for linux-mips@oss.sgi.com; Sun, 12 Aug 2001 15:48:35 +0200 (MET DST)
Message-Id: <200108121348.PAA02757@copsun17.mips.com>
Subject: Malta kernel config file
To: linux-mips@oss.sgi.com
Date: Sun, 12 Aug 2001 15:48:35 +0200 (MET DST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I think I saw somebody ask last week how to configure the kernel
for the MIPS Malta board.

In the tar archives on ftp.mips.com, e.g. 

	linux-2.4.3.mips-src-01.00.tar.gz

There are several .config files:

/home/hartvige/tmp/linux-2.4.3> ll .config*
-r--r-----   1 hartvige mips       11361 May 25 10:59 .config.atlas
-r--r-----   1 hartvige mips       11436 May 17 09:59 .config.malta
-r--r-----   1 hartvige mips       10681 May 17 10:49 .config.malta.64

Copy or link the right one (in this case .config.malta) to .config, and
you're ready to go!

/Hartvig
