Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 20:12:55 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:59675 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012822AbbKPTMvjVUj8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Nov 2015 20:12:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=Uk30eNopG2GP/pMzmziUPOcSYp4i5jdCvnJrI9mA+B4=;
        b=o1axTK7+7LzyBX+misBEN+GNlBlnkYHEmafrpzSkx416NNj01u9W+t9fhqJHuxLLZrhGb/1HTV/muO4Ar7qyl0K+HNv9Y/DOzIa6m4gTt8n/pHS8Y3JmyvL01zJEDk9SSRLOP6LRNzAIoZwGhq8TuIP5vJNtNSkb690NwW9958y6V7GEPPkEpyY6OtBCMf5BiWTJlylg2gsSf37wiI8GP0/YhuoPgb0Du4PC/q+iIAcYZXBM2aL5Pxog87TQav9Bk0ux87/2482WCF+T7wtkNE1Ls6s05svrwtxB03qGBTvJ9THqRTlCowY1/ufla6W0pIGtTVY8ztZdfujVxTWWYg==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:43001 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1ZyPCf-00041i-GH (Exim); Mon, 16 Nov 2015 19:12:39 +0000
Subject: [PATCH 1/2] irqchip: Add brcm,bcm6345-l1-intc device tree binding
To:     Rob Herring <robh@kernel.org>
References: <5648B804.40806@simon.arlott.org.uk>
 <20151116153443.GA13799@rob-hp-laptop>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <564A2AA4.3060901@simon.arlott.org.uk>
Date:   Mon, 16 Nov 2015 19:12:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151116153443.GA13799@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

Add device tree binding for the BCM6345 interrupt controller.

This controller is similar to the SMP-capable BCM7038 and
the BCM3380 but with packed interrupt registers.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
On 16/11/15 15:34, Rob Herring wrote:
> On Sun, Nov 15, 2015 at 04:51:16PM +0000, Simon Arlott wrote:
>> Add device tree binding for the BCM63168 interrupt controller.
>> 
>> This controller is similar to the SMP-capable BCM7038 and
>> the BCM3380 but with packed interrupt registers.
>> 
>> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> 
> Acked-by: Rob Herring <robh@kernel.org>

I'm going to rename this to bcm6345-l1 as suggested by Jonas Gorski, and
the binding now specifies a <soc> version of the compatible name to be
included.

 .../interrupt-controller/brcm,bcm6345-l1-intc.txt  | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm6345-l1-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm6345-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm6345-l1-intc.txt
new file mode 100644
index 0000000..c5bdcf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm6345-l1-intc.txt
@@ -0,0 +1,57 @@
+Broadcom BCM6345-style Level 1 interrupt controller
+
+This block is a first level interrupt controller that is typically connected
+directly to one of the HW INT lines on each CPU.
+
+Key elements of the hardware design include:
+
+- 32, 64 or 128 incoming level IRQ lines
+
+- Most onchip peripherals are wired directly to an L1 input
+
+- A separate instance of the register set for each CPU, allowing individual
+  peripheral IRQs to be routed to any CPU
+
+- Contains one or more enable/status word pairs per CPU
+
+- No atomic set/clear operations
+
+- No polarity/level/edge settings
+
+- No FIFO or priority encoder logic; software is expected to read all
+  2-4 status words to determine which IRQs are pending
+
+Required properties:
+
+- compatible: should be "brcm,bcm<soc>-l1-intc", "brcm,bcm6345-l1-intc"
+- reg: specifies the base physical address and size of the registers;
+  the number of supported IRQs is inferred from the size argument
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 1.
+- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
+  this one is cascaded from
+- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
+  node; valid values depend on the type of parent interrupt controller
+
+If multiple reg ranges and interrupt-parent entries are present on an SMP
+system, the driver will allow IRQ SMP affinity to be set up through the
+/proc/irq/ interface.  In the simplest possible configuration, only one
+reg range and one interrupt-parent is needed.
+
+The driver operates in native CPU endian by default, there is no support for
+specifying an alternative endianness.
+
+Example:
+
+periph_intc: periph_intc@10000000 {
+        compatible = "brcm,bcm63168-l1-intc", "brcm,bcm6345-l1-intc";
+        reg = <0x10000020 0x20>,
+              <0x10000040 0x20>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        interrupt-parent = <&cpu_intc>;
+        interrupts = <2>, <3>;
+};
-- 
2.1.4

-- 
Simon Arlott
