Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2018 01:30:42 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992960AbeGYXaiQqB53 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jul 2018 01:30:38 +0200
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF4D20685;
        Wed, 25 Jul 2018 23:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532561431;
        bh=simC5lAovSMiFfejwgnGnX0qhpV0mdP44Vc15Qe8+DI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=MlFYSk55iP8BvRE1Yod7juRytg0sUHOIKJ6OTtFTNDasvVI09wa9Vg1KQcd+pfJXX
         nyGtJvYbC0k+Mj4CTgc7WRPVkbWWJMeDsOcCz+/GUG3ybYwaWsTeOe9KM4ftNPQSTb
         577aTkKIIwFJ0vvsZ6HK1/TKbH0NT/hMJp1zAf9I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180724231958.20659-15-paul@crapouillou.net>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20180724231958.20659-1-paul@crapouillou.net>
 <20180724231958.20659-15-paul@crapouillou.net>
Message-ID: <153256143066.48062.8671703408424915070@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 14/21] clk: jz4740: Add TCU clock
Date:   Wed, 25 Jul 2018 16:30:30 -0700
Return-Path: <sboyd@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@kernel.org
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

Quoting Paul Cercueil (2018-07-24 16:19:51)
> Add the missing TCU clock to the list of clocks supplied by the CGU for
> the JZ4740 SoC.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
