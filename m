Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HK24nC029666
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 13:02:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HK24la029665
	for linux-mips-outgoing; Mon, 17 Jun 2002 13:02:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HK22nC029662
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 13:02:02 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g5HK4djf007898;
	Mon, 17 Jun 2002 13:04:39 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g5HK4dan007893;
	Mon, 17 Jun 2002 13:04:39 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Mon, 17 Jun 2002 13:04:39 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   <linux-mips@oss.sgi.com>, <linux-mips-kernel@lists.sourceforge.net>
Subject: Re: tx3912 Re: [PATCH] fbdev updates.
In-Reply-To: <20020606211252.GA1112@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0206171304110.31825-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> Hi!
>
> >    This patch includes the latest in the fbdev BK repository. I have
> > modified several fbdev drivers (maxinefb, tx3912fb, pmag drivers) to the
> > new api. Please test these changes out before I submit them to linus.
> > Thank you. It is against the latest BK tree and 2.5.20.
>
> Does the code even boot on any machine having tx3912fb?

Yes :-) Also a few other types of MIPS devices use this framebuffer.
