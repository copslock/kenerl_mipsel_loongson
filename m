Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 19:27:18 +0200 (CEST)
Received: from mail-io0-x232.google.com ([IPv6:2607:f8b0:4001:c06::232]:48044
        "EHLO mail-io0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdJTR1LrwKxI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2017 19:27:11 +0200
Received: by mail-io0-x232.google.com with SMTP id h70so13972667ioi.4;
        Fri, 20 Oct 2017 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YeGKHOPNC978modBHj9dnaWCMMkgU6or3S4tCRZ+jMA=;
        b=DaQesRiht9bOmI9Z/C7+Cd6gi35dn9LpppOUFZxsnQAXZPQUll9aDVv0m6Tua1n85t
         o9HvaVft1ZA4nbcNYf1Uh6ITK8V5sCT+IdbLQNVYyPJsAVQ3AldHG0/21m+0bl8UwKqy
         saPqf/ehhc2YId0WW3Ib5/tE2r7yToKqzTBRjBbgYVP0ARUVnaCLgfZcjlyQHqFK1Le/
         v7cTIhe+4EmIw7Ea26OHjVUGcP8dn8MsTcO6cy7dexmAIZHbk2HPXz7jo82Ss6iRpY98
         4WXEpnQDcVyrJiI0074zVBEliazUq3AssWj7tmeY4L2BwL9F3ZCbzCWp/q1wpUDZQOqj
         zDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YeGKHOPNC978modBHj9dnaWCMMkgU6or3S4tCRZ+jMA=;
        b=D2oVmHpV4e7pKqNzKM7XbOzEKX/QrxIFswEoTbDFH/UUMvhX0b0fqJR31ghgg6FbkH
         flLbUZTG0q0HUrmILDkUxd/OqUqthw/V0tu07I+l2Mn/gH03x8FQklJyj/hEtasdfHDu
         zyVV4dAvhWRCnXqhfTXgzCOw5es/tvfPxfZAcP+GghJ1qYKGf0/ERXSZRaKTL4t9CsAK
         OoAJsUCXOosx3hN+Vk61NVb/hTEz4vTq+X4TeIrl7q22NQmiSS7gNDCopf8wthL7OgNq
         koUesnGxYy8UQBSZKvMtfGHQnKn++y2QjqepMuh4nl0buYn3uB//Iatwaq77OxP15x1O
         pSTw==
X-Gm-Message-State: AMCzsaWEtTawckcU62OJ5mydIT6FkGEpykTxpjKmhLACAXaC2fyjk6Vr
        4x69LiSPBw5onE6nc/8eT50=
X-Google-Smtp-Source: ABhQp+Qc+V1d3543pM3P6MqcX8Su8YuD01gd59Bu5X3/q9lOYI3gnXGUt9RGrG/YRGwlZnsk3qUF9A==
X-Received: by 10.107.69.7 with SMTP id s7mr7731483ioa.108.1508520425452;
        Fri, 20 Oct 2017 10:27:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:1600:f801:ca45:e730:e39f])
        by smtp.gmail.com with ESMTPSA id i201sm710278ita.32.2017.10.20.10.27.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 20 Oct 2017 10:27:04 -0700 (PDT)
Date:   Fri, 20 Oct 2017 10:27:01 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/9] PCI: host: brcmstb: add DT docs for Brcmstb PCIe
 device
Message-ID: <20171020172701.GA105780@google.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-3-git-send-email-jim2101024@gmail.com>
 <20171017202418.ykve2o4zvuwxjdgj@rob-hp-laptop>
 <CANCKTBt_gUF8qAEuhS1336Uce+WdP_98ApZhv1sxZgJsWGoiGQ@mail.gmail.com>
 <CAL_JsqLoqB0GF201ofJrjdYH8B-Ca=hGBtE4=VcrBxS7M52mVQ@mail.gmail.com>
 <9fae640f-a9da-90bf-01d2-c62131611ef9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fae640f-a9da-90bf-01d2-c62131611ef9@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Thu, Oct 19, 2017 at 02:58:55PM -0700, Florian Fainelli wrote:
