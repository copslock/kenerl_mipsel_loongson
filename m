Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAKN4Rv07663
	for linux-mips-outgoing; Tue, 20 Nov 2001 15:04:27 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAKN4Oo07660
	for <linux-mips@oss.sgi.com>; Tue, 20 Nov 2001 15:04:24 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08339
	for <linux-mips@oss.sgi.com>; Tue, 20 Nov 2001 14:04:20 -0800 (PST)
	mail_from (agx@gandalf.physik.uni-konstanz.de)
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 166IvH-0001sz-00; Tue, 20 Nov 2001 22:59:19 +0100
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 166Iu7-0006o9-00; Tue, 20 Nov 2001 22:58:07 +0100
Date: Tue, 20 Nov 2001 22:58:07 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: TrueColor on an Indy
Message-ID: <20011120225807.A26150@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
I just managed to get 24bpp to work on my Indy. I'll have to cleanup the
code, but for all of you who can't wait...a patch against current
xfree86 cvs can be found at:
 http://honk.physik.uni-konstanz.de/~agx/mipslinux/x/24bpp-2001-11-20.diff
There's one bug left. When the server comes up, you have to switch back
and forth to the console once, to get the display right...hope to find
it soon.
 -- Guido
