Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Oct 2017 15:08:32 +0100 (CET)
Received: from mail-vk0-x241.google.com ([IPv6:2607:f8b0:400c:c05::241]:49855
        "EHLO mail-vk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992215AbdJ3OIZd1ya5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Oct 2017 15:08:25 +0100
Received: by mail-vk0-x241.google.com with SMTP id t184so8162746vka.6;
        Mon, 30 Oct 2017 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3unQ+LFXUbU9vd9XNttCtj7OFIBA8nul1hJ7Jkp9pBY=;
        b=czZ9bpu5ehuJpmmy2ul7Jl5lAs9zLBi9ci9/7OfDhYix167DsxfdIHJeTsr3HrTuFS
         Hn/SS3REaG8SS3hBpl4MPmh6IdPjMNUI4aCVy+Asu0inpvVbbD40gmWG2F5q/5i0uy7U
         5vfKmexJBdOgzjCJwXyItt2+4fH2zjWTEyJXKor7eEJRvNPYpIHPQgsIfGBO6I/x9KT4
         8XhcuDWHBOjIP18MflN3xrwxCnH+SZzfr70pkDwDN3h2milEUo3PuM8UuC6sWvUvTy0w
         VPJG+KrDgLwwg2iUrmtAePmZz8CSTWTLteKdwY4TMrFSO6V05xjFlvtn848vYyATGxpq
         y8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3unQ+LFXUbU9vd9XNttCtj7OFIBA8nul1hJ7Jkp9pBY=;
        b=BJAXaM17Bs5QOpQCtG4NTKZflOymHvtmUVn8yhoQ6PeeEtSo9haFUaD3/KqjeywwZV
         qA9xpXpvp5c48lQUVQrib62N3NPyaSIjrsh+9vsPVZaE3F25VjhBZeYcH/8dJwy9yLbF
         CnWphVK4cg6HfzdnI0Ja6Vod6zOyA0LQEqKm6GZhLYJeQ7KU64h0UJakPZak5SUR2sdT
         /5qCD9q0N9HuLV0CCel1ohgs79eUcvOWiseAQNUFzll5z0hODlJUeGuBKJ/VUitgGpK8
         bIZdvutCneRE56uo252Q4Ec7q09rQIAs1g4e+/CIg40yperlqJ5K/hYmDvYubS5shP3t
         A3eA==
X-Gm-Message-State: AMCzsaXNHuh3Wjr2en4KzGzyroL3Nlg1OZpmZ1Vci9xypeMHey+Zcp7i
        cuIQrjiqR8kWtmir4hv13/4KBM23S1v54eBh1wo=
X-Google-Smtp-Source: ABhQp+TcPUkew8bMssDTRrqi0HJe0G19hMQwR98YgROMeQ6pdBpel58NZv2R4TaxCg5AsKnFH7A64pVwgj2XTmZIAjo=
X-Received: by 10.31.3.98 with SMTP id 95mr6839247vkd.82.1509372499282; Mon,
 30 Oct 2017 07:08:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.49.16 with HTTP; Mon, 30 Oct 2017 07:07:58 -0700 (PDT)
In-Reply-To: <1508868949-16652-3-git-send-email-jim2101024@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com> <1508868949-16652-3-git-send-email-jim2101024@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 30 Oct 2017 15:07:58 +0100
Message-ID: <CAOiHx=kYf0pOrSvRHuj6+cy6qzSuz23RfNbB8ADLy_dRwZhiAg@mail.gmail.com>
Subject: Re: [PATCH 2/8] PCI: host: brcmstb: add DT docs for Brcmstb PCIe device
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pci@vger.kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Hi,

On 24 October 2017 at 20:15, Jim Quinlan <jim2101024@gmail.com> wrote:
> The DT bindings description of the Brcmstb PCIe device is described.  This
> node can be used by almost all Broadcom settop box chips, using
> ARM, ARM64, or MIPS CPU architectures.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcmstb-pci.txt        | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pci.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pci.txt b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
> new file mode 100644
> index 0000000..49f9852
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
> @@ -0,0 +1,63 @@
> +Brcmstb PCIe Host Controller Device Tree Bindings
> +
> +Required Properties:
> +- compatible
> +  "brcm,bcm7425-pcie" -- for 7425 family MIPS-based SOCs.
> +  "brcm,bcm7435-pcie" -- for 7435 family MIPS-based SOCs.
> +  "brcm,bcm7445-pcie" -- for 7445 and later ARM based SOCs (not including
> +      the 7278).
> +  "brcm,bcm7278-pcie"  -- for 7278 family ARM-based SOCs.
> +

(snip)

> +
> +Example Node:
> +
> +pcie0: pcie@f0460000 {
> +               reg = <0x0 0xf0460000 0x0 0x9310>;
> +               interrupts = <0x0 0x0 0x4>;
> +               compatible = "brcm,pci-plat-dev";

This is not one of the valid compatibles mentioned above.


Regards
Jonas
