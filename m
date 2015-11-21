Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 01:14:28 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:23260 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013012AbbKUAOSAFTVx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 01:14:18 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Fri, 20 Nov 2015
 17:14:09 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Fri, 20 Nov 2015
 17:20:35 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 01/14] DEVICETREE: Add bindings for PIC32 interrupt controller
Date:   Fri, 20 Nov 2015 17:17:13 -0700
Message-ID: <1448065205-15762-2-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

From: Cristian Birsan <cristian.birsan@microchip.com>

Document the devicetree bindings for the interrupt controller on Microchip
PIC32 class devices. This also adds a header defining associated interrupts
and related settings.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 .../microchip,pic32mz-evic.txt                     |   65 ++++++
 .../interrupt-controller/microchip,pic32mz-evic.h  |  238 ++++++++++++++++++++
 2 files changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt
 create mode 100644 include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt b/Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt
new file mode 100644
index 0000000..12fb91f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt
@@ -0,0 +1,65 @@
+Microchip PIC32MZ Interrupt Controller
+======================================
+
+The Microchip PIC32MZ SOC contains an Enhanced Vectored Interrupt Controller
+(EVIC) version 2. It handles internal and external interrupts and provides
+support for priority, sub-priority, irq type and polarity.
+
+Required properties
+-------------------
+
+- compatible: Should be "microchip,evic-v2"
+
+- reg: specifies physical base address and size of register range.
+
+- interrupt-controller: Identifies the node as an interrupt controller.
+
+- #interrupt cells: Specifies the number of cells used to encode an interrupt
+source connected to this controller. The value shall be 3 and interrupt
+descriptor shall have the following format:
+	<hw_irq irq_priority_and_subpriority irq_type>
+
+hw_irq - represents the hardware interrupt number as in the data sheet.
+
+irq_priority_and_subpriority - sets the priority and sub-priority for the
+interrupt line. The INT_PRI(pri, subpri) macro can be used to set desired
+values or the DEFAULT_INT_PRI can be used for the default value.
+
+irq_type - is used to describe the type and polarity of an interrupt. For
+internal interrupts use IRQ_TYPE_EDGE_RISING for non persistent interrupts and
+IRQ_TYPE_LEVEL_HIGH for persistent interrupts. For external interrupts use
+IRQ_TYPE_EDGE_RISING or IRQ_TYPE_EDGE_FALLING to select the desired polarity.
+
+Example
+-------
+
+evic: interrupt-controller@1f810000 {
+        compatible = "microchip,evic-v2";
+        interrupt-controller;
+        #interrupt-cells = <3>;
+        reg = <0x1f810000 0x1000>;
+        device_type="evic-v2";
+};
+
+Each device must request his interrupt line with the associated priority and
+polarity
+
+Internal interrupt DTS snippet
+------------------------------
+
+device@1f800000 {
+	...
+	interrupt-parent = <&evic>;
+	interrupts = <UART1_RECEIVE_DONE DEFAULT_INT_PRI IRQ_TYPE_NONE>;
+	...
+};
+
+External interrupt DTS snippet
+------------------------------
+
+device@1f800000 {
+	...
+	interrupt-parent = <&evic>;
+	interrupts = <EXTERNAL_INTERRUPT_0 DEFAULT_INT_PRI IRQ_TYPE_EDGE_RISING>;
+	...
+};
diff --git a/include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h b/include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h
new file mode 100644
index 0000000..2c466b8
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h
@@ -0,0 +1,238 @@
+/*
+ * This header provides constants for the MICROCHIP PIC32 EVIC.
+ */
+
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_MICROCHIP_EVIC_H
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_MICROCHIP_EVIC_H
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/* Hardware interrupt number */
+#define CORE_TIMER_INTERRUPT 0
+#define CORE_SOFTWARE_INTERRUPT_0 1
+#define CORE_SOFTWARE_INTERRUPT_1 2
+#define EXTERNAL_INTERRUPT_0 3
+#define TIMER1 4
+#define INPUT_CAPTURE_1_ERROR 5
+#define INPUT_CAPTURE_1 6
+#define OUTPUT_COMPARE_1 7
+#define EXTERNAL_INTERRUPT_1 8
+#define TIMER2 9
+#define INPUT_CAPTURE_2_ERROR 10
+#define INPUT_CAPTURE_2 11
+#define OUTPUT_COMPARE_2 12
+#define EXTERNAL_INTERRUPT_2 13
+#define TIMER3 14
+#define INPUT_CAPTURE_3_ERROR 15
+#define INPUT_CAPTURE_3 16
+#define OUTPUT_COMPARE_3 17
+#define EXTERNAL_INTERRUPT_3 18
+#define TIMER4 19
+#define INPUT_CAPTURE_4_ERROR 20
+#define INPUT_CAPTURE_4 21
+#define OUTPUT_COMPARE_4 22
+#define EXTERNAL_INTERRUPT_4 23
+#define TIMER5 24
+#define INPUT_CAPTURE_5_ERROR 25
+#define INPUT_CAPTURE_5 26
+#define OUTPUT_COMPARE_5 27
+#define TIMER6 28
+#define INPUT_CAPTURE_6_ERROR 29
+#define INPUT_CAPTURE_6 30
+#define OUTPUT_COMPARE_6 31
+#define TIMER7 32
+#define INPUT_CAPTURE_7_ERROR 33
+#define INPUT_CAPTURE_7 34
+#define OUTPUT_COMPARE_7 35
+#define TIMER8 36
+#define INPUT_CAPTURE_8_ERROR 37
+#define INPUT_CAPTURE_8 38
+#define OUTPUT_COMPARE_8 39
+#define TIMER9 40
+#define INPUT_CAPTURE_9_ERROR 41
+#define INPUT_CAPTURE_9 42
+#define OUTPUT_COMPARE_9 43
+/* ADC */
+#define ADC1_GLOBAL 44
+/* Reserved */
+#define ADC1_DIGITAL_COMPARATOR_1 46
+#define ADC1_DIGITAL_COMPARATOR_2 47
+#define ADC1_DIGITAL_COMPARATOR_3 48
+#define ADC1_DIGITAL_COMPARATOR_4 49
+#define ADC1_DIGITAL_COMPARATOR_5 50
+#define ADC1_DIGITAL_COMPARATOR_6 51
+#define ADC1_DIGITAL_FILTER_1 52
+#define ADC1_DIGITAL_FILTER_2 53
+#define ADC1_DIGITAL_FILTER_3 54
+#define ADC1_DIGITAL_FILTER_4 55
+#define ADC1_DIGITAL_FILTER_5 56
+#define ADC1_DIGITAL_FILTER_6 57
+/* Reserved */
+#define ADC1_DATA_0 59
+#define ADC1_DATA_1 60
+#define ADC1_DATA_2 61
+#define ADC1_DATA_3 62
+#define ADC1_DATA_4 63
+#define ADC1_DATA_5 64
+#define ADC1_DATA_6 65
+#define ADC1_DATA_7 66
+#define ADC1_DATA_8 67
+#define ADC1_DATA_9 68
+#define ADC1_DATA_10 69
+#define ADC1_DATA_11 70
+#define ADC1_DATA_12 71
+#define ADC1_DATA_13 72
+#define ADC1_DATA_14 73
+#define ADC1_DATA_15 74
+#define ADC1_DATA_16 75
+#define ADC1_DATA_17 76
+#define ADC1_DATA_18 77
+#define ADC1_DATA_19 78
+#define ADC1_DATA_20 79
+#define ADC1_DATA_21 80
+#define ADC1_DATA_22 81
+#define ADC1_DATA_23 82
+#define ADC1_DATA_24 83
+#define ADC1_DATA_25 84
+#define ADC1_DATA_26 85
+#define ADC1_DATA_27 86
+#define ADC1_DATA_28 87
+#define ADC1_DATA_29 88
+#define ADC1_DATA_30 89
+#define ADC1_DATA_31 90
+#define ADC1_DATA_32 91
+#define ADC1_DATA_33 92
+#define ADC1_DATA_34 93
+#define ADC1_DATA_35 94
+#define ADC1_DATA_36 95
+#define ADC1_DATA_37 96
+#define ADC1_DATA_38 97
+#define ADC1_DATA_39 98
+#define ADC1_DATA_40 99
+#define ADC1_DATA_41 100
+#define ADC1_DATA_42 101
+#define ADC1_DATA_43 102
+#define ADC1_DATA_44 103
+#define CORE_PERFORMANCE_COUNTER_INTERRUPT 104
+#define CORE_FAST_DEBUG_CHANNEL_INTERRUPT 105
+#define SYSTEM_BUS_PROTECTION_VIOLATION 106
+#define CRYPTO_ENGINE_EVENT 107
+/* Reserved */
+#define SPI1_FAULT 109
+#define SPI1_RECEIVE_DONE 110
+#define SPI1_TRANSFER_DONE 111
+#define UART1_FAULT 112
+#define UART1_RECEIVE_DONE 113
+#define UART1_TRANSFER_DONE 114
+#define I2C1_BUS_COLLISION_EVENT 115
+#define I2C1_SLAVE_EVENT 116
+#define I2C1_MASTER_EVENT 117
+#define PORTA_INPUT_CHANGE_INTERRUPT 118
+#define PORTB_INPUT_CHANGE_INTERRUPT 119
+#define PORTC_INPUT_CHANGE_INTERRUPT 120
+#define PORTD_INPUT_CHANGE_INTERRUPT 121
+#define PORTE_INPUT_CHANGE_INTERRUPT 122
+#define PORTF_INPUT_CHANGE_INTERRUPT 123
+#define PORTG_INPUT_CHANGE_INTERRUPT 124
+#define PORTH_INPUT_CHANGE_INTERRUPT 125
+#define PORTJ_INPUT_CHANGE_INTERRUPT 126
+#define PORTK_INPUT_CHANGE_INTERRUPT 127
+#define PARALLEL_MASTER_PORT 128
+#define PARALLEL_MASTER_PORT_ERROR 129
+#define COMPARATOR_1_INTERRUPT 130
+#define COMPARATOR_2_INTERRUPT 131
+#define USB_GENERAL_EVENT 132
+#define USB_DMA_EVENT 133
+#define DMA_CHANNEL_0 134
+#define DMA_CHANNEL_1 135
+#define DMA_CHANNEL_2 136
+#define DMA_CHANNEL_3 137
+#define DMA_CHANNEL_4 138
+#define DMA_CHANNEL_5 139
+#define DMA_CHANNEL_6 140
+#define DMA_CHANNEL_7 141
+#define SPI2_FAULT 142
+#define SPI2_RECEIVE_DONE 143
+#define SPI2_TRANSFER_DONE 144
+#define UART2_FAULT 145
+#define UART2_RECEIVE_DONE 146
+#define UART2_TRANSFER_DONE 147
+#define I2C2_BUS_COLLISION_EVENT 148
+#define I2C2_SLAVE_EVENT 149
+#define I2C2_MASTER_EVENT 150
+#define CONTROL_AREA_NETWORK_1 151
+#define CONTROL_AREA_NETWORK_2 152
+#define ETHERNET_INTERRUPT 153
+#define SPI3_FAULT 154
+#define SPI3_RECEIVE_DONE 155
+#define SPI3_TRANSFER_DONE 156
+#define UART3_FAULT 157
+#define UART3_RECEIVE_DONE 158
+#define UART3_TRANSFER_DONE 159
+#define I2C3_BUS_COLLISION_EVENT 160
+#define I2C3_SLAVE_EVENT 161
+#define I2C3_MASTER_EVENT 162
+#define SPI4_FAULT 163
+#define SPI4_RECEIVE_DONE 164
+#define SPI4_TRANSFER_DONE 165
+#define REAL_TIME_CLOCK 166
+#define FLASH_CONTROL_EVENT 167
+#define PREFETCH_MODULE_SEC_EVENT 168
+#define SQI1_EVENT 169
+#define UART4_FAULT 170
+#define UART4_RECEIVE_DONE 171
+#define UART4_TRANSFER_DONE 172
+#define I2C4_BUS_COLLISION_EVENT 173
+#define I2C4_SLAVE_EVENT 174
+#define I2C4_MASTER_EVENT 175
+#define SPI5_FAULT 176
+#define SPI5_RECEIVE_DONE 177
+#define SPI5_TRANSFER_DONE 178
+#define UART5_FAULT 179
+#define UART5_RECEIVE_DONE 180
+#define UART5_TRANSFER_DONE 181
+#define I2C5_BUS_COLLISION_EVENT 182
+#define I2C5_SLAVE_EVENT 183
+#define I2C5_MASTER_EVENT 184
+#define SPI6_FAULT 185
+#define SPI6_RECEIVE_DONE 186
+#define SPI6_TRANSFER_DONE 187
+#define UART6_FAULT 188
+#define UART6_RECEIVE_DONE 189
+#define UART6_TRANSFER_DONE 190
+#define SDHC_EVENT 191
+#define GLCD_INTERRUPT 192
+#define GPU_INTERRUPT 193
+
+/* Interrupt priority bits */
+#define PRI_0	0	/* Note:This priority disables the interrupt! */
+#define PRI_1	1
+#define PRI_2	2
+#define PRI_3	3
+#define PRI_4	4
+#define PRI_5	5
+#define PRI_6	6
+#define PRI_7	7
+
+/* Interrupt subpriority bits */
+#define SUB_PRI_0	0
+#define SUB_PRI_1	1
+#define SUB_PRI_2	2
+#define SUB_PRI_3	3
+
+#define PRI_MASK	0x7	/* 3 bit priority mask */
+#define SUBPRI_MASK	0x3	/* 2 bit subpriority mask */
+#define INT_MASK	0x1F	/* 5 bit pri and subpri mask */
+#define NR_EXT_IRQS	5	/* 5 external interrupts sources */
+
+#define MICROCHIP_EVIC_MIN_PRIORITY 0
+#define MICROCHIP_EVIC_MAX_PRIORITY INT_MASK
+
+#define INT_PRI(pri, subpri)	\
+	(((pri & PRI_MASK) << 2) | (subpri & SUBPRI_MASK))
+
+#define DEFINE_INT(irq, pri) { irq, pri }
+
+#define DEFAULT_INT_PRI INT_PRI(2, 0)
+
+#endif /*_DT_BINDINGS_INTERRUPT_CONTROLLER_MICROCHIP_EVIC_H*/
-- 
1.7.9.5
