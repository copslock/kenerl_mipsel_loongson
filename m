Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 17:47:44 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:38058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27033472AbcEWPrkTsiXE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 17:47:40 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 228BB203C2;
        Mon, 23 May 2016 15:47:38 +0000 (UTC)
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com [209.85.161.181])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7584203A5;
        Mon, 23 May 2016 15:47:36 +0000 (UTC)
Received: by mail-yw0-f181.google.com with SMTP id x189so174494671ywe.3;
        Mon, 23 May 2016 08:47:36 -0700 (PDT)
X-Gm-Message-State: ALyK8tIwIUjRKONCtsdlYkwxEdnokSBAUraS20d5ADJmoGXfA/h9jsSJDALz4xWcf8gs681Q+OafwG2NC5IALg==
X-Received: by 10.129.153.72 with SMTP id q69mr4464134ywg.116.1464018456313;
 Mon, 23 May 2016 08:47:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.107.135 with HTTP; Mon, 23 May 2016 08:47:16 -0700 (PDT)
In-Reply-To: <1464003540-13009-1-git-send-email-antonynpavlov@gmail.com>
References: <1464003540-13009-1-git-send-email-antonynpavlov@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 23 May 2016 10:47:16 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+CC3p0hPTtPB=RsL9O7sqX1ZXKkoFk0dOj0gvvKifAkw@mail.gmail.com>
Message-ID: <CAL_Jsq+CC3p0hPTtPB=RsL9O7sqX1ZXKkoFk0dOj0gvvKifAkw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: devicetree: fix cpu interrupt controller node-names
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53615
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

On Mon, May 23, 2016 at 6:39 AM, Antony Pavlov <antonynpavlov@gmail.com> wrote:
> Here is the quote from [1]:
>
>     The unit-address must match the first address specified
>     in the reg property of the node. If the node has no reg property,
>     the @ and unit-address must be omitted and the node-name alone
>     differentiates the node from other nodes at the same level
>
> This patch adjusts MIPS dts-files and devicetree binding
> documentation in accordance with [1].
>
>     [1] Power.org(tm) Standard for Embedded Power Architecture(tm)
>         Platform Requirements (ePAPR). Version 1.1 – 08 April 2011.
>         Chapter 2.2.1.1 Node Name Requirements

FYI, you can reference "the Devicetree Spec" now: devicetree.org

Acked-by: Rob Herring <robh@kernel.org>

> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/mips/cpu_irq.txt | 2 +-
>  arch/mips/boot/dts/ingenic/jz4740.dtsi             | 2 +-
>  arch/mips/boot/dts/ralink/mt7620a.dtsi             | 2 +-
>  arch/mips/boot/dts/ralink/rt2880.dtsi              | 2 +-
>  arch/mips/boot/dts/ralink/rt3050.dtsi              | 2 +-
>  arch/mips/boot/dts/ralink/rt3883.dtsi              | 2 +-
>  arch/mips/boot/dts/xilfpga/nexys4ddr.dts           | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
