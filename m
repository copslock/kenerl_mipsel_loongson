Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 23:00:00 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:35827 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010215AbaI3U75fkaGn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 22:59:57 +0200
Received: from localhost (nat-pool-rdu-t.redhat.com [66.187.233.202])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C4EE7587CE3;
        Tue, 30 Sep 2014 13:59:52 -0700 (PDT)
Date:   Tue, 30 Sep 2014 16:59:51 -0400 (EDT)
Message-Id: <20140930.165951.1877491408006986300.davem@davemloft.net>
To:     linux@roeck-us.net
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH] next: mips: bpf: Fix build failure
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1412095140-10953-1-git-send-email-linux@roeck-us.net>
References: <1412095140-10953-1-git-send-email-linux@roeck-us.net>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.7 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Sep 2014 13:59:53 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42923
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

From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 30 Sep 2014 09:39:00 -0700

> Fix:
> 
> arch/mips/net/bpf_jit.c: In function 'build_body':
> arch/mips/net/bpf_jit.c:762:6: error: unused variable 'tmp'
> cc1: all warnings being treated as errors
> make[2]: *** [arch/mips/net/bpf_jit.o] Error 1
> 
> Seen when building mips:allmodconfig in -next since next-20140924.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thank you.
