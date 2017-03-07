Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 02:07:50 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:51310 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993887AbdCGBHkqDjTS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 02:07:40 +0100
Received: from localhost (unknown [216.9.110.13])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4FB4C125C7EB5;
        Mon,  6 Mar 2017 17:07:38 -0800 (PST)
Date:   Mon, 06 Mar 2017 17:07:38 -0800 (PST)
Message-Id: <20170306.170738.1828218476269137640.davem@davemloft.net>
To:     tremyfr@gmail.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sgi: ioc3-eth: use new api
 ethtool_{get|set}_link_ksettings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1488145739-30614-1-git-send-email-tremyfr@gmail.com>
References: <1488145739-30614-1-git-send-email-tremyfr@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Mar 2017 17:07:38 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57063
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

From: Philippe Reynes <tremyfr@gmail.com>
Date: Sun, 26 Feb 2017 22:48:59 +0100

> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> As I don't have the hardware, I'd be very pleased if
> someone may test this patch.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
