Received:  by oss.sgi.com id <S553897AbQKLRDL>;
	Sun, 12 Nov 2000 09:03:11 -0800
Received: from [62.145.23.107] ([62.145.23.107]:21369 "HELO
        fileserv2.Cologne.DE") by oss.sgi.com with SMTP id <S553885AbQKLRCp>;
	Sun, 12 Nov 2000 09:02:45 -0800
Received: from localhost (1347 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m13v0Wb-0006sNC@fileserv2.Cologne.DE>
	for <linux-mips@oss.sgi.com>; Sun, 12 Nov 2000 18:02:37 +0100 (CET)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id RAA02817;
	Sun, 12 Nov 2000 17:58:59 +0100
Message-ID: <20001112175843.A1201@excalibur.cologne.de>
Date:   Sun, 12 Nov 2000 17:58:43 +0100
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     linux-mips@oss.sgi.com
Subject: Re: Boot Problem on DS 5000/240
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20001111154721.B9307@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91i
In-Reply-To: <20001111154721.B9307@lug-owl.de>; from Jan-Benedict Glaw on Sat, Nov 11, 2000 at 03:47:22PM +0100
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Nov 11, 2000 at 03:47:22PM +0100, Jan-Benedict Glaw wrote:

> I've got some problem booting another DECStation I've got:
> 
> = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
> KN03-AA V5.1b
          ^^^^^

This firmware release has no working tftp support. Boot via MOP,
mopd-sources are available at http://decstation.unix-ag.org/.

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
