Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2011 01:54:38 +0200 (CEST)
Received: from mail.vyatta.com ([76.74.103.46]:44260 "EHLO mail.vyatta.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491194Ab1DLXye (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Apr 2011 01:54:34 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.vyatta.com (Postfix) with ESMTP id 3FD4D18298B6;
        Tue, 12 Apr 2011 16:54:27 -0700 (PDT)
X-Virus-Scanned: amavisd-new at tahiti.vyatta.com
Received: from mail.vyatta.com ([127.0.0.1])
        by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AV6FADaB47BD; Tue, 12 Apr 2011 16:54:26 -0700 (PDT)
Received: from nehalam (static-50-53-80-93.bvtn.or.frontiernet.net [50.53.80.93])
        by mail.vyatta.com (Postfix) with ESMTPSA id 4E0DB1829045;
        Tue, 12 Apr 2011 16:54:26 -0700 (PDT)
Date:   Tue, 12 Apr 2011 16:54:24 -0700
From:   Stephen Hemminger <shemminger@vyatta.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: lantiq: add ethernet driver
Message-ID: <20110412165424.0b6ba71a@nehalam>
In-Reply-To: <1302624675-18652-3-git-send-email-blogic@openwrt.org>
References: <1302624675-18652-1-git-send-email-blogic@openwrt.org>
        <1302624675-18652-3-git-send-email-blogic@openwrt.org>
Organization: Vyatta
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <shemminger@vyatta.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shemminger@vyatta.com
Precedence: bulk
X-list: linux-mips

On Tue, 12 Apr 2011 18:11:14 +0200
John Crispin <blogic@openwrt.org> wrote:

> +
> +struct ltq_mii_priv {
> +	struct ltq_eth_data *pldata;
> +	struct resource *res;
> +	struct net_device_stats stats;

You don't need to have private stats structure it is part
of net_device in recent kernels. In fact, since you don't
set .ndo_get_stats, the driver is getting the default function
which prints the values from network_device, not your priv structure.

Also, please consider adding basic ethtool support to
show speed/duplex and driver information.

-- 
