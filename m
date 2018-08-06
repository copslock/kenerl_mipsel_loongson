Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 17:16:29 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994619AbeHFPQZEh0Bz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Aug 2018 17:16:25 +0200
Received: from mail-qt0-f176.google.com (mail-qt0-f176.google.com [209.85.216.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F9F21A53;
        Mon,  6 Aug 2018 15:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568578;
        bh=bJVb7hhJZaZKGOrAQ3WlYb/R+37IkiZ71jK7OxKyzBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G8hvMWmFZJ/Vn86CkfPt7OSocrxeHHM4IWnozbkmVZ2ezn9k/arJMJ+kn4SYu06CJ
         +tNTXJNKjzgADOYWp90VcyPgnHudx0iQ1lXGVZCqZVWLcj6WZQ2kxUYuKFM8Q5Zr3H
         2QshlH24Lz0rATym/eah2T5bQ6mc1p5gRxjMi+50=
Received: by mail-qt0-f176.google.com with SMTP id b15-v6so14157989qtp.11;
        Mon, 06 Aug 2018 08:16:18 -0700 (PDT)
X-Gm-Message-State: AOUpUlE10A4bUqQQMaIV3j+4VW9aW8EPHnCGnrehq73xQSXj9vjldzdv
        PqSxx6zbZdy1/lqXHk1j9zwVOkYA971ifSZdFw==
X-Google-Smtp-Source: AAOMgpeWAstVrJqh0e89zXkpsiza/vVvDx8V25b/9cRwXe8aUXfq9EfjFHMTRLBjMexqUhWe7MkWnm9HZgnvVBz2928=
X-Received: by 2002:ac8:29a4:: with SMTP id 33-v6mr15426288qts.354.1533568577899;
 Mon, 06 Aug 2018 08:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-6-songjun.wu@linux.intel.com>
In-Reply-To: <20180803030237.3366-6-songjun.wu@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Aug 2018 09:16:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMZbDuUsqbg63P-pO4D_L6PHqhJqj2NXfu9xwmu3Rabw@mail.gmail.com>
Message-ID: <CAL_JsqLMZbDuUsqbg63P-pO4D_L6PHqhJqj2NXfu9xwmu3Rabw@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] dt-binding: MIPS: Add documentation of Intel
 MIPS SoCs
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin zhu <yixin.zhu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65413
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

On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>
> From: Hua Ma <hua.ma@linux.intel.com>
>
> This patch adds binding documentation for the
> compatible values of the Intel MIPS SoCs.
>
> Signed-off-by: Hua Ma <hua.ma@linux.intel.com>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>
> Changes in v2:
> - New patch split from previous patch
> - Add the board and chip compatible in dt document
>
>  Documentation/devicetree/bindings/mips/intel.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/intel.txt

Reviewed-by: Rob Herring <robh@kernel.org>
