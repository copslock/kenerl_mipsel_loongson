Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2ACGZB25701
	for linux-mips-outgoing; Sun, 10 Mar 2002 04:16:35 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2ACGV925696
	for <linux-mips@oss.sgi.com>; Sun, 10 Mar 2002 04:16:32 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16k1JL-0002KT-00; Sun, 10 Mar 2002 12:16:19 +0100
Date: Sun, 10 Mar 2002 12:16:19 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: =?iso-8859-1?q?Nicolas=20Sauzede?= <nsauzede@yahoo.com>
cc: linux-mips@oss.sgi.com
Subject: Re: XL8 => XL24
In-Reply-To: <20020308172453.53229.qmail@web13008.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0203101200480.8613-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 8 Mar 2002, Nicolas Sauzede wrote:

> Sorry this is not related to linux, but does anyone know if it's
> possible to (in hardware) modify an Indy shipped with XL8 graphics to
> XL24 ??

Newport graphics is sloted GIO device, so it is easy to replace it.

> (I mean, does one just have to replace one chip by another)

one card by another... in fact 8bit version of newport differs only in
amount of memory. printed circuit board is the same, so in theory adding
memory should be all you have to do. (is anyone able to lend me 24bit
version of Newport to do juxtaposition?)

	ladis
