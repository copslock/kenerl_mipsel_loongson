Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 18:19:47 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:50164 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007992AbbCTRTpokXM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 18:19:45 +0100
Received: from localhost (cpe-66-108-87-106.nyc.res.rr.com [66.108.87.106])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B7EB55840FD;
        Fri, 20 Mar 2015 10:19:43 -0700 (PDT)
Date:   Fri, 20 Mar 2015 13:19:43 -0400 (EDT)
Message-Id: <20150320.131943.186301137261996820.davem@davemloft.net>
To:     markos.chandras@imgtec.com
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        pcnet32@frontier.com
Subject: Re: [PATCH v2] net: ethernet: pcnet32: Setup the SRAM and NOUFLO
 on Am79C97{3,5}
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1426760894-2677-1-git-send-email-markos.chandras@imgtec.com>
References: <20150319083704.GA31322@mchandras-linux.le.imgtec.org>
        <1426760894-2677-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: Mew version 6.6 on Emacs 24.4 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46483
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

From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 19 Mar 2015 10:28:14 +0000

> On a MIPS Malta board, tons of fifo underflow errors have been observed
> when using u-boot as bootloader instead of YAMON. The reason for that
> is that YAMON used to set the pcnet device to SRAM mode but u-boot does
> not. As a result, the default Tx threshold (64 bytes) is now too small to
> keep the fifo relatively used and it can result to Tx fifo underflow errors.
> As a result of which, it's best to setup the SRAM on supported controllers
> so we can always use the NOUFLO bit.
> 
> Cc: <netdev@vger.kernel.org>
> Cc: <stable@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Cc: Don Fry <pcnet32@frontier.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

Applied.
