Received:  by oss.sgi.com id <S554128AbRA0BvA>;
	Fri, 26 Jan 2001 17:51:00 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:56077 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S554125AbRA0Buh>;
	Fri, 26 Jan 2001 17:50:37 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id 78607205FA
	for <linux-mips@oss.sgi.com>; Fri, 26 Jan 2001 17:50:31 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Fri, 26 Jan 2001 17:44:46 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id 77D421595F
	for <linux-mips@oss.sgi.com>; Fri, 26 Jan 2001 17:50:31 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 8CEE1686D; Fri, 26 Jan 2001 17:50:49 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     linux-mips@oss.sgi.com
Subject: GDB 5 for mips-linux/Shared library loading with new binutils/glibc
Date:   Fri, 26 Jan 2001 17:40:07 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <0101261750492Y.00834@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Working with some pretty bleeding edge GNU tools, here, and there doesn't seem
to be any support for mips-linux in GDB 5.  Has anyone else run across this,
and, if so, are there patches available somewhere?

Also, I've run into a problem with ld.so from glibc-2.2 on mips32-linux.  After
some hunting, I found that the templates in elf32bsmip.sh for gnu ld have
recently changed to support SHLIB_TEXT_START_ADDR as a (non-zero) base address
for shared library loading.  SHLIB_TEXT_START_ADDR defaults to 0x5ffe0000 in
the current sources.

I'm curious if anyone knows the rationale for these changes.  Best conjecture
I've heard is that it allows ld.so to not have to relocate itself, as it will
load by default to the high address.  

However, ld.so seems to know nothing about relocating shared library with a
non-zero shared library base address, which causes dynamically linked stuff to
crash spectacularly.  

I think fixing ld.so won't be too difficult, but I'm really wanting to find out
why these changes were made.  And whether I'm reinventing some wheels by fixing
ld.so to cope with the new binutils stuff.

Anyone tread the ground before?

binutils we're using is from CVS as of about Dec 17th.  Glibc is also a
snapshot from about the same time.

-Justin
