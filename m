Received:  by oss.sgi.com id <S553765AbQJXR5p>;
	Tue, 24 Oct 2000 10:57:45 -0700
Received: from fileserv2.cologne.de ([195.227.25.6]:35673 "HELO
        fileserv2.Cologne.DE") by oss.sgi.com with SMTP id <S553714AbQJXR5X>;
	Tue, 24 Oct 2000 10:57:23 -0700
Received: from localhost (3405 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m13o8K5-0006w7C@fileserv2.Cologne.DE>
	for <ralf@oss.sgi.com>; Tue, 24 Oct 2000 19:57:17 +0200 (CEST)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id TAA04519;
	Tue, 24 Oct 2000 19:55:55 +0200
Message-ID: <20001024195555.A4469@excalibur.cologne.de>
Date:   Tue, 24 Oct 2000 19:55:55 +0200
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: process lockups
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
	linux-mips@oss.sgi.com
References: <20001024044736.B3397@bacchus.dhis.org> <200010240551.HAA02069@sparta.research.kpn.com> <20001024163843.A7342@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91i
In-Reply-To: <20001024163843.A7342@bacchus.dhis.org>; from Ralf Baechle on Tue, Oct 24, 2000 at 04:38:43PM +0200
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 24, 2000 at 04:38:43PM +0200, Ralf Baechle wrote:

> Which is a problem - I need exactly the WCHAN information to debug this
> problem.

Here we go...

Two major processes are running: a tar zxvf (PIDs 212 and 213) and a
dpkg-buildpackage. Both together should consume all CPU time available,
but they do not, they just sit idle. Interesting is that here there is no
process in state "D" as I had before. This seems to be reproducible.

These logs were created from a fresh cvs-checkout (already including your
patch).

root# ps -laww
  F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
100 S     0   189   168  0  60   0 -  1000 pause  ttyp0    00:00:00 screen
100 S     0   212   191  1  60   0 -   579 ?      ttya0    00:00:00 tar
000 S     0   213   212  0  60   0 -   394 pipe_w ttya0    00:00:00 gzip
100 S     0   220   197  0  60   0 -   873 wait4  ttya2    00:00:00 dpkg-buildpacka
100 S     0   272   220  0  60   0 -  1563 wait4  ttya2    00:00:02 dpkg-source
000 S     0   277   272  0  60   0 -   394 pipe_w ttya2    00:00:00 gunzip
100 S     0   278   272  0  60   0 -   536 ?      ttya2    00:00:00 cpio
000 S     0   279   278  0  60   0 -   864 wait4  ttya2    00:00:00 sh
000 S     0   280   279  0  60   0 -   333 pipe_w ttya2    00:00:00 egrep
000 R     0   283   196  0  60   0 -   800 -      ttya1    00:00:00 ps

While this happens, top tells:

27 processes: 26 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  10.5% user,   9.5% system,   0.0% nice,  79.9% idle
Mem:  127056K av,  22064K used, 104992K free,      0K shrd,    488K buff
Swap:      0K av,      0K used,      0K free                 10952K cached
 
  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
  284 root       0   0  1048 1048   684 R       0 12.9  0.8   0:00 top
  190 root       0   0  1204 1204   984 S       0  0.8  0.9   0:02 screen
    1 root       0   0   484  484   408 S       0  0.0  0.3   0:02 init
[...]
Any further processes have 0% CPU.


After some time the tar zxvf suddenly starts running and decompresses the
archive in one step.

Hope this description is helpful, if you need further information, just
mail me.

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
