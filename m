Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADFX0A30403
	for linux-mips-outgoing; Tue, 13 Nov 2001 07:33:00 -0800
Received: from smtpzilla3.xs4all.nl (smtpzilla3.xs4all.nl [194.109.127.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADFWw030400
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 07:32:58 -0800
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by smtpzilla3.xs4all.nl (8.12.0/8.12.0) with ESMTP id fADFWrIr003024;
	Tue, 13 Nov 2001 16:32:55 +0100 (CET)
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.12 #1 (Debian))
	id 163fYI-00010M-00; Tue, 13 Nov 2001 16:32:42 +0100
Date: Tue, 13 Nov 2001 16:32:42 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender:  <roman@serv>
To: Richard Zidlicky <rz@linux-m68k.org>
cc: Roman Zippel <zippel@linux-m68k.org>,
   Geert Uytterhoeven <geert@linux-m68k.org>, Jun Sun <jsun@mvista.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <20011113144240.B669@linux-m68k.org>
Message-ID: <Pine.LNX.4.33.0111131630310.3818-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

On Tue, 13 Nov 2001, Richard Zidlicky wrote:

> hwclock and a bunch of less known porgrams like chrony.

I was playing with chrony, but it was unable to adjust the time, last
weekend I switched back to ntp and that works better.

bye, Roman
