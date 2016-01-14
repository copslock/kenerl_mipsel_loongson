Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 22:46:13 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:44924 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010453AbcANVqGKENW7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 22:46:06 +0100
Received: from localhost (unknown [38.140.131.194])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 000BF5A72D9;
        Thu, 14 Jan 2016 13:46:01 -0800 (PST)
Date:   Thu, 14 Jan 2016 16:46:00 -0500 (EST)
Message-Id: <20160114.164600.1186126324030429206.davem@davemloft.net>
To:     kvalo@codeaurora.org
Cc:     arnd@arndb.de, zajec5@gmail.com, hauke@hauke-m.de, m@bues.ch,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ssb: host_soc depends on sprom
From:   David Miller <davem@davemloft.net>
In-Reply-To: <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
References: <8128014.DbbgBtKY3z@wuerfel>
        <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
X-Mailer: Mew version 6.6 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Jan 2016 13:46:02 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51138
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

From: Kalle Valo <kvalo@codeaurora.org>
Date: Thu, 14 Jan 2016 08:46:29 +0200

> I can take it. For historical reasons ssb patches go through my
> wireless-drivers trees.

+1
