Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2004 15:11:59 +0100 (BST)
Received: from mailer.x-mail.net ([IPv6:::ffff:65.110.6.10]:64524 "EHLO
	mailer.xmail.net") by linux-mips.org with ESMTP id <S8226073AbUGFOLz>;
	Tue, 6 Jul 2004 15:11:55 +0100
Received: from [217.115.67.73] by www.xmail.net with HTTP for <linux-mips@linux-mips.org>; Tue, 06 Jul 2004 07:11:53 -0800
Message-ID: <1089123113.40eab32979315@www.x-mail.net>
Date: Tue, 06 Jul 2004 07:11:53 -0800
From: Thomas Kunze <thomas.kunze@xmail.net>
To: linux-mips@linux-mips.org
Subject: bootimage for RM300E ?
References: <03b101c46351$96679c90$0200000a@ALEC>
In-Reply-To: <03b101c46351$96679c90$0200000a@ALEC>
X-Mailer: Web XMail 3.2a
X-Mail.net: *** Free Web Based E-Mail & Hosting ***
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.kunze@xmail.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.kunze@xmail.net
Precedence: bulk
X-list: linux-mips

Quoting Alexander Voropay <a.voropay@vmb-service.ru>:

> 
> >OK. what are the next steps to get a bigendian bootimage for the
> RM300E? 
> >are there any sources available to compile for the RM300? 
> >is there a bootimage for the RM200C that i can give a try?
> 
> 1) Install a bigendian toolchain at the x86 host box and recompile the
> Linux kernel.
> P.5  http://howto.linux-mips.org/mips-howto.html

ok i downloaded toolchain. 
which kernel should i use? that one from kernel.org or from linux-mips.org ?
what should be done next, after create a kernel ? 
what do i need to create a bootimage for the RM300 ?
how must this bootimage looks like ?
any howto's ?

with best regards
thomas
-------------------------------------------------------------------------------------------
***Protect your PC from local E-Mail Application security holes***
***Maintain your Privacy - MS Passport Free***
***Anti SPAM "Whitelist" feature***

http://www.xmail.net Web E-Mail, accessible anywhere, 128 bit SSL Secure

Voice Messages, Voice Calls (VoIP), Video Conferencing,  
XMail Messenger, Personal Web Hosting, Private Disk Storage,  
Calendar, Bookmarks, Forwarding, Virtual Mail Map Aliasing

XMail Premium: 20 - 250MB Storage, 20MB Messages, SMTP, POP3, Ad Free
Starting at $9.95 per year
-------------------------------------------------------------------------------------------
Anonymous Web Surfing http://www.snoopblocker.com
Search http://www.teradex.com
