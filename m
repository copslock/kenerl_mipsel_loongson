Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 13:07:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49117 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S29057233AbYISMHy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 13:07:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8JC7rWK019907;
	Fri, 19 Sep 2008 14:07:53 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8JC7qV9019905;
	Fri, 19 Sep 2008 14:07:52 +0200
Date:	Fri, 19 Sep 2008 14:07:52 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, u1@terran.org,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] MIPS checksum fix
Message-ID: <20080919120752.GA19877@linux-mips.org>
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl> <20080917.222350.41199051.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl> <20080918.002705.78730226.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809171917580.17103@cliff.in.clinika.pl> <20080918220734.GA19222@linux-mips.org> <Pine.LNX.4.55.0809190112090.22686@cliff.in.clinika.pl> <20080919112304.GB13440@linux-mips.org> <20080919114743.GA19359@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080919114743.GA19359@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 19, 2008 at 01:47:43PM +0200, Ralf Baechle wrote:

> I'm interested in test reports of this on all sorts of configurations -
> 32-bit, 64-bit, big / little endian, R2 processors and pre-R2.  In
> particular Cavium being the only MIPS64 R2 implementation would be
> interesting.  This definately is stuff which should go upstream for 2.6.27.

There was a trivial bug in the R2 code.
