Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 23:39:00 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:54094 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011895AbcA1Wi5gx37- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 23:38:57 +0100
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F23BE5AC34B;
        Thu, 28 Jan 2016 14:38:52 -0800 (PST)
Date:   Thu, 28 Jan 2016 14:38:49 -0800 (PST)
Message-Id: <20160128.143849.1063439968744271789.davem@davemloft.net>
To:     eugenia.emantayev@gmail.com
Cc:     ddecotig@gmail.com, ben@decadent.org.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org, akpm@linux-foundation.org, tj@kernel.org,
        edumazet@google.com, eugenia@mellanox.co.il, ogerlitz@mellanox.com,
        idos@mellanox.com, joe@perches.com, saeedm@mellanox.com,
        _govind@gmx.com, VenkatKumar.Duvvuru@emulex.com,
        jeffrey.t.kirsher@intel.com, pshelar@nicira.com,
        eswierk@skyportsystems.com, robert.w.love@intel.com,
        JBottomley@parallels.com, Yuval.Mintz@qlogic.com,
        linux@rasmusvillemoes.dk, decot@googlers.com
Subject: Re: [PATCH net-next v6 19/19] net: mlx4: use new
 ETHTOOL_G/SSETTINGS API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CABqvoseo5UPNuNDjmP1PDhco7KGja2QzEVd5Aio+GD+UbaV0+g@mail.gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
        <1453250644-14796-20-git-send-email-ddecotig@gmail.com>
        <CABqvoseo5UPNuNDjmP1PDhco7KGja2QzEVd5Aio+GD+UbaV0+g@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Jan 2016 14:38:53 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51515
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

From: Eugenia Emantayev <eugenia.emantayev@gmail.com>
Date: Thu, 28 Jan 2016 10:21:53 +0200

> Acked-by: Eugenia Emantayev <eugenia@mellanox.com>

Please don't quote an entire HUGE patch just to give your ACK.

Only quote, at most, the commit message itself.

I know it's easy to be lazy, and I also realize that most email
clients are terrible and make quick editing of quoted material a pain
in the ass, but that's not an excuse to bomb the whole list
unnecessarily like this.  You're causing problems for everyone who
reads this list.

Thanks in advance for your cooperation.
