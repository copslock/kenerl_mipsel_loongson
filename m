Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 09:32:10 +0100 (BST)
Received: from mail-out.m-online.net ([IPv6:::ffff:212.18.0.9]:41631 "EHLO
	mail-out.m-online.net") by linux-mips.org with ESMTP
	id <S8225203AbUGMIcF>; Tue, 13 Jul 2004 09:32:05 +0100
Received: from mail.m-online.net (svr14.m-online.net [192.168.3.144])
	by svr8.m-online.net (Postfix) with ESMTP id 012AF52A69;
	Tue, 13 Jul 2004 10:32:01 +0200 (CEST)
Received: from denx.de (host-82-135-33-74.customer.m-online.net [82.135.33.74])
	by mail.m-online.net (Postfix) with ESMTP id E4A0CE4287;
	Tue, 13 Jul 2004 10:32:00 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 6D23E422AE; Tue, 13 Jul 2004 10:32:00 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 20933C109F; Tue, 13 Jul 2004 10:32:00 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 1DC6513D6D2; Tue, 13 Jul 2004 10:32:00 +0200 (MEST)
To: "safiudeen Ts" <safiudeen@hotmail.com>
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Jtag spec. and the firmware for Au1100 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Tue, 13 Jul 2004 08:23:01 -0000."
             <BAY15-F33CIq1eE3VsX00049230@hotmail.com> 
Date: Tue, 13 Jul 2004 10:31:55 +0200
Message-Id: <20040713083200.20933C109F@atlas.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <BAY15-F33CIq1eE3VsX00049230@hotmail.com> you wrote:
> How can we copy the kernel image to target board (processor au1100  )?
> if we want to use JTAG where can I get the jatg schemetic detailes and the 
> firmware for Red Hat linux 9

You don't need any special information about the JTAG interface  (and
you  will  find that it is very difficult to get and under strict NDA
if at all). All you need is a JTAG debugger which understands how  to
deal  with  this interface, for example the Abatron BDI2000 (which is
just great especially for Linux).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The C-shell doesn't parse. It adhoculates.
    - Casper.Dik@Holland.Sun.COM in <3ol96k$b2j@engnews2.Eng.Sun.COM>
