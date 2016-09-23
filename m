Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 14:43:21 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991932AbcIWMnOFfi81 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Sep 2016 14:43:14 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 33BE120445;
        Fri, 23 Sep 2016 12:43:09 +0000 (UTC)
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com [209.85.213.178])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3566920431;
        Fri, 23 Sep 2016 12:43:08 +0000 (UTC)
Received: by mail-yb0-f178.google.com with SMTP id u125so66007505ybg.3;
        Fri, 23 Sep 2016 05:43:08 -0700 (PDT)
X-Gm-Message-State: AE9vXwNhlw8DKZ4ViOnB8vYtFopc2Fj8u7JbF5jO2f90ExC9WiI9MSNM0AUoFVE+srdUEXt6CMrwoamqmwLHiw==
X-Received: by 10.37.89.137 with SMTP id n131mr5648865ybb.59.1474634587481;
 Fri, 23 Sep 2016 05:43:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.212.78 with HTTP; Fri, 23 Sep 2016 05:42:47 -0700 (PDT)
In-Reply-To: <20160919212132.28893-8-paul.burton@imgtec.com>
References: <20160919212132.28893-1-paul.burton@imgtec.com> <20160919212132.28893-8-paul.burton@imgtec.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 23 Sep 2016 07:42:47 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+mFreBhUeT9b2J07jo0kmXwrJdzAqpd-8_Tcrfa5i2QA@mail.gmail.com>
Message-ID: <CAL_Jsq+mFreBhUeT9b2J07jo0kmXwrJdzAqpd-8_Tcrfa5i2QA@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] of/platform: Probe "isa" busses by default
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55249
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

On Mon, Sep 19, 2016 at 4:21 PM, Paul Burton <paul.burton@imgtec.com> wrote:
> Since commit 44a7185c2ae6 ("of/platform: Add common method to populate
> default bus") platforms calling of_platform_bus_probe from an initcall
> is either a rather unsafe race with of_platform_default_populate_init or
> a no-op. The MIPS Malta board needs to probe devices under an ISA bus,
> which we do support in the of_busses array but until now haven't
> included in of_default_bus_match_table.
>
> Add an "isa" entry to of_default_bus_match_table such that we can just
> accept use of of_platform_default_populate_init & remove the
> Malta-specific match table in a later patch.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Acked-by: Rob Herring <robh@kernel.org>
