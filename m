Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2018 17:42:01 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:60720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994650AbeBSQlxsOIwn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Feb 2018 17:41:53 +0100
Received: from localhost (67.110.78.66.ptr.us.xo.net [67.110.78.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1F3EB13C441F3;
        Mon, 19 Feb 2018 08:41:44 -0800 (PST)
Date:   Mon, 19 Feb 2018 11:41:44 -0500 (EST)
Message-Id: <20180219.114144.1093189940690873472.davem@davemloft.net>
To:     paul.burton@mips.com
Cc:     David.Laight@ACULAB.COM, netdev@vger.kernel.org,
        hassan.naveed@mips.com, matt.redfearn@mips.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v5 07/14] net: pch_gbe: Fix handling of TX padding
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180219164223.plclfvimcyiqzh4h@pburton-laptop>
References: <20180217201037.3006-8-paul.burton@mips.com>
        <33d3777368d244a79c6287b2e955853f@AcuMS.aculab.com>
        <20180219164223.plclfvimcyiqzh4h@pburton-laptop>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 19 Feb 2018 08:41:45 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Paul Burton <paul.burton@mips.com>
Date: Mon, 19 Feb 2018 08:42:23 -0800

> So whilst I totally agree that copying around the whole frame is awful,
> it's a separate problem to the length used for DMA mapping being
> incorrect which is what this patch addresses & I'd rather not start
> adding more & more fixes or cleanups into this initial series before the
> driver is even functional on my hardware.

Agreed.
