Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 02:41:29 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34280 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993912AbdHWAlV1zWxA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 02:41:21 +0200
Received: by mail-oi0-f65.google.com with SMTP id k62so325133oia.1;
        Tue, 22 Aug 2017 17:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWvtNhDNwCan5MN17mI77pkreqRO+ilUKKHgJJMPNOs=;
        b=Z6/rEDXQ9Zzzl/MYtqf/Lra3PEmEq1uoUKvjFX/OqeXe+xuOmcagzBtjk8ZsO4F1Al
         5xy1mCptGcRiISnEGmoMFgIizdaD6ga0RTvMskFuI6aIjwEu1LkZ4d0cJPhEfXdd/NDQ
         cwKTqtF76VvJuVP/Z3rUiYM4wEUc7E8HFPPuUBNnym10S2WRc/pvJzJGQONKndS6QNXq
         nrVllFbk63nqLJxPURPckR6H7v5poSaZyvM6fQk713QIjRNHoyOG8OwL8WfJaCdiDF5T
         jzXK9+6DqEjldXpijZaJVHD+T8JzQW1VdL/TVKJ0lDLjEhwBo/lGs0xHKaFuKmBtmDJq
         dLjQ==
X-Gm-Message-State: AHYfb5jQwk4a5bC34rmSkPzzHv2Tttvqof2WIxaWNl51NlJrZluUDJrT
        4/VSerMRXZBPWg==
X-Received: by 10.202.67.6 with SMTP id q6mr1389920oia.144.1503448875625;
        Tue, 22 Aug 2017 17:41:15 -0700 (PDT)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id t186sm408333oie.29.2017.08.22.17.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Aug 2017 17:41:15 -0700 (PDT)
Date:   Tue, 22 Aug 2017 19:41:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     mark.rutland@arm.com, ralf@linux-mips.org, john@phrozen.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [V2 1/4] MIPS: dts: ralink: Add Mediatek MT7628A SoC
Message-ID: <20170823004114.a7raxjrjj7vcmpbb@rob-hp-laptop>
References: <1503312931-34416-1-git-send-email-harvey.hunt@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503312931-34416-1-git-send-email-harvey.hunt@imgtec.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59763
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

On Mon, Aug 21, 2017 at 11:55:29AM +0100, Harvey Hunt wrote:
> The MT7628A is the successor to the MT7620 and pin compatible with the
> MT7688A, although the latter supports only a 1T1R antenna rather than
> a 2T2R antenna.
> 
> This commit adds support for the following features:
> 
> - UART
> - USB PHY
> - EHCI
> - Interrupt controller
> - System controller
> - Memory controller
> - Reset controller
> 
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: linux-mips@linux-mips.org 
> Cc: devicetree@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 
> Cc: linux-mediatek@lists.infradead.org 
> ---
> Ralf: I've added this patch to both my vocore2 and omega2+
> patchsets for ease of review, please only merge it once :-)
> 
> Changes in V2:
> - Add MT7628 to patchset to keep kbuild happy and retain context
> - Rename multiple DT nodes to standard names
> - Add labels for uarts
> - Rename USB PHY handle
> 
>  Documentation/devicetree/bindings/mips/ralink.txt |   1 +
>  arch/mips/boot/dts/ralink/mt7628a.dtsi            | 126 ++++++++++++++++++++++
>  2 files changed, 127 insertions(+)
>  create mode 100644 arch/mips/boot/dts/ralink/mt7628a.dtsi

Acked-by: Rob Herring <robh@kernel.org>
