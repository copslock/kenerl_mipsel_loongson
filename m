Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 15:20:50 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:44110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992721AbcGYNUmWJdyQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jul 2016 15:20:42 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id E64F42047C;
        Mon, 25 Jul 2016 13:20:39 +0000 (UTC)
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com [209.85.220.169])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B952049D;
        Mon, 25 Jul 2016 13:20:37 +0000 (UTC)
Received: by mail-qk0-f169.google.com with SMTP id s63so159454287qkb.2;
        Mon, 25 Jul 2016 06:20:37 -0700 (PDT)
X-Gm-Message-State: AEkoousxVrudE6FQ1Z5oeYvWWKcHsaBi8NYj3alifyi4eRxSCrcNeS7+aCsKi9XHrlOzLkykCjRDbuHiiJQgrA==
X-Received: by 10.13.247.131 with SMTP id h125mr15141898ywf.18.1469452836661;
 Mon, 25 Jul 2016 06:20:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.155.200 with HTTP; Mon, 25 Jul 2016 06:20:17 -0700 (PDT)
In-Reply-To: <1469318415-1834-1-git-send-email-linux@roeck-us.net>
References: <1469318415-1834-1-git-send-email-linux@roeck-us.net>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 25 Jul 2016 08:20:17 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+2OSmj-xTmiLPTgtpJV7fZtV1bKtCCmLdaxmW+wqQ2nQ@mail.gmail.com>
Message-ID: <CAL_Jsq+2OSmj-xTmiLPTgtpJV7fZtV1bKtCCmLdaxmW+wqQ2nQ@mail.gmail.com>
Subject: Re: [PATCH -next] MIPS: ath79: Add missing include file
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54365
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

On Sat, Jul 23, 2016 at 7:00 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Commit ddd0ce87bfde ("mips: Remove unnecessary of_platform_populate with
> default match table") dropped the include of linux/clk-provider.h from
> arch/mips/ath79/setup.c. This results in the following build error.
>
> arch/mips/ath79/setup.c: In function 'ath79_of_plat_time_init':
> arch/mips/ath79/setup.c:232:2: error:
>         implicit declaration of function 'of_clk_init'
>
> Fixes: ddd0ce87bfde ("mips: Remove unnecessary of_platform_populate with default match table")
> Cc: Rob Herring <robh@kernel.org>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/mips/ath79/setup.c | 1 +
>  1 file changed, 1 insertion(+)

Since the error is in my tree, I've applied this. Thanks.

Rob
