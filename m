Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB4AJHW20506
	for linux-mips-outgoing; Tue, 4 Dec 2001 02:19:17 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB4AJBo20501
	for <linux-mips@oss.sgi.com>; Tue, 4 Dec 2001 02:19:11 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16BBiv-0003YA-00; Tue, 04 Dec 2001 10:18:45 +0100
Date: Tue, 4 Dec 2001 10:18:45 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: Florian Lohoff <flo@rfc822.org>
cc: Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation
 5000/150)
In-Reply-To: <20011204095951.A27343@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.21.0112041008090.12262-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from QUOTED-PRINTABLE to 8bit by oss.sgi.com id fB4AJDo20503
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 4 Dec 2001, Florian Lohoff wrote:

> CONFIG_RTC is set by "Enhanced Real Time Clock Support" - It seems
> there is something broken in the config system then ...
> 
> tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
> if [ "$CONFIG_IA64" = "y" ]; then
>    bool 'EFI Real Time Clock Services' CONFIG_EFI_RTC
> fi
> if [ "$CONFIG_OBSOLETE" = "y" -a "$CONFIG_ALPHA_BOOK1" = "y" ]; then
>    bool 'Tadpole ANA H8 Support'  CONFIG_H8
> fi

look to the drivers/sgi/Config.in instead

comment 'SGI devices'
bool 'SGI Zilog85C30 serial support' CONFIG_SGI_SERIAL
if [ "$CONFIG_SGI_SERIAL" = "y" ]; then
   bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE
fi
bool 'SGI DS1286  RTC support' CONFIG_SGI_DS1286

i know... we have special driver for SGI, special driver for some ARM
based boards, for some ...(a lot of clocks to list :-)). but, that's
living ;-) search linux-mips archives, there was long debate about this
month ago. personaly i don't like way how it works now, but i haven't time
nor knowledges to change it without breaking anything, so i'm happy that
it works somehow.

	laïa
