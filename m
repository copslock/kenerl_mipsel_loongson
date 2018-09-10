Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 11:45:14 +0200 (CEST)
Received: from mail-lj1-x243.google.com ([IPv6:2a00:1450:4864:20::243]:37430
        "EHLO mail-lj1-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992279AbeIJJpLNnLzf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2018 11:45:11 +0200
Received: by mail-lj1-x243.google.com with SMTP id v9-v6so17332892ljk.4;
        Mon, 10 Sep 2018 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wa8dwKIZZXT39GhJu2oZlG5y/j2pwoOUpKuZN+ukFXQ=;
        b=CtiX8ezVk4BVK142DIScWfCQt18B5on3P6c3mrpgqH30spgQP4L4g28FnwJzd6newi
         f9PIbEsnGjpU5FNN2iW/bfvZ8Kub5h0bF+WcrrMrQU17/fxENg+y/e6/IwrNZ8YjbTcH
         gCS4fxl3WrMcSbePKqFIu+UVhgJyGlLlPqs9SoqlGpkltHUO8F3BIceXigjB3B5bMcUz
         LB3g6geFyPCNT/q7V77Xp/G1TwuD6jSr7xYo6Sv/UnOTz/6Lv65WWc4T70wEI2DGuiZh
         uTQ/rm4gyrMKj4ycC9Jx+Ux2Q1cCLHZ3sKnc6moa/Y1xmuJyTNxiZb8ihT/3TdRJpkgW
         avHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wa8dwKIZZXT39GhJu2oZlG5y/j2pwoOUpKuZN+ukFXQ=;
        b=eJBzJe/beLD+m6EZvumiHGd7yG/9p37xMeSfStyKcyulNPan4HEzPWD72LMPQCzNiJ
         Aipre3E7903iA7xjnZQJM7l9K1v2C0yLwBha26apdx8+eHY+fej/OE3Ft1qQV9A1hY+V
         xUNdt87Sgzp65XvHpmPqWpJbmrM+dzpAjlY/v48rgReQC36ENf1eNukB/us3Gx4IhCYo
         aJw7MSAtrWvuUvRZH9uzSxbhDCk3wGEM5uOIWaiZUp/tGZjDJq9kNYrAf23tMicFwFTd
         Ck+XgHZiYSEOXFN00d3zGkRhGyqFcoINfY9xAWawX/ItK0+Va4LJU9rTxUtrN5yztsye
         W40g==
X-Gm-Message-State: APzg51BI37mf7lNcK2sn+FeR5p13Cxe+xXprcPabmLcr8WdioWd52aLH
        T1GF8mhpmIVQfsK6nU6xIVE=
X-Google-Smtp-Source: ANB0VdbSfTMZrvphSUKxVMdjBxpeQ3Dq/+q/QuZzwTxMXcEg0DHsR1drUb9FgUx8SqKrrmAXTFl0oA==
X-Received: by 2002:a2e:4242:: with SMTP id p63-v6mr11696507lja.83.1536572705412;
        Mon, 10 Sep 2018 02:45:05 -0700 (PDT)
Received: from ?IPv6:2001:14bb:43:46b3:d135:7d7c:caf7:1c82? (dkqdnjzl1s10p1948tk-4.rev.dnainternet.fi. [2001:14bb:43:46b3:d135:7d7c:caf7:1c82])
        by smtp.gmail.com with ESMTPSA id q85-v6sm2635503lfg.20.2018.09.10.02.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 02:45:04 -0700 (PDT)
Subject: Re: [PATCH] mips: bug: add unlikely() to BUG_ON()
To:     Paul Burton <paul.burton@mips.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <20180907180302.656-1-igor.stoppa@huawei.com>
 <20180907220208.nqucxycxsxmyxt4m@pburton-laptop>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <d702acea-0aac-abc3-c48e-21f0e44d5870@gmail.com>
Date:   Mon, 10 Sep 2018 12:45:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907220208.nqucxycxsxmyxt4m@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <igor.stoppa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: igor.stoppa@gmail.com
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

Hi Paul,

On 08/09/18 01:02, Paul Burton wrote:

> I'm not sure this will actually do anything.
> 
> __BUG_ON() doesn't use the value of its condition argument for regular
> control flow unless it's compile-time constant anyway, in which case
> unlikely() should be redundant because the compiler knows the value
> already.
> 
> If the condition isn't compile-time constant then we just emit a tne
> (trap-if-not-equal) instruction using inline asm. That will generate an
> exception if the value is non-zero at runtime. I don't see how adding
> unlikely() is going to help the compiler do anything differently with
> that.

Thank you for the explanation. Please discard this patch.

--
igor
