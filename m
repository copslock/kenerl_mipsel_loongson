Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 07:13:26 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:44260 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815759Ab3FTFNYQMQH6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 07:13:24 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 82FFC581CF2;
        Wed, 19 Jun 2013 22:13:20 -0700 (PDT)
Date:   Wed, 19 Jun 2013 22:13:18 -0700 (PDT)
Message-Id: <20130619.221318.187522776943172956.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        david.daney@cavium.com
Subject: Re: [PATCH 0/2] netdev: octeon_mgmt minor fixes.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37042
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
Date: Wed, 19 Jun 2013 17:40:18 -0700

> David Daney (2):
>   netdev: octeon_mgmt: Correct tx IFG workaround.
>   netdev: octeon_mgmt: Fix structure layout for little-endian.

Applied to net, thanks.
