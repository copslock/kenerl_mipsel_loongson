Received:  by oss.sgi.com id <S553767AbQJPBdN>;
	Sun, 15 Oct 2000 18:33:13 -0700
Received: from short.adgrafix.com ([63.79.128.2]:64187 "EHLO
        short.adgrafix.com") by oss.sgi.com with ESMTP id <S553761AbQJPBdD>;
	Sun, 15 Oct 2000 18:33:03 -0700
Received: from ppan2 (c534317-a.stcla1.sfba.home.com [24.20.134.153])
	by short.adgrafix.com (8.9.3/8.9.3) with SMTP id VAA01115;
	Sun, 15 Oct 2000 21:27:05 -0400 (EDT)
From:   "Mike Klar" <mfklar@ponymail.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Jay Carlson" <nop@nop.com>, <linux-mips@fnet.fr>,
        <linux-mips@oss.sgi.com>
Subject: RE: stable binutils, gcc, glibc ...
Date:   Sun, 15 Oct 2000 18:33:42 -0700
Message-ID: <NDBBIDGAOKMNJNDAHDDMAENPCMAA.mfklar@ponymail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20001016023523.D15377@bacchus.dhis.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:

> Have the other tools - in particular binutils and gcc actually
> been modified
> except maybe changing defaults?

binutils we use unmodified from the cross- SRPM on ftp://oss.sgi.com.
egcs-1.0.3a did require a small patch, which Jay has at:
ftp://ftp.place.org/pub/nop/linuxce/egcs-1.0.3a-mips-softfloat.patch
I've reworked it slightly to patch cleanly against the latest Linux-MIPS
egcs-1.0.3a release, but the server that's on is a bit whacked at the moment
(the patch conflict was pretty trivial, though...).

We actually did not change the compiler default from hard-float, to compile
soft-float, the flag -msoft-float still has to be used.  Jay's patch just
makes -msoft-float work (with glibc), at least that's my understanding.

Mike Klar
