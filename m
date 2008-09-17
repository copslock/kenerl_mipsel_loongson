Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 19:21:41 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:37616 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S23860100AbYIQSVa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 19:21:30 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8HILSvx019114;
	Wed, 17 Sep 2008 20:21:28 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8HILO7t019110;
	Wed, 17 Sep 2008 19:21:24 +0100
Date:	Wed, 17 Sep 2008 19:21:23 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	u1@terran.org, linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
In-Reply-To: <20080918.002705.78730226.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.55.0809171917580.17103@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
 <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl>
 <20080918.002705.78730226.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 18 Sep 2008, Atsushi Nemoto wrote:

> >  Hmm, what's the purpose of doing the fold in csum_partial() then?
> 
> Well, maybe odd-byte handling requires 16-bit holded values?

 It should be enough to swap odd and even bytes in the word in the
unaligned path.  Though perhaps extra code to do masking would make it no
shorter/faster than what we have now; however the aligned path would
benefit.  Hmm...

  Maciej
