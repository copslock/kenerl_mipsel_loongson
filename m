Received:  by oss.sgi.com id <S553781AbQJYBa1>;
	Tue, 24 Oct 2000 18:30:27 -0700
Received: from u-66.karlsruhe.ipdial.viaginterkom.de ([62.180.19.66]:1541 "EHLO
        u-66.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S553775AbQJYBaF>; Tue, 24 Oct 2000 18:30:05 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869752AbQJYB3c>;
        Wed, 25 Oct 2000 03:29:32 +0200
Date:   Wed, 25 Oct 2000 03:29:32 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: process lockups
Message-ID: <20001025032932.A15247@bacchus.dhis.org>
References: <20001024044736.B3397@bacchus.dhis.org> <200010240551.HAA02069@sparta.research.kpn.com> <20001024163843.A7342@bacchus.dhis.org> <20001024195555.A4469@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001024195555.A4469@excalibur.cologne.de>; from karsten@excalibur.cologne.de on Tue, Oct 24, 2000 at 07:55:55PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 24, 2000 at 07:55:55PM +0200, Karsten Merker wrote:

> Two major processes are running: a tar zxvf (PIDs 212 and 213) and a
> dpkg-buildpackage. Both together should consume all CPU time available,
> but they do not, they just sit idle. Interesting is that here there is no
> process in state "D" as I had before. This seems to be reproducible.
> 
> These logs were created from a fresh cvs-checkout (already including your
> patch).

Which was still pretty fishy.  The scheduler has changed significantly
and so it took a little bit more fixing.  Which explains the `?' in the
listing below.  I tried to fix this in the CVS tree.

> root# ps -laww
>   F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
> 100 S     0   189   168  0  60   0 -  1000 pause  ttyp0    00:00:00 screen
> 100 S     0   212   191  1  60   0 -   579 ?      ttya0    00:00:00 tar
> 000 S     0   213   212  0  60   0 -   394 pipe_w ttya0    00:00:00 gzip
> 100 S     0   220   197  0  60   0 -   873 wait4  ttya2    00:00:00 dpkg-buildpacka
> 100 S     0   272   220  0  60   0 -  1563 wait4  ttya2    00:00:02 dpkg-source
> 000 S     0   277   272  0  60   0 -   394 pipe_w ttya2    00:00:00 gunzip
> 100 S     0   278   272  0  60   0 -   536 ?      ttya2    00:00:00 cpio
> 000 S     0   279   278  0  60   0 -   864 wait4  ttya2    00:00:00 sh
> 000 S     0   280   279  0  60   0 -   333 pipe_w ttya2    00:00:00 egrep
> 000 R     0   283   196  0  60   0 -   800 -      ttya1    00:00:00 ps

Ok, so dpkg-buildpackage is waiting for the termination of some other
process.

> While this happens, top tells:
> 
> 27 processes: 26 sleeping, 1 running, 0 zombie, 0 stopped
> CPU states:  10.5% user,   9.5% system,   0.0% nice,  79.9% idle
> Mem:  127056K av,  22064K used, 104992K free,      0K shrd,    488K buff
> Swap:      0K av,      0K used,      0K free                 10952K cached
>  
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
>   284 root       0   0  1048 1048   684 R       0 12.9  0.8   0:00 top
>   190 root       0   0  1204 1204   984 S       0  0.8  0.9   0:02 screen
>     1 root       0   0   484  484   408 S       0  0.0  0.3   0:02 init
> [...]
> Any further processes have 0% CPU.

Those CPU percentage are meaninless anyway.  They don't indicate anything
about a process' current CPU usage.

> After some time the tar zxvf suddenly starts running and decompresses the
> archive in one step.

The `?' show that tar is sleeping but due to thie get_wchan bug was don't
see on what it is waiting for so there is little I can do with this
information ...

  Ralf
