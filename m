Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 18:18:13 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:34484 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022753AbXFGRSL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 18:18:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57HBC2q031484;
	Thu, 7 Jun 2007 18:11:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57HBB8B031483;
	Thu, 7 Jun 2007 18:11:11 +0100
Date:	Thu, 7 Jun 2007 18:11:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] update cobalt_defconfig
Message-ID: <20070607171111.GB31413@linux-mips.org>
References: <20070602021241.2147f7ee.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070602021241.2147f7ee.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 02, 2007 at 02:12:41AM +0900, Yoichi Yuasa wrote:

> This patch has updated cobalt_defconfig.
> Cobalt button support has added to it.
> Also ATA driver has changed BLK_DEV_VIA82CXXX to PATA_VIA.

Queued up for 2.6.23.

  Ralf
