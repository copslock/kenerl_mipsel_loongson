Received:  by oss.sgi.com id <S42240AbQGMHQW>;
	Thu, 13 Jul 2000 00:16:22 -0700
Received: from rno-dsl0b-218.gbis.net ([216.82.145.218]:40202 "EHLO
        ozymandias.foobazco.org") by oss.sgi.com with ESMTP
	id <S42211AbQGMHPx>; Thu, 13 Jul 2000 00:15:53 -0700
Received: (from wesolows@localhost)
	by ozymandias.foobazco.org (8.9.3/8.9.3) id AAA27586
	for linux-mips@oss.sgi.com; Thu, 13 Jul 2000 00:16:01 -0700
Date:   Thu, 13 Jul 2000 00:16:01 -0700
From:   Keith M Wesolowski <wesolows@foobazco.org>
To:     linux-mips@oss.sgi.com
Subject: Simple Linux/MIPS 0.2b
Message-ID: <20000713001601.A27565@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Simple Linux/MIPS 0.2b ``Death on a Stick'' has been released.

*** This is not a production release ***

This version runs on big-endian MIPS systems and has been tested on
R4400 SGI IP22. You can obtain the distribution from the following location:

MANDATORY Release Notes:
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/userland-0.2b/RELEASE_NOTES-0.2b
Binaries:
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/userland-0.2b/bin

There are also some patches in the src/ directory. I have lost some of
my patches but will be recreating them and making them available at
that location as well. Also included is a summary of the commands used
to build the distribution.

Highlights:

- glibc 2.1.90 (000622) based - with empty symbol fix from Maciej
- gcc 2.96 (000707)
- binutils 2.10.90 (000707)
- linux 2.4.0-test3-pre5 (000708)
- support for profiling
- full netkit and net-tools
- gdb 5.0
- ncurses 5.1
- kernel debugging tools
- numerous bugs fixed
- numerous new bugs

Please read the release notes before using. Installation instructions
for 0.1, which should still work in general, can be found at
http://foobazco.org/~wesolows/Install-HOWTO.html.

Thanks to everyone who has been submitting patches, fixing bugs,
writing the software, and in general making this distribution
possible.

This will be the last release for at least 6 weeks. Happy hacking!

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows/
(( Project Foobazco Coordinator and Network Administrator )) aiieeeeeeee!
"The list of people so amazingly stupid they can't even tie their shoes?"
"Yeah, you know, /etc/passwd."
