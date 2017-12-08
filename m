Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 20:29:43 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:47184 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbdLHT3gsVJIK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 20:29:36 +0100
Received: from localhost (unknown [38.140.131.194])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2557C133F654C;
        Fri,  8 Dec 2017 11:29:32 -0800 (PST)
Date:   Fri, 08 Dec 2017 14:29:31 -0500 (EST)
Message-Id: <20171208.142931.969279261124372071.davem@davemloft.net>
To:     david.daney@cavium.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        james.hogan@mips.com, netdev@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        steven.hill@cavium.com, devicetree@vger.kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com, pombredanne@nexb.com, cmunoz@cavium.com
Subject: Re: [PATCH v6 net-next,mips 6/7] netdev: octeon-ethernet: Add
 Cavium Octeon III support.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20171208000934.6554-7-david.daney@cavium.com>
References: <20171208000934.6554-1-david.daney@cavium.com>
        <20171208000934.6554-7-david.daney@cavium.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Dec 2017 11:29:33 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61379
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

From: David Daney <david.daney@cavium.com>
Date: Thu,  7 Dec 2017 16:09:33 -0800

> +static void bgx_port_check_state(struct work_struct *work)
> +{
 ...
> +	mutex_lock(&priv->lock);
> +	if (priv->work_queued)
> +		queue_delayed_work(check_state_wq, &priv->dwork, HZ);
> +	mutex_unlock(&priv->lock);
> +}
 ...
> +int bgx_port_disable(struct net_device *netdev)
> +{
 ...
> +	mutex_lock(&priv->lock);
> +	if (priv->work_queued) {
> +		cancel_delayed_work_sync(&priv->dwork);
> +		priv->work_queued = false;

This can deadlock.

When you do a sync work cancel, it waits until all running work
instances finish.  You have the priv->lock, so if
bgx_port_check_status() need to still take priv->lock to complete
then no further progress will be made.

I think it is pointless to use this weird work_queued boolean state.

Just unconditionally, and without locking, cancel the delayed work,
ragardless of whether it was actually used ever or not.

Thank you.
