Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 01:58:41 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32839 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012446AbcBKA6jSSFwE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 01:58:39 +0100
Received: by mail-pa0-f47.google.com with SMTP id fl4so8428969pad.0
        for <linux-mips@linux-mips.org>; Wed, 10 Feb 2016 16:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Vrvtu7j9cCfsZQlDAL8+oWyy+6KCeOD8S5zj32zeu74=;
        b=MebKVxA4ixuafIsdQyhEccjy66Tabpw+wYJ7tCPcd5myEpeYqvVXB5ZmQUdLRdtnvM
         q1TrXhXi6Sjd7W8wex0WswbKftU/SBqmKcDqB/YTteP5bNgCbEUBZQ+5X9zJFyIm8QKD
         BdMbwvqrzt0Craj5bOQ8oeP/M3UIRQHEi+QBaVv/5IGNvISFolrXNE2n3ahLqC2LCn0H
         2aufl97Cx+KJTWDHKM0xawUwfifBc++i5Uv9VS+2FtK9EuylVmAETtiRpKXOvEtyOYp7
         q1TSstV9m3W2kdBNydPiyUrKnbK1XwVI90rIiYD+EzrT9KknVhbM+LIdt9a18jmRKMtH
         cmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Vrvtu7j9cCfsZQlDAL8+oWyy+6KCeOD8S5zj32zeu74=;
        b=GAvrlY4P3k2P+SdZXUEHpjPQ9alc4mfyvDHqUig+byhRWZ4kFiy2hmhq7lnJEDC0Bg
         rm7mSZk5UnRToxZAymM0HfEz0fJoa1pfbwqoKZpf5+jdHsetUh/t+rlyoht09WqLtnEe
         yPsLnPxebam3uaeVc4qg7c9Zw4v7NqT1ITPrSOuM+3uvOacp35FbPu7yEAiclxYxKN/b
         VsvJf8xBSQ7EvpwgKwK3GbQZSXWo/oxmk2HSzVwT6cIHAtsb8wp7qyJ8XxAk+dnNyMAp
         2Pp5dl9Q3yXs/FPZIj8tV0ZZ4x4fSCsaOy1x9z9SiUq+fHQGs7mYUF3v7avNyhGUPg51
         ZiQA==
X-Gm-Message-State: AG10YOT9+SEO51Y30mC6rPlZyZWkUSp/VJy4goWQSFZRfm3MdCWbq85Q62QrfNkLPOkibA==
X-Received: by 10.66.122.36 with SMTP id lp4mr63270617pab.31.1455152313625;
        Wed, 10 Feb 2016 16:58:33 -0800 (PST)
Received: from xeon-e3 (static-50-53-82-155.bvtn.or.frontiernet.net. [50.53.82.155])
        by smtp.gmail.com with ESMTPSA id e20sm7808466pfd.4.2016.02.10.16.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2016 16:58:33 -0800 (PST)
Date:   Wed, 10 Feb 2016 16:58:46 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     David Decotigny <ddecotig@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Decotigny <decot@googlers.com>
Subject: Re: [PATCH net-next v7 15/19] net: bridge: use
 __ethtool_get_ksettings
Message-ID: <20160210165846.0e7ae670@xeon-e3>
In-Reply-To: <1454893743-6285-16-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
        <1454893743-6285-16-git-send-email-ddecotig@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <stephen@networkplumber.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stephen@networkplumber.org
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

On Sun,  7 Feb 2016 17:08:59 -0800
David Decotigny <ddecotig@gmail.com> wrote:

> From: David Decotigny <decot@googlers.com>
> 
> Signed-off-by: David Decotigny <decot@googlers.com>
> ---
>  net/bridge/br_if.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index c367b3e..cafe4e6 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -36,10 +36,10 @@
>   */
>  static int port_cost(struct net_device *dev)
>  {
> -	struct ethtool_cmd ecmd;
> +	struct ethtool_ksettings ecmd;
>  
> -	if (!__ethtool_get_settings(dev, &ecmd)) {
> -		switch (ethtool_cmd_speed(&ecmd)) {
> +	if (!__ethtool_get_ksettings(dev, &ecmd)) {
> +		switch (ecmd.parent.speed) {
>  		case SPEED_10000:
>  			return 2;
>  		case SPEED_1000:

Sure looks fine for bridge.
This reminds me that bridge code needs to transition to this decade
and do latest STP.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
