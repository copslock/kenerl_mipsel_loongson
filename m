Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 22:49:20 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:46422 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012670AbbHKUtQX4yrB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2015 22:49:16 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 65B2D5891ED;
        Tue, 11 Aug 2015 13:49:13 -0700 (PDT)
Date:   Tue, 11 Aug 2015 13:49:11 -0700 (PDT)
Message-Id: <20150811.134911.568429332024299359.davem@davemloft.net>
To:     ddaney@caviumnetworks.com
Cc:     ddaney.cavm@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        rrichter@cavium.com, tomasz.nowicki@linaro.org,
        sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, mark.rutland@arm.com,
        rafael@kernel.org, david.daney@cavium.com
Subject: Re: [PATCH v2 0/2] net: thunder: Add ACPI support.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <55CA5567.9010002@caviumnetworks.com>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
        <20150811.114908.1384923604512568161.davem@davemloft.net>
        <55CA5567.9010002@caviumnetworks.com>
X-Mailer: Mew version 6.6 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Aug 2015 13:49:13 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48774
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

From: David Daney <ddaney@caviumnetworks.com>
Date: Tue, 11 Aug 2015 13:04:55 -0700

> You seem to be recommending precedence for OF.  It should be
> consistent across all drivers/sub-systems, so do you really think
> that OF before ACPI is the way to go?

I just think it's more hackish to test acpi_disabled than to
simply see if the matching OF node even exists.

If ACPI is enabled, no OF node will be found.

It could just be my preference for such things.

I really wish it just fell out from the probing method, but
we're using PCI for that.
