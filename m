Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQNvPQ29306
	for linux-mips-outgoing; Mon, 26 Nov 2001 15:57:25 -0800
Received: from luonnotar.infodrom.org (postfix@luonnotar.infodrom.org [195.124.48.78])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQNvMo29296
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 15:57:22 -0800
Received: by luonnotar.infodrom.org (Postfix, from userid 10)
	id C81B2366A81; Mon, 26 Nov 2001 23:57:19 +0100 (CET)
Received: at Infodrom Oldenburg (/\##/\ Smail-3.2.0.102 1998-Aug-2 #2)
	from infodrom.org by finlandia.Infodrom.North.DE
	via smail from stdin
	id <m168ULs-000pU0C@finlandia.Infodrom.North.DE>
	for flo@rfc822.org; Mon, 26 Nov 2001 23:35:48 +0100 (CET) 
Date: Mon, 26 Nov 2001 23:35:48 +0100
From: Martin Schulze <joey@infodrom.org>
To: Florian Lohoff <flo@rfc822.org>
Cc: Karsten Merker <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com
Subject: Re: Status RM200
Message-ID: <20011126233548.D26510@finlandia.infodrom.north.de>
References: <20011126204509.A10341@paradigm.rfc822.org> <20011126213450.B943@excalibur.cologne.de> <20011126231737.B13081@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011126231737.B13081@paradigm.rfc822.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Florian Lohoff wrote:
> On Mon, Nov 26, 2001 at 09:34:50PM +0100, Karsten Merker wrote:
> > Ralf has at least made the RM200 support compile again while we
> > were driving home from Oldenburg :-).
> > I do not know if it really works though - wrong endianess...
> 
> How can the RM200 port be wrong endianess - The RM200 is bi-endian
> thus any endianess would be ok (As long as the port does not assume
> a specific endianess except the prom stuff).

As I remember, you can't switch to "the right" endianess without a support
drivers f*ckup disk - which hasn't appeared on the stage yet.

Regards,

	Joey

-- 
Computers are not intelligent.  They only think they are.
