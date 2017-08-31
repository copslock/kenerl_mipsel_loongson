Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2017 02:36:55 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:37686
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994821AbdHaAgtCAhbj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Aug 2017 02:36:49 +0200
Received: by mail-wm0-x243.google.com with SMTP id x189so3358889wmg.4
        for <linux-mips@linux-mips.org>; Wed, 30 Aug 2017 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sb41c4C6+Of/KW4LbBG4MP50SGzwLCz7ypGzgGjxYi0=;
        b=ilt4YwQsu1k6khQCNHTqnxW1HcJ40FYM06MtWOJ+5smpYSrQzCYgge2BvnJqOSXYm+
         p+P51l2OlJpK+cTObsmiP5+2oIgoDGMRTb0T6UhvZrPC+0OXg9y/Q56Ybog8G6JSB6wr
         NAT6ZHzGqPYRz1iM4rRbR3KsSNAEugXT8wXY+//e6FXbWwN//6+7I1oHcISIE3pS1DjS
         mjWRLhr+BDykMz6ZoOz/5Q62WDzzLL/Wm/ha1RHMQozQK0narV4krQqFN4dO5goFmHld
         BnEHUcZ9kMnjo63dlmqIitnws48szvQI+x6q+GZFEr0+4mI/PVp9rqkf71lGJUi3Z3rr
         TDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sb41c4C6+Of/KW4LbBG4MP50SGzwLCz7ypGzgGjxYi0=;
        b=svwaslvHJEJhedY1fxRezWqjy84KbkTuI3a/1BhEfE+r1yGSS+jndI0Sa8an0YxSl2
         hSWVVqa/rAmtfxZ/Xk8aHzUiUbA/0kQN0GDCQlB2F1mb1Cu6zh4ekY4QB/CSQtYdh2v1
         JkdbY1hMKejDdLrx7ZKzQokQiDgh1F9JMp3JI/UNOFWie+RVe8gfuF1rBPW2Wqhk87GA
         00KF9OavCgwKZmpqjApHRzrIhh5LpcXek1XwrryVyv4GcuvWBmG8FA18Otc7Fe3OEiKf
         Z1h66rOaxTCjPCxSgE4+eiptcI+sz9RPHto/b74MMXgW7k7kJk1GqiWepM7zrddi8e/u
         thIA==
X-Gm-Message-State: AHYfb5j63w6nzcGE+OfEB8vSJO9mLSkHzGylTFuDP767qIdy1ePZWE4r
        r6Cf1Cc/nmEVMbFqAB4=
X-Received: by 10.28.60.215 with SMTP id j206mr2705358wma.73.1504139803545;
        Wed, 30 Aug 2017 17:36:43 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id n50sm11861632wrb.37.2017.08.30.17.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Aug 2017 17:36:42 -0700 (PDT)
Subject: Re: [PATCH] irqchip: irq-bcm7120-l2: Use correct I/O accessors for
 irq_fwd_mask
To:     Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org
Cc:     opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:BROADCOM BMIPS MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>
References: <1504032187-53035-1-git-send-email-f.fainelli@gmail.com>
 <2c52e192-9cb2-0e53-ddc2-23e25d1ae5bc@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6344fffc-4125-a3b9-ce96-741f4d8becfb@gmail.com>
Date:   Wed, 30 Aug 2017 17:36:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2c52e192-9cb2-0e53-ddc2-23e25d1ae5bc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 08/30/2017 03:48 AM, Marc Zyngier wrote:
> On 29/08/17 19:43, Florian Fainelli wrote:
>> Initialization of irq_fwd_mask was done using __raw_readl() which
>> happens to work for all cases except when using ARM BE8 which requires
>> readl() (with the proper swapping). Move the initialization of the
> 
> s/readl/writel/, I presume?

Correct, just submitted a v2 with that fixed, thanks.
-- 
Florian
