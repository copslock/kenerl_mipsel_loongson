Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2004 01:29:33 +0100 (BST)
Received: from cantor.suse.de ([IPv6:::ffff:195.135.220.2]:1997 "EHLO
	Cantor.suse.de") by linux-mips.org with ESMTP id <S8225202AbUHKA33>;
	Wed, 11 Aug 2004 01:29:29 +0100
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 82B58A263DC;
	Wed, 11 Aug 2004 02:24:38 +0200 (CEST)
To: Richard Henderson <rth@redhat.com>
Cc: Richard Sandiford <rsandifo@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl>
	<410E9E25.7080104@mips.com> <87acxcbxfl.fsf@redhat.com>
	<410F5964.3010109@mips.com> <876580bm2e.fsf@redhat.com>
	<410F60DF.9020400@mips.com>
	<Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl>
	<87r7qiwz54.fsf@redhat.com> <20040809220838.GE16493@redhat.com>
	<87zn5336h7.fsf@redhat.com> <20040810232020.GA21922@redhat.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm EXCITED!!  I want a FLANK STEAK WEEK-END!!  I think I'm JULIA
 CHILD!!
Date: Wed, 11 Aug 2004 02:24:37 +0200
In-Reply-To: <20040810232020.GA21922@redhat.com> (Richard Henderson's
 message of "Tue, 10 Aug 2004 16:20:20 -0700")
Message-ID: <je3c2usere.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <schwab@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@suse.de
Precedence: bulk
X-list: linux-mips

Richard Henderson <rth@redhat.com> writes:

> Patch seems ok then.  We'd have to add a new macro/target flag
> to handle non-truncating shifts -- we've got cases:
>
>   (1) Large shift shifts out all bits (ARM)
>   (2) Large shifts trap (VAX)
>   (3) Shift count truncated to 31, always, which means QI/HI
>       shifts are yield undefined results with large shifts.  (i386)
    (4) Shift count reduced modulo 64 (m68k)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
