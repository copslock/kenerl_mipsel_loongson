Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 13:36:34 +0100 (BST)
Received: from [IPv6:::ffff:212.105.56.244] ([IPv6:::ffff:212.105.56.244]:22984
	"EHLO dmz.lumentis.net") by linux-mips.org with ESMTP
	id <S8225267AbUEJMgd>; Mon, 10 May 2004 13:36:33 +0100
Received: from jockewin (fw [172.31.1.1])
	(authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id i4ACaPvC029223
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 10 May 2004 14:36:25 +0200
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Bradley D. LaRonde" <brad@laronde.org>,
	"Richard Sandiford" <rsandifo@redhat.com>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
Subject: RE: [uClibc] Re: uclibc mips ld.so and undefined symbols with nonzerosymbol table entry st_value
Date: Mon, 10 May 2004 14:36:20 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEEEEJCIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <JPEALJAFNGDDLOPNDIEEIEEICIAA.joakim.tjernlund@lumentis.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Return-Path: <joakim.tjernlund@lumentis.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joakim.tjernlund@lumentis.se
Precedence: bulk
X-list: linux-mips

> 
> This looks like the problem we had with dlopen() and friends when introducing
> the new WEAK symbol handling.
> 
> in libc/misc/pthread/weaks.c you have stuff like:
> weak_alias(__phtread_return_0, __phtread_once);
> 
> where __phtread_return_0 is non NULL:
> int __phtread_return_0(void)
> {
>  return 0;
> }
> 

Changing the alias for __phtread_once to
extern int __phtread_once(void) __attribute__ ((weak));
makes st_value=0 in libc, making the entry
look the same as in glibc.

 Jocke
