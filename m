Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4VKNLnC013411
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 31 May 2002 13:23:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4VKNL0V013410
	for linux-mips-outgoing; Fri, 31 May 2002 13:23:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4VKNJnC013407
	for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 13:23:19 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g4VKOD6F008837;
	Fri, 31 May 2002 13:24:13 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g4VKO9FO008833;
	Fri, 31 May 2002 13:24:09 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 31 May 2002 13:24:08 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dan Malek <dan@embeddededge.com>,
   "Kevin D. Kissell" <kevink@mips.com>, Jun Sun <jsun@mvista.com>,
   "Steven J. Hill" <sjhill@realitydiluted.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PCI Graphics/Video Card for Malta Board?
In-Reply-To: <Pine.GSO.4.21.0205291014450.2890-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0205311323110.3190-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> <sarcastic>
> I guess that's why we still don't have working frame buffer devices for them?
> There are at least 3 frame buffer devices for the Trio floating around the net,
> but none of them work on my cards.
> </sarcastic>

I have started a operation to find all the MIA framebuffer drivers that
have been posted. I really like to track those S3 drivers down.
