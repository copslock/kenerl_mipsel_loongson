Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jul 2013 08:05:23 +0200 (CEST)
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51297 "EHLO
        mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816288Ab3GLGFMFGx9b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jul 2013 08:05:12 +0200
Received: by mail-vc0-f174.google.com with SMTP id kw10so7304214vcb.5
        for <multiple recipients>; Thu, 11 Jul 2013 23:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ZWn18pqkOq4g5qF9/TC6EvJ/G6TRlxEWcGTkw/EB3Y0=;
        b=Cty3svmtcpUeO+KECMECX7Euql331grpSVu6wIxtW1oVBRfR9DedkbFRSbWd8R6Kn/
         aDBmbmiVuJMNPFh73hSaBrlDaMq0mCULKrkYH8eK9LUaBnPFG/t2FFWTKG1EVJXtI9Xo
         tqCg5irjvnuk8g5vXzm1bgOOx/45SGcK3zCWCPczZi1xaCrQiUahv/CkD/3OXGqnJ2X2
         vWihKLj1Z3q28dJQ4kTcMaFcJh/JTBWek2bwKhKkow1y9/uWXvL8/S+j/NfX9jSlmv92
         tNuu8qVQ9OhAVFlaX6V1tdS8O6aOlfYMVGjn/b+M7h3D+2Pohik8EQEihO3vEC1wlwdN
         dDeQ==
MIME-Version: 1.0
X-Received: by 10.58.46.48 with SMTP id s16mr23842879vem.52.1373609105388;
 Thu, 11 Jul 2013 23:05:05 -0700 (PDT)
Received: by 10.52.231.4 with HTTP; Thu, 11 Jul 2013 23:05:05 -0700 (PDT)
In-Reply-To: <1373571281-4457-1-git-send-email-aaro.koskinen@iki.fi>
References: <1373571281-4457-1-git-send-email-aaro.koskinen@iki.fi>
Date:   Fri, 12 Jul 2013 11:35:05 +0530
X-Google-Sender-Auth: UXFwICWKPs-OPNYVJbIrfI0anDQ
Message-ID: <CAOh2x==snAt8UfdG+d_FvA6m9Pqnp_BmonOB=u7UX1MLH8O89A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: loongson2: cpufreq: fix broken cpufreq
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "Rafael J. Wysocki" <rjw@sisk.pl>,
        Ralf Baechle <ralf@linux-mips.org>, cpufreq@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <viresh.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

On Fri, Jul 12, 2013 at 1:04 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Commit 42913c799 (MIPS: Loongson2: Use clk API instead of direct
> dereferences) broke the cpufreq functionality on Loongson2 boards:
> clk_set_rate() is called before the CPU frequency table is initialized,
> and therefore will always fail.
>
> Fix by moving the clk_set_rate() after the table initialization.
> Tested on Lemote FuLoong mini-PC.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: stable@vger.kernel.org
> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Ackec-by: Viresh Kumar <viresh.kumar@linaro.org>
