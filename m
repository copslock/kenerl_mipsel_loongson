Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 16:45:50 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36906 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013396AbaKKPpsLJq6A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 16:45:48 +0100
Received: by mail-pd0-f181.google.com with SMTP id y10so10326482pdj.12
        for <linux-mips@linux-mips.org>; Tue, 11 Nov 2014 07:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=RYxWVBbFplHY567nisaInY4WK1CbOhB6pJsgc7i0w/U=;
        b=B8JkwBnVeA3qm++V3+gTlE4SC16uVXTnLJVo1tlnoS0w1GpGNbXe2NmC/S7/WWCq72
         ISgw3AuAjJsEg3WlgkhUGKY+wPPCR/dbY047t0Y/4IjWr6CL9oHTkNgG2p2rAVxl8KNB
         UCbQ/ksOi33Yq00//BPqy+xr1SctYZbwsG2AzuriSaEZ3Ew65S1ljBS5LxJQ7kYwas/5
         RegxK/6i6b8RJqroil8ZInMKjHYu5CFwvIq/VnRfPp9yFKt3ShCzgRDKbMH1HXhPoU3H
         qt1dhDceq/20nfdjCZ2OV5PQ46E/WSPbNnPDPAty4Yf7qWVreiXMPp5i3QLBxzDe/sL5
         l4fQ==
X-Gm-Message-State: ALoCoQns8O7nL9YIiHXSV4vjFV08MUVvFgBj5WejVqDUy5xXe3IKN/NSIFSp8BVe6wvZPPWOXY+7
X-Received: by 10.68.131.133 with SMTP id om5mr40192310pbb.41.1415720741914;
        Tue, 11 Nov 2014 07:45:41 -0800 (PST)
Received: from localhost (c-67-183-17-239.hsd1.wa.comcast.net. [67.183.17.239])
        by mx.google.com with ESMTPSA id ez4sm19783209pab.36.2014.11.11.07.45.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Nov 2014 07:45:40 -0800 (PST)
From:   Kevin Hilman <khilman@kernel.org>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-sh@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] irqchip: atmel-aic: fix irqdomain initialization
References: <20141110230301.GV4068@piout.net>
        <1415712816-9202-1-git-send-email-boris.brezillon@free-electrons.com>
Date:   Tue, 11 Nov 2014 07:45:37 -0800
In-Reply-To: <1415712816-9202-1-git-send-email-boris.brezillon@free-electrons.com>
        (Boris Brezillon's message of "Tue, 11 Nov 2014 14:33:36 +0100")
Message-ID: <7hioiloi5a.fsf@deeprootsystems.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <khilman@deeprootsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khilman@kernel.org
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

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> First of all IRQCHIP_SKIP_SET_WAKE is not a valid irq_gc_flags and thus
> should not be passed as the last argument of
> irq_alloc_domain_generic_chips.
>
> Then pass the correct handler (handle_fasteoi_irq) to
> irq_alloc_domain_generic_chips instead of manually re-setting it in the
> initialization loop.
>
> And eventually initialize default irq flags to the pseudo standard:
> IRQ_REQUEST | IRQ_PROBE | IRQ_AUTOEN.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
> Hello Kevin,
>
> This patch has not been tested yet but it should solve the issue you've
> experienced with the IRQ_GC_BE_IO flag and the atmel-aic driver.
>
> I'll test it tomorrow and let you know if it actually works.

Well, it at least boots on my xplained and my sama5d35-ek:

Tested-by: Kevin Hilman <khilman@linaro.org>

I'll let Jason pick this up as a fix through his tree.

Kevin
