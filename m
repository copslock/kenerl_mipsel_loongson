Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2004 02:36:34 +0100 (BST)
Received: from thunder.netspace.net.au ([IPv6:::ffff:203.10.110.71]:28424 "EHLO
	mail.netspace.net.au") by linux-mips.org with ESMTP
	id <S8226037AbUEPBgZ>; Sun, 16 May 2004 02:36:25 +0100
Received: from [192.168.1.1] (dsl-203-113-219-176.VIC.netspace.net.au [203.113.219.176])
	by mail.netspace.net.au (Postfix) with ESMTP id EE4DD4213B
	for <linux-mips@linux-mips.org>; Sun, 16 May 2004 11:36:18 +1000 (EST)
From: Jason Hecker <jhecker@wireless.org.au>
Reply-To: jhecker@wireless.org.au
Organization: Melbourne Wireless
To: linux-mips@linux-mips.org
Subject: EJTAG and RTL8181
Date: Sun, 16 May 2004 11:36:16 +1000
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161136.16071.jhecker@wireless.org.au>
Return-Path: <jhecker@wireless.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhecker@wireless.org.au
Precedence: bulk
X-list: linux-mips

I am trying to get JTAG working with Realtek's RTL8181 part.  It uses a Lexra 
LX5280 core which is mostly MIPS R3000 compatible (bar the unaligned load and 
save instructions).

A chronicle of my efforts can be seen here: 
http://www.wireless.org.au/~jhecker/rtljtag

Realtek can't offer me a BSDL file as they claim they use some 3rd party tool 
to talk to it with JTAG.  My lack of luck with Macraigor's Wiggler and a demo 
of their OCD debugger (in Windows) in EJTAG mode just yielded a screenful of 
errors.

Has anyone had much experience with Wigglers and MIPS based parts that don't 
support EJTAG?  Any ideas on trying to reverse engineer the boundary scan 
chain?
