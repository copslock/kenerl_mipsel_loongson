Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 07:12:05 +0100 (BST)
Received: from vopmail.sfo.interquest.net ([IPv6:::ffff:66.135.128.69]:58382
	"EHLO micaiah.rwc.iqcicom.com") by linux-mips.org with ESMTP
	id <S8225278AbTEJGMB>; Sat, 10 May 2003 07:12:01 +0100
Received: from Muruga.localdomain (unverified [66.135.134.124]) by micaiah.rwc.iqcicom.com
 (Vircom SMTPRS 2.0.244) with ESMTP id <B0006366815@micaiah.rwc.iqcicom.com> for <linux-mips@linux-mips.org>;
 Fri, 9 May 2003 23:11:59 -0700
Received: from localhost (muthu@localhost)
	by Muruga.localdomain (8.11.6/8.11.2) with ESMTP id h4A5oON12880
	for <linux-mips@linux-mips.org>; Fri, 9 May 2003 22:50:24 -0700
Date: Fri, 9 May 2003 22:50:24 -0700 (PDT)
From: Muthukumar Ratty <muthu@iqmail.net>
To: <linux-mips@linux-mips.org>
Subject: Re: OpenSSL/Binutils Issues
In-Reply-To: <3EBC7E21.6040109@gentoo.org>
Message-ID: <Pine.LNX.4.33.0305092248450.12875-100000@Muruga.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <muthu@iqmail.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muthu@iqmail.net
Precedence: bulk
X-list: linux-mips

> 		./conftest: error while loading shared libraries:
> 		usr/lib/libcrypto.so.0.9.6: unexpected reloc type 0x68
>


something really wrong with your crypto library (has some non mips
specific rel. syms???)

> not sure if this is mips-specific, or if I need to bother the OpenSSL
> team about it.

probably you should :)


>
> 	Ideas?
>
> --Kumba
>
>
>
>
