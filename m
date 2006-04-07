Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 18:33:30 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:21680 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133600AbWDGRdQ
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Apr 2006 18:33:16 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k37HiX71020170;
	Fri, 7 Apr 2006 10:44:34 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k37HiQXw028374;
	Fri, 7 Apr 2006 10:44:32 -0700 (PDT)
Message-ID: <090d01c65a6b$623f6480$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001126.GA17967@deprecation.cyrius.com> <20060220003128.GD17967@deprecation.cyrius.com> <20060220113420.GB5594@linux-mips.org> <20060407171910.GU6869@deprecation.cyrius.com>
Subject: Re: Diff between Linus' and linux-mips git: elf.h
Date:	Fri, 7 Apr 2006 19:47:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Arguably, whatever's used by binutils should be the tie-breaker.
Googling around, I see that the EM_MIPS_RS3_LE value was
added in the October 4, 1999 draft of the ELF spec, but inexplicably
the alias with EM_MIPS_RS4_BE was left in place - perhaps they
were supposed to be disambiguated by some 32-vs-64-bit flag
somewhere.  A random sampling of ELF documents on the web
shows the vast majority calling out RS3_LE and not RS4_BE.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Martin Michlmayr" <tbm@cyrius.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Sent: Friday, April 07, 2006 7:19 PM
Subject: Re: Diff between Linus' and linux-mips git: elf.h


> * Ralf Baechle <ralf@linux-mips.org> [2006-02-20 11:34]:
> > > Can we agree?
> > > -#define EM_MIPS_RS4_BE 10 /* MIPS R4000 big-endian */
> > > +#define EM_MIPS_RS3_LE 10 /* MIPS R3000 little-endian */
> > Not really :-)
> > 
> > I've dug deep into history - but it seems nobody remembers the reason for
> > this change anymore.  I suspect actually both constant names might
> > historically have been in use.  For the purposes of Linux it's probably
> > best to dump the whole number - it never had any relevance.
> 
> Maybe you can remove it, or at least bring it in sync.
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
> 
> 
