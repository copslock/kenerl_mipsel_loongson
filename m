Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2005 18:26:49 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:38154 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225256AbVAMS0n>;
	Thu, 13 Jan 2005 18:26:43 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Cp9lv-0007Jn-00; Thu, 13 Jan 2005 18:32:39 +0000
Received: from [192.168.192.200] (helo=perivale.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Cp9fR-0005kB-00; Thu, 13 Jan 2005 18:25:57 +0000
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1Cp9fR-0005bT-00; Thu, 13 Jan 2005 18:25:57 +0000
Date: Thu, 13 Jan 2005 18:25:57 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Richard Sandiford <rsandifo@redhat.com>
cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, macro@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
In-Reply-To: <874qhltcyv.fsf@redhat.com>
Message-ID: <Pine.LNX.4.61.0501131824350.21179@perivale.mips.com>
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
 <20050107.004521.74752947.anemo@mba.ocn.ne.jp> <Pine.LNX.4.61.0501101503020.18023@perivale.mips.com>
 <20050111.022138.25909508.anemo@mba.ocn.ne.jp> <Pine.LNX.4.61.0501101750420.18023@perivale.mips.com>
 <874qhltcyv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.725,
	required 4, AWL, BAYES_00)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

On Thu, 13 Jan 2005, Richard Sandiford wrote:

> >> Well, maybe the 'volatile' have no sense, but some archs (including
> >> i386, of course :-)) and some drivers use it.  Adding the 'volatile'
> >> will remove some compiler warnings.
> >
> >  As will removing "volatile" from broken ports.
> 
> There's nothing wrong with "volatile void *".

 So what's the volatile value you can get by dereferencing such a pointer?

  Maciej
