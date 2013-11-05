Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2013 01:45:28 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:35707 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819547Ab3KEApZdsTYi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Nov 2013 01:45:25 +0100
Received: from localhost (cpe-74-68-127-86.nyc.res.rr.com [74.68.127.86])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 122E4584100;
        Mon,  4 Nov 2013 16:45:21 -0800 (PST)
Date:   Mon, 04 Nov 2013 19:45:19 -0500 (EST)
Message-Id: <20131104.194519.1657797548878784116.davem@davemloft.net>
To:     aurelien@aurel32.net
Cc:     linux-mips@linux-mips.org, libc-alpha@sourceware.org
Subject: Re: prlimit64: inconsistencies between kernel and userland
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20131104213756.GD18700@hall.aurel32.net>
References: <20130628133835.GA21839@hall.aurel32.net>
        <20131104213756.GD18700@hall.aurel32.net>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.1 (shards.monkeyblade.net [0.0.0.0]); Mon, 04 Nov 2013 16:45:22 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38450
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

From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 4 Nov 2013 22:37:56 +0100

> Any news about this issue? It really starts to causes a lot of issues in
> Debian. I have added a Cc: to libc people so that we can also hear their
> opinion.

I had the same exact problem on sparc several years ago, I simply fixed
the glibc header value, it's the only way to fix this.

Yes, that means you then have to recompile applications and libraries
that reference this value.
