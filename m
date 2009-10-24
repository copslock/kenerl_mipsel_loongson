Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Oct 2009 15:23:34 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43208
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492360AbZJXNX0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Oct 2009 15:23:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 2E33FC8C2A9;
	Sat, 24 Oct 2009 06:23:40 -0700 (PDT)
Date:	Sat, 24 Oct 2009 06:23:39 -0700 (PDT)
Message-Id: <20091024.062339.83445567.davem@davemloft.net>
To:	ddaney@caviumnetworks.com
Cc:	cfriesen@nortel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Irq architecture for multi-core network driver.
From:	David Miller <davem@davemloft.net>
In-Reply-To: <4AE0DB98.1000101@caviumnetworks.com>
References: <4AE0D14B.1070307@caviumnetworks.com>
	<4AE0D72A.4090607@nortel.com>
	<4AE0DB98.1000101@caviumnetworks.com>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>
Date: Thu, 22 Oct 2009 15:24:24 -0700

> Certainly this is one mode of operation that should be supported, but
> I would also like to be able to go for raw throughput and have as many
> cores as possible reading from a single queue (like I currently have).

You can't do this, at least within the same flow, since as you even
mention in your original posting this can result in packet reordering
which we must avoid as much as is possible.
