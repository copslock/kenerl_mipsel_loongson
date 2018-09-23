Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Sep 2018 08:20:40 +0200 (CEST)
Received: from mail-ot1-x32a.google.com ([IPv6:2607:f8b0:4864:20::32a]:33847
        "EHLO mail-ot1-x32a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990396AbeIWGUfbakyL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Sep 2018 08:20:35 +0200
Received: by mail-ot1-x32a.google.com with SMTP id i12-v6so16990496otl.1
        for <linux-mips@linux-mips.org>; Sat, 22 Sep 2018 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fGMZisMSU0oco4B/fQ3Dg0oB9MsTWPF8Oxorw6sa2hc=;
        b=Xiw4tcBwY/CgGsieXcImtcImbhxwDrXUuNztO924yObeNy1EVYQzrLBz+bGvE5lXWB
         piDlEReWFXK9cPZEXj8v1HYDXHu0VdTk1JrpdjkSbT+xBCh3aKkcr0i7oidQmXP1ArbE
         tsrrLbxVEb3tKnVtdFhGUoxcnrOiMuGug4B/r187zpbefBVO5sdzysr8wdbTu5x+Ie4f
         lVYc6VAydJP0Shc0lRf/Su5WMzsAo+o/lnM4O6C8kTcPq7dLX97Xq5ZCXmxxtzrcT/oV
         Zo5AivDYdfM4sFwPj1OEjDRH56EGTY9w2u7KrJf+yb1UjY+fMH49e5U3ZgC2+Cl4BHOC
         9cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fGMZisMSU0oco4B/fQ3Dg0oB9MsTWPF8Oxorw6sa2hc=;
        b=OLzp5ho64Hz1LqSArROlYxNmWdQp1rFM25fxDFq09+7g7GhgNK5RNSrZUiZWpfy9QD
         ZiFIv+cUay6wo9l1/RYjQMQtB/s1wbCPKlLvVquDXoXnH2jLofzYi9o6Idv3PVh0yES5
         gmpo0Iy6aE77gzCzqEI4xifxZQtqMvzHzYaZe5hvsUqLkxPVPGjZTdQLQyZ+QXaWyP4u
         yfvFC80095YL/yMlmLX04XCcHbFkt29y6oDeKFevAgapOLIwS2eknFOZdUrv22NKd9q/
         +Aw4JOFjrzOKeze/lCibozGVQGumKES4WHnkD5ZwPd0xWpBQMSr81YbPtQmE0DunL3Hz
         QFPQ==
X-Gm-Message-State: ABuFfohe8P9vw4Tu5jtgZn8Mi+0WgUVdyl+vZsx8qJeMnX+Am5hw5qdN
        HMZw5suNTmsqLE6Uy9nUl1hHRgke161ONe/vFbo=
X-Google-Smtp-Source: ACcGV630rkyUWkV0Sh+NDjjtdZ/TPMNx7wLqxBvJ+GIIW1gAWoeaCy98kjfRDg2xkaHrzdxTkPMlCBwVFP6/WUgILv4=
X-Received: by 2002:a9d:5cc3:: with SMTP id r3-v6mr3105936oti.301.1537683629107;
 Sat, 22 Sep 2018 23:20:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:521f:0:0:0:0:0 with HTTP; Sat, 22 Sep 2018 23:20:28
 -0700 (PDT)
In-Reply-To: <8fd595af-53fa-c100-c369-8c7a30eba8e3@gmail.com>
References: <8fd595af-53fa-c100-c369-8c7a30eba8e3@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 23 Sep 2018 08:20:28 +0200
Message-ID: <CAMhs-H-CM3bb9fg2eX6G_534bmuQYcoFa+pJSuNeArXLSXO4=Q@mail.gmail.com>
Subject: Re: mt7621/mt7628 PCIe linux driver
To:     Petr Cvek <petrcvekcz@gmail.com>
Cc:     ryder.lee@mediatek.com, blogic@openwrt.org,
        linux-mediatek@lists.infradead.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <sergio.paracuellos@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergio.paracuellos@gmail.com
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

Hi Petr,

On Sat, Sep 22, 2018 at 11:06 PM, Petr Cvek <petrcvekcz@gmail.com> wrote:
> Hello,
>
> I'm trying to play with mt7628 PCIe (and it's old driver mt7620), but
> the system keeps freezing. It is probably because of bus master access
> of my PCIe cards but I don't see any memory access controls for PCIe <->
> RAM in the datasheet. The same problem is with MSI. It seems the root
> complex supports MSI (it has an MSI capability field), but there isn't
> any mention in the MT7628 datasheet too. As it seems the MT7628 PCIe is
> based on MT7621 PCIe, I went for an MT7621 datasheet, but sadly in the
> datasheet the PCIe section is missing completely.

AFAIK, MT7628 should be covered with mt7620 driver. The source code is in
arch/mips/pci/pci-mt7620.c. For initialization in really depends on
the "ralink_soc"
variable exported in arch/mips/ralink/prom.c.

You have to figure out why and where is really freezing. Does a clean kernel
boots and success on setting up PCI? A 'dmesg' would be helpful.

>
> Does anybody have a working MT7621/28 bus master setup or a more
> completed datasheet? I would like to get some information for fixing the
> mt7620 PCIe driver. It is possible the MSI/bus master is controlled by
> the undocumented bridge registers (in the pci-mt7621 they controls the
> manual oscillator settings, I've found a link quality register at
> 0x101490c4) or in a PCI config space of the root complex (around 0x700
> offset). If you have a working SoC with MSI/bus mastering (= mem access
> from card), can you send me the dump of there spaces?

The datasheet for the mt7620 contains information about PCI registers.
Linux initializes the
pci topology but master bit of command registers for endpoints is
disabled and is mission of final
card driver to enable it in order to allow memory accessing to the card.

Hope this helps.

>
> Thanks
>
> best regards,
> Petr

Best regards,
    Sergio Paracuellos
