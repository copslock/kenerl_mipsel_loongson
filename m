Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADFUtT30220
	for linux-mips-outgoing; Tue, 13 Nov 2001 07:30:55 -0800
Received: from smtpzilla2.xs4all.nl (smtpzilla2.xs4all.nl [194.109.127.138])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADFUr030190
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 07:30:53 -0800
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by smtpzilla2.xs4all.nl (8.12.0/8.12.0) with ESMTP id fADFUP3E052723;
	Tue, 13 Nov 2001 16:30:26 +0100 (CET)
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.12 #1 (Debian))
	id 163fW4-00010K-00; Tue, 13 Nov 2001 16:30:24 +0100
Date: Tue, 13 Nov 2001 16:30:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender:  <roman@serv>
To: Tom Rini <trini@kernel.crashing.org>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
   Roman Zippel <zippel@linux-m68k.org>, Jun Sun <jsun@mvista.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
   <rz@linux-m68k.org>
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <20011113074424.A16723@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0111131627580.3818-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

On Tue, 13 Nov 2001, Tom Rini wrote:

> > http://linux-m68k-cvs.apia.dhs.org/
>
> That's the non-generic m68k version tho, yes?  Or did Roman do it in
> that tree too?

That version is even more recent than the one currently in the APUS
repository. :)
But I tested it also under APUS, so you only need to provide
[gs]et_rtc_time and it should work.

bye, Roman
