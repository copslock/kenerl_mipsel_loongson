Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 20:49:13 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:45558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012492AbbHKStLowI0O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2015 20:49:11 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CABAE588FDB;
        Tue, 11 Aug 2015 11:49:08 -0700 (PDT)
Date:   Tue, 11 Aug 2015 11:49:08 -0700 (PDT)
Message-Id: <20150811.114908.1384923604512568161.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, rrichter@cavium.com,
        tomasz.nowicki@linaro.org, sgoutham@cavium.com,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        mark.rutland@arm.com, rafael@kernel.org, david.daney@cavium.com
Subject: Re: [PATCH v2 0/2] net: thunder: Add ACPI support.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.6 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Aug 2015 11:49:09 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48770
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
Date: Mon, 10 Aug 2015 17:58:35 -0700

> Change from v1:  Drop PHY binding part, use fwnode_property* APIs.
> 
> The first patch (1/2) rearranges the existing code a little with no
> functional change to get ready for the second.  The second (2/2) does
> the actual work of adding support to extract the needed information
> from the ACPI tables.

Series applied.

In the future it might be better structured to try and get the OF
node, and if that fails then try and use the ACPI method to obtain
these values.
