Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 04:14:06 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:58121 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006154AbbLBDOErpv7f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 04:14:04 +0100
Received: from localhost (cpe-72-227-129-226.nyc.res.rr.com [72.227.129.226])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 641DD59DAA1;
        Tue,  1 Dec 2015 19:13:58 -0800 (PST)
Date:   Tue, 01 Dec 2015 22:13:56 -0500 (EST)
Message-Id: <20151201.221356.2176806670215219133.davem@davemloft.net>
To:     ddecotig@gmail.com
Cc:     ben@decadent.org.uk, amirv@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org, edumazet@google.com,
        eugenia@mellanox.co.il, ogerlitz@mellanox.com, idos@mellanox.com,
        joe@perches.com, saeedm@mellanox.com, _govind@gmx.com,
        VenkatKumar.Duvvuru@Emulex.Com, jeffrey.t.kirsher@intel.com,
        eyalpe@mellanox.com, pshelar@nicira.com,
        eswierk@skyportsystems.com, robert.w.love@intel.com,
        JBottomley@parallels.com, Yuval.Mintz@qlogic.com,
        decot@googlers.com
Subject: Re: [PATCH net-next v3 03/17] net: ethtool: add new
 ETHTOOL_GSETTINGS/SSETTINGS API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1448921155-24764-4-git-send-email-ddecotig@gmail.com>
References: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
        <1448921155-24764-4-git-send-email-ddecotig@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 01 Dec 2015 19:14:00 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50268
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
Date: Mon, 30 Nov 2015 14:05:41 -0800

> This patch defines a new ETHTOOL_GSETTINGS/SSETTINGS API, handled by
> the new get_ksettings/set_ksettings callbacks. This API provides
> support for most legacy ethtool_cmd fields, adds support for larger
> link mode masks (up to 4064 bits, variable length), and removes
> ethtool_cmd deprecated fields (transceiver/maxrxpkt/maxtxpkt).

Please do not define the mask using a non-fixed type.  I know it makes
it easier to use the various bitmap helper routines if you use 'long',
but here it is clearly superior to use "u32" for the bitmap type and
do the bit operations by hand if necessary.

Otherwise you have to have all of this ulong size CPP conditional code
which is incredibly ugly.

Furthermore you have to use fixed sized types anyways so that we don't
need compat code to deal with 32-bit userspace applications making
these ethtool calls into a 64-bit kernel.

THanks.
