Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 15:23:57 +0100 (BST)
Received: from [IPv6:::ffff:212.105.56.244] ([IPv6:::ffff:212.105.56.244]:5352
	"EHLO dmz.lumentis.net") by linux-mips.org with ESMTP
	id <S8225576AbUEJOXd>; Mon, 10 May 2004 15:23:33 +0100
Received: from jockewin (fw [172.31.1.1])
	(authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id i4AENNvC029493
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 10 May 2004 16:23:23 +0200
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Bradley D. LaRonde" <brad@laronde.org>,
	"Richard Sandiford" <rsandifo@redhat.com>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
Subject: RE: [uClibc] Re: uclibc mips ld.so and undefined symbols with nonzerosymbol table entry st_value
Date: Mon, 10 May 2004 16:23:18 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEMEELCIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <JPEALJAFNGDDLOPNDIEEEEEJCIAA.joakim.tjernlund@lumentis.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Return-Path: <joakim.tjernlund@lumentis.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joakim.tjernlund@lumentis.se
Precedence: bulk
X-list: linux-mips

> Changing the alias for __phtread_once to
> extern int __phtread_once(void) __attribute__ ((weak));
> makes st_value=0 in libc, making the entry
> look the same as in glibc.

hmm, this is not quite true. The binding in glibc is WEAK, but
the above trick makes the binding GLOBAL in uClibc.

  Jocke
PS

 I am on PPC, so I may be way off here w.r.t MIPS:(
