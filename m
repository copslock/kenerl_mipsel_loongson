Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2009 05:39:54 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:56890
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491978AbZHZDjq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2009 05:39:46 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id C1CB5C8C1B2;
	Tue, 25 Aug 2009 20:39:50 -0700 (PDT)
Date:	Tue, 25 Aug 2009 20:39:50 -0700 (PDT)
Message-Id: <20090825.203950.26330430.davem@davemloft.net>
To:	a.beregalov@gmail.com
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] irda/au1k_ir: fix broken netdev_ops conversion
From:	David Miller <davem@davemloft.net>
In-Reply-To: <1251125667-6509-1-git-send-email-a.beregalov@gmail.com>
References: <1251125667-6509-1-git-send-email-a.beregalov@gmail.com>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Mon, 24 Aug 2009 18:54:27 +0400

> This patch is based on commit d2f3ad4 (pxaficp-ir: remove incorrect
> net_device_ops). Do the same for au1k_ir.
> Untested.
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>

Applied.
