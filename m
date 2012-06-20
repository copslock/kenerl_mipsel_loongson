Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 21:37:20 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:53149 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903632Ab2FTTgr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2012 21:36:47 +0200
Received: by lbbgg6 with SMTP id gg6so1070568lbb.36
        for <linux-mips@linux-mips.org>; Wed, 20 Jun 2012 12:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=z3ffZbe1Rj8Pj52+1pkbMqaLOdTiKE3TOvvpm/AcB1I=;
        b=T3+L0cdshYaW4HxXZ13FuIoqrRHbnl2VRLsTqyK8YEjp5Tggi96gPss/JOumPzNS8T
         6Oe0AzzrMtxGelsrwzzqN5nPzYP+DMaWVu4Pm6ZhCrLFxVDP0GlxVIRq4tMj6+jkxc95
         I29ibP2T8/zWdscOjjiDkjbaTFsrppR1M+r30GuRqvyF3VVGlikb+hTwyjbA9vjVWkV9
         UyHdj1hsjxoP1c1k/brm3/XknURLZF65gWSFabNBn70lKJcEmIZpBjtRLk+Plq36QkuG
         NLRja+bkYOJY7gsfLkzeNQ/A/mRNE64hEiaT5Lx2DNspd+67yXfV5ByVwekhG60Zu+MC
         UGQw==
Received: by 10.112.86.105 with SMTP id o9mr10509395lbz.32.1340221000497;
        Wed, 20 Jun 2012 12:36:40 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id n7sm16828069lbk.10.2012.06.20.12.36.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 12:36:38 -0700 (PDT)
Message-ID: <4FE225F3.4080806@mvista.com>
Date:   Wed, 20 Jun 2012 23:35:15 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Kelvin Cheung <keguang.zhang@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, wuzhangjin@gmail.com,
        zhzhl555@gmail.com
Subject: Re: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
References: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com> <1339757617-2187-3-git-send-email-keguang.zhang@gmail.com> <20120620192551.GC29446@linux-mips.org>
In-Reply-To: <20120620192551.GC29446@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQk5q/NqjRn44B1U+V0g1idP+RoOgXG2aOXUMd1WgmZ2S6NsXI9e+5iJsInNi44x+AMHaZ19
X-archive-position: 33748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 06/20/2012 11:25 PM, Ralf Baechle wrote:

>> +#include <linux/clk.h>

>> +static LIST_HEAD(clocks);
>> +static DEFINE_MUTEX(clocks_mutex);
>> +
>> +struct clk *clk_get(struct device *dev, const char *name)
>> +{
>> +	struct clk *c;
>> +	struct clk *ret = NULL;
>> +
>> +	mutex_lock(&clocks_mutex);
>> +	list_for_each_entry(c, &clocks, node) {
>> +		if (!strcmp(c->name, name)) {
>> +			ret = c;
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&clocks_mutex);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(clk_get);

> This redefines a function that already is declared in <linux/clk.h> and
> defined in drivers/clk/clkdev.c.  Why?

    Because he doesn't support clkdev? clkdev support is optional.

>> +int clk_register(struct clk *clk)
>> +{
>> +	mutex_lock(&clocks_mutex);
>> +	list_add(&clk->node, &clocks);
>> +	if (clk->ops->init)
>> +		clk->ops->init(clk);
>> +	mutex_unlock(&clocks_mutex);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(clk_register);

> Same here.

>    Ralf

WBR, Sergei