> On 10/19/2017 02:49 PM, Rob Herring wrote:
> > On Tue, Oct 17, 2017 at 5:42 PM, Jim Quinlan <jim2101024@gmail.com> wrote:
> >> On Tue, Oct 17, 2017 at 4:24 PM, Rob Herring <robh@kernel.org> wrote:
> >>> This is not the regulator binding. Use the standard binding.
> >>>
> >> The reason we do it this way is because the PCIe controller does not
> >> know or care what the names of the supplies are, or how many there
> >> will be.  The list of regulators can be different for each board we
> >> support, as these regulators turn on/off the downstream EP device.
> >> All the PCIe controller does is turn on/off this list of regulators
> >> when booting,resuming/suspending.
> >>
> >> An alternative would have the node specifying the standard properties
> >>
> >> xyz-supply = <&xyz_reg>;
> >> abc-supply = <&abc_reg>;
> >> pdq-supply = <&pdq_reg>;
> >> ...
> >>
> >> and then have this driver search all of the properties in the PCIe
> >> node for names matching /-supply$/, and then create a list of phandles
> >> from that.  Is that what you would like?
> > 
> > Really, you should have child nodes of the PCIe devices and have the
> > supplies in there.
> 
> While that would be technically more correct this poses a number of issues:
> 
> - there is precedence in that area, and you already Acked binding
> documents proposing the same thing:
> 	* Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt (commit
> c26ebe98a103479dae9284fe0a86a95af4a5cd46)
> 	* Documentation/devicetree/bindings/pci/rockchip-pcie.txt (commit
> 828bdcfbdb98eeb97facb05fe6c96ba0aed65c4a and before)

I can actually speak to the Rockchip binding a bit :)

It actually has a mixture of true controller regulators (e.g., the 1.8V
and 0.9V regulators power analog portions of the SoC's PCIe logic) and
controls for the PCIe endpoints (e.g., 12V). Additionally, some of these
have been misused to represent a little of both, since the regulator
framework is actually quite flexible ;)

That may or may not help, but they are at least partially correct.

The Freescale one does look like it's plainly *not* about the root
controller.

Also, those rails *are* all fairly well defined by the various PCIe
electromechanical specifications, so isn't it reasonable to expect that
a controller can optionally control power for 1 of each of the standard
power types? Or do we really want to represent the flexibility that
there can be up to N of each type for N endpoints?

As a side note: it's also been pretty tough to get the power sequencing
requirements represented correctly for some PCIe endpoints. I've tried
to make use of this previously, but the series took so long (>1 year and
counting!) my team lost interest:

[PATCH v16 2/7] power: add power sequence library
https://www.spinics.net/lists/linux-usb/msg158452.html

It doesn't really solve all of this problem, but it could be worth
looking at.

> (which may indicate those should also be corrected, at the possible
> expense of creating incompatibilities)

If a better way is developed, we can always augment the bindings. The
current bindings aren't that hard to maintain as "deprecated backups."

> - there is a chicken and egg problem, you can't detect the EP without
> turning its regulator on, and if you can't create a pci_device, you
> certainly won't be able to associate it with an device_node counterpart

That's definitely a major problem driving some of the current bindings.
We're just not set up to walk the child devices if we can't probe them.

> - PCIe being dynamic by nature, can you have "wildcard" PCIE EP DT node
> that would be guaranteed to match any physically attached PCIE EP which
> is discovered by the PCI bus layer (and then back to issue #2)

Technically, you *can* walk the DT (i.e., 'device_node's) without having
pci_dev's for each yet. Something like of_pci_find_child_device() would
do it. But that still seems kind of wonky, and it's currently neither
precise enough nor flexible enough for this, I don't think.

Brian

> If we can solve #2 and #3, it would be reasonable to move the regulator
> to a PCIE EP node. Ideally, we may want the generic PCI layer to be
> responsible for managing regulators within pci_enable_device() and
> pci_disable_device() for instance?
> 
> > 
> > The driver could do what you describe, but you've still got to define
> > the names here.
> > 
> > Rob
> > 
> 
> 
> -- 
> Florian
