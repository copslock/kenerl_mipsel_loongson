Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2006 01:54:32 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36256 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20038469AbWHWAya (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2006 01:54:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7N0snGT029814;
	Wed, 23 Aug 2006 01:54:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7N0skMC029790;
	Wed, 23 Aug 2006 01:54:46 +0100
Date:	Wed, 23 Aug 2006 01:54:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Alexander Voropay <a.voropay@equant.ru>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/12] Cobalt use GT64120 PCI routines
Message-ID: <20060823005446.GA21720@linux-mips.org>
References: <20060822223406.56435d84.yoichi_yuasa@tripeaks.co.jp> <0b2801c6c5ff$1ff8a8c0$e90d11ac@spb.in.rosprint.ru> <20060823094444.4c158363.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823094444.4c158363.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 23, 2006 at 09:44:44AM +0900, Yoichi Yuasa wrote:

> arch/mips/pci/pci-gt64120.c supports only PCI_0.
> Now GT64111 and GT64120 can share pci-gt64120.c .
> 
> I don't know a board that uses PCI_1.
> Do you have any information about it?

The GT-64120 even has a special mode where multiple GT-64120 can be
combined into a single system.  Some people have hacked Linux to
support that configuration but the code was never contributed back and
it's a very rare hardware configuration anyway.

  Ralf
