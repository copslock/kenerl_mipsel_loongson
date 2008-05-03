Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2008 20:57:21 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:3832 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28583755AbYECT5T (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 May 2008 20:57:19 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m43JvDs2021039;
	Sat, 3 May 2008 21:57:13 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m43Jv4mB021032;
	Sat, 3 May 2008 20:57:04 +0100
Date:	Sat, 3 May 2008 20:57:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, tsbogend@alpha.franken.de,
	linux-mips@linux-mips.org
Subject: Re: Breakage in arch/mips/kernel/traps.c for 64bit
In-Reply-To: <20080503173927.GA19925@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0805032051010.20206@cliff.in.clinika.pl>
References: <20080501163314.GA9955@alpha.franken.de> <20080502101113.GA24408@linux-mips.org>
 <20080504.011647.93019265.anemo@mba.ocn.ne.jp> <20080503173927.GA19925@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 3 May 2008, Ralf Baechle wrote:

> Slightly cleaner:
> 
>   return KSEGX(a) == KSEG0;

 You mean:

return KSEGX(a) == KSEG0 || KSEGX(a) == KSEG1;

right?

> Unfortunately there is no such macro for the 64-bit segments nor does
> the existing KSEGX() work correctly for non-CKSEGx 64-bit addresses.

 As I mentioned there is suitable code doing exactly this in
arch/mips/lib/uncached.c and it can be extracted to an inline function to
be put in <asm/addrspace.h> to be reused here and in the future possibly
elsewhere.

  Maciej
