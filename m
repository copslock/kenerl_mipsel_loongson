Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NKVUt02177
	for linux-mips-outgoing; Mon, 23 Jul 2001 13:31:30 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NKVTX02174
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 13:31:29 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA06919
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 10:48:23 -0700 (PDT)
	mail_from (agx@gandalf.physik.uni-konstanz.de)
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 15Ojok-0001z5-00; Mon, 23 Jul 2001 19:48:30 +0200
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15Ojok-0002M9-00; Mon, 23 Jul 2001 19:48:30 +0200
Date: Mon, 23 Jul 2001 19:48:30 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips@oss.sgi.com
Subject: Segfaults on r4600
Message-ID: <20010723194830.A9033@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm seeing various segfaults especially with perl on an R4600 Indy.
R4000 I2 with identical debian packages works fine though. I have tried
various kernels (cvs head as from two days ago(natively and
crosscompiled) and 2.4.3-r4k-ip22 from rfc822.org. Interesting enough
the segfaults disappear when using "strace -o/dev/null
segfaulting_binary". I also tried to investigate the core file but gdb
dies when loading it(gdb is 5.0-3 debian package).
Any ideas,
 -- Guido
