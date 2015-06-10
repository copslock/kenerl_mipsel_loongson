Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 10:47:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42022 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008003AbbFJIrhg48eD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jun 2015 10:47:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t5A8lXYl031138;
        Wed, 10 Jun 2015 10:47:33 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t5A8lQGe031137;
        Wed, 10 Jun 2015 10:47:26 +0200
Date:   Wed, 10 Jun 2015 10:47:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 3/4] mips: make loongsoon serial driver explicitly modular
Message-ID: <20150610084726.GE2753@linux-mips.org>
References: <1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com>
 <1433276168-21550-4-git-send-email-paul.gortmaker@windriver.com>
 <20150609073533.GB2753@linux-mips.org>
 <20150609231528.GQ7125@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150609231528.GQ7125@windriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jun 09, 2015 at 07:15:28PM -0400, Paul Gortmaker wrote:

> I've dropped my change in favour of this one, and crafted up a commit
> log from this e-mail exchange as follows:
> 
> https://git.kernel.org/cgit/linux/kernel/git/paulg/linux.git/commit/?h=init-v4.1-rc6&id=5eee56adcce9b0baf2da55c0bff88eb0f1c0eb61
> 
> Assuming nobody else has an issue with it, then we should be done here
> (i.e. it doesn't even need to be in mips-next; it just needs to be here
> in this series so we don't get bisect fails introduced.)

I've committed this as d9fb5660459819513d510e72caa3120a7cf41ee1 (MIPS:
Loongson: Do not register 8250 platform device from module.) on my
4.1-fixes branch and intend to send it out on Friday to Linus.

Still nothing heared about the uart_base.o situation.

  Ralf
