Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 10:47:38 +0200 (CEST)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33799 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992334AbcHLIrbtxTk- convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Aug 2016 10:47:31 +0200
Received: by mail-pa0-f67.google.com with SMTP id hh10so1168781pac.1;
        Fri, 12 Aug 2016 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GuJ5nmcgQmGZINEE83+yInSSLcro1nm8oiyJnlfq1ts=;
        b=FHGeud0GexQ/e2HW6Q6Wy823Ya7zxmk7d9O9HZUhKnYQmJOsUoF2y33V50JT3gPL9G
         oJlwL1ULr38kvydwegRZg7kVReffgf5INKhVkCyV3LWn0miylvp2LLNQ/KEV8fb4Sq2Q
         AKmOqyDcZ5hvy4loOsGJnfEDCVH/MzyZUsAJ910ejxthg7iuxYWhsvaVK/ZX67zq5KBQ
         a5GPsSCIzRfD5P+durATYzrYGPbDVdI6sRYgDFLN4Mhk3JV5XlOMQqlA2x5xAF4K3ijq
         IZBOmCr9lo4T0u3bhzyAovdHG5JQT/zdmQBoC7SbjMdwl1GKvaq03/Dyqe4lsoM7aL29
         VrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GuJ5nmcgQmGZINEE83+yInSSLcro1nm8oiyJnlfq1ts=;
        b=FX6Diz+exnitXcAvPzp7QKgVq6wCmm4icq4CnwSrrtxoWjccISSRMRnDr5/piLv1E8
         QBaJzdTffUFOVbipGGQ8QdZ0F9/TYdveq0MDHr6mjRF6FK+Tc/g76r/WIY9XFiKoY1nZ
         c0jlLSXoHUfL1jQScoMrCcyCda0EE0N0TFKWr8NOYrDdHdrvbhL64oPeSzRqH0K6NvXO
         LCsYk7j1Ja3gMMTQsBTadFgacTPku+E/Rn2fqZVrC8uPdbcPm0PnN5mH+xsqB+NJCopc
         XFQzyHgQ3q57UidJmi4HTulrQbjJI7jfpx3t4gdRDd70c9KV8cAqloVX/3HKhqstmZxA
         ElLw==
X-Gm-Message-State: AEkoouuqn+x92OSCzPbj7C50vakyqtP6sJoDsEv6+Qe/lvunk1Z3xu/ZJnkQQLrIFC3tZQ==
X-Received: by 10.66.127.10 with SMTP id nc10mr24975757pab.109.1470991645695;
        Fri, 12 Aug 2016 01:47:25 -0700 (PDT)
Received: from [172.30.1.12] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id vt10sm10949095pab.43.2016.08.12.01.47.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 01:47:25 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [v2 0/5] Add device nodes for BCM7xxx SoCs
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <20160812020923.3299-1-jaedon.shin@gmail.com>
Date:   Fri, 12 Aug 2016 17:47:21 +0900
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E0DBCC80-9563-4F75-83A3-9E6B1D9DFD4D@gmail.com>
References: <20160812020923.3299-1-jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
X-Mailer: Apple Mail (2.3124)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Please discard this patch series. This have incorrect interrupt numbers
in aon_pm_l2_intc. 

Sorry, for the noise.

> On Aug 12, 2016, at 11:09 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> 
> This patch series adds support for Broadcom BCM7xxx MIPS based SoCs.
> 
> The NAND device nodes have common file including chip select, BCH
> and partitions for the reference board with the same properties.
> 
> Changes in v2:
> - Removed status properties in always enabled GPIO nodes.
> - Removed NAND nodes for v3.3 brcmnand controller.
> - Renamed interrupt-controller instead of lable string.
> - Renamed bcm97xxx-nand-cs1-bch8.dtsi
> 
> Jaedon Shin (5):
>  MIPS: BMIPS: Add support PWM device nodes
>  MIPS: BMIPS: Add support GPIO device nodes
>  MIPS: BMIPS: Add support SDHCI device nodes
>  MIPS: BMIPS: Add support NAND device nodes
>  MIPS: BMIPS: Use interrupt-controller node name
> 
> arch/mips/boot/dts/brcm/bcm7125.dtsi               |  34 ++++++-
> arch/mips/boot/dts/brcm/bcm7346.dtsi               |  97 +++++++++++++++++-
> arch/mips/boot/dts/brcm/bcm7358.dtsi               |  89 ++++++++++++++++-
> arch/mips/boot/dts/brcm/bcm7360.dtsi               |  89 ++++++++++++++++-
> arch/mips/boot/dts/brcm/bcm7362.dtsi               |  89 ++++++++++++++++-
> arch/mips/boot/dts/brcm/bcm7420.dtsi               |  42 +++++++-
> arch/mips/boot/dts/brcm/bcm7425.dtsi               | 109 ++++++++++++++++++++-
> arch/mips/boot/dts/brcm/bcm7435.dtsi               | 109 ++++++++++++++++++++-
> arch/mips/boot/dts/brcm/bcm97125cbmb.dts           |   4 +
> arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  17 ++++
> arch/mips/boot/dts/brcm/bcm97358svmb.dts           |  13 +++
> arch/mips/boot/dts/brcm/bcm97360svmb.dts           |  13 +++
> arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  13 +++
> arch/mips/boot/dts/brcm/bcm97420c.dts              |   8 ++
> arch/mips/boot/dts/brcm/bcm97425svmb.dts           |  21 ++++
> arch/mips/boot/dts/brcm/bcm97435svmb.dts           |  21 ++++
> .../mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch8.dtsi |  24 +++++
> 17 files changed, 754 insertions(+), 38 deletions(-)
> create mode 100644 arch/mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch8.dtsi
> 
> -- 
> 2.9.2
> 
