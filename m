Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 08:44:10 +0100 (BST)
Received: from indigo.cs.bgu.ac.il ([IPv6:::ffff:132.72.42.23]:54996 "EHLO
	indigo.cs.bgu.ac.il") by linux-mips.org with ESMTP
	id <S8225219AbTDXHoJ>; Thu, 24 Apr 2003 08:44:09 +0100
Received: from merlin (merlin [132.72.45.100])
	by indigo.cs.bgu.ac.il (8.11.0/8.11.0) with ESMTP id h3O7fZx02785;
	Thu, 24 Apr 2003 10:41:36 +0300 (IDT)
Date: Thu, 24 Apr 2003 10:43:45 +0300 (IDT)
From: Nir Tzachar <tzachar@cs.bgu.ac.il>
X-X-Sender: tzachar@merlin
To: Gilad Benjamini <yaelgilad@myrealbox.com>
cc: kernelnewbies@nl.linux.org, <linux-mips@linux-mips.org>
Subject: RE: Crash on insmod
In-Reply-To: <1051006532.8589a060yaelgilad@myrealbox.com>
Message-ID: <Pine.LNX.4.44.0304241036510.30698-100000@merlin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <tzachar@cs.bgu.ac.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tzachar@cs.bgu.ac.il
Precedence: bulk
X-list: linux-mips

> Using /lib/modules/2.4.20-pre6-sb20021114 ...
> unable to handle kernel paging request at virtual address 00006e76, epc == c0005100, ra == 80117e08
> Oops in fault.c::do_page_fault, line 224:

hello.

from ur oops msg, can i assume ur using 2.4.20-pre6 ???
does this problem happen on a stable release? 
try using a stable vanila kernel, and c what happens...

i tried insmoding ur module, and it gave no problem using  a 2.4.18 
or 2.4.20 on i386 -> maybe ur problem is mips related ??



-- 
========================================================================
nir.
