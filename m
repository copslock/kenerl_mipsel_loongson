Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 11:21:10 +0200 (CEST)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62035 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835136Ab3FQJVFjfGA3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jun 2013 11:21:05 +0200
Received: by mail-ob0-f172.google.com with SMTP id wo10so2904766obc.3
        for <linux-mips@linux-mips.org>; Mon, 17 Jun 2013 02:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=gOGpMNSZV5r++ZD0hIMNkPA08LAgafD/fVlDTKKf1kM=;
        b=IYXMrJ0WYERJrp1UIZhxrDI7M4XIvwB1zhq4T/RZH2qDp9ewMtYG0/0TDDUAUkQTiM
         b2oS7rIuJrrZFcqQMOjPmtiJLmithwU+NFnLH+dKb29V9S7d5RuAef6j9vA8hkSnBUwo
         vkpz5cLgAxLjAhi6w/h3jdG0cgyMX0NKXiSVbfY9ik4PT0QpvfISEs03wzosmkDF6qJe
         WGxlALEdL2AaczCSEjn+2b23rPgal59SDX0eZMcsVszI3Q4OrvWAjbg6dXt92+f/p60v
         4CDAjVLzRhF2XvikaOncldA8rBSyfV830cHMLMxhWeCykCzJqkvDwl1ininuu2PzQ9RO
         1kFQ==
MIME-Version: 1.0
X-Received: by 10.182.40.202 with SMTP id z10mr8274056obk.74.1371460857813;
 Mon, 17 Jun 2013 02:20:57 -0700 (PDT)
Received: by 10.182.120.7 with HTTP; Mon, 17 Jun 2013 02:20:57 -0700 (PDT)
In-Reply-To: <1371228049-27080-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
        <1371228049-27080-5-git-send-email-javier.martinez@collabora.co.uk>
Date:   Mon, 17 Jun 2013 11:20:57 +0200
Message-ID: <CACRpkdafxpwuaUHLb3uHiPNrKLsmcekqG1ATQKj8fgz+ekXmDg@mail.gmail.com>
Subject: Re: [PATCH 4/7] mfd: stmpe: use irq_get_trigger_type() to get IRQ flags
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQnFRmTMV24f9JX3br2LVWvGe08woS7NXIGNm26uqFZf5mf4vjzkACZenhJEvCcufNtmZVGE
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36942
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

On Fri, Jun 14, 2013 at 6:40 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> Use irq_get_trigger_type() to get the IRQ trigger type flags
> instead calling irqd_get_trigger_type(irq_get_irq_data(irq))
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

If you get the other patches ACKed.

Yours,
Linus Walleij
