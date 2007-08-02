Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 12:27:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7836 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022091AbXHBL1w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 12:27:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l72BRpNQ026937;
	Thu, 2 Aug 2007 12:27:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l72BRpvY026936;
	Thu, 2 Aug 2007 12:27:51 +0100
Date:	Thu, 2 Aug 2007 12:27:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Imre Kaloz <kaloz@openwrt.org>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Sync SiByte system code to the new DUART driver - try 2
Message-ID: <20070802112751.GA26930@linux-mips.org>
References: <op.twfi9gbp2s3iss@ecaz.afh.b-m.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.twfi9gbp2s3iss@ecaz.afh.b-m.hu>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 02, 2007 at 01:23:30PM +0200, Imre Kaloz wrote:

> The new upstream SiByte DUART driver uses a different config option then
> the old one, so the SiByte target doesn't compile currently.
> This patch fixes the problem and also syncs the defconfig files.

Too late, already fixed that myself :)

  Ralf
