Received:  by oss.sgi.com id <S42247AbQJKF77>;
	Tue, 10 Oct 2000 22:59:59 -0700
Received: from fileserv2.cologne.de ([195.227.25.6]:42860 "HELO
        fileserv2.Cologne.DE") by oss.sgi.com with SMTP id <S42215AbQJKF7Y>;
	Tue, 10 Oct 2000 22:59:24 -0700
Received: from localhost (2179 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m13jEuT-0006vBC@fileserv2.Cologne.DE>
	for <linux-mips@oss.sgi.com>; Wed, 11 Oct 2000 07:58:37 +0200 (CEST)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id HAA01454;
	Wed, 11 Oct 2000 07:48:50 +0200
Message-ID: <20001011074850.A999@excalibur.cologne.de>
Date:   Wed, 11 Oct 2000 07:48:50 +0200
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     linux-mips@oss.sgi.com
Subject: Re: Problem w/ serial console after power-on
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20001011013803.A5873@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91i
In-Reply-To: <20001011013803.A5873@lug-owl.de>; from Jan-Benedict Glaw on Wed, Oct 11, 2000 at 01:38:04AM +0200
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 11, 2000 at 01:38:04AM +0200, Jan-Benedict Glaw wrote:

> I've got a DECStation 5000/120 and tried to start some hacking,
> but no success: I can read everything the box outputs to its
> serial lines, but anything I type into my minicom seems to end
> up in /dev/null... The cable is okay, but what could be wrong
> instead? Any hints?

Well known effect :-)
I have a "normal" 7-wire-nullmodem cable that works fine when connecting
my vt420 to my Linux PC and running a getty on the port, ist also works
fine when connecting the vt420 to the DECstations serial console port, but
I have the same problem as you when connecting the DECstation to the PC
and running a terminal emulation program on the PC.

The soloution: use a 3-wire-nullmodem cable and inside each of the
connectors connect RTS-CTS and DTR-DSR-DCD.

This should look like this:

DECstation           PC

GND ---------------- GND

RxD ---------------- TxD

TxD ---------------- RxD

RTS -+            +- RTS
     |            |
CTS -+            +- CTS

DTR-+             +- DTR
    |             |
DSR-+             +- DSR
    |             |
DCD-+             +- DCD

  
Viel Spass beim Loeten :-).

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
