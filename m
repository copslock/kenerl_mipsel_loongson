Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Dec 2015 17:38:22 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:59102 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008014AbbLPQiVSwkK- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Dec 2015 17:38:21 +0100
Received: from localhost (cpe-72-227-129-226.nyc.res.rr.com [72.227.129.226])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C0835A3CE1;
        Wed, 16 Dec 2015 08:38:16 -0800 (PST)
Date:   Wed, 16 Dec 2015 11:38:14 -0500 (EST)
Message-Id: <20151216.113814.2025166082777387327.davem@davemloft.net>
To:     ddecotig@gmail.com
Cc:     ben@decadent.org.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org,
        akpm@linux-foundation.org, tj@kernel.org, edumazet@google.com,
        eugenia@mellanox.co.il, ogerlitz@mellanox.com, idos@mellanox.com,
        joe@perches.com, saeedm@mellanox.com, _govind@gmx.com,
        VenkatKumar.Duvvuru@Emulex.Com, jeffrey.t.kirsher@intel.com,
        pshelar@nicira.com, eswierk@skyportsystems.com,
        robert.w.love@intel.com, JBottomley@parallels.com,
        Yuval.Mintz@qlogic.com, linux@rasmusvillemoes.dk,
        decot@googlers.com
Subject: Re: [PATCH net-next v5 05/19] net: ethtool: add new
 ETHTOOL_GSETTINGS/SSETTINGS API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1450127046-4573-6-git-send-email-ddecotig@gmail.com>
References: <1450127046-4573-1-git-send-email-ddecotig@gmail.com>
        <1450127046-4573-6-git-send-email-ddecotig@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 Dec 2015 08:38:18 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50641
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

From: David Decotigny <ddecotig@gmail.com>
Date: Mon, 14 Dec 2015 13:03:52 -0800

> +static int ethtool_get_ksettings(struct net_device *dev, void __user *useraddr)
> +{
 ...
> +	if (__ETHTOOL_LINK_MODE_MASK_NU32
> +	    != ksettings.parent.link_mode_masks_nwords) {
> +		/* wrong link mode nbits requested */
> +		memset(&ksettings, 0, sizeof(ksettings));
> +		/* keep cmd field reset to 0 */
> +		/* send back number of words required as negative val */
> +		compiletime_assert(__ETHTOOL_LINK_MODE_MASK_NU32 <= S8_MAX,
> +				   "need too many bits for link modes!");
> +		ksettings.parent.link_mode_masks_nwords
> +			= -((s8)__ETHTOOL_LINK_MODE_MASK_NU32);

I'm trying to understand how this can work.

Supposedly, the link_mode_masks_nwords field is there so that we can
add new link modes yet still work with tools built against any
particular link mode list in the UAPI header files.

But here you're forcing the value of link_mode_masks_nwords and then
copying that amount back to userspace.  If the user allocated less
space than the the link mode list in the kernel supports, we will
overwrite past the end of the user's usettings object.

You cannot unconditionally copy sizeof(usettings) back to the user,
as store_ksettings_for_user() will do.

I think you have to truncate here, copying only the array elements the
user's structure actually has space for.  That's the only way this can
work.
