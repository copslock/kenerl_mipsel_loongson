Received:  by oss.sgi.com id <S553685AbQJRArC>;
	Tue, 17 Oct 2000 17:47:02 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:26117 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553673AbQJRAqo>;
	Tue, 17 Oct 2000 17:46:44 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A56489F1; Wed, 18 Oct 2000 02:46:41 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C444C900C; Wed, 18 Oct 2000 02:45:32 +0200 (CEST)
Date:   Wed, 18 Oct 2000 02:45:32 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: delo 0.7
Message-ID: <20001018024532.B2130@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
new "delo" release - It seems that i might call it "everyday use" release.

New features:

- reads /etc/delo.conf for parameters and kernel image name
- command line arguments for the bootsector installer


-----------------schnipp------------------------------------

KN05 V2.1k    (PC: 0xbfc007ac, SP: 0x82e47de8)
3/prcache
delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
Loading /etc/delo.conf .. ok
Loading /boot/vmlinux ................... ok
This DECstation is a DS5000/2x0
Loading R4000 MMU routines.
CPU revision is: 00000440
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.
Linux version 2.4.0-test8-pre1 (flo@slimer.rfc822.org) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)) #3 Fri Oct 13 16:27:07 CEST 2000

-----------------schnapp------------------------------------

There is a known bug i cant seem to find - Look into the readme.

I only tried on /260 so far but i guess itl work on any REX machine.
There is currentl no "NON-REX" support but someday ....

The loading is currently SLOW like hell - I guess
its because of the PROM beeing very slow. There are possibilities
to speed up - But - Who wants to boot his Decstation that often ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
