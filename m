Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBI0H8S11322
	for linux-mips-outgoing; Mon, 17 Dec 2001 16:17:08 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBI0H5o11318
	for <linux-mips@oss.sgi.com>; Mon, 17 Dec 2001 16:17:05 -0800
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 16G70I-0000Ae-00; Tue, 18 Dec 2001 00:17:02 +0100
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16G6z5-000312-00; Tue, 18 Dec 2001 00:15:47 +0100
Date: Tue, 18 Dec 2001 00:15:47 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Cc: debian-mips@lists.debian.org
Subject: Console corruption with newport & XFree86
Message-ID: <20011218001546.B11359@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
to get a better idea with which versions of the newport the console
corruption happens I'd like to ask everybody with a newport to send me:
- The version numbers of the different chips on the newport(as printed
  by the kernel - dmesg)
- if it is the 8bpp or 24bpp version
- the version number of XFree86 with which console corruption[1] happens(if
  any)
- the version number of XFree86 with which *no* console corruption happens(if
  any)
So even if everything is fine for you, please drop me a short notice.
Please do this in private mail, since I don't want to pollute this ml
with(for other people) uninteresting stuff.
Thanks,
 -- Guido

[1] completely black console with only a blinking cursor
