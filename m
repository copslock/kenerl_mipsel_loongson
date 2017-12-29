Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 13:41:18 +0100 (CET)
Received: from mail-wr0-x22c.google.com ([IPv6:2a00:1450:400c:c0c::22c]:36795
        "EHLO mail-wr0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdL2MlL7SS3p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 13:41:11 +0100
Received: by mail-wr0-x22c.google.com with SMTP id u19so35191767wrc.3
        for <linux-mips@linux-mips.org>; Fri, 29 Dec 2017 04:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nI1/fjh57qUyMUAwFf+EZ5+NXWqW8CeIwINXitgtjlI=;
        b=rAtwXcRAlIthWOQLZ4ajP2Y0Ve09bunssiPt38jkeUu4hLXHk2z0sEUYyIhxQRaz1h
         o7LvX4SPhmoPsqoA2TeitS9UgZLz8iWGgwO3fz5rI4tguZbUS7hC7Niru9EgFWbJv5Ix
         iVOTSFMtdbmZVtUDx1kyFT4KY89x2tTJP1asJmkqKLnt5MqQ1slZftMl4dm+VWDqWUOX
         Ltx1KtftvQ6BYwMcGqNV5TzrQg1Se+FzY1Cu9HO0jkti+nUE03qPZOu/u7XRNnFfTAaF
         C7BkNYdEgobU4qwqer79Qu2RUFpYbHx5yLAElzYkcfUIKJ6Ek0bXaUTQ7lyxHVpVH9Lm
         dqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nI1/fjh57qUyMUAwFf+EZ5+NXWqW8CeIwINXitgtjlI=;
        b=W2Brlm4AVAz2M73rv1hLpwCBrdz3sNyDy5OnLZ4UYBhLkMU9kbhVDPhZyrzIM+loKH
         6nQ7B6U7YzcWmtvE6RV/sAsmUZIXSZvyKyP93KdbWh92SUDqS1mqcC7Bi3L1rU32QV90
         M8doeFy8NrTStrYehiQgHxXKHxrjf/wmN3IubEoMtea5V0ZlKfj10BnttsLuJ84+FP1q
         lZOEgWv1fFfkKsvzJ2QZ78Po3ZNXMcFOSqZW/sLSfbJe6fiwFE6dktjEcuQTY+GQZT6j
         SPm0PIa+c45uLCyDZ8N9TTqEasseF0tQhngoaNwJDaqN7qYbYe2GIazfPUN8L11Ckmid
         r1pA==
X-Gm-Message-State: AKGB3mITQjsXkUe9/jfSdkoEoVda2V1lM/LSYvR+pL2/zCkXBM1ZRIPl
        d8XHcbmmOrQ4DI7i2RTp1KMVP+k+c7wIdnQKeyfumg==
X-Google-Smtp-Source: ACJfBoshVW5/pWijeno2Shm3WT5YkRuB34yu+GyAKrkMC32f7KRFu6vADnDvnex6QutRgJi4Mbx251ZWBS5VGfvOBYk=
X-Received: by 10.223.156.193 with SMTP id h1mr4613002wre.29.1514551266555;
 Fri, 29 Dec 2017 04:41:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.206 with HTTP; Fri, 29 Dec 2017 04:40:26 -0800 (PST)
In-Reply-To: <20171226132339.7356-2-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com> <20171226132339.7356-2-jiaxun.yang@flygoat.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Fri, 29 Dec 2017 13:40:26 +0100
Message-ID: <CAOFm3uH8n4Ag+_buYOyBgSa3kzkcAJRpKcHXAk3dBBVNHDiCdw@mail.gmail.com>
Subject: Re: [PATCH 1/7] MIPS: Loongson64: cleanup all cs5536 files to use
 SPDX Identifier
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

On Tue, Dec 26, 2017 at 2:23 PM, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> To reduce unnecessary license text.

<snip>

> diff --git a/arch/mips/loongson64/common/cs5536/cs5536_acc.c b/arch/mips/loongson64/common/cs5536/cs5536_acc.c
> index ab4d6cc57384..ba0474bb4a3d 100644
> --- a/arch/mips/loongson64/common/cs5536/cs5536_acc.c
> +++ b/arch/mips/loongson64/common/cs5536/cs5536_acc.c
> @@ -1,3 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Please use  // comment in .c files as requested by Linus and discussed on list.
This is also documented in Thomas doc patches.
This applies to the whole patch set.

<snip>

> diff --git a/arch/mips/loongson64/common/cs5536/cs5536_isa.c b/arch/mips/loongson64/common/cs5536/cs5536_isa.c
> index 924be39e7733..c358c0755eff 100644
> --- a/arch/mips/loongson64/common/cs5536/cs5536_isa.c
> +++ b/arch/mips/loongson64/common/cs5536/cs5536_isa.c
> @@ -1,3 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

And this is the correct comment style for .h files.

Thanks!

-- 
Cordially
Philippe Ombredanne
