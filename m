Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2004 10:14:27 +0100 (BST)
Received: from mailer.x-mail.net ([IPv6:::ffff:65.110.6.10]:14861 "EHLO
	mailer.xmail.net") by linux-mips.org with ESMTP id <S8226025AbUGFJOW>;
	Tue, 6 Jul 2004 10:14:22 +0100
Received: from [217.115.67.74] by www.xmail.net with HTTP for <a.voropay@vmb-service.ru>; Tue, 06 Jul 2004 02:14:20 -0800
Message-ID: <1089105260.40ea6d6cf2f9c@www.x-mail.net>
Date: Tue, 06 Jul 2004 02:14:20 -0800
From: Thomas Kunze <thomas.kunze@xmail.net>
To: a.voropay@vmb-service.ru
Cc: linux-mips@linux-mips.org
Subject: RE: Linux on SNI RM300E ?
References: <038c01c46334$38621de0$0200000a@ALEC>
In-Reply-To: <038c01c46334$38621de0$0200000a@ALEC>
X-Mailer: Web XMail 3.2a
X-Mail.net: *** Free Web Based E-Mail & Hosting ***
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.kunze@xmail.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.kunze@xmail.net
Precedence: bulk
X-list: linux-mips

Quoting Alexander Voropay <a.voropay@vmb-service.ru>:

>  AFAIK, the RM300E is an ARC compatible. (?)
i don't no. i saw something like that on the net. but nothing about that in the manuals
that i have.
> 
>  So, try to load "arcdiag" utility instead of kernel :
> 
> ftp://ftp.sra.co.jp/pub/os/NetBSD/misc/arc/
> 
i've downloaded the arcdiag-0.2 and served it via tftp. but the RM300E don't like that
file. it only says "Bad magic number". what does this mean (little/bigendian)? 

the same error-message appears when the to load mipsel boot-images.

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
