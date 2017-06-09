Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2017 15:22:03 +0200 (CEST)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33439 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993155AbdFINV4JZsTO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jun 2017 15:21:56 +0200
Received: by mail-oi0-f66.google.com with SMTP id k145so3311444oih.0
        for <linux-mips@linux-mips.org>; Fri, 09 Jun 2017 06:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lvUMSQYogA330MRgQGWnD81wWgwFaC426xDe2uyCZkE=;
        b=AUX8MOsWCs0c1QKkQ0VbHz38BB6rGBbH4RXdVLdK52aipwPbLr1yYLgr74g6cDrTX1
         MuEI8fNl2YH7b8hUk3a93YzGlDlzXSdPk41KKLL5mGByzOUI0PkRaXLvTONsQK8bWRRy
         mddNIysQdUflX3bFPCJHfnQnFF0xb/XuM2bKu2AUBzX8Hckc70+/C3OzWLtxgK3dDN9d
         yRmRalADLH6bHz78Z3n94nW5JDyu+MO9YCnDLGc8WEw1s6XA6ypOAM5ZoSmWVbFSRLRS
         QoI8giSuTV5As9ttPF6bjIkGLMsnzUVwBKIM8WG9WR4S+Q8uUVdabxGJXBjBx59gWcUj
         Cq8Q==
X-Gm-Message-State: AODbwcAEKfDFQkwFevcaWwsDNyakNrIHdmOZ3QDBhECDKwsNyoZ8NAMv
        uUnCkT8S4hJocQ==
X-Received: by 10.202.193.135 with SMTP id r129mr18938400oif.135.1497014510132;
        Fri, 09 Jun 2017 06:21:50 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id q36sm472715otg.7.2017.06.09.06.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Jun 2017 06:21:49 -0700 (PDT)
Date:   Fri, 9 Jun 2017 08:21:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, Eric Dumazet <edumazet@google.com>,
        Jarod Wilson <jarod@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/7] dt-bindings: net: Document Intel pch_gbe binding
Message-ID: <20170609132149.uihv7qnr7zvodm6f@rob-hp-laptop>
References: <20170602234042.22782-1-paul.burton@imgtec.com>
 <20170605173136.10795-1-paul.burton@imgtec.com>
 <20170605173136.10795-4-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605173136.10795-4-paul.burton@imgtec.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58382
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

On Mon, Jun 05, 2017 at 10:31:32AM -0700, Paul Burton wrote:
> Introduce documentation for a device tree binding for the Intel Platform
> Controller Hub (PCH) GigaBit Ethernet (GBE) device. Although this is a
> PCIe device & thus largely auto-detectable, this binding will be used to
> provide the driver with the PHY reset GPIO.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jarod Wilson <jarod@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: netdev@vger.kernel.org
> 
> ---
> 
> Changes in v4: None
> 
> Changes in v3:
> - New patch.
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/net/pch_gbe.txt | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pch_gbe.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/pch_gbe.txt b/Documentation/devicetree/bindings/net/pch_gbe.txt
> new file mode 100644
> index 000000000000..5de479c26b04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pch_gbe.txt
> @@ -0,0 +1,25 @@
> +Intel Platform Controller Hub (PCH) GigaBit Ethernet (GBE)
> +
> +Required properties:
> +- compatible:		Should be the PCI vendor & device ID, eg. "pci8086,8802".
> +- reg:			Should be a PCI device number as specified by the PCI bus
> +			binding to IEEE Std 1275-1994.
> +- phy-reset-gpios:	Should be a GPIO list containing a single GPIO that
> +			resets the attached PHY when active.
> +
> +Example:
> +
> +	eg20t_mac@2,0,1 {

ethernet@...

Your unit address is not valid for PCI[1]. You should not have the bus 
number (2) as there should be a bridge node that defines the bus number.

Rob

[1] http://www.o3one.org/hwdocs/openfirmware/pci_supplement_2_1.pdf
