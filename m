Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB8HZt015786
	for linux-mips-outgoing; Sat, 8 Dec 2001 09:35:55 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB8HZno15783;
	Sat, 8 Dec 2001 09:35:50 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16CkRw-0003oW-00; Sat, 08 Dec 2001 17:35:40 +0100
Date: Sat, 8 Dec 2001 17:35:39 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Ian Chilton <ian@ichilton.co.uk>, Florian Lohoff <flo@rfc822.org>,
   linux-mips@oss.sgi.com
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation
 5000/150)
In-Reply-To: <20011207003143.E1202@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.21.0112081727330.14453-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from QUOTED-PRINTABLE to 8bit by oss.sgi.com id fB8HZpo15784
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 7 Dec 2001, Ralf Baechle wrote:

> > Has any changes been made to the IRQ code lately?
> 
> There indeed were and the guilty person already sent me a few fixes which
> I haven't applied yet.

There is another bug i know about. When you powerup machine calibrating
delay loop takes approx. 70 sec (on Indy 100MHz). It seems that no (timer)
interrupt arrive during this delay. I didn't notice that, because i only
rebooted machine when i was testing it (in this case, everything works
well). I'll fix it as soon (monday) as i return from mountains.

	Laïa
