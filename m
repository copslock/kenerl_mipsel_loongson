Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2003 11:01:20 +0100 (BST)
Received: from grex.cyberspace.org ([IPv6:::ffff:216.93.104.34]:18440 "HELO
	grex.cyberspace.org") by linux-mips.org with SMTP
	id <S8225204AbTFXKBS>; Tue, 24 Jun 2003 11:01:18 +0100
Received: from localhost (ik@localhost) by grex.cyberspace.org (8.6.13/8.6.12) with SMTP id GAA06619; Tue, 24 Jun 2003 06:00:17 -0400
Date: Tue, 24 Jun 2003 06:00:16 -0400 (EDT)
From: <ik@cyberspace.org>
To: <kernelnewbies@nl.linux.org>, <linux-mips@linux-mips.org>
Subject: is there any docs/manuals for linker scripts symbols
Message-ID: <Pine.SUN.3.96.1030624055005.4605A-100000@grex.cyberspace.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ik@grex.cyberspace.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ik@cyberspace.org
Precedence: bulk
X-list: linux-mips

Hi All,

Is there any documentation for the symbols in the ld.script linker
scripts for the linux kernel. 

I'm porting Linux kernel to a mips board for which I need to understand
the various symbols used in the kernel.

For example what is the use of the following symbols
`__init_begin'
`__init_end'
`__initcall_start
`__initcall_end'
`_ftext'
`__setup_start'
`__setup_end'

I'm not good in these linker scripts... any help pointers would be of
great help to me ! (I'm referrring gnu ld  manual pages ... still have a
long way to go :(

Thanks in advance !
Indu
