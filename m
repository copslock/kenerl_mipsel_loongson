Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB3HeZp05278
	for linux-mips-outgoing; Mon, 3 Dec 2001 09:40:35 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB3HeIo05264
	for <linux-mips@oss.sgi.com>; Mon, 3 Dec 2001 09:40:19 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16Aw3E-0001PO-00; Mon, 03 Dec 2001 17:34:40 +0100
Date: Mon, 3 Dec 2001 17:34:40 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: Ian Chilton <ian@ichilton.co.uk>
cc: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation
 5000/150)
In-Reply-To: <20011203161921.B30391@woody.ichilton.co.uk>
Message-ID: <Pine.LNX.4.21.0112031726021.2278-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from QUOTED-PRINTABLE to 8bit by oss.sgi.com id fB3HeLo05265
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 3 Dec 2001, Ian Chilton wrote:

> Hello,
> 
> > It basically comes up for me but is endlessly slow because i am getting
> > a mad interrupt - Putting an printk("I%d", irq) into do_IRQ shows 
> > IRQ 8 going mad ...
> 
> Interesting. Does anyone know what IRQ 8 is?

sure :-) IRQ 8 is FIFO full and was never used (and to be honest, i don't
know what that irq is used for). before Wed, 21 Nov 2001 17:49:32 +0100
it was General purpose local interrupt - this one was also never
used. see include/asm-mips/sgi/sgint23.h for more info.

i have no clue, why you're getting this interrupt. it works pretty well
for me...

laïa
