Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2018 00:41:25 +0200 (CEST)
Received: from mail-io0-f194.google.com ([209.85.223.194]:45017 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeHIWlWW4fi9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Aug 2018 00:41:22 +0200
Received: by mail-io0-f194.google.com with SMTP id q19-v6so6105638ioh.11
        for <linux-mips@linux-mips.org>; Thu, 09 Aug 2018 15:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:references
         :in-reply-to:cc:cc:status:lines;
        bh=NELGKDJ12DGUY4g/M3WRr6OvLQFM07WFv1SIeNf/RdU=;
        b=N6hILnyDNSmCddYdXrsdFjMTpIDHymQxdNRNEauU2egzOeHxeEmFPoSoKJil2RJ1ox
         uWDvG40L9nks6dCvTj5mSPwJhaOLGrzvgdV6+Y372CU3xqbb1Ygt6zyUgZ6K64wtPZcv
         6PooupuieiX6hR98SEDDbKkEW4mG07RyxG/B3E13oGbGkEVQbhplEr5of5Aevy023pU8
         fPip75/BaNzlUC8v9rLtgC5EHI6hb4i/PTgLqOx3/RPlKFkh1WDzawtjEIB6yuutJOfI
         lrPYT8Q4/x5bNJVdgNf9oILTG4WlukprkoKtOmQCvi2uinI95As/OwiyMFlaSo0k/lBn
         ud3w==
X-Gm-Message-State: AOUpUlFPzz0ccKo0wGABbnKo0OQwND7ZbiWkh0b5EgdRy89uZyPy4NlZ
        6vQ3YO9cYR7QJxkNPV+dNQ==
X-Google-Smtp-Source: AA+uWPw2QgFSbQww4DKMUh9zUgvQjlnRJfGTSKd0idhaHZawMVnjjtialKeH5k851gReOWnizuZv4w==
X-Received: by 2002:a6b:cc03:: with SMTP id c3-v6mr3290282iog.191.1533854474267;
        Thu, 09 Aug 2018 15:41:14 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id j126-v6sm3469275ioe.17.2018.08.09.15.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 15:41:13 -0700 (PDT)
Message-ID: <5b6cc309.1c69fb81.63d80.612a@mx.google.com>
Date:   Thu, 09 Aug 2018 16:41:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     songjun.wu@linux.intel.com
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-3-songjun.wu@linux.intel.com>
In-Reply-To: <20180803030237.3366-3-songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

Hi, this is an automated email from Rob's (experimental) review bot. I
found a couple of common problems with your patch. Please see below.

On Fri,  3 Aug 2018 11:02:21 +0800, Songjun Wu wrote:
> From: Yixin Zhu <yixin.zhu@linux.intel.com>
> 
> This driver provides PLL clock registration as well as various clock
> branches, e.g. MUX clock, gate clock, divider clock and so on.
> 
> PLLs that provide clock to DDR, CPU and peripherals are shown below:
> 
>                  +---------+
>             |--->| LCPLL3 0|--PCIe clk-->
>    XO       |    +---------+
> +-----------|
>             |    +---------+
>             |    |        3|--PAE clk-->
>             |--->| PLL0B  2|--GSWIP clk-->
>             |    |        1|--DDR clk-->DDR PHY clk-->
>             |    |        0|--CPU1 clk--+   +-----+
>             |    +---------+            |--->0    |
>             |                               | MUX |--CPU clk-->
>             |    +---------+            |--->1    |
>             |    |        0|--CPU0 clk--+   +-----+
>             |--->| PLLOA  1|--SSX4 clk-->
>                  |        2|--NGI clk-->
>                  |        3|--CBM clk-->
>                  +---------+
> 
> Signed-off-by: Yixin Zhu <yixin.zhu@linux.intel.com>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
> 
> Changes in v2:
> - Rewrite clock driver, add platform clock description details in
>   clock driver.
> 
>  drivers/clk/Kconfig                          |   1 +
>  drivers/clk/Makefile                         |   3 +
>  drivers/clk/intel/Kconfig                    |  20 ++
>  drivers/clk/intel/Makefile                   |   7 +
>  drivers/clk/intel/clk-cgu-pll.c              | 166 ++++++++++
>  drivers/clk/intel/clk-cgu-pll.h              |  34 ++
>  drivers/clk/intel/clk-cgu.c                  | 470 +++++++++++++++++++++++++++
>  drivers/clk/intel/clk-cgu.h                  | 259 +++++++++++++++
>  drivers/clk/intel/clk-grx500.c               | 168 ++++++++++
>  include/dt-bindings/clock/intel,grx500-clk.h |  69 ++++
>  10 files changed, 1197 insertions(+)
>  create mode 100644 drivers/clk/intel/Kconfig
>  create mode 100644 drivers/clk/intel/Makefile
>  create mode 100644 drivers/clk/intel/clk-cgu-pll.c
>  create mode 100644 drivers/clk/intel/clk-cgu-pll.h
>  create mode 100644 drivers/clk/intel/clk-cgu.c
>  create mode 100644 drivers/clk/intel/clk-cgu.h
>  create mode 100644 drivers/clk/intel/clk-grx500.c
>  create mode 100644 include/dt-bindings/clock/intel,grx500-clk.h
> 

DT bindings (including binding headers) should be a separate patch. See
Documentation/devicetree/bindings/submitting-patches.txt.
