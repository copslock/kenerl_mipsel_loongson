Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 17:42:44 +0100 (CET)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:57044 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011405AbaJ0QmjXXnyE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 17:42:39 +0100
Received: by mail-ig0-f171.google.com with SMTP id l13so6670366iga.4
        for <linux-mips@linux-mips.org>; Mon, 27 Oct 2014 09:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bFv/1xvV/AKe4eQTtGWNYaHnyyAgTSZMY1wymk5hJo0=;
        b=Jd93F2BC5+SPxmGLf6mnideOvpu9NWOGUJPQDf6pHjJyCdvaeCyVCA/l0hx645KhWy
         BVKxGyaJu2VOXc/OXB8XcFxxG10WOH3EnjrZpD4hgc7c3cBUq6e4ywRMU1ZAwYI8Sc2i
         KcYFJSJz5UOU2rgsYCCsP/SQDDFYkhZIIAQzTdxd/K5Lip/CbOrcPu50GvlAYvwqe41A
         he5djvjEXDY48JWfm/AH+Cm/KwRliKeiGbLknE1QNlfS5353Z0DUaIjTQvHKgE0QoLXd
         YhyEScf62+PRDlfL5RWiGyhjC8fJ+CZyhseW8PAe1ElkPj6gUmYIVbGY3ODAaERUhu9Z
         tn+Q==
X-Gm-Message-State: ALoCoQlSwaK5uF5aFf/ron6Ej2DnNkHYlwqPmpcLJXSY4MNaFff0rPAWzUVbCbXrVXYbrT8vDjrN
MIME-Version: 1.0
X-Received: by 10.107.165.19 with SMTP id o19mr5869749ioe.1.1414428153728;
 Mon, 27 Oct 2014 09:42:33 -0700 (PDT)
Received: by 10.42.49.141 with HTTP; Mon, 27 Oct 2014 09:42:33 -0700 (PDT)
In-Reply-To: <1412972930-16777-5-git-send-email-blogic@openwrt.org>
References: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
        <1412972930-16777-5-git-send-email-blogic@openwrt.org>
Date:   Mon, 27 Oct 2014 17:42:33 +0100
Message-ID: <CACRpkdZmf6q5apZAYGtjO_GeG-BRBzTOKa53vi3J_5riqrN-zQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] MIPS: ralink: we require gpiolib
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43601
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

On Fri, Oct 10, 2014 at 10:28 PM, John Crispin <blogic@openwrt.org> wrote:

> Select ARCH_REQUIRE_GPIOLIB by default when building a kernel for RALINK.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>

Happy with selecting this, but don't think you need the altered
mach gpio.h header. Do like x86 does.

Yours,
Linus Walleij
