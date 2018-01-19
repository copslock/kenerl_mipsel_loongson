Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2018 20:20:44 +0100 (CET)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35507 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990754AbeASTUel24U6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jan 2018 20:20:34 +0100
Received: by mail-oi0-f68.google.com with SMTP id b11so1849747oif.2;
        Fri, 19 Jan 2018 11:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GxRzjEcH5yR3b2HUZZipNIlJddZVL0yVORQ20ja45fg=;
        b=FaFtP1FskbLvFTeJVAa0qlOINgkj9jWgujFqRQS9q6FabtwcOItWsHc86qVZ06GV/A
         Jn/JXEH9f22nw5Bpg1m3SZ3OcF219S66ooEhYrdO5mKjLpwuPpki3fLCdjbNMTTZTtqd
         8LZBYt5vSK7ZJzSEEPFJDkVtwlXM9IhVxeHybxX+mkPSeLZQ6y5gWGTK6kQrKucyBxi8
         CKNZsUoEpErucddDEyqyP12uv+MekRS04kKnRQTYUldlIJnqCS3PYl4Zb2adg8i38G4f
         WO88tg8DTRzy+PWCfx2Mz18CuTVtJF66vF+6QJQZ9oQG5MTHF/gwxWuYGXQXEMM4aUaS
         ZdYw==
X-Gm-Message-State: AKwxytezthZo+OIQNu5Md2nRDGx+vpNMTfHabiz/eMPBexUCNl+Xi5D3
        DayjrhUZoeYmAddmgPnOUw==
X-Google-Smtp-Source: ACJfBovpwF61Ph+pVi+YQJi84ZZ1je6tSW7A0kkC3lWjMuN63RXaaRGJ+aWpfcOyO36l51P8kMLKow==
X-Received: by 10.202.84.146 with SMTP id i140mr5797840oib.176.1516389628294;
        Fri, 19 Jan 2018 11:20:28 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id c32sm4714997otb.79.2018.01.19.11.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jan 2018 11:20:27 -0800 (PST)
Date:   Fri, 19 Jan 2018 13:20:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/8] dt-bindings: pci: Add DT docs for Brcmstb PCIe
 device
Message-ID: <20180119192026.b3bhiercl45u2mga@rob-hp-laptop>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-3-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516058925-46522-3-git-send-email-jim2101024@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Mon, Jan 15, 2018 at 06:28:39PM -0500, Jim Quinlan wrote:
> The DT bindings description of the Brcmstb PCIe device is described.  This
> node can be used by almost all Broadcom settop box chips, using
> ARM, ARM64, or MIPS CPU architectures.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcmstb-pcie.txt       | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt

I acked v3. Please add acks when posting new versions.
