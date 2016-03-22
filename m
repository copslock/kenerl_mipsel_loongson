Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 14:36:25 +0100 (CET)
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34108 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007013AbcCVNgXkglaH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Mar 2016 14:36:23 +0100
Received: by mail-oi0-f54.google.com with SMTP id i17so7142595oib.1
        for <linux-mips@linux-mips.org>; Tue, 22 Mar 2016 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ItI47aXJOAgUcdWNzU0ytVDdEvXsU+eazCzwSpsveJY=;
        b=XzpKXqJrPt/xhrW01dPpnxUDGaqmAlIZ+P6pUewlhMJZZPDoaIqFdo3hy18400NUZM
         ogvyq5m3pFwFFr3HuKE1QiExEBL+KShHxOewkio7Y2bgMvViPwU2BuiPUXipF2it8Co0
         EvYsxInIRKd4lL+bYE1PSYSRUOvWfOsSNj23k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ItI47aXJOAgUcdWNzU0ytVDdEvXsU+eazCzwSpsveJY=;
        b=hbSGLFCiQWKa/RpQUNYBbTSv0HWZqUdrG7mV1SmkDyCuVHgLhYuuTGysHvKeKQG+uy
         TvEVgsBMu4Cf+N0oGZo/gvJGYOjRuKov+rxmwv3A98Bf0CgsRONaE6mP4Ic/iUfKlxDB
         E0DsP0UzbxiCmDXIXG3WIqh071S+GB5mxRGTIMU2XEduKsa+F9/04H9eqUmo6JLxg5uf
         EQFxS6U9VbaQwtwC+CNjdjdvwdwGSkGX7lyrK0PxoSmE7oKOt6fuYDlXyNVLPF+pWG3y
         jzzAYO0HglU2I+gcDpF2/sDGGSDsb2arhoEzM+HkEpXh3Qo/HDErr2DCi2xpi2bTv9wj
         z4BQ==
X-Gm-Message-State: AD7BkJKVRNfUBFXD/DtH8J7au2WmPcvC0r6qk5arujJee+6XPJcbDd/HeIcIzVDq2vkX2ll9zvOUYyxcox3N5gBc
MIME-Version: 1.0
X-Received: by 10.157.2.39 with SMTP id 36mr2527335otb.140.1458653777840; Tue,
 22 Mar 2016 06:36:17 -0700 (PDT)
Received: by 10.182.55.105 with HTTP; Tue, 22 Mar 2016 06:36:17 -0700 (PDT)
In-Reply-To: <1458306366.17098.1.camel@ingics.com>
References: <1458306316.17098.0.camel@ingics.com>
        <1458306366.17098.1.camel@ingics.com>
Date:   Tue, 22 Mar 2016 14:36:17 +0100
Message-ID: <CACRpkdbQf9iw=d0gptD6OXyfU5sGRQ_npsEyU16bOwQAG5AKaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: octeon: Constify octeon_gpio_match table
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     David Daney <david.daney@cavium.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Fri, Mar 18, 2016 at 2:06 PM, Axel Lin <axel.lin@ingics.com> wrote:

> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Patch applied for v4.7.

Yours,
Linus Walleij
