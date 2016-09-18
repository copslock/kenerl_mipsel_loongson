Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Sep 2016 21:38:00 +0200 (CEST)
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35019 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbcIRThxBe39f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Sep 2016 21:37:53 +0200
Received: by mail-oi0-f50.google.com with SMTP id w11so170402206oia.2;
        Sun, 18 Sep 2016 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=iVo2pIWuOVxRvCbt/OCeKPJbPFUkK630sVsLU2fz4Kw=;
        b=Rp9jzADM/scCOt6ZOjfIDJxJ55kRNihPip+obcjKodWyRrsSB9pMmWv8JKtjq6ussn
         +PmvjEpN3+BaanjN1DJR/UcUKVJfy2soetDLUjNvBeWPyQvPIWHvZF1v430Ou57RJsfv
         3Xz+KMMdYPB1Kvo9nCcjxX5Xah6dusiTq0t1EOqtLFesGKabRdUUAlwq4JsdStacZSPO
         m52DKl++Ubn9ymFUoXKH6IezlgnDvcdafAa/wbvo9Nd9TkBV3afeiSULQ2JolfLcdux+
         rkg7Lfoxlk/eGinln/22eeTgrQHnqYM7HipgHAWE+4aBiyVhpuRnW3/n0MJVRqxbOpA2
         J7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=iVo2pIWuOVxRvCbt/OCeKPJbPFUkK630sVsLU2fz4Kw=;
        b=EL4CByJTpxB7F1/gIDOPvOdmtQzFxBSwIrqV2Vd8GOEvMrnaZn2UBPBvo9TuOtZys/
         axpyrQ3XwAXjWfxksMfVw8mQf1d9CDU3XLpUpgfBs5jK0c63wIrf8PCvC6A8bchTQ1MD
         e6HWQ6/yqCip18WyEFDWGm73cs/PWw6d1HsY4IlYS1jIfFacIfijAYk6R9CM84GQ2Dbt
         dAqVnqHoJdiQmbidSxHQDWq4S7CPQb6FaBw8dvvlU2S5ajb6zJTiVTwEp3wxuQi+Z1QK
         qFUodsxM7NX1DRKo9+86aEHWQNiOdpSJxHwdjLsw+XPVtHuTh6lj1WXKdCprtqG3UP8D
         MGiQ==
X-Gm-Message-State: AE9vXwPAMpGXDFN3P6IRZgDyg8rB/Jh2VlnjUBILbr0Na//ZtQZO3F8gmI2ekTP9sB0sNQ==
X-Received: by 10.202.104.224 with SMTP id o93mr4980392oik.82.1474227467105;
        Sun, 18 Sep 2016 12:37:47 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:d4cf:3fa5:ba12:898b? ([2001:470:d:73f:d4cf:3fa5:ba12:898b])
        by smtp.googlemail.com with ESMTPSA id y10sm16163016oig.29.2016.09.18.12.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Sep 2016 12:37:46 -0700 (PDT)
Subject: Re: [PATCH v4] MIPS: bcm63xx: let clk_disable() return immediately if
 clk is NULL
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <1474221875-22687-1-git-send-email-yamada.masahiro@socionext.com>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d70c5d6c-1648-ba19-627f-c5fb374ad112@gmail.com>
Date:   Sun, 18 Sep 2016 12:37:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1474221875-22687-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55160
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

Le 18/09/2016 à 11:04, Masahiro Yamada a écrit :
> In many of clk_disable() implementations, it is a no-op for a NULL
> pointer input, but this is one of the exceptions.
> 
> Making it treewide consistent will allow clock consumers to call
> clk_disable() without NULL pointer check.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
