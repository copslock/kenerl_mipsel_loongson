Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 01:13:13 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:51114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993981AbdF2XNDl0hEP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Jun 2017 01:13:03 +0200
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E957822BDC
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 23:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E957822BDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
Received: by mail-yw0-f169.google.com with SMTP id j11so43006185ywa.2
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 16:13:01 -0700 (PDT)
X-Gm-Message-State: AKS2vOwH9joyCg0LxlGm75w93oLGP4YmASJL8H8NMXnjrDZxiRo9kwEq
        VmG8TCpqG4KQi1742EOfnj4F0Iz/Yg==
X-Received: by 10.129.87.197 with SMTP id l188mr14995978ywb.268.1498777981208;
 Thu, 29 Jun 2017 16:13:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.82.66 with HTTP; Thu, 29 Jun 2017 16:12:40 -0700 (PDT)
In-Reply-To: <1498664922-28493-7-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com> <1498664922-28493-7-git-send-email-aleksandar.markovic@rt-rk.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Jun 2017 18:12:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+m-g__T34W2-7ddAF9ehH1woT3WfuxuDnHQMfzrg86Hg@mail.gmail.com>
Message-ID: <CAL_Jsq+m-g__T34W2-7ddAF9ehH1woT3WfuxuDnHQMfzrg86Hg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] Documentation: Add device tree binding for
 Goldfish FB driver
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58928
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

On Wed, Jun 28, 2017 at 10:46 AM, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>
> Add documentation for DT binding of Goldfish FB driver. The compatible
> string used by OS for binding the driver is "google,goldfish-fb".
>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  .../bindings/goldfish/google,goldfish-fb.txt           | 18 ++++++++++++++++++

bindings/display/

I don't know that this should even go upstream. There's no upstream
qemu support for goldfish-fb. Maybe this is a minor driver change, but
FB drivers are being replaced with DRM drivers. And the time for AOSP
supporting framebuffer drivers is limited I think with HWC2 and
explicit fence support in DRM.

Rob
