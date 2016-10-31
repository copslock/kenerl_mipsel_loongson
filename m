Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 22:18:18 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993015AbcJaVRVnlI60 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 31 Oct 2016 22:17:21 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id E4A372034C;
        Mon, 31 Oct 2016 21:17:18 +0000 (UTC)
Received: from mail-yb0-f179.google.com (mail-yb0-f179.google.com [209.85.213.179])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA80201EF;
        Mon, 31 Oct 2016 21:17:17 +0000 (UTC)
Received: by mail-yb0-f179.google.com with SMTP id f97so67921431ybi.1;
        Mon, 31 Oct 2016 14:17:17 -0700 (PDT)
X-Gm-Message-State: ABUngvdJx+6iMujxwLAicFPTuVB9YvA2XBU+BaWrPCk0ZS+5tIS4ENsaaZOzVfuQU7my+AdaN7r8Ci/JFhzRuA==
X-Received: by 10.37.170.198 with SMTP id t64mr26633676ybi.63.1477948637061;
 Mon, 31 Oct 2016 14:17:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.212.208 with HTTP; Mon, 31 Oct 2016 14:16:56 -0700 (PDT)
In-Reply-To: <20161031203951.5444-2-paul@crapouillou.net>
References: <20161030230247.20538-1-paul@crapouillou.net> <20161031203951.5444-1-paul@crapouillou.net>
 <20161031203951.5444-2-paul@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 31 Oct 2016 16:16:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5=QXfCTux1S7ysu8J5qnzU5AXr-0xzRTifnUYtzaQOg@mail.gmail.com>
Message-ID: <CAL_Jsq+5=QXfCTux1S7ysu8J5qnzU5AXr-0xzRTifnUYtzaQOg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] Documentation: dt: Add binding info for jz4740-rtc driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <rtc-linux@googlegroups.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Mon, Oct 31, 2016 at 3:39 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> This commit adds documentation for the device-tree bindings of the
> jz4740-rtc driver, which supports the RTC unit present in the JZ4740 and
> JZ4780 SoCs from Ingenic.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt

Acked-by: Rob Herring <robh@kernel.org>
