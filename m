Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g56M6QnC027772
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 6 Jun 2002 15:06:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g56M6QEL027770
	for linux-mips-outgoing; Thu, 6 Jun 2002 15:06:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from Elf.ucw.cz (root@[195.39.17.254])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g56M6LnC027752
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 15:06:22 -0700
Received: from bug.ucw.cz (root@amd.ucw.cz [10.0.0.6])
	by Elf.ucw.cz (8.8.8/8.8.5) with ESMTP id XAA20401;
	Thu, 6 Jun 2002 23:12:59 +0200
Received: (from pavel@localhost)
	by bug.ucw.cz (8.8.8/8.8.5) id XAA01479;
	Thu, 6 Jun 2002 23:12:52 +0200
Date: Thu, 6 Jun 2002 23:12:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: tx3912 Re: [PATCH] fbdev updates.
Message-ID: <20020606211252.GA1112@elf.ucw.cz>
References: <Pine.LNX.4.44.0206041248330.1200-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206041248330.1200-100000@www.transvirtual.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi!

>    This patch includes the latest in the fbdev BK repository. I have
> modified several fbdev drivers (maxinefb, tx3912fb, pmag drivers) to the
> new api. Please test these changes out before I submit them to linus.
> Thank you. It is against the latest BK tree and 2.5.20.

Does the code even boot on any machine having tx3912fb?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
