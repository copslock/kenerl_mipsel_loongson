Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2017 06:07:32 +0100 (CET)
Received: from mail-ot0-f194.google.com ([74.125.82.194]:47774 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991986AbdKPFHYyoSY4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Nov 2017 06:07:24 +0100
Received: by mail-ot0-f194.google.com with SMTP id s4so12331517ote.4;
        Wed, 15 Nov 2017 21:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OGT1RUlZe82NvocA7mJasUq7MMk2dZSp/f12zTZK948=;
        b=CG8kh8GmnKELbQyZwUyiYMcand9xyzbbcdWgyhhvpbWSwnEt+JfIsuEZI2TNQwN4m2
         hLNMXtEDJvi9amPMj0GJdyW+p/DhqhnNjsWWseQukz1VcO6TJChDb/QZLRD2UQmmLAbp
         n/vnGQDT1Oxrfmjbuz4QTrbNlzJS9VilpP1+Q051uVLsvpLLKp2kyOL+grG2r6acuE88
         7H0FUc7+C1Fgqtn1pWMmlVOOj8YXBkVr8GuKV+GgmeoHXEWFAtgWlTyaMpGOgZJrBI1a
         jRhgQ725KLpXf9t6z1CAutAWBPFb4Q84ozQuFAdEz5UZWbePfQ21gjyDhfmA8kabQ3uj
         zwbw==
X-Gm-Message-State: AJaThX6GZpw6S4hyDS4nlHH+niG+XGBUN+n034oJm26PqeQQkSIiudWQ
        dPW4jmzVNigq1hJkFBkYNQ==
X-Google-Smtp-Source: AGs4zMYqn8ms2H5ogEK0g5jZ0z9WqPVkXXGjb84Zbctss+RbWWwRX5equtaQ/QwNoldsAD86Q0ZPzA==
X-Received: by 10.157.17.52 with SMTP id g49mr332369ote.187.1510808838794;
        Wed, 15 Nov 2017 21:07:18 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id u16sm144987otd.78.2017.11.15.21.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Nov 2017 21:07:18 -0800 (PST)
Date:   Wed, 15 Nov 2017 23:07:17 -0600
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
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3 2/8] dt-bindings: pci: Add DT docs for Brcmstb PCIe
 device
Message-ID: <20171116050717.35lklxvhfvtuly5i@rob-hp-laptop>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-3-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510697532-32828-3-git-send-email-jim2101024@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60970
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

On Tue, Nov 14, 2017 at 05:12:06PM -0500, Jim Quinlan wrote:
> The DT bindings description of the Brcmstb PCIe device is described.  This
> node can be used by almost all Broadcom settop box chips, using
> ARM, ARM64, or MIPS CPU architectures.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcmstb-pcie.txt       | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt

Acked-by: Rob Herring <robh@kernel.org>
