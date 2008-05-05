Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2008 00:17:26 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:62096 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20022420AbYEEXRX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 May 2008 00:17:23 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m45NGaKq031412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 May 2008 16:16:37 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m45NGY4K010330;
	Mon, 5 May 2008 16:16:34 -0700
Date:	Mon, 5 May 2008 16:16:34 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Matteo Croce <matteo@openwrt.org>
Cc:	jgarzik@pobox.com, ralf@linux-mips.org, nbd@openwrt.org,
	ejka@imfi.kspu.ru, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH]: cpmac bugfixes and enhancements
Message-Id: <20080505161634.6964d46b.akpm@linux-foundation.org>
In-Reply-To: <200805041904.22726.matteo@openwrt.org>
References: <200805041904.22726.matteo@openwrt.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Sun, 4 May 2008 19:04:22 +0200
Matteo Croce <matteo@openwrt.org> wrote:

> This patch fixes an IRQ storm, a locking issues, moves platform code in the right sections
> and other small fixes.
> 

Please feed this patch (and all future ones) through scripts/checkpatch.pl.
It picks up rather a lot of simple problems which there is no reason for
us to retain.

>
> ...
>
> +	spin_unlock(&priv->rx_lock);
> +	netif_rx_complete(priv->dev, napi);
> +	netif_stop_queue(priv->dev);
> +	napi_disable(&priv->napi);
> +	
> +	atomic_inc(&priv->reset_pending);
> +	cpmac_hw_stop(priv->dev);
> +	if (!schedule_work(&priv->reset_work))
> +		atomic_dec(&priv->reset_pending);
> +	return 0;
> + 
>  }
>  
>  static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
> @@ -456,6 +549,9 @@ static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct cpmac_desc *desc;
>  	struct cpmac_priv *priv = netdev_priv(dev);
>  
> +	if (unlikely(atomic_read(&priv->reset_pending)))
> +		return NETDEV_TX_BUSY;
> +

This looks a bit strange.  schedule_work() will return zero if the work was
already scheduled, in which case we arrange for cpmac_start_xmit() to abort
early.

But if schedule_work() *doesn't* return zero, there is a time window in
which the reset is still pending.  Because it takes time for keventd to be
awoken and to run the work function.

I would have thought that we would want to prevent cpmac_start_xmit() from
running within that time window also?


But that's just a guess - the text which you used to describe your work is
missing much information, so I don't have a lot to work with here.
