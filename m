Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 11:12:53 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:31729 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S29037900AbYISKMi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 11:12:38 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8JACVOM029824;
	Fri, 19 Sep 2008 12:12:31 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8JACNG4029814;
	Fri, 19 Sep 2008 11:12:23 +0100
Date:	Fri, 19 Sep 2008 11:12:22 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, u1@terran.org,
	linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
In-Reply-To: <20080918220734.GA19222@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0809190112090.22686@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
 <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl>
 <20080918.002705.78730226.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.55.0809171917580.17103@cliff.in.clinika.pl>
 <20080918220734.GA19222@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2008, Ralf Baechle wrote:

> Which is a truely weird operation - but MIPS R2 happens to have a wonderful
> instruction for this operation, WSBH / DSBH.

 Ah, finally a justification for the R2 ISA!

 Seriously though, I smell a caller somewhere fails to call csum_fold() on
the result obtained from csum_partial() where it should, so it would be
good to fix the bug rather than trying to cover it.  Bryan, would you be
able to track down the caller?

 I can see you have done the microoptimisation I had in mind meanwhile --
thanks for saving me the effort. ;)  There is a delay slot to fill left
though -- will you take care of it too?

  Maciej
