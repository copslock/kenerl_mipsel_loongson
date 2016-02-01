Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 00:34:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41984 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010131AbcBAXef0lbti (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2016 00:34:35 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u11NYY7M028754;
        Tue, 2 Feb 2016 00:34:34 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u11NYYMQ028753;
        Tue, 2 Feb 2016 00:34:34 +0100
Date:   Tue, 2 Feb 2016 00:34:34 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alban <albeu@free.fr>
Cc:     Antony Pavlov <antonynpavlov@gmail.com>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [RFC v3 02/14] MIPS: ath79: use clk-ath79.c driver for
 AR913X/AR933X
Message-ID: <20160201233433.GA28652@linux-mips.org>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
 <1453580251-2341-3-git-send-email-antonynpavlov@gmail.com>
 <20160125232428.6472f4e6@tock>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160125232428.6472f4e6@tock>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51605
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

On Mon, Jan 25, 2016 at 11:24:28PM +0100, Alban wrote:

> > +	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
> > +		return;
> > +	}
> > +
> 
> I think it would make more sense to move the whole implementation to
> drivers/clk, otherwise we'll need to maintain two implementations.

As a general rule, if there's a driver subsystem for something, I want
code  to go there, not arch/mips.

  Ralf
