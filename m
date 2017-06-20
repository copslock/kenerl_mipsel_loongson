Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 22:44:55 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:47306 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992143AbdFTUorjVs7k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 22:44:47 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B9FAA607CE; Tue, 20 Jun 2017 20:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497991485;
        bh=Qz/ubYupPGVhA+bo8YTRDkGlZ1kWtN5esDzvOixpaCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXKITXpq2a4P0cvmM5zAH+EGQ0mHrIrD9VJ+dgg6oMS6elK+kfeSv56tSlfKhXU7T
         dU91GNn/sQpFJffhzwmjWl/yVBh18yYogrCb7tFWAutJA5AD43YhTVqXExqFxHzEJL
         0lOibt+vXxLBzRQyy7M9Omk2sti82aSTZR/tlmsE=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E757F60288;
        Tue, 20 Jun 2017 20:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497991485;
        bh=Qz/ubYupPGVhA+bo8YTRDkGlZ1kWtN5esDzvOixpaCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXKITXpq2a4P0cvmM5zAH+EGQ0mHrIrD9VJ+dgg6oMS6elK+kfeSv56tSlfKhXU7T
         dU91GNn/sQpFJffhzwmjWl/yVBh18yYogrCb7tFWAutJA5AD43YhTVqXExqFxHzEJL
         0lOibt+vXxLBzRQyy7M9Omk2sti82aSTZR/tlmsE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E757F60288
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Tue, 20 Jun 2017 13:44:44 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     zhoubb <zhoubb@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?utf-8?B?6LCi6Ie06YKm?= <Yeking@red54.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        HuaCai Chen <chenhc@lemote.com>
Subject: Re: [PATCH v7 7/8] clk: Loongson: Add Loongson-1A clock support
Message-ID: <20170620204444.GT4493@codeaurora.org>
References: <1497581573-17258-1-git-send-email-zhoubb@lemote.com>
 <1497581573-17258-8-git-send-email-zhoubb@lemote.com>
 <20170619233434.GQ20170@codeaurora.org>
 <CAMpQs4L1_VvWxk_mkbRgvVb3o23m+RdVosgzxFLMRX7fjKa+6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4L1_VvWxk_mkbRgvVb3o23m+RdVosgzxFLMRX7fjKa+6w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

On 06/20, zhoubb wrote:
> On Tue, Jun 20, 2017 at 7:34 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 06/16, Binbin Zhou wrote:
> >> +
> >> +static DEFINE_SPINLOCK(_lock);
> >
> > I know the other loongson1*.c files also call it "_lock", but
> > that's not a very good name for something that may show up in
> > lockdep debugging error messages. How about something a bit more
> > descriptive, loongson1x_clk_lock?
> >
> It's a good idea！
> Actually, the variable is not be used in this file.
> If I rename it in another new patch will be better.
> Do you think so ?

Ok sure.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
