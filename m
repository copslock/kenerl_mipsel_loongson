Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 14:32:10 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:58893 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225410AbVFVNbr>; Wed, 22 Jun 2005 14:31:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BC8FAF596C; Wed, 22 Jun 2005 15:30:38 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04842-04; Wed, 22 Jun 2005 15:30:38 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6B44BF596A; Wed, 22 Jun 2005 15:30:38 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5MDUZAQ014489;
	Wed, 22 Jun 2005 15:30:35 +0200
Date:	Wed, 22 Jun 2005 14:30:41 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: .set mips2 breaks 64bit kernel (Re: CVS Update@linux-mips.org:
 linux)
In-Reply-To: <42B95FB2.1090604@gentoo.org>
Message-ID: <Pine.LNX.4.61L.0506221403420.4849@blysk.ds.pg.gda.pl>
References: <20050614173512Z8225617-1340+8840@linux-mips.org>
 <20050622.163101.103777455.nemoto@toshiba-tops.co.jp>
 <Pine.LNX.4.61L.0506221330240.4849@blysk.ds.pg.gda.pl> <42B95FB2.1090604@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/950/Wed Jun 22 02:48:34 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 22 Jun 2005, Kumba wrote:

> I've tested to see it break IP30, and Thiemo reported IP27 was also not
> booting (no text display after kernel entry).  Reversing this patch seems to
> allow both systems to boot.  Is it possible it breaks ELF64-only builds?  I
> haven't tested it on IP28 yet, so I can't confirm this (it's also ELF64).

 Well, could I please ask people to be more specific when writing such 
reports?  Unfortunately "break" can mean anything and my crystal ball is 
currently away for a service.  At least you've mentioned problems at a 
bootstrap, so I infer it's not a build-time failure.

 That said, I'm only using ELF64 for my 64-bit builds, so that shouldn't 
be the cause.  But I think there is one possiblity of a problem -- 
obsolete versions of GCC may rely on gas expanding "ll" and "sc" as 
macros, i.e. substitute a name of a symbol rather than a valid 
machine-level address expression (e.g. "0($reg)" or "%lo(sym)($reg)") for 
memory constraints.  Well, by using "m" right now we sort of permit it to.  

 But shouldn't gas actually complain if the ISA or CPU selection forbids 
it doing the right address calculation for the ABI in use?  I think it 
should, so I consider it a bug in gas.  Of course, blaming gas doesn't 
magically make our code right, but the deficiency makes noticing such 
problems tougher.

 As we still strive to support old versions of GCC, I guess a reasonable 
solution is taking an approach similar to that I already have in 
include/asm-mips/bitops.h, i.e. defining __SET_MIPS appropriately and 
using it instead of hardcoded ".set mips2".  I'll prepare a fix shortly.

  Maciej
