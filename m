Received:  by oss.sgi.com id <S553659AbRAHSm2>;
	Mon, 8 Jan 2001 10:42:28 -0800
Received: from [62.145.23.107] ([62.145.23.107]:53339 "HELO
        fileserv2.Cologne.DE") by oss.sgi.com with SMTP id <S553653AbRAHSmX>;
	Mon, 8 Jan 2001 10:42:23 -0800
Received: from localhost (1940 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m14FhFN-00073oC@fileserv2.Cologne.DE>
	for <linux-mips@oss.sgi.com>; Mon, 8 Jan 2001 19:42:21 +0100 (CET)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id TAA00920
	for linux-mips@oss.sgi.com; Mon, 8 Jan 2001 19:30:10 +0100
Date:   Mon, 8 Jan 2001 19:30:10 +0100
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     linux-mips@oss.sgi.com
Subject: Re: Current CVS kernel no-go on R4k Decstation
Message-ID: <20010108193010.B887@excalibur.cologne.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20010108155302.A18422@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010108155302.A18422@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Jan 08, 2001 at 03:53:02PM +0100
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jan 08, 2001 at 03:53:02PM +0100, Florian Lohoff wrote:

> Hi,
> i am seeing this on my R4k Decstation (5000/150) 
> 
> This was the first try 
> 
> [...]
> Freeing unused PROM memory: 124k freed
> Freeing unused kernel memory: 60k freed
> [init:1] Illegal instruction 0320f809 at 0fb651c4 ra=0fb651cc
> [init:1] Illegal instruction 8f998018 at 0fb651c8 ra=0fb651cc
> 
> Second try doesnt give me any output at all after
> the "Freeing unused kernel ..."
> 
> CVS Checkout @ 20010108 ~15:00 MESZ
                                 ^^^^
Is it still summer in Westfalen :-) ?

Similar effect for me (DS5000/150, Checkout @ Sat Jan 6 ~22:30 CET),
except that I do not get the "illigal instruction" lines. Harald has the
same problem on his /260. It looks like sometime in December 2000
something has gone broken in the R4K-support, or are we perhaps
triggering a compiler bug in egcs 1.1.2?

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
