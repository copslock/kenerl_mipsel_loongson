Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 21:32:39 +0200 (CEST)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36060 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994585AbeGCTcbv6QQt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 21:32:31 +0200
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so6146240oie.3;
        Tue, 03 Jul 2018 12:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIGN36IUEMCStOLlmFeCJzWbXLac1ZeWJE7alWOPrVM=;
        b=AU933zZkdetXtQpOPAuo+84nlih/9QiptaMSNnCyAG1OaG/i1LuJNjIs4bjhUIr/fM
         u9sCzrXujFR9BahGXB9xJim7b8dUccRriguh86FZ+aHajY732Sm3EjjUqW9Sjv68Wx1M
         AhHmtz8ysbXKkA2phe3yzL4uZF0XesJYCXg/kqV4YpGE7l/xREh/U0VVssIBe87Bw/4i
         bnCiae6Oa1qTyT8J6DXgbvEDNvPpQQ/rZDU+wQAtFlfjHubQOeLIA2auxp4W+c2krNRC
         ksxFIMcOPZERGt43wAO+ZJX9vDyz9DJ/yqrhSQfw51AqTgxFwiO5Yki3xdGTVPSmAFgD
         F3UA==
X-Gm-Message-State: APt69E1/BQnike9HVA0q3TyFoFrtJ0LWZ5Il01Tbq1ndxuSwnL3ML85q
        zN25Xx+0al9zpHKuv/fecyRIqPOpAHjI5FFZE14=
X-Google-Smtp-Source: AAOMgpeqDeuJ+WX9XvzawN3Ed6bH+RnsqAvEhFjV63D/CkiH0FZVbN3GAo7idsvKNs4g7zvEf6awDDiWsmRn/cYrVE0=
X-Received: by 2002:aca:5e07:: with SMTP id s7-v6mr22819060oib.353.1530646345795;
 Tue, 03 Jul 2018 12:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180703123214.23090-1-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 3 Jul 2018 21:32:13 +0200
Message-ID: <CA+7wUsykjQkSHshNNVJaZJ4d_U9Q4fhaoRaNOTHhjoj43xRPLg@mail.gmail.com>
Subject: Re: [PATCH 00/14] dma-jz4780 improvements
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     vkoul@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        dansilsby@gmail.com, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Tue, Jul 3, 2018 at 2:32 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi,
>
> This set of patches by myself and Daniel extends the dma-jz4780 driver
> to support other SoCs (JZ4770, JZ4740, JZ4725B).
>
> Some fixes are also included, for proper residue reporting, which fixes
> errors with ALSA.
>
> Finally, the last two patches update the devicetree bindings for the
> JZ4780 SoC and add a binding for the JZ4770 SoC.
>
> This patchset was tested on JZ4780, JZ4770 and JZ4725B, but was not tested
> on the JZ4740, so it would be fantastic if somebody could test it there.

For the entire series, everything works as expected on JZ4780 (Creator
CI20), including reading from sdcard.

Tested-by: Mathieu Malaterre <malat@debian.org>

> Regards,
> -Paul
>
