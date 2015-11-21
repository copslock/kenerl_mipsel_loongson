Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 21:47:46 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:52064 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012263AbbKUUroxczKD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 21:47:44 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPSA (Nemesis) id 0LroMs-1aUJgG4686-013d4f; Sat, 21 Nov
 2015 21:47:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/14] DEVICETREE: Add bindings for PIC32 interrupt controller
Date:   Sat, 21 Nov 2015 21:47:14 +0100
Message-ID: <7036408.cJ9oZKCcQe@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1448065205-15762-2-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com> <1448065205-15762-2-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:9uwU2p9RhbbSnSJVp2ow+Fof3ZdRlhQOTpG/lh85mGfIbJcN5Hd
 ffqJWPMlNaA5mAvSEA0W0KdmcXUYgD60adlhTRctLfoRec/AKZNU7mnD/G40AyBPcAgOGJQ
 T+0EjiH1RLNlkk2JoFBqEpXI8vDCeHPNNRC/pLhcxGXkZR3NMbAm3cRIsroh59fZcZ6+/F5
 HMTnfRXdzqYnTcHaO2YLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9yAiyW3X7L4=:x9x0fFJJO5hTME5cCkxP4a
 6AgeegPW8u3r6iN0KFSHhQnd3nBYWJASmmdHBcpeO8o2ByJsXBTMyTCC+8hTTMrpzONzAhYvV
 +oCy+75a/UI8T3/lTAXzX8VxjFQkmAjqHJA7mHnciVapu3TIFgo8jdCtZk4OuqRb9E7dBzKOX
 TGbK9KCsjhkOi+RA1YXxRQ2ksqNBZYhQu41b1tH0RdsFQaKHP78/uirz3on5o208CbQO6HPt2
 miVgmwA0mI1lm64ykHxp4uyNVk4m1fze22gnP2wcu/a4nUGvj6qmKch2VlnY7A3gtYQOiX7ig
 epqEg9HElgDAd3FEWcNRDxWQLAbovK1fesZdrSXcsAam4TKvTv5vwuH3Kxq7yoFztQeAwd5UV
 RRHeRjwLWBr6IYMwZiL34dXXki1xotQdqS2oBU3bATZ5ItxzLABWHu/4ZPyXpzlYoB33X6nYq
 kXYNtG5jNVFTv3vhbA+KZg+RiKhcBQ8CVHfq7sVgMHuhoQolQ0EOOy7CkZu/eRkUdkTuE6UCZ
 27xj/cE+CqAl3QtmAe9MFnQboR6QZ++8Vca+IfVJdA4T2vncIzQXAENwYJy/09skK91rQ7AVz
 SK9EuEItIEHQZ+sJxEIlPKFTr1N0MBiH75c3KUgBB4nLBCmXEdgiDeambTFI1g4RDqIHQWjSY
 aPC1/MZEefkEACtiB2mBAJEpVezUw4e+faR6g2HlKgcDvLLzRnDQ1pkIBTCwCHe4wnR/rstCy
 t4b6opiII7fwAckd
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Friday 20 November 2015 17:17:13 Joshua Henderson wrote:

> +Example
> +-------
> +
> +evic: interrupt-controller@1f810000 {
> +        compatible = "microchip,evic-v2";
> +        interrupt-controller;
> +        #interrupt-cells = <3>;
> +        reg = <0x1f810000 0x1000>;
> +        device_type="evic-v2";
> +};

This is not a correct use of device_type. Just drop that property.

> diff --git a/include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h b/include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h
> new file mode 100644
> index 0000000..2c466b8
> --- /dev/null
> +++ b/include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h
> @@ -0,0 +1,238 @@
> +/*
> + * This header provides constants for the MICROCHIP PIC32 EVIC.
> + */
> +
> +#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_MICROCHIP_EVIC_H
> +#define _DT_BINDINGS_INTERRUPT_CONTROLLER_MICROCHIP_EVIC_H
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/* Hardware interrupt number */
> +#define CORE_TIMER_INTERRUPT 0
> +#define CORE_SOFTWARE_INTERRUPT_0 1
> +#define CORE_SOFTWARE_INTERRUPT_1 2
> +#define EXTERNAL_INTERRUPT_0 3
> +#define TIMER1 4

A header file like this is just going to make everyone's life
miserable. Try to remove as much as possible here: normally
you can just use the numbers from the data sheet that match
the actual hardware registers, and put them into the dts file.

> +/* Interrupt priority bits */
> +#define PRI_0	0	/* Note:This priority disables the interrupt! */
> +#define PRI_1	1
> +#define PRI_2	2
> +#define PRI_3	3
> +#define PRI_4	4
> +#define PRI_5	5
> +#define PRI_6	6
> +#define PRI_7	7

> +/* Interrupt subpriority bits */
> +#define SUB_PRI_0	0
> +#define SUB_PRI_1	1
> +#define SUB_PRI_2	2
> +#define SUB_PRI_3	3

These are obviously silly and should be removed/

> +#define PRI_MASK	0x7	/* 3 bit priority mask */
> +#define SUBPRI_MASK	0x3	/* 2 bit subpriority mask */
> +#define INT_MASK	0x1F	/* 5 bit pri and subpri mask */
> +#define NR_EXT_IRQS	5	/* 5 external interrupts sources */
> +
> +#define MICROCHIP_EVIC_MIN_PRIORITY 0
> +#define MICROCHIP_EVIC_MAX_PRIORITY INT_MASK
> +
> +#define INT_PRI(pri, subpri)	\
> +	(((pri & PRI_MASK) << 2) | (subpri & SUBPRI_MASK))
> +
> +#define DEFINE_INT(irq, pri) { irq, pri }
> +
> +#define DEFAULT_INT_PRI INT_PRI(2, 0)

Is it required to have a specific priority configured for each line?
If these are software selectable, it's probably better to not put
them into DT in the first place.

If you absolutely need them, I would suggest using two separate cells
for pri and subpri so you can avoid the macro.

	Arnd
