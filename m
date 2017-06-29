Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 01:18:02 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:51538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993981AbdF2XRzoKDeP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Jun 2017 01:17:55 +0200
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com [209.85.161.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5476822B6A
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 23:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5476822B6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
Received: by mail-yw0-f172.google.com with SMTP id j11so43036272ywa.2
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 16:17:54 -0700 (PDT)
X-Gm-Message-State: AKS2vOyfez91z3PVKjXTfT8x+DhBF8y4raqcLUb1nH7LqS9saNm7/ILb
        6CkH2SrZtOggm5xOXd7PjkmxMswB7A==
X-Received: by 10.129.159.78 with SMTP id w75mr13780414ywg.238.1498778273598;
 Thu, 29 Jun 2017 16:17:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.82.66 with HTTP; Thu, 29 Jun 2017 16:17:33 -0700 (PDT)
In-Reply-To: <1498664922-28493-4-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com> <1498664922-28493-4-git-send-email-aleksandar.markovic@rt-rk.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Jun 2017 18:17:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHN90TbOtcvr8CjLqpy9zokzKX1UgoRu+j=uH37-Xi6A@mail.gmail.com>
Message-ID: <CAL_JsqJHN90TbOtcvr8CjLqpy9zokzKX1UgoRu+j=uH37-Xi6A@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] Documentation: Add device tree binding for
 Goldfish PIC driver
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58929
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
> Add documentation for DT binding of Goldfish PIC driver. The compatible
> string used by OS for binding the driver is "google,goldfish-pic".

This isn't even supported in Google's common kernel tree. If it's not
important enough for it, why should it be for mainline kernel?

To put it another way, why does goldfish need a special interrupt
controller. Just use one of the many that are already supported in the
kernel and emulated by qemu.

Same comments apply to the RTC patch.

Rob
