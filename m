Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 18:32:05 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:39799 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007502AbbLBRcEIg6xG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 18:32:04 +0100
Received: from localhost (unknown [38.140.131.194])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1B2CA59F037;
        Wed,  2 Dec 2015 09:32:00 -0800 (PST)
Date:   Wed, 02 Dec 2015 12:31:59 -0500 (EST)
Message-Id: <20151202.123159.1617446027222393431.davem@davemloft.net>
To:     ddecotig@gmail.com
Cc:     ben@decadent.org.uk, amirv@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org, edumazet@google.com,
        eugenia@mellanox.co.il, ogerlitz@mellanox.com, idos@mellanox.com,
        joe@perches.com, saeedm@mellanox.com, _govind@gmx.com,
        VenkatKumar.Duvvuru@emulex.com, jeffrey.t.kirsher@intel.com,
        eyalpe@mellanox.com, pshelar@nicira.com,
        eswierk@skyportsystems.com, robert.w.love@intel.com,
        JBottomley@parallels.com, Yuval.Mintz@qlogic.com
Subject: Re: [PATCH net-next v3 03/17] net: ethtool: add new
 ETHTOOL_GSETTINGS/SSETTINGS API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAG88wWbW=yxO0mzauJauEd3W-SuPq3eNGRE+Xe6ATcLKhrPq3A@mail.gmail.com>
References: <1448921155-24764-4-git-send-email-ddecotig@gmail.com>
        <20151201.221356.2176806670215219133.davem@davemloft.net>
        <CAG88wWbW=yxO0mzauJauEd3W-SuPq3eNGRE+Xe6ATcLKhrPq3A@mail.gmail.com>
X-Mailer: Mew version 6.6 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 02 Dec 2015 09:32:01 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50293
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
Date: Tue, 1 Dec 2015 22:00:58 -0800

> There is a set of conversion routines ulong[]<->u32[] to address this
> 32/64-bit compat issue.

And it's extremely ugly.

There is nothing stopping you from adding bitmap_set32() et al. helpers
to facilitate things.
