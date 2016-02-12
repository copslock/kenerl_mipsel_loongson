Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2016 03:21:33 +0100 (CET)
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36072 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012572AbcBLCVchLX0R convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Feb 2016 03:21:32 +0100
Received: by mail-pf0-f179.google.com with SMTP id e127so39325766pfe.3
        for <linux-mips@linux-mips.org>; Thu, 11 Feb 2016 18:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=content-type:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=AO2hLaK8zFmpI9OXNH1ONjun5jcIo3tygqMomFYtBZY=;
        b=DE4BI+GucLRpxEwcl5DCRPfFzuml7ZMHpzLq45LQrooibF1ay45i0h/sUmDK/MeqIg
         HR97VMooiYvnkYzTYiqcgElc0sp8fG8f7sAvIDd9MhhqxEDvBnmNqtpp4SKUV8/POhWo
         oLC/gJsnMoxyTI1/dMZADLVjwE2Zdo8xoBlJPX7ZfjySVBOHhjAJi5isSeaNO0y/9dUN
         +eTZ5mbKce7YCQ0fTLz3Bh1ucUHxw9dxOHv+psmPEx1Dv0fjDi02KabvzsCF3L3ftHEp
         WNa2ASj4eoIN+VuN5HBu282qkD9BE7O7ki26mk4mHsi4LDe7ehfCTJwXzqLoFaspA0al
         KsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=AO2hLaK8zFmpI9OXNH1ONjun5jcIo3tygqMomFYtBZY=;
        b=AMcsletDPn0JCl0fyrgbqViHrprwk+zx3ewUHvKp40DdggWsRDRi8snfWPuVIx//De
         VaObBAY0rD4c1U9WA9pJuTQ4enEFzoY0fvOO+cnHtVLPzFJB3ibQvWuzY9Ncqgk/d8o6
         CYWTqtWPecFcty0l0DOU0QvGDDz204lSmIJce70QHQFSM5ESr0NYizPHuF9Z+xGIPgdJ
         TFPg0tPIlqhHVU8zJeqnOvG1a9JD82EJ6305aXKzU7N37JpS7TJ7ajadwLBI3n5eOVtk
         6UUMUvvYbhV48oyeQwS1Qum+X55wwk4OtIWv0NSssDiCcvQY8zOzrlPsdyjyVu5LccPE
         1mSQ==
X-Gm-Message-State: AG10YOSetz3sfPbXabfQ4GOMGwdtZhkh4HSUxYsrvyq7EcKx3360wtQWmw0iybvp1+11b9N+
X-Received: by 10.98.71.92 with SMTP id u89mr71470078pfa.122.1455243686210;
        Thu, 11 Feb 2016 18:21:26 -0800 (PST)
Received: from localhost (cpe-172-248-200-249.socal.res.rr.com. [172.248.200.249])
        by smtp.gmail.com with ESMTPSA id r5sm15148610pap.7.2016.02.11.18.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2016 18:21:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Antony Pavlov <antonynpavlov@gmail.com>, linux-mips@linux-mips.org
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <1455005641-7079-2-git-send-email-antonynpavlov@gmail.com>
Cc:     "Marek Vasut" <marex@denx.de>, "Wills Wang" <wills.wang@live.com>,
        "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>,
        "Alban Bedel" <albeu@free.fr>,
        "Stephen Boyd" <sboyd@codeaurora.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Paul Burton" <paul.burton@imgtec.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
 <1455005641-7079-2-git-send-email-antonynpavlov@gmail.com>
Message-ID: <20160212022124.3210.30707@quark.deferred.io>
User-Agent: alot/0.3.6
Subject: Re: [RFC v5 01/15] WIP: clk: add Atheros AR933X SoCs clock driver
Date:   Thu, 11 Feb 2016 18:21:24 -0800
Return-Path: <mturquette@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@baylibre.com
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

Quoting Antony Pavlov (2016-02-09 00:13:47)
> +static void __init ar9130_init(struct device_node *np)
> +{
> +       int retval;
> +       struct ath79_cblk *cblk;
> +
> +       cblk = ath79_cblk_new(ar9331_clocks, ARRAY_SIZE(ar9331_clocks), np);
> +       if (!cblk) {
> +               pr_err("%s: failed to initialise clk block\n", __func__);
> +               return;
> +       }
> +
> +       retval = ath79_cblk_register_clocks(cblk);
> +       if (retval)
> +               pr_err("%s: failed to register clocks\n", __func__);
> +}
> +CLK_OF_DECLARE(ar933x_clk, "qca,ar9330-pll", ar9130_init);

Is there any reason this isn't a platform_driver?

Thanks,
Mike
