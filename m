Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 18:31:31 +0200 (CEST)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:57042 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816022Ab3DJQb3nI2Q4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Apr 2013 18:31:29 +0200
Received: by mail-ob0-f178.google.com with SMTP id ni5so600660obc.9
        for <linux-mips@linux-mips.org>; Wed, 10 Apr 2013 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DNwSDsxcDhqvkErKDq1pmSXAbLFi1cKZXPOIhGMyzKo=;
        b=R6c5r5akyi510aR1W1Xl0pvLZi1Pgh9Rbm7Jo7G9lpY7/fQk4Oa+QkbpSmTFnt9K5V
         35Skv7YbvAMJ1voLWdm2sjtdyMrCywOfhuyOouidTZlO5abnFh0tr4f8H25DugBsyyKY
         offnRWSjcMjEODmYJp1dk1hqlkY0zBPvLL6sOFdd5k8DftMp9FOwt7jWTGtZ1W57TRu0
         iTQ+2ntirkHzkICG5z3Cw0VPTo/f1ol5qvQ3cq616YN12kNXlDsCxkw6vprp78OSQifG
         udk5OgvEjVuV2Gu+QuE1XBUnMKPIHDdJA/j4k2CytOeokSiGHRkNvGPfJgXcwkfwmRKE
         0FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=DNwSDsxcDhqvkErKDq1pmSXAbLFi1cKZXPOIhGMyzKo=;
        b=SyLhjNeNo8oxotUFiGbSFD4IdedKy9iZUSbk1XwA2LAnuMIMrUXHvNP/7m+03MRIv9
         dX+iAhBQO4NfsA6MltRqxaPmQi2ukESV0Ys80BwSrF/61LDIPNaZzVaCk7iRmgQi63XV
         L5i90//ttcbeIgUV76LdHkjPiVp5rOaNXHzNd1pzxY+dsGUnQdz969L7NKbg2LnB8O5G
         8z1fJ0OgyIR/QFGlaUpE2Pv7VlBcCF37yaWVVhrgPBWxf7uTGgA12FQxTs4SnhKwocJR
         lJk3Qtk0S+sb94ZHRLbBlUpbpkakP94yo1qX7PfR+8A/XxuBiejwuWnNYb6xvnEwgFn5
         4aCg==
X-Received: by 10.60.173.144 with SMTP id bk16mr964218oec.103.1365611483506;
 Wed, 10 Apr 2013 09:31:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.102.68 with HTTP; Wed, 10 Apr 2013 09:31:02 -0700 (PDT)
In-Reply-To: <1365098483-26821-2-git-send-email-juhosg@openwrt.org>
References: <1365098483-26821-1-git-send-email-juhosg@openwrt.org> <1365098483-26821-2-git-send-email-juhosg@openwrt.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 10 Apr 2013 10:31:02 -0600
Message-ID: <CAErSpo4ih-Kgp4LxX1MDodac-eoPo=Mu1d6ex8oNnaEEc_GQnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: implement pcibios_get_phb_of_node
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQlg+gZSePGNuR88p+hTeI51IaS6etWLFu2eVidxEUlh/m5Stv/JCJzPu4ZB1vIBAlvHjvhEOceopzkWuXp+Kt/YB1EjSkKvezxPZpe+vkojnpxmlK59dVwizFviKphW85TRW2MfD2T1W60cNe7V7vGVf+c4EAfeqmfPWbACc6ynsTedsRoXx1wDwIa+MuFe9Ip+c4gv9/beUA0y6TGOIWU+UCgfCQ==
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Thu, Apr 4, 2013 at 12:01 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> The of_node field of the device assigned to a
> PCI bus is used during scanning of the PCI bus.
> However on MIPS, the of_node field is assigned
> only after the bus has been scanned.
>
> Implement the architecture specific version of
> 'pcibios_get_phb_of_node'. Which ensures that the
> PCI driver core will initialize the of_node field
> before starting the scan.
>
> Also remove the local assignment of bus->dev.of_node,
> it is not needed after the patch.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

I removed the __weak annotation from include/linux/pci.h and applied
this patch to my pci/gabor-get-of-node.  Give it a try and make sure
it solves your problem.  If so, and Ralph approves, I can push both
for v3.10.  It should appear at
http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/gabor-get-of-node
soon.

Or if you prefer, you can take them through the MIPS tree.

Bjorn

> ---
>  arch/mips/pci/pci.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index 0872f12..594e60d 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -115,7 +115,6 @@ static void pcibios_scanbus(struct pci_controller *hose)
>                         pci_bus_assign_resources(bus);
>                         pci_enable_bridges(bus);
>                 }
> -               bus->dev.of_node = hose->of_node;
>         }
>  }
>
> @@ -169,6 +168,13 @@ void pci_load_of_ranges(struct pci_controller *hose, struct device_node *node)
>                 }
>         }
>  }
> +
> +struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
> +{
> +       struct pci_controller *hose = bus->sysdata;
> +
> +       return of_node_get(hose->of_node);
> +}
>  #endif
>
>  static DEFINE_MUTEX(pci_scan_mutex);
> --
> 1.7.10
>
