Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 08:28:08 +0100 (BST)
Received: from [IPv6:::ffff:212.105.56.244] ([IPv6:::ffff:212.105.56.244]:27229
	"EHLO dmz.lumentis.net") by linux-mips.org with ESMTP
	id <S8225331AbUEKH2F>; Tue, 11 May 2004 08:28:05 +0100
Received: from jockewin (fw [172.31.1.1])
	(authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id i4B7RmvC031005
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Tue, 11 May 2004 09:27:48 +0200
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Bradley D. LaRonde" <brad@laronde.org>,
	"Richard Sandiford" <rsandifo@redhat.com>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
Subject: RE: [uClibc] Re: uclibc mips ld.so and undefined symbols withnonzerosymbol table entry st_value
Date: Tue, 11 May 2004 09:27:42 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEGEFDCIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <JPEALJAFNGDDLOPNDIEEMEELCIAA.joakim.tjernlund@lumentis.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Return-Path: <joakim.tjernlund@lumentis.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joakim.tjernlund@lumentis.se
Precedence: bulk
X-list: linux-mips

> > Changing the alias for __phtread_once to
> > extern int __phtread_once(void) __attribute__ ((weak));
> > makes st_value=0 in libc, making the entry
> > look the same as in glibc.
> 
> hmm, this is not quite true. The binding in glibc is WEAK, but
> the above trick makes the binding GLOBAL in uClibc.

__phtread_once becoms WEAK if add "weak_function" to the
declaration in libc/inet/rpc/rpc_thread.c:
      extern weak_function int __pthread_once (pthread_once_t *__once_control,
			   void (*__init_routine) (void));
and remove the it compleatly from libc/misc/pthread/weaks.c
 
Now __phtread_once matches glibc, execpt for the reloc type. In glibc
you get a R_PPC_GLOB_DAT and in uClibc a R_PPC_ADDR32. Don't think that matters.

Is it desirable to match the pthread_ functions with glibc?
I havn't tried to run any code with these changes, so I have no
idea if it actually works.

 Jocke
