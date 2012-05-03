Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2012 21:30:30 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:46136 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903765Ab2ECTa0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 May 2012 21:30:26 +0200
Received: by yenr9 with SMTP id r9so424471yen.36
        for <multiple recipients>; Thu, 03 May 2012 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l1DlFo0gltURw60q+cQHRq36KSU7X6VDNin+NMLqdcA=;
        b=fWH+5Yz2ykhSVzx1E9G5//L9eHEUHR7ecMvFNi+4fQrWPrfkj+bi5HkNkej//7AVaD
         UN07Veza9IaOzjVqqiti58dCDXoggrS9LyY1fVVu8sZ1l0/VlmKG6aJ5lHdHhsRailJF
         sLlSsN/r9983N5mB/Mepj1TKx9EuWBFPXlGNvdanBtDsSUfAJvjpP7rF1iKRVDTG3oC4
         8b9f8NoqkIiya3ihe4n4r0hLTg9q3Z4kgfjVhe+qWHD7p4AXcUk2VWCWDrXBCIjGwK8+
         fxAV18JBgCL7A6i3Rt5P21fmUVXfs1FwLbeUlYSnoYaN6B86qAAyyKJ0JQalcPZ++fEg
         rjtg==
MIME-Version: 1.0
Received: by 10.50.178.71 with SMTP id cw7mr1227470igc.19.1336073420081; Thu,
 03 May 2012 12:30:20 -0700 (PDT)
Received: by 10.231.144.135 with HTTP; Thu, 3 May 2012 12:30:20 -0700 (PDT)
In-Reply-To: <1336066949-24546-1-git-send-email-blogic@openwrt.org>
References: <1336066949-24546-1-git-send-email-blogic@openwrt.org>
Date:   Thu, 3 May 2012 21:30:20 +0200
X-Google-Sender-Auth: Ucju-3sORwKMowOXn4NvoCS2MDA
Message-ID: <CAMuHMdWkd4YYKp1dBOFXyLFUT=Jc0iE3nb5OqbT6isQ977z1_w@mail.gmail.com>
Subject: Re: [PATCH 02/14] MIPS: pci: parse memory ranges from devicetree
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 33132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, May 3, 2012 at 7:42 PM, John Crispin <blogic@openwrt.org> wrote:
> Implement pci_load_of_ranges on MIPS. Due to lack of test hardware only 32bit
> bus width is supported. This function is based on the implementation found on
> powerpc.

There's no pci_load_of_ranges() in arch/powerpc/?

> +void __devinit pci_load_of_ranges(struct pci_controller *hose,
> +                               struct device_node *node)
> +{
> +       const __be32 *ranges;
> +       int rlen;
> +       int pna = of_n_addr_cells(node);
> +       int np = pna + 5;
> +
> +       pr_info("PCI host bridge %s ranges:\n", node->full_name);
> +       ranges = of_get_property(node, "ranges", &rlen);
> +       if (ranges == NULL)
> +               return;
> +       hose->of_node = node;
> +
> +       while ((rlen -= np * 4) >= 0) {
> +               u32 pci_space;
> +               struct resource *res = NULL;
> +               unsigned long long addr, size;

You better use u64, as that's what of_translate_address() and
of_read_number() return.

> +
> +               pci_space = ranges[0];

pci_space = be32_to_cpup(&ranges[0])

> +               addr = of_translate_address(node, ranges + 3);
> +               size = of_read_number(ranges + pna + 3, 2);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
