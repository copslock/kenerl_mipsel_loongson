Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 13:21:30 +0100 (BST)
Received: from [IPv6:::ffff:212.105.56.244] ([IPv6:::ffff:212.105.56.244]:27586
	"EHLO dmz.lumentis.net") by linux-mips.org with ESMTP
	id <S8225255AbUEJMV3>; Mon, 10 May 2004 13:21:29 +0100
Received: from jockewin (fw [172.31.1.1])
	(authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id i4ACLIvC029180
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 10 May 2004 14:21:19 +0200
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Bradley D. LaRonde" <brad@laronde.org>,
	"Richard Sandiford" <rsandifo@redhat.com>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
Subject: RE: [uClibc] Re: uclibc mips ld.so and undefined symbols with nonzerosymbol table entry st_value
Date: Mon, 10 May 2004 14:21:13 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEIEEICIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <012701c43607$83aa65f0$8d01010a@prefect>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Return-Path: <joakim.tjernlund@lumentis.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joakim.tjernlund@lumentis.se
Precedence: bulk
X-list: linux-mips

> > The x86 and MIPS ABIs are very different though.
> 
> I notice that the debian mipsel libpthread.so.0 in
> http://ftp.debian.org/pool/main/g/glibc/libc6_2.2.5-11.5_mipsel.deb has
> st_value == 0 for every UND FUNC, just like my x86 debian libraries.  This
> is very different than the uClibc libpthread.so where every UND FUNC has
> st_value != 0.  Interestingly if I link glibc's libpthread with uClibc's
> libc.so I see that most UND FUNCs then have st_value != 0.
> 
> I would like to see how uClibc ld.so behaves I could somehow get ld to not
> generate any stubs in  libpthread.  Any idea why libpthread gets full stubs
> when linked with uClibc libc.so but no stubs when linked with glibc libc.so?

This looks like the problem we had with dlopen() and friends when introducing
the new WEAK symbol handling.

in libc/misc/pthread/weaks.c you have stuff like:
weak_alias(__phtread_return_0, __phtread_once);

where __phtread_return_0 is non NULL:
int __phtread_return_0(void)
{
 return 0;
}
