Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2004 14:22:47 +0100 (BST)
Received: from p508B68D3.dip.t-dialin.net ([IPv6:::ffff:80.139.104.211]:51224
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225555AbUGANWn>; Thu, 1 Jul 2004 14:22:43 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i61DMfMd006291;
	Thu, 1 Jul 2004 15:22:41 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i61DMeQa006290;
	Thu, 1 Jul 2004 15:22:40 +0200
Date: Thu, 1 Jul 2004 15:22:40 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 pci_dma_sync_sg fix
Message-ID: <20040701132240.GA6219@linux-mips.org>
References: <20040701.222120.41626500.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701.222120.41626500.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 01, 2004 at 10:21:20PM +0900, Atsushi Nemoto wrote:

> pci_dma_sync_sg in 2.4 tree seems broken.  pci_map_sg were fixed a
> while ago.  Please fix pci_dma_sync_sg also.

Leave the #ifdef stuff there - or otherwise gcc might optimize this into
empty loops ...

  Ralf
