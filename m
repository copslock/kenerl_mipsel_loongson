Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Aug 2013 17:16:59 +0200 (CEST)
Received: from mail-ee0-f48.google.com ([74.125.83.48]:51503 "EHLO
        mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816122Ab3HXPQxBHO60 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Aug 2013 17:16:53 +0200
Received: by mail-ee0-f48.google.com with SMTP id l10so796142eei.35
        for <multiple recipients>; Sat, 24 Aug 2013 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UuesBkZzEU06Zxj3DMw8/HlSIdomIOu+9dEMZzj/e2Q=;
        b=MYGIKT7SThfK0MbXToiR+3+ixQkhAgQjv0mzDDSnGRj/vsMSpltHsmuz4796yTw0ID
         vm1iW2LSZHY1F1l68uyD2r7+DgCcGIx6Q2rZfbFhOxpdb0FfU7tikolr33yjnhEU3dy3
         ATWCKcD/2oLJMaomZVC4tbaBPdhjoCP0vK0s2CneY6207k5lBqBBHJ7u7214FaSTNjwD
         3b4r+3RsFiyXW/ssjY0guF2eZFvcFUzl6C7uUHakaf9v+EG2yhXhaaiUtE2t5n6evD7z
         TIT0KqLl0kCAFmKjO4p1QZUMvI9mL8L9N8wHb3WUCrnAAaQpStGqE3AFmwxVYo5+c/or
         os6Q==
X-Received: by 10.14.184.3 with SMTP id r3mr5549735eem.49.1377357407607;
        Sat, 24 Aug 2013 08:16:47 -0700 (PDT)
Received: from [192.168.1.110] (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id r48sm7409855eev.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 08:16:46 -0700 (PDT)
Message-ID: <5218CE5B.1020906@gmail.com>
Date:   Sat, 24 Aug 2013 17:16:43 +0200
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, mturquette@linaro.org,
        jiada_wang@mentor.com, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, shawn.guo@linaro.org,
        sebastian.hesselbarth@gmail.com, LW@KARO-electronics.de,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v3 3/5] clk: Add common __clk_get(), __clk_put() implementations
References: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com> <1377270227-1030-4-git-send-email-s.nawrocki@samsung.com> <20130823231314.GR6617@n2100.arm.linux.org.uk>
In-Reply-To: <20130823231314.GR6617@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sylvester.nawrocki@gmail.com
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

On 08/24/2013 01:13 AM, Russell King - ARM Linux wrote:
> On Fri, Aug 23, 2013 at 05:03:45PM +0200, Sylwester Nawrocki wrote:
>> >  This patch adds common __clk_get(), __clk_put() clkdev helpers which
>> >  replace their platform specific counterparts when the common clock
>> >  API is enabled.
>> >
>> >  The owner module pointer field is added to struct clk so a reference
>> >  to the clock supplier module can be taken by the clock consumers.
>> >
>> >  Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> >  Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>
> I'm mostly happy with this now.
>
>> >  +int __clk_get(struct clk *clk)
>> >  +{
>> >  +	if (clk&&  !try_module_get(clk->owner))
>> >  +		return 0;
>> >  +
>> >  +	return 1;
>> >  +}
>> >  +EXPORT_SYMBOL(__clk_get);
>> >  +
>> >  +void __clk_put(struct clk *clk)
>> >  +{
>> >  +	if (WARN_ON_ONCE(IS_ERR(clk)))
>> >  +		return;
>> >  +
>> >  +	if (clk)
>> >  +		module_put(clk->owner);
>> >  +}
>> >  +EXPORT_SYMBOL(__clk_put);
>
> Why are these exported?  clkdev can only be built into the kernel, as can
> the common clk framework - they can't be modular.  So why would a module
> wish to access these directly?

I must have been mislead by the fact that some ARM sub-architecture exports
those, have added them initially and then didn't think enough about it and
left these in. Actually, at some point I noticed the exporting is not 
needed,
but never did get around to remove it. Thanks. The updated series to 
follow.
