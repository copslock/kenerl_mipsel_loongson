Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR7Pvo08653
	for linux-mips-outgoing; Mon, 26 Nov 2001 23:25:57 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAR7Pso08650
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 23:25:55 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAR6Pof31489;
	Tue, 27 Nov 2001 17:25:50 +1100
Date: Tue, 27 Nov 2001 17:25:50 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Status RM200
Message-ID: <20011127172550.D29424@dea.linux-mips.net>
References: <20011126204509.A10341@paradigm.rfc822.org> <20011126213450.B943@excalibur.cologne.de> <20011126231737.B13081@paradigm.rfc822.org> <20011126233548.D26510@finlandia.infodrom.north.de> <20011127071800.A292@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011127071800.A292@excalibur.cologne.de>; from karsten@excalibur.cologne.de on Tue, Nov 27, 2001 at 07:18:10AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 27, 2001 at 07:18:10AM +0100, Karsten Merker wrote:

> > > How can the RM200 port be wrong endianess - The RM200 is bi-endian
> > > thus any endianess would be ok (As long as the port does not assume
> > > a specific endianess except the prom stuff).
> 
> Unfortunately the firmware functions are different between little- and
> big-endian firmware and there are quite some parts in the RM200 support
> which currently do not work (and some even do not compile) on a big-endian
> machine due to missing (correct) definitions. Another problem regarding 
> the big endian firmware is that nobody seems to have documentation about
> it, not even a function vector table.

As I understand the big endian firmware is just yet another ARC firmware
implementation with some support for old MIPS firmware style vector tables.

  Ralf
