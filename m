Received:  by oss.sgi.com id <S554151AbRBCRF3>;
	Sat, 3 Feb 2001 09:05:29 -0800
Received: from [62.145.23.107] ([62.145.23.107]:23056 "HELO
        fileserv2.Cologne.DE") by oss.sgi.com with SMTP id <S554147AbRBCRFL>;
	Sat, 3 Feb 2001 09:05:11 -0800
Received: from localhost (1481 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m14P67Y-0007FZC@fileserv2.Cologne.DE>
	for <linux-mips@oss.sgi.com>; Sat, 3 Feb 2001 18:05:08 +0100 (CET)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id SAA14172
	for linux-mips@oss.sgi.com; Sat, 3 Feb 2001 18:05:32 +0100
Date:   Sat, 3 Feb 2001 18:05:32 +0100
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     linux-mips@oss.sgi.com
Subject: Re: [PATCH] R3912 mm stuff from linux-vr tree
Message-ID: <20010203180532.A6849@excalibur.cologne.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20010203162758.A1986@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010203162758.A1986@paradigm.rfc822.org>; from flo@rfc822.org on Sat, Feb 03, 2001 at 04:27:58PM +0100
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Feb 03, 2001 at 04:27:58PM +0100, Florian Lohoff wrote:

[PATCH]
> I only booted on an R3912 Board and it seemed to work at least for
> Cache detection - Could someone verify if this doesnt break R3k
> Decstations e.g ?

It looks like the DECstation support is already broken again :-(. I have
just tried to test the current CVS on a 5000/150 - the kernel crashes just
after mounting the rootfs. Anybody with similar experience?

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der
Nutzung oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die
Markt- oder Meinungsforschung.
