Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2016 23:26:02 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:58669 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008212AbcCRWZ5kdNsU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2016 23:25:57 +0100
Received: from localhost (unknown [216.58.112.169])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 69D0D5B1436;
        Fri, 18 Mar 2016 15:25:54 -0700 (PDT)
Date:   Fri, 18 Mar 2016 18:25:50 -0400 (EDT)
Message-Id: <20160318.182550.1326216108383007578.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, david.daney@cavium.com
Subject: Re: [PATCH] netdev: Move octeon/octeon_mgmt driver to cavium
 directory.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1458003428-27632-1-git-send-email-ddaney.cavm@gmail.com>
References: <1458003428-27632-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 18 Mar 2016 15:25:54 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52662
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

From: David Daney <ddaney.cavm@gmail.com>
Date: Mon, 14 Mar 2016 17:57:08 -0700

> From: David Daney <david.daney@cavium.com>
> 
> No code changes.  Since OCTEON is a Cavium product, move the driver to
> the vendor directory to unclutter things a bit.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Applied, thanks.
