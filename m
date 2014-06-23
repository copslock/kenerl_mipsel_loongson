Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 21:49:27 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:42673 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817546AbaFWTtZqoCuT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 21:49:25 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AB0E7582086;
        Mon, 23 Jun 2014 12:49:22 -0700 (PDT)
Date:   Mon, 23 Jun 2014 12:49:19 -0700 (PDT)
Message-Id: <20140623.124919.2215480222213445820.davem@davemloft.net>
To:     markos.chandras@imgtec.com
Cc:     linux-mips@linux-mips.org, dborkman@redhat.com, ast@plumgrid.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH 00/17] Misc MIPS/BPF fixes for 3.16
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.7 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Jun 2014 12:49:22 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40679
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

From: Markos Chandras <markos.chandras@imgtec.com>
Date: Mon, 23 Jun 2014 10:38:43 +0100

> Here are some fixes for MIPS/BPF for 3.16. These fixes make
> the bpf testsuite *almost* happy with only 2 tests (LD_IND_LL,
> LD_IND_NET) failing at the moment. Since fixing the remaining tests
> is not so trivial, it would be nice to have these fixes in 3.16 for now.
> 
> The patches are based on the upstream-sfr/mips-for-linux-next tree
> because they depend on https://patchwork.linux-mips.org/patch/7099/

You did not CC: netdev on patches 1, 2, and 3.  Please do not do this,
people on this list will want to review the series as a whole.
