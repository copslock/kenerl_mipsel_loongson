Received:  by oss.sgi.com id <S553887AbRCFF4z>;
	Mon, 5 Mar 2001 21:56:55 -0800
Received: from [62.145.23.107] ([62.145.23.107]:26416 "HELO
        fileserv2.Cologne.DE") by oss.sgi.com with SMTP id <S553882AbRCFF4h>;
	Mon, 5 Mar 2001 21:56:37 -0800
Received: from localhost (1929 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m14aASZ-0007clC@fileserv2.Cologne.DE>
	for <linux-mips@oss.sgi.com>; Tue, 6 Mar 2001 06:56:35 +0100 (CET)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id TAA01480
	for linux-mips@oss.sgi.com; Mon, 5 Mar 2001 19:59:39 +0100
Date:   Mon, 5 Mar 2001 19:59:39 +0100
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     linux-mips@oss.sgi.com
Subject: Re: build-problems: GNU fileutils 4.01 on mipsel with glibc 2.2.2
Message-ID: <20010305195939.A1476@excalibur.cologne.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20010304213609.B25825@linuxtag.org> <20010304231534.B17775@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010304231534.B17775@bacchus.dhis.org>; from ralf@oss.sgi.com on Sun, Mar 04, 2001 at 11:15:34PM +0100
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Mar 04, 2001 at 11:15:34PM +0100, Ralf Baechle wrote:

[glibc-2.2.2, gcc-2.95.3]
> > chroot()-environment. When trying to compile fileutils, the ./configure
> > starts ok, but when coming to "checking for working mktime..." the script
> > just hangs forever, and according to top there is nothing consuming CPU
> > time (except for top itself). Compiling the fileutils on the "host
> > system", i.e. outside the chroot()-environment using egcs-1.0.3a and
> > glibc-2.0.6 the problem does not appear. Can anybody confirm this on
> > another system? Any ideas what can be the reason for this?
> 
> Does you chroot environment have a mounted /proc filesystem?  In the past
> we had obscure libc bugs which were triggered when /proc were not
> mounted.

I had not mounted /proc, but doing so does not make any difference :-(.

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
