Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2012 22:41:43 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:51816 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903439Ab2IXUlh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2012 22:41:37 +0200
Received: from localhost (nat-pool-rdu.redhat.com [66.187.233.202])
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9A1C9584CEA;
        Mon, 24 Sep 2012 13:41:34 -0700 (PDT)
Date:   Mon, 24 Sep 2012 16:41:30 -0400 (EDT)
Message-Id: <20120924.164130.1073842749430205590.davem@davemloft.net>
To:     sjhill@mips.com
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] net: mipsnet: Remove the MIPSsim Ethernet driver.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1348498036-30257-1-git-send-email-sjhill@mips.com>
References: <1348498036-30257-1-git-send-email-sjhill@mips.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 34547
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>
Date: Mon, 24 Sep 2012 09:47:16 -0500

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> The MIPSsim platform is no longer supported or used. This patch
> deletes the Ethernet driver.
> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

I'll apply this to net-next, thanks.
