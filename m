Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 15:48:01 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:17144 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20246914AbYIQOrI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 15:47:08 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8HEl5rO018203;
	Wed, 17 Sep 2008 16:47:06 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8HEkvS8018199;
	Wed, 17 Sep 2008 15:46:57 +0100
Date:	Wed, 17 Sep 2008 15:46:56 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	u1@terran.org, linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
In-Reply-To: <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl>
References: <072748C6-07A9-4167-A8A5-80D0F7D9C784@darkforest.org>
 <B45397E7-EBE4-497B-9055-42B604A909AA@terran.org>
 <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
 <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 17 Sep 2008, Atsushi Nemoto wrote:

> On Wed, 17 Sep 2008 11:40:01 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > > and it seems to fix the problem for me.  Can you comment?
> > 
> >  It seems obvious that a carry from the bit #15 in the last addition of
> > the passed checksum -- ADDC(sum, a2) -- will negate the effect of the
> > folding.  However a simpler fix should do as well.  Try if the following
> > patch works for you.  Please note this is completely untested and further
> > optimisation is possible, but I've skipped it in this version for clarity.
> 
> Well, csum_partial()'s return value is __wsum (32-bit).  So strictly
> there is no need to folding into 16-bit.

 Hmm, what's the purpose of doing the fold in csum_partial() then?

 Anyway, having looked at the code again the byte swap at the end means
the passed checksum should be added afterwards, so my proposal is
incorrect.  Your suggestion to use 32-bit addition in all cases is 
certainly valid.

  Maciej
