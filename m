Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 03:37:23 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:56888
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491903Ab0EYBhU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 May 2010 03:37:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id 9B10824C08E;
        Mon, 24 May 2010 18:37:26 -0700 (PDT)
Date:   Mon, 24 May 2010 18:37:26 -0700 (PDT)
Message-Id: <20100524.183726.264769230.davem@davemloft.net>
To:     yuasa@linux-mips.org
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: net/dccp: expansion of error code size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20100524154508.10a40589.yuasa@linux-mips.org>
References: <20100524154508.10a40589.yuasa@linux-mips.org>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Yoichi Yuasa <yuasa@linux-mips.org>
Date: Mon, 24 May 2010 15:45:08 +0900

> Because MIPS's EDQUOT value is 1133(0x46d).
> It's larger than u8.
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>

Applied, thank you.
