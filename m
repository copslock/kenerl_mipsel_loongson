Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA04723; Tue, 8 Apr 1997 12:31:51 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA18855 for linux-list; Tue, 8 Apr 1997 12:31:14 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA18552; Tue, 8 Apr 1997 12:30:31 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA17386; Tue, 8 Apr 1997 12:26:23 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199704081926.MAA17386@yon.engr.sgi.com>
Subject: Re: serial consoles, sash and other wonders
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Tue, 8 Apr 1997 12:26:23 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199704081903.PAA01566@neon.ingenia.ca> from "Mike Shaver" at Apr 8, 97 03:03:33 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Just in case the real experts on this don't answer.
I'll give my 0.02 ...

Check out the following man pages:

dvhtool (1M)            - modify and obtain disk volume header information
vh (7M)                 - disk volume header

sash is hidden in that volume header. In a normal IRIX system,
The ARC PROM boots sash and sash boots /unix.

/unix is ELF (32 or 64 depending on the platform) in every IRIX
since 6.2 (I think). Used to be ECOFF earlier.

sash is ECOFF on Indys and ELF in newer systems as Bill Earl
said. One of the things we need to give you are the sources
for sash, right ?

I'll see what I can do on the sash thing. (Actually was on my
TODO list for a while.)

:
:So damned close we can taste it.
:I can tftp the kernel off neon, the bootp server is up (but not tested
:-- anyone have a good way to test without a reboot), and we've got a
:serial terminal set up.
:
:We've still got to get the console working on the serial line, but we
:should be OK with that.
:
:What's got me confused is this, from the archive (I think it's wje's
:message):
:
:     On an Indy, the booted kernel (or other program) must be in MIPS
:ECOFF format.  On Moosehead, the kernel must be in ELF format.  The
:"-coff" option to the IRIX ld will cause it to create an ECOFF binary
:instead of an ELF binary in the final link, even if all the input
:binaries are in ELF format.  If you want to boot an ELF kernel on
:Indy, you have to boot an indirect loader.  You can use the IRIX sash.
:Put sash in the volume header on the Indy, or in a bootp-able place on
:the host system.
:
:-----
:
:1) Where's sash?  A find / on my Indy didn't turn up anything by that
:name.
:2) What exactly does `bootp-able' mean?  If I stick it in
:/tftpboot/205.207.220.72/sash, does that count?  (The Indy is my only
:IRIX box, and I don't have the installation CDs, so I'm somewhat
:loathe to go screwing with the disk.)
:3) Once I get it booting (pls, pls) will the Linux kernel know how to
:talk to the serial console?
:4) I've just got the kernel as /tftpboot/205.207.220.72/vmlinux.  DO I
:need to add .IP22 or anything?
:
:Any ideas?
:
:Mike
:
:-- 
:#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
:#>                   Welcome to the technocracy.
:#>                                                                     
:#> "you'd be so disappointed
:#>              to find out that the magic was not
:#>                          really meant for you" - OLP
:


-- 
Peace, Ariel
