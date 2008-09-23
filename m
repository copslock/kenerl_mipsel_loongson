Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 23:06:23 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57534 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28652780AbYIWWGU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2008 23:06:20 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8NM6Grd011145;
	Wed, 24 Sep 2008 00:06:17 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8NM6EYg011143;
	Wed, 24 Sep 2008 00:06:14 +0200
Date:	Wed, 24 Sep 2008 00:06:14 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bryan Phillippe <u1@terran.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] MIPS checksum fix
Message-ID: <20080923220614.GA10590@linux-mips.org>
References: <20080917.222350.41199051.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl> <20080918.002705.78730226.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809171917580.17103@cliff.in.clinika.pl> <20080918220734.GA19222@linux-mips.org> <Pine.LNX.4.55.0809190112090.22686@cliff.in.clinika.pl> <20080919112304.GB13440@linux-mips.org> <20080919114743.GA19359@linux-mips.org> <20080919120752.GA19877@linux-mips.org> <BFB5F5A7-2980-4BCB-A14D-9EB6114B031B@terran.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFB5F5A7-2980-4BCB-A14D-9EB6114B031B@terran.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 23, 2008 at 02:52:24PM -0700, Bryan Phillippe wrote:

> If anyone would like to send me an updated unified diff for this issue, I 
> can re-test today within the next day.

An updated fix is already in the lmo and kernel.org git repositories.

  Ralf
