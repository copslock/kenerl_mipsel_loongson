Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2018 04:38:48 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:38864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990393AbeEBCikQXaV2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 May 2018 04:38:40 +0200
Received: from mail-qt0-f178.google.com (mail-qt0-f178.google.com [209.85.216.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CEF12376A;
        Wed,  2 May 2018 02:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525228713;
        bh=jrSMXAllj1OIJVopA2yYtw9H2oTCAvcbpc+FhKteNkg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VNm1sTTtRoJxjvFvPPTU4r/JuzguCk23HgQYSDgRtduRIgJLuKK6TswACsyztjjOJ
         1HM8Fav5/hX4yB1BALYAxOuKRHUds177HV5MH5m5c/mqyFWd4m7qGOBYnc/zV9sl/Q
         HR10g2FAmqwJcM2ICxsLSfnrT7p3qk+sqMU0GaQQ=
Received: by mail-qt0-f178.google.com with SMTP id f5-v6so3331644qth.2;
        Tue, 01 May 2018 19:38:33 -0700 (PDT)
X-Gm-Message-State: ALQs6tBDNvMz1zudu7yYMmGeTWd/zyVS92ttydnfZACy8WLMd1HigHKE
        kj5Ni5x5WWyp4hdbPQ13iS5Yh/sV/T5cB+FMwA==
X-Google-Smtp-Source: AB8JxZq+3zAUWKrOSw3HYEEtatBUT6qMrX5hINk2NHLVjTCfHcB3DfaP/3MdyQPvAKmC+Aq4ls/rAtZdNbnAQhuw3nQ=
X-Received: by 2002:a0c:b351:: with SMTP id a17-v6mr14918615qvf.27.1525228712636;
 Tue, 01 May 2018 19:38:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.155.2 with HTTP; Tue, 1 May 2018 19:38:12 -0700 (PDT)
In-Reply-To: <20180328011435.29776-1-robh@kernel.org>
References: <20180328011435.29776-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 1 May 2018 21:38:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJmiUKGRGnc4SfifW4rt7Pb6Mkyku4Y3UAAxQUa1uazAw@mail.gmail.com>
Message-ID: <CAL_JsqJmiUKGRGnc4SfifW4rt7Pb6Mkyku4Y3UAAxQUa1uazAw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: use memblock instead of rescanning the FDT
To:     James Hogan <jhogan@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63837
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

On Tue, Mar 27, 2018 at 8:14 PM, Rob Herring <robh@kernel.org> wrote:
> There's no need to scan /memory nodes twice. The DT core code scans
> nodes and adds memblocks already, so we can just use
> memblock_phys_mem_size() to see if we have any memory already setup.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: John Crispin <john@phrozen.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/ralink/of.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)

Ping. Can MIPS maintainers please pick this up.

Rob
