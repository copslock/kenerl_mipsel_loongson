Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 16:34:02 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:57100 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225784AbVD1Pds>; Thu, 28 Apr 2005 16:33:48 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3SFXuqg005957;
	Thu, 28 Apr 2005 16:33:56 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3SFXuLS005956;
	Thu, 28 Apr 2005 16:33:56 +0100
Date:	Thu, 28 Apr 2005 16:33:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	"Kevin D. Kissell" <KevinK@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: preempt safe fpu-emulator
Message-ID: <20050428153356.GI1276@linux-mips.org>
References: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp> <20050428134118.GC1276@linux-mips.org> <002d01c54bfa$5b913f80$0deca8c0@Ulysses> <20050428152123.GH1276@linux-mips.org> <Pine.LNX.4.61L.0504281623160.31018@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0504281623160.31018@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 28, 2005 at 04:25:30PM +0100, Maciej W. Rozycki wrote:

>  It depends on how they were actually used -- real FPU circuitry is 
> "global", too, and somehow it works or at least it has to.

But it's not shared across processes ;-)

  Ralf
