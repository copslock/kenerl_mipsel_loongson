Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g54K3hnC006160
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 13:03:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g54K3hZN006159
	for linux-mips-outgoing; Tue, 4 Jun 2002 13:03:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g54K3dnC006156
	for <linux-mips@oss.sgi.com>; Tue, 4 Jun 2002 13:03:39 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g54K5RTP006694;
	Tue, 4 Jun 2002 13:05:27 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g54K5RnI006690;
	Tue, 4 Jun 2002 13:05:27 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 4 Jun 2002 13:05:27 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   <linux-mips@oss.sgi.com>, <linux-mips-kernel@lists.sourceforge.net>
Subject: [PATCH] fbdev updates.
Message-ID: <Pine.LNX.4.44.0206041248330.1200-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi!

   This patch includes the latest in the fbdev BK repository. I have
modified several fbdev drivers (maxinefb, tx3912fb, pmag drivers) to the
new api. Please test these changes out before I submit them to linus.
Thank you. It is against the latest BK tree and 2.5.20.

diff:

   http://www.transvirtual.com/~jsimmons/fbdev.diff.gz

BK:

   http://fbdev.bkbits.net:8080/fbdev-2.5

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/
