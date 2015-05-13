Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 04:52:22 +0200 (CEST)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33518 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006508AbbEMCwU6fHEy convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 May 2015 04:52:20 +0200
Received: by iebgx4 with SMTP id gx4so20099607ieb.0
        for <linux-mips@linux-mips.org>; Tue, 12 May 2015 19:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=BHeoVsX6PaaTZ9QphJ7KlT7AVJGqfH3dXFG4G/SsY6w=;
        b=GUGG/jmBnxzOrYZWzb8DP4SrzqAqHYR3x5Kp6c07lmQh0wO4Iiz/GazfZOC6Ba85ID
         nLbGwny5TCvJUIfVUru9K5l1XmveEIb8vYkJWMr89p9KN/zlz6hC0l8rOxpZWy3KzMPn
         xnCgQaEHiq3LG/Pywe4Dpn1BSwyTPRMLVbSnJwIKII58ZVqac32G0m9rP85Ov21J4a2R
         HkRZHOHOXrbaTUFBSf7heAipHm5xwRONrUnxCCYyWn3YWO9tPfzAFA0TjNeB9wT0azqS
         ue45TmsgIHK6K/M2FwjMr7COYsTpJto3RmCGzwwfTc1IPOUNLqYXULDm2E5vE0futbGV
         eO9Q==
X-Gm-Message-State: ALoCoQlTOEFpeqgk74mLT6WjH/GtnPZ8Mq2iUE7poLrJFukeJZ4uGAT3ClX8JRoN0dGwZMgwIkUr
X-Received: by 10.50.41.8 with SMTP id b8mr25151875igl.38.1431485537378;
        Tue, 12 May 2015 19:52:17 -0700 (PDT)
Received: from localhost (pool-71-119-96-202.lsanca.fios.verizon.net. [71.119.96.202])
        by mx.google.com with ESMTPSA id v3sm2643802igk.1.2015.05.12.19.52.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 19:52:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
From:   Michael Turquette <mturquette@linaro.org>
In-Reply-To: <1429881457-16016-27-git-send-email-paul.burton@imgtec.com>
Cc:     "Paul Burton" <paul.burton@imgtec.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Pawel Moll" <pawel.moll@arm.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Stephen Boyd" <sboyd@codeaurora.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
 <1429881457-16016-27-git-send-email-paul.burton@imgtec.com>
Message-ID: <20150513025204.20636.10155@quantum>
User-Agent: alot/0.3.5
Subject: Re: [PATCH v4 26/37] MIPS,clk: migrate JZ4740 to common clock framework
Date:   Tue, 12 May 2015 19:52:04 -0700
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47356
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

Quoting Paul Burton (2015-04-24 06:17:26)
> +static void __init jz4740_cgu_init(struct device_node *np)
> +{
> +       int retval;
> +
> +       cgu = ingenic_cgu_new(jz4740_cgu_clocks,
> +                             ARRAY_SIZE(jz4740_cgu_clocks), np);
> +       if (!cgu) {
> +               pr_err("%s: failed to initialise CGU\n", __func__);
> +               return;
> +       }
> +
> +       retval = ingenic_cgu_register_clocks(cgu);
> +       if (retval)
> +               pr_err("%s: failed to register CGU Clocks\n", __func__);
> +}
> +CLK_OF_DECLARE(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
> -- 
> 2.3.5
> 

Patch looks good to me, but I have one question. Is it possible for you
to have a proper platform_device for the cgu instead of relying on
CLK_OF_DECLARE?

For an example of a clock driver that does this, check out the bottom of
drivers/clk/qcom/gcc-msm8660.c.

Regards,
Mike
