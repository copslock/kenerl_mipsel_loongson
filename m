Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA03903; Tue, 8 Apr 1997 12:19:09 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA14559 for linux-list; Tue, 8 Apr 1997 12:18:04 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA14478 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 12:17:50 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id MAA00307 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 12:17:40 -0700
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id PAA01566 for linux@engr.sgi.com; Tue, 8 Apr 1997 15:03:34 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199704081903.PAA01566@neon.ingenia.ca>
Subject: serial consoles, sash and other wonders
To: linux@cthulhu.engr.sgi.com
Date: Tue, 8 Apr 1997 15:03:33 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

So damned close we can taste it.
I can tftp the kernel off neon, the bootp server is up (but not tested
-- anyone have a good way to test without a reboot), and we've got a
serial terminal set up.

We've still got to get the console working on the serial line, but we
should be OK with that.

What's got me confused is this, from the archive (I think it's wje's
message):

     On an Indy, the booted kernel (or other program) must be in MIPS
ECOFF format.  On Moosehead, the kernel must be in ELF format.  The
"-coff" option to the IRIX ld will cause it to create an ECOFF binary
instead of an ELF binary in the final link, even if all the input
binaries are in ELF format.  If you want to boot an ELF kernel on
Indy, you have to boot an indirect loader.  You can use the IRIX sash.
Put sash in the volume header on the Indy, or in a bootp-able place on
the host system.

-----

1) Where's sash?  A find / on my Indy didn't turn up anything by that
name.
2) What exactly does `bootp-able' mean?  If I stick it in
/tftpboot/205.207.220.72/sash, does that count?  (The Indy is my only
IRIX box, and I don't have the installation CDs, so I'm somewhat
loathe to go screwing with the disk.)
3) Once I get it booting (pls, pls) will the Linux kernel know how to
talk to the serial console?
4) I've just got the kernel as /tftpboot/205.207.220.72/vmlinux.  DO I
need to add .IP22 or anything?

Any ideas?

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                   Welcome to the technocracy.
#>                                                                     
#> "you'd be so disappointed
#>              to find out that the magic was not
#>                          really meant for you" - OLP
