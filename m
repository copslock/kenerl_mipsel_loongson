Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB3HJUS04840
	for linux-mips-outgoing; Mon, 3 Dec 2001 09:19:30 -0800
Received: from woody.ichilton.co.uk (woody.ichilton.co.uk [216.28.122.60])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB3HJSo04837
	for <linux-mips@oss.sgi.com>; Mon, 3 Dec 2001 09:19:28 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id BFB697CEE; Mon,  3 Dec 2001 16:19:21 +0000 (GMT)
Date: Mon, 3 Dec 2001 16:19:21 +0000
From: Ian Chilton <ian@ichilton.co.uk>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation 5000/150)
Message-ID: <20011203161921.B30391@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20011203000338.A30090@paradigm.rfc822.org> <20011203000036.A10356@buzz.ichilton.local> <20011203143734.A5965@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <20011203143734.A5965@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Dec 03, 2001 at 02:37:34PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

> It basically comes up for me but is endlessly slow because i am getting
> a mad interrupt - Putting an printk("I%d", irq) into do_IRQ shows 
> IRQ 8 going mad ...


Interesting. Does anyone know what IRQ 8 is?


Thanks

Ian
