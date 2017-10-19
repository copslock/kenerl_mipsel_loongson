Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 14:27:23 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:38312 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992618AbdJSM1QXWQdf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 14:27:16 +0200
Received: from localhost (unknown [27.100.128.234])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6D57A1363BDE3;
        Thu, 19 Oct 2017 05:27:07 -0700 (PDT)
Date:   Thu, 19 Oct 2017 13:27:04 +0100 (WEST)
Message-Id: <20171019.132704.299365871401082792.davem@davemloft.net>
To:     kumba@gentoo.org
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ethernet/sgi: Code cleanup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <53f0ad54-514a-b572-5801-7bd237055f86@gentoo.org>
References: <53f0ad54-514a-b572-5801-7bd237055f86@gentoo.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Oct 2017 05:27:12 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60465
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

From: Joshua Kinard <kumba@gentoo.org>
Date: Tue, 17 Oct 2017 13:54:30 -0400

> From: Joshua Kinard <kumba@gentoo.org>
> 
> The below patch attempts to clean up the code for the in-tree driver
> for IOC3 ethernet and serial console support, primarily used by SGI
> MIPS platforms.  Notable changes include:
> 
>   - Lots of whitespace cleanup
>   - Using shorthand integer types (u16, u32, etc) where appropriate

These seem to be arbitrary, "unsigned int" is a fine value for a
hash computation.

You're also making many different kinds of changes in one patch
which makes it very difficult to review.

This driver is also for such ancient hardware, that the risk
of potentially breaking the driver far outweighs the value of
"cleaning up" the code.
