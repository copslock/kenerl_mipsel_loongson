Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2015 23:18:11 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:47447 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011610AbbDOVSJw0Lcp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Apr 2015 23:18:09 +0200
Received: from localhost (cpe-66-108-87-106.nyc.res.rr.com [66.108.87.106])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E29BD5868B3;
        Wed, 15 Apr 2015 14:18:07 -0700 (PDT)
Date:   Wed, 15 Apr 2015 17:18:05 -0400 (EDT)
Message-Id: <20150415.171805.1957066097252829921.davem@davemloft.net>
To:     zajec5@gmail.com
Cc:     linux@roeck-us.net, ralf@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [RFC PATCH] bgmac: Fix build error seen if BCM47XX is not
 configured
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CACna6rwPYP0FV60v9ey0uV=3eU_8SZ4t+WoZCtiDHHeCLiM3Dg@mail.gmail.com>
References: <1429128338-28549-1-git-send-email-linux@roeck-us.net>
        <CACna6rwPYP0FV60v9ey0uV=3eU_8SZ4t+WoZCtiDHHeCLiM3Dg@mail.gmail.com>
X-Mailer: Mew version 6.6 on Emacs 24.4 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 15 Apr 2015 14:18:08 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46870
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

From: Rafa©© Mi©©ecki <zajec5@gmail.com>
Date: Wed, 15 Apr 2015 22:21:49 +0200

> I guess the decisions depends on
> a) time needed for David to revert fc300dc & send pull request
> vs.
> b) time needed for Ralf to send pull request

Let's just wait for Ralf's stuff to hit Linus's tree.
