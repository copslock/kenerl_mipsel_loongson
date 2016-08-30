Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 17:06:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29953 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992009AbcH3PG31xUkJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 17:06:29 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 51E3B129BC7DB;
        Tue, 30 Aug 2016 16:06:10 +0100 (IST)
Received: from [127.0.0.1] (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 16:06:12 +0100
Subject: Re: [PATCH 25/26] clk: boston: Add a driver for MIPS Boston board
 clocks
To:     Stephen Boyd <sboyd@codeaurora.org>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
 <20160826153725.11629-26-paul.burton@imgtec.com>
 <20160826174144.GW19826@codeaurora.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <251ea47c-322c-12d0-4542-8159e878e9d8@imgtec.com>
Date:   Tue, 30 Aug 2016 16:06:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160826174144.GW19826@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On 26/08/16 18:41, Stephen Boyd wrote:
>> +	if (err)
>> +		pr_err("failed to add DT provider: %d\n", err);
>> +}
>> +CLK_OF_DECLARE(clk_boston, "img,boston-clock", clk_boston_setup);
> 
> Please make this into a platform driver.

Hi Stephen,

The problem with this would be that we need to obtain the CPU clock rate
fairly early during boot in order to set up the clocksource & delay loop
etc. Using CLK_OF_DECLARE allows for that but if this were a platform
driver my understanding is that the clocks wouldn't become available
until some point later in boot. If I'm wrong & there's a way to avoid
that please let me know.

Also: why? If CLK_OF_DECLARE isn't liked, shouldn't that be documented
somewhere (ideally next to the declaration of CLK_OF_DECLARE in
include/linux/clk-provider.h)?

Thanks,
    Paul
