Received:  by oss.sgi.com id <S553719AbQJXBZ2>;
	Mon, 23 Oct 2000 18:25:28 -0700
Received: from fileserv2.cologne.de ([195.227.25.6]:13127 "HELO
        fileserv2.Cologne.DE") by oss.sgi.com with SMTP id <S553698AbQJXBZR>;
	Mon, 23 Oct 2000 18:25:17 -0700
Received: from localhost (1731 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m13nspy-0006uSC@fileserv2.Cologne.DE>
	for <linux-mips@oss.sgi.com>; Tue, 24 Oct 2000 03:25:10 +0200 (CEST)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id DAA03717;
	Tue, 24 Oct 2000 03:22:33 +0200
Message-ID: <20001024032232.A3426@excalibur.cologne.de>
Date:   Tue, 24 Oct 2000 03:22:32 +0200
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     linux-mips@fnet.fr
Cc:     linux-mips@oss.sgi.com
Subject: process lockups
Mail-Followup-To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91i
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hallo everyone,

I am running Kernel 2.4.0-test9 on a DECstation 5000/150. I am
experiencing a strange behaviour when having strong I/O-load, such as
running a "tar xvf foobar.tgz" with a large archive. After some time of
activity the process (in this case tar) is stuck in status "D". There is
neither an entry in the syslog nor on the console that would give me a
hint what is happening. Is anyone else experiencing this?

Another thing I see on my 5000/150 (and only there - this is my only
R4K-machine, so I do not know whether this is CPU- or machine-type-bound)
is "top" going weird, eating lots of CPU cycles and spitting messages
"schedule_timeout: wrong timeout value fffbd0b2 from 800900f8; Setting
flush to zero for top". I know Florian also has this on his 5000/150.
Anyone else with the same behavoiur or any idea about the cause for this?

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der
Nutzung oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die
Markt- oder Meinungsforschung.
