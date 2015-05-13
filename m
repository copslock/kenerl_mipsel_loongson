Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 04:56:18 +0200 (CEST)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33775 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008759AbbEMC4RkKBlX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 May 2015 04:56:17 +0200
Received: by igbpi8 with SMTP id pi8so106925219igb.0
        for <linux-mips@linux-mips.org>; Tue, 12 May 2015 19:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=2AM+4vHqH2WEkPCHehx3sSgPt4cMgWmAJKgqD4697fY=;
        b=XI0NfANql5gHJLj7rHUKHGqSmopDoE7ipuM0IAoIgnQCMl0JepB9eAQNCOUy+ufy/a
         TV8nRkLgWZpexRO31pk+VCpO/yppGU+q+/yntJuMlMA8FXdodEmG5SvnLRg8qm0/D3zk
         RoeQHj2bVWAoIz+7zMVERFY+5coYonnnKg7l2auTQknvfdJDEq7ekvCMEypzRnR693mX
         CtFtRjzecjkmiEa53+rpDijOhJyFGtxR9pE3o4oZ0qPoHJw3hTX8x7R96oAWYHT5F4ZV
         CqH0/89NOxRyYBSUBU01jvFMwW/VvRqZSrFw27w5a5arAbPLI/J9HK9pcLC6JARDRa17
         u18A==
X-Gm-Message-State: ALoCoQke3j4cdgREnt4jmiW7piICkhCCQPpt5JQmg1DM19XfAaREKu+Fn6/lZzkp+bm2Ftq1P79j
X-Received: by 10.50.33.51 with SMTP id o19mr7887697igi.45.1431485773054;
        Tue, 12 May 2015 19:56:13 -0700 (PDT)
Received: from localhost (pool-71-119-96-202.lsanca.fios.verizon.net. [71.119.96.202])
        by mx.google.com with ESMTPSA id ot6sm2633808igb.11.2015.05.12.19.56.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 19:56:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
From:   Michael Turquette <mturquette@linaro.org>
In-Reply-To: <1429881457-16016-28-git-send-email-paul.burton@imgtec.com>
Cc:     "Paul Burton" <paul.burton@imgtec.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Stephen Boyd" <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
 <1429881457-16016-28-git-send-email-paul.burton@imgtec.com>
Message-ID: <20150513025600.20636.34201@quantum>
User-Agent: alot/0.3.5
Subject: Re: [PATCH v4 27/37] MIPS, clk: move jz4740_clock_set_wait_mode to jz4740-cgu
Date:   Tue, 12 May 2015 19:56:00 -0700
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@linaro.org
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

Quoting Paul Burton (2015-04-24 06:17:27)
> +void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode)
> +{
> +       uint32_t lcr = readl(cgu->base + CGU_REG_LCR);
> +
> +       switch (mode) {
> +       case JZ4740_WAIT_MODE_IDLE:
> +               lcr &= ~LCR_SLEEP;
> +               break;
> +
> +       case JZ4740_WAIT_MODE_SLEEP:
> +               lcr |= LCR_SLEEP;
> +               break;
> +       }
> +
> +       writel(lcr, cgu->base + CGU_REG_LCR);
> +}

What do these modes do? How are they used?

Do you think the above function is a good candidate for .prepare and
.unprepare callback?

Regards,
Mike
