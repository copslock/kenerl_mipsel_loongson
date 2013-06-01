Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Jun 2013 20:43:20 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:38569 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823009Ab3FASnThlRBQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Jun 2013 20:43:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 1B00219BEE9;
        Sat,  1 Jun 2013 21:43:18 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id PRvkg2ZohunI; Sat,  1 Jun 2013 21:43:17 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with ESMTP id 6FBBF5BC002;
        Sat,  1 Jun 2013 21:43:08 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-usb@vger.kernel.org, linux-mips@linux-mips.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] staging: MIPS: add Octeon USB HCD support
Date:   Sat,  1 Jun 2013 21:42:58 +0300
Message-Id: <1370112178-16430-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Add support for Octeon USB HCD. Tested on EdgeRouter Lite with USB
mass storage.

The driver has been extracted from GPL sources of EdgeRouter Lite firmware
(based on Linux 2.6.32.13). Some minor fixes and cleanups have been done
to make it work with 3.10-rc3.

$ uname -a
Linux (none) 3.10.0-rc3-edge-00005-g86cb5bc #41 SMP PREEMPT Sat Jun 1 20:41:46 EEST 2013 mips64 GNU/Linux
$ modprobe octeon-usb
[   37.971683] octeon_usb: module is from the staging directory, the quality is unknown, you have been warned.
[   37.983649] OcteonUSB: Detected 1 ports
[   37.999360] OcteonUSB OcteonUSB.0: Octeon Host Controller
[   38.004847] OcteonUSB OcteonUSB.0: new USB bus registered, assigned bus number 1
[   38.012332] OcteonUSB OcteonUSB.0: irq 122, io mem 0x00000000
[   38.019970] hub 1-0:1.0: USB hub found
[   38.023851] hub 1-0:1.0: 1 port detected
[   38.028101] OcteonUSB: Registered HCD for port 0 on irq 122
[   38.391443] usb 1-1: new high-speed USB device number 2 using OcteonUSB
[   38.586922] usb-storage 1-1:1.0: USB Mass Storage device detected
[   38.597375] scsi0 : usb-storage 1-1:1.0
[   39.604111] scsi 0:0:0:0: Direct-Access              USB DISK 2.0     PMAP PQ: 0 ANSI: 4
[   39.619113] sd 0:0:0:0: [sda] 7579008 512-byte logical blocks: (3.88 GB/3.61 GiB)
[   39.630696] sd 0:0:0:0: [sda] Write Protect is off
[   39.635945] sd 0:0:0:0: [sda] No Caching mode page present
[   39.641464] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   39.651341] sd 0:0:0:0: [sda] No Caching mode page present
[   39.656917] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   39.664296]  sda: sda1 sda2
[   39.675574] sd 0:0:0:0: [sda] No Caching mode page present
[   39.681093] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   39.687223] sd 0:0:0:0: [sda] Attached SCSI removable disk

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/Kconfig                      |    2 +
 drivers/staging/Makefile                     |    1 +
 drivers/staging/octeon-usb/Kconfig           |   10 +
 drivers/staging/octeon-usb/Makefile          |    3 +
 drivers/staging/octeon-usb/TODO              |   11 +
 drivers/staging/octeon-usb/cvmx-usb.c        | 3344 ++++++++++++++++++++++++++
 drivers/staging/octeon-usb/cvmx-usb.h        | 1085 +++++++++
 drivers/staging/octeon-usb/cvmx-usbcx-defs.h | 3086 ++++++++++++++++++++++++
 drivers/staging/octeon-usb/cvmx-usbnx-defs.h | 1596 ++++++++++++
 drivers/staging/octeon-usb/octeon-hcd.c      |  854 +++++++
 10 files changed, 9992 insertions(+)
 create mode 100644 drivers/staging/octeon-usb/Kconfig
 create mode 100644 drivers/staging/octeon-usb/Makefile
 create mode 100644 drivers/staging/octeon-usb/TODO
 create mode 100644 drivers/staging/octeon-usb/cvmx-usb.c
 create mode 100644 drivers/staging/octeon-usb/cvmx-usb.h
 create mode 100644 drivers/staging/octeon-usb/cvmx-usbcx-defs.h
 create mode 100644 drivers/staging/octeon-usb/cvmx-usbnx-defs.h
 create mode 100644 drivers/staging/octeon-usb/octeon-hcd.c

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index aefe820..e7066ac 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -62,6 +62,8 @@ source "drivers/staging/line6/Kconfig"
 
 source "drivers/staging/octeon/Kconfig"
 
+source "drivers/staging/octeon-usb/Kconfig"
+
 source "drivers/staging/serqt_usb2/Kconfig"
 
 source "drivers/staging/vt6655/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 415772e..b9dc499 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_LINE6_USB)		+= line6/
 obj-$(CONFIG_NETLOGIC_XLR_NET)	+= netlogic/
 obj-$(CONFIG_USB_SERIAL_QUATECH2)	+= serqt_usb2/
 obj-$(CONFIG_OCTEON_ETHERNET)	+= octeon/
+obj-$(CONFIG_OCTEON_USB)	+= octeon-usb/
 obj-$(CONFIG_VT6655)		+= vt6655/
 obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_VME_BUS)		+= vme/
diff --git a/drivers/staging/octeon-usb/Kconfig b/drivers/staging/octeon-usb/Kconfig
new file mode 100644
index 0000000..018af6d
--- /dev/null
+++ b/drivers/staging/octeon-usb/Kconfig
@@ -0,0 +1,10 @@
+config OCTEON_USB
+	tristate "Cavium Networks Octeon USB support"
+	depends on CPU_CAVIUM_OCTEON && USB
+	help
+	  This driver supports USB host controller on some Cavium
+	  Networks' products in the Octeon family.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called octeon-usb.
+
diff --git a/drivers/staging/octeon-usb/Makefile b/drivers/staging/octeon-usb/Makefile
new file mode 100644
index 0000000..89df1ad
--- /dev/null
+++ b/drivers/staging/octeon-usb/Makefile
@@ -0,0 +1,3 @@
+obj-${CONFIG_OCTEON_USB} := octeon-usb.o
+octeon-usb-y := octeon-hcd.o
+octeon-usb-y += cvmx-usb.o
diff --git a/drivers/staging/octeon-usb/TODO b/drivers/staging/octeon-usb/TODO
new file mode 100644
index 0000000..cc58a7e
--- /dev/null
+++ b/drivers/staging/octeon-usb/TODO
@@ -0,0 +1,11 @@
+This driver is functional and has been tested on EdgeRouter Lite with
+USB mass storage.
+
+TODO:
+	- kernel coding style
+	- checkpatch warnings
+	- dead code elimination
+	- device tree bindings
+	- possibly eliminate the extra "hardware abstraction layer"
+
+Contact: Aaro Koskinen <aaro.koskinen@iki.fi>
diff --git a/drivers/staging/octeon-usb/cvmx-usb.c b/drivers/staging/octeon-usb/cvmx-usb.c
new file mode 100644
index 0000000..08ee4ab
--- /dev/null
+++ b/drivers/staging/octeon-usb/cvmx-usb.c
@@ -0,0 +1,3344 @@
+/***********************license start***************
+ * Copyright (c) 2003-2010  Cavium Networks (support@cavium.com). All rights
+ * reserved.
+ *
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *
+ *   * Redistributions in binary form must reproduce the above
+ *     copyright notice, this list of conditions and the following
+ *     disclaimer in the documentation and/or other materials provided
+ *     with the distribution.
+
+ *   * Neither the name of Cavium Networks nor the names of
+ *     its contributors may be used to endorse or promote products
+ *     derived from this software without specific prior written
+ *     permission.
+
+ * This Software, including technical data, may be subject to U.S. export  control
+ * laws, including the U.S. Export Administration Act and its  associated
+ * regulations, and may be subject to export or import  regulations in other
+ * countries.
+
+ * TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
+ * AND WITH ALL FAULTS AND CAVIUM  NETWORKS MAKES NO PROMISES, REPRESENTATIONS OR
+ * WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT TO
+ * THE SOFTWARE, INCLUDING ITS CONDITION, ITS CONFORMITY TO ANY REPRESENTATION OR
+ * DESCRIPTION, OR THE EXISTENCE OF ANY LATENT OR PATENT DEFECTS, AND CAVIUM
+ * SPECIFICALLY DISCLAIMS ALL IMPLIED (IF ANY) WARRANTIES OF TITLE,
+ * MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, LACK OF
+ * VIRUSES, ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION OR
+ * CORRESPONDENCE TO DESCRIPTION. THE ENTIRE  RISK ARISING OUT OF USE OR
+ * PERFORMANCE OF THE SOFTWARE LIES WITH YOU.
+ ***********************license end**************************************/
+
+
+/**
+ * @file
+ *
+ * "cvmx-usb.c" defines a set of low level USB functions to help
+ * developers create Octeon USB drivers for various operating
+ * systems. These functions provide a generic API to the Octeon
+ * USB blocks, hiding the internal hardware specific
+ * operations.
+ *
+ * <hr>$Revision: 32636 $<hr>
+ */
+#include <linux/delay.h>
+#include <asm/octeon/cvmx.h>
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
+#include "cvmx-usbnx-defs.h"
+#include "cvmx-usbcx-defs.h"
+#include "cvmx-usb.h"
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-helper-board.h>
+
+#define CVMX_PREFETCH0(address) CVMX_PREFETCH(address, 0)
+#define CVMX_PREFETCH128(address) CVMX_PREFETCH(address, 128)
+// a normal prefetch
+#define CVMX_PREFETCH(address, offset) CVMX_PREFETCH_PREF0(address, offset)
+// normal prefetches that use the pref instruction
+#define CVMX_PREFETCH_PREFX(X, address, offset) asm volatile ("pref %[type], %[off](%[rbase])" : : [rbase] "d" (address), [off] "I" (offset), [type] "n" (X))
+#define CVMX_PREFETCH_PREF0(address, offset) CVMX_PREFETCH_PREFX(0, address, offset)
+#define CVMX_CLZ(result, input) asm ("clz %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
+
+#define cvmx_likely likely
+#define cvmx_wait_usec udelay
+#define cvmx_unlikely unlikely
+#define cvmx_le16_to_cpu le16_to_cpu
+
+#define MAX_RETRIES         3   /* Maximum number of times to retry failed transactions */
+#define MAX_PIPES           32  /* Maximum number of pipes that can be open at once */
+#define MAX_TRANSACTIONS    256 /* Maximum number of outstanding transactions across all pipes */
+#define MAX_CHANNELS        8   /* Maximum number of hardware channels supported by the USB block */
+#define MAX_USB_ADDRESS     127 /* The highest valid USB device address */
+#define MAX_USB_ENDPOINT    15  /* The highest valid USB endpoint number */
+#define MAX_USB_HUB_PORT    15  /* The highest valid port number on a hub */
+#define MAX_TRANSFER_BYTES  ((1<<19)-1) /* The low level hardware can transfer a maximum of this number of bytes in each transfer. The field is 19 bits wide */
+#define MAX_TRANSFER_PACKETS ((1<<10)-1) /* The low level hardware can transfer a maximum of this number of packets in each transfer. The field is 10 bits wide */
+
+/* These defines disable the normal read and write csr. This is so I can add
+    extra debug stuff to the usb specific version and I won't use the normal
+    version by mistake */
+#define cvmx_read_csr use_cvmx_usb_read_csr64_instead_of_cvmx_read_csr
+#define cvmx_write_csr use_cvmx_usb_write_csr64_instead_of_cvmx_write_csr
+
+typedef enum
+{
+    __CVMX_USB_TRANSACTION_FLAGS_IN_USE = 1<<16,
+} cvmx_usb_transaction_flags_t;
+
+enum {
+	USB_CLOCK_TYPE_REF_12,
+	USB_CLOCK_TYPE_REF_24,
+	USB_CLOCK_TYPE_REF_48,
+	USB_CLOCK_TYPE_CRYSTAL_12,
+};
+
+/**
+ * Logical transactions may take numerous low level
+ * transactions, especially when splits are concerned. This
+ * enum represents all of the possible stages a transaction can
+ * be in. Note that split completes are always even. This is so
+ * the NAK handler can backup to the previous low level
+ * transaction with a simple clearing of bit 0.
+ */
+typedef enum
+{
+    CVMX_USB_STAGE_NON_CONTROL,
+    CVMX_USB_STAGE_NON_CONTROL_SPLIT_COMPLETE,
+    CVMX_USB_STAGE_SETUP,
+    CVMX_USB_STAGE_SETUP_SPLIT_COMPLETE,
+    CVMX_USB_STAGE_DATA,
+    CVMX_USB_STAGE_DATA_SPLIT_COMPLETE,
+    CVMX_USB_STAGE_STATUS,
+    CVMX_USB_STAGE_STATUS_SPLIT_COMPLETE,
+} cvmx_usb_stage_t;
+
+/**
+ * This structure describes each pending USB transaction
+ * regardless of type. These are linked together to form a list
+ * of pending requests for a pipe.
+ */
+typedef struct cvmx_usb_transaction
+{
+    struct cvmx_usb_transaction *prev;  /**< Transaction before this one in the pipe */
+    struct cvmx_usb_transaction *next;  /**< Transaction after this one in the pipe */
+    cvmx_usb_transfer_t type;           /**< Type of transaction, duplicated of the pipe */
+    cvmx_usb_transaction_flags_t flags; /**< State flags for this transaction */
+    uint64_t buffer;                    /**< User's physical buffer address to read/write */
+    int buffer_length;                  /**< Size of the user's buffer in bytes */
+    uint64_t control_header;            /**< For control transactions, physical address of the 8 byte standard header */
+    int iso_start_frame;                /**< For ISO transactions, the starting frame number */
+    int iso_number_packets;             /**< For ISO transactions, the number of packets in the request */
+    cvmx_usb_iso_packet_t *iso_packets; /**< For ISO transactions, the sub packets in the request */
+    int xfersize;
+    int pktcnt;
+    int retries;
+    int actual_bytes;                   /**< Actual bytes transfer for this transaction */
+    cvmx_usb_stage_t stage;             /**< For control transactions, the current stage */
+    cvmx_usb_callback_func_t callback;  /**< User's callback function when complete */
+    void *callback_data;                /**< User's data */
+} cvmx_usb_transaction_t;
+
+/**
+ * A pipe represents a virtual connection between Octeon and some
+ * USB device. It contains a list of pending request to the device.
+ */
+typedef struct cvmx_usb_pipe
+{
+    struct cvmx_usb_pipe *prev;         /**< Pipe before this one in the list */
+    struct cvmx_usb_pipe *next;         /**< Pipe after this one in the list */
+    cvmx_usb_transaction_t *head;       /**< The first pending transaction */
+    cvmx_usb_transaction_t *tail;       /**< The last pending transaction */
+    uint64_t interval;                  /**< For periodic pipes, the interval between packets in frames */
+    uint64_t next_tx_frame;             /**< The next frame this pipe is allowed to transmit on */
+    cvmx_usb_pipe_flags_t flags;        /**< State flags for this pipe */
+    cvmx_usb_speed_t device_speed;      /**< Speed of device connected to this pipe */
+    cvmx_usb_transfer_t transfer_type;  /**< Type of transaction supported by this pipe */
+    cvmx_usb_direction_t transfer_dir;  /**< IN or OUT. Ignored for Control */
+    int multi_count;                    /**< Max packet in a row for the device */
+    uint16_t max_packet;                /**< The device's maximum packet size in bytes */
+    uint8_t device_addr;                /**< USB device address at other end of pipe */
+    uint8_t endpoint_num;               /**< USB endpoint number at other end of pipe */
+    uint8_t hub_device_addr;            /**< Hub address this device is connected to */
+    uint8_t hub_port;                   /**< Hub port this device is connected to */
+    uint8_t pid_toggle;                 /**< This toggles between 0/1 on every packet send to track the data pid needed */
+    uint8_t channel;                    /**< Hardware DMA channel for this pipe */
+    int8_t  split_sc_frame;             /**< The low order bits of the frame number the split complete should be sent on */
+} cvmx_usb_pipe_t;
+
+typedef struct
+{
+    cvmx_usb_pipe_t *head;              /**< Head of the list, or NULL if empty */
+    cvmx_usb_pipe_t *tail;              /**< Tail if the list, or NULL if empty */
+} cvmx_usb_pipe_list_t;
+
+typedef struct
+{
+    struct
+    {
+        int channel;
+        int size;
+        uint64_t address;
+    } entry[MAX_CHANNELS+1];
+    int head;
+    int tail;
+} cvmx_usb_tx_fifo_t;
+
+/**
+ * The state of the USB block is stored in this structure
+ */
+typedef struct
+{
+    int init_flags;                     /**< Flags passed to initialize */
+    int index;                          /**< Which USB block this is for */
+    int idle_hardware_channels;         /**< Bit set for every idle hardware channel */
+    cvmx_usbcx_hprt_t usbcx_hprt;       /**< Stored port status so we don't need to read a CSR to determine splits */
+    cvmx_usb_pipe_t *pipe_for_channel[MAX_CHANNELS];    /**< Map channels to pipes */
+    cvmx_usb_transaction_t *free_transaction_head;      /**< List of free transactions head */
+    cvmx_usb_transaction_t *free_transaction_tail;      /**< List of free transactions tail */
+    cvmx_usb_pipe_t pipe[MAX_PIPES];                    /**< Storage for pipes */
+    cvmx_usb_transaction_t transaction[MAX_TRANSACTIONS];       /**< Storage for transactions */
+    cvmx_usb_callback_func_t callback[__CVMX_USB_CALLBACK_END]; /**< User global callbacks */
+    void *callback_data[__CVMX_USB_CALLBACK_END];               /**< User data for each callback */
+    int indent;                         /**< Used by debug output to indent functions */
+    cvmx_usb_port_status_t port_status; /**< Last port status used for change notification */
+    cvmx_usb_pipe_list_t free_pipes;    /**< List of all pipes that are currently closed */
+    cvmx_usb_pipe_list_t idle_pipes;    /**< List of open pipes that have no transactions */
+    cvmx_usb_pipe_list_t active_pipes[4]; /**< Active pipes indexed by transfer type */
+    uint64_t frame_number;              /**< Increments every SOF interrupt for time keeping */
+    cvmx_usb_transaction_t *active_split; /**< Points to the current active split, or NULL */
+    cvmx_usb_tx_fifo_t periodic;
+    cvmx_usb_tx_fifo_t nonperiodic;
+} cvmx_usb_internal_state_t;
+
+/* This macro logs out whenever a function is called if debugging is on */
+#define CVMX_USB_LOG_CALLED() \
+    if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_CALLS)) \
+        cvmx_dprintf("%*s%s: called\n", 2*usb->indent++, "", __FUNCTION__);
+
+/* This macro logs out each function parameter if debugging is on */
+#define CVMX_USB_LOG_PARAM(format, param) \
+    if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_CALLS)) \
+        cvmx_dprintf("%*s%s: param %s = " format "\n", 2*usb->indent, "", __FUNCTION__, #param, param);
+
+/* This macro logs out when a function returns a value */
+#define CVMX_USB_RETURN(v)                                              \
+    do {                                                                \
+        typeof(v) r = v;                                                \
+        if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_CALLS))    \
+            cvmx_dprintf("%*s%s: returned %s(%d)\n", 2*--usb->indent, "", __FUNCTION__, #v, r); \
+        return r;                                                       \
+    } while (0);
+
+/* This macro logs out when a function doesn't return a value */
+#define CVMX_USB_RETURN_NOTHING()                                       \
+    do {                                                                \
+        if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_CALLS))    \
+            cvmx_dprintf("%*s%s: returned\n", 2*--usb->indent, "", __FUNCTION__); \
+        return;                                                         \
+    } while (0);
+
+/* This macro spins on a field waiting for it to reach a value */
+#define CVMX_WAIT_FOR_FIELD32(address, type, field, op, value, timeout_usec)\
+    ({int result;                                                       \
+    do {                                                                \
+        uint64_t done = cvmx_get_cycle() + (uint64_t)timeout_usec *     \
+			octeon_get_clock_rate() / 1000000;		\
+        type c;                                                         \
+        while (1)                                                       \
+        {                                                               \
+            c.u32 = __cvmx_usb_read_csr32(usb, address);                \
+            if (c.s.field op (value)) {                                 \
+                result = 0;                                             \
+                break;                                                  \
+            } else if (cvmx_get_cycle() > done) {                       \
+                result = -1;                                            \
+                break;                                                  \
+            } else                                                      \
+                cvmx_wait(100);                                         \
+        }                                                               \
+    } while (0);                                                        \
+    result;})
+
+/* This macro logically sets a single field in a CSR. It does the sequence
+    read, modify, and write */
+#define USB_SET_FIELD32(address, type, field, value)\
+    do {                                            \
+        type c;                                     \
+        c.u32 = __cvmx_usb_read_csr32(usb, address);\
+        c.s.field = value;                          \
+        __cvmx_usb_write_csr32(usb, address, c.u32);\
+    } while (0)
+
+/* Returns the IO address to push/pop stuff data from the FIFOs */
+#define USB_FIFO_ADDRESS(channel, usb_index) (CVMX_USBCX_GOTGCTL(usb_index) + ((channel)+1)*0x1000)
+
+static int octeon_usb_get_clock_type(void)
+{
+	switch (cvmx_sysinfo_get()->board_type) {
+	case CVMX_BOARD_TYPE_BBGW_REF:
+	case CVMX_BOARD_TYPE_LANAI2_A:
+	case CVMX_BOARD_TYPE_LANAI2_U:
+	case CVMX_BOARD_TYPE_LANAI2_G:
+		return USB_CLOCK_TYPE_CRYSTAL_12;
+	}
+
+	/* FIXME: This should use CVMX_BOARD_TYPE_UBNT_E100 */
+	if (OCTEON_IS_MODEL(OCTEON_CN50XX) &&
+	    cvmx_sysinfo_get()->board_type == 20002)
+		return USB_CLOCK_TYPE_CRYSTAL_12;
+
+	return USB_CLOCK_TYPE_REF_48;
+}
+
+/**
+ * @INTERNAL
+ * Read a USB 32bit CSR. It performs the necessary address swizzle
+ * for 32bit CSRs and logs the value in a readable format if
+ * debugging is on.
+ *
+ * @param usb     USB block this access is for
+ * @param address 64bit address to read
+ *
+ * @return Result of the read
+ */
+static inline uint32_t __cvmx_usb_read_csr32(cvmx_usb_internal_state_t *usb,
+                                             uint64_t address)
+{
+    uint32_t result = cvmx_read64_uint32(address ^ 4);
+    return result;
+}
+
+
+/**
+ * @INTERNAL
+ * Write a USB 32bit CSR. It performs the necessary address
+ * swizzle for 32bit CSRs and logs the value in a readable format
+ * if debugging is on.
+ *
+ * @param usb     USB block this access is for
+ * @param address 64bit address to write
+ * @param value   Value to write
+ */
+static inline void __cvmx_usb_write_csr32(cvmx_usb_internal_state_t *usb,
+                                          uint64_t address, uint32_t value)
+{
+    cvmx_write64_uint32(address ^ 4, value);
+    cvmx_read64_uint64(CVMX_USBNX_DMA0_INB_CHN0(usb->index));
+}
+
+
+/**
+ * @INTERNAL
+ * Read a USB 64bit CSR. It logs the value in a readable format if
+ * debugging is on.
+ *
+ * @param usb     USB block this access is for
+ * @param address 64bit address to read
+ *
+ * @return Result of the read
+ */
+static inline uint64_t __cvmx_usb_read_csr64(cvmx_usb_internal_state_t *usb,
+                                             uint64_t address)
+{
+    uint64_t result = cvmx_read64_uint64(address);
+    return result;
+}
+
+
+/**
+ * @INTERNAL
+ * Write a USB 64bit CSR. It logs the value in a readable format
+ * if debugging is on.
+ *
+ * @param usb     USB block this access is for
+ * @param address 64bit address to write
+ * @param value   Value to write
+ */
+static inline void __cvmx_usb_write_csr64(cvmx_usb_internal_state_t *usb,
+                                          uint64_t address, uint64_t value)
+{
+    cvmx_write64_uint64(address, value);
+}
+
+
+/**
+ * @INTERNAL
+ * Utility function to convert complete codes into strings
+ *
+ * @param complete_code
+ *               Code to convert
+ *
+ * @return Human readable string
+ */
+static const char *__cvmx_usb_complete_to_string(cvmx_usb_complete_t complete_code)
+{
+    switch (complete_code)
+    {
+        case CVMX_USB_COMPLETE_SUCCESS: return "SUCCESS";
+        case CVMX_USB_COMPLETE_SHORT:   return "SHORT";
+        case CVMX_USB_COMPLETE_CANCEL:  return "CANCEL";
+        case CVMX_USB_COMPLETE_ERROR:   return "ERROR";
+        case CVMX_USB_COMPLETE_STALL:   return "STALL";
+        case CVMX_USB_COMPLETE_XACTERR: return "XACTERR";
+        case CVMX_USB_COMPLETE_DATATGLERR: return "DATATGLERR";
+        case CVMX_USB_COMPLETE_BABBLEERR: return "BABBLEERR";
+        case CVMX_USB_COMPLETE_FRAMEERR: return "FRAMEERR";
+    }
+    return "Update __cvmx_usb_complete_to_string";
+}
+
+
+/**
+ * @INTERNAL
+ * Return non zero if this pipe connects to a non HIGH speed
+ * device through a high speed hub.
+ *
+ * @param usb    USB block this access is for
+ * @param pipe   Pipe to check
+ *
+ * @return Non zero if we need to do split transactions
+ */
+static inline int __cvmx_usb_pipe_needs_split(cvmx_usb_internal_state_t *usb, cvmx_usb_pipe_t *pipe)
+{
+    return ((pipe->device_speed != CVMX_USB_SPEED_HIGH) && (usb->usbcx_hprt.s.prtspd == CVMX_USB_SPEED_HIGH));
+}
+
+
+/**
+ * @INTERNAL
+ * Trivial utility function to return the correct PID for a pipe
+ *
+ * @param pipe   pipe to check
+ *
+ * @return PID for pipe
+ */
+static inline int __cvmx_usb_get_data_pid(cvmx_usb_pipe_t *pipe)
+{
+    if (pipe->pid_toggle)
+        return 2; /* Data1 */
+    else
+        return 0; /* Data0 */
+}
+
+
+/**
+ * Return the number of USB ports supported by this Octeon
+ * chip. If the chip doesn't support USB, or is not supported
+ * by this API, a zero will be returned. Most Octeon chips
+ * support one usb port, but some support two ports.
+ * cvmx_usb_initialize() must be called on independent
+ * cvmx_usb_state_t structures.
+ *
+ * @return Number of port, zero if usb isn't supported
+ */
+int cvmx_usb_get_num_ports(void)
+{
+    int arch_ports = 0;
+
+    if (OCTEON_IS_MODEL(OCTEON_CN56XX))
+        arch_ports = 1;
+    else if (OCTEON_IS_MODEL(OCTEON_CN52XX))
+        arch_ports = 2;
+    else if (OCTEON_IS_MODEL(OCTEON_CN50XX))
+        arch_ports = 1;
+    else if (OCTEON_IS_MODEL(OCTEON_CN31XX))
+        arch_ports = 1;
+    else if (OCTEON_IS_MODEL(OCTEON_CN30XX))
+        arch_ports = 1;
+    else
+        arch_ports = 0;
+
+    return arch_ports;
+}
+
+
+/**
+ * @INTERNAL
+ * Allocate a usb transaction for use
+ *
+ * @param usb    USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return Transaction or NULL
+ */
+static inline cvmx_usb_transaction_t *__cvmx_usb_alloc_transaction(cvmx_usb_internal_state_t *usb)
+{
+    cvmx_usb_transaction_t *t;
+    t = usb->free_transaction_head;
+    if (t)
+    {
+        usb->free_transaction_head = t->next;
+        if (!usb->free_transaction_head)
+            usb->free_transaction_tail = NULL;
+    }
+    else if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_INFO))
+        cvmx_dprintf("%s: Failed to allocate a transaction\n", __FUNCTION__);
+    if (t)
+    {
+        memset(t, 0, sizeof(*t));
+        t->flags = __CVMX_USB_TRANSACTION_FLAGS_IN_USE;
+    }
+    return t;
+}
+
+
+/**
+ * @INTERNAL
+ * Free a usb transaction
+ *
+ * @param usb    USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param transaction
+ *               Transaction to free
+ */
+static inline void __cvmx_usb_free_transaction(cvmx_usb_internal_state_t *usb,
+                                        cvmx_usb_transaction_t *transaction)
+{
+    transaction->flags = 0;
+    transaction->prev = NULL;
+    transaction->next = NULL;
+    if (usb->free_transaction_tail)
+        usb->free_transaction_tail->next = transaction;
+    else
+        usb->free_transaction_head = transaction;
+    usb->free_transaction_tail = transaction;
+}
+
+
+/**
+ * @INTERNAL
+ * Add a pipe to the tail of a list
+ * @param list   List to add pipe to
+ * @param pipe   Pipe to add
+ */
+static inline void __cvmx_usb_append_pipe(cvmx_usb_pipe_list_t *list, cvmx_usb_pipe_t *pipe)
+{
+    pipe->next = NULL;
+    pipe->prev = list->tail;
+    if (list->tail)
+        list->tail->next = pipe;
+    else
+        list->head = pipe;
+    list->tail = pipe;
+}
+
+
+/**
+ * @INTERNAL
+ * Remove a pipe from a list
+ * @param list   List to remove pipe from
+ * @param pipe   Pipe to remove
+ */
+static inline void __cvmx_usb_remove_pipe(cvmx_usb_pipe_list_t *list, cvmx_usb_pipe_t *pipe)
+{
+    if (list->head == pipe)
+    {
+        list->head = pipe->next;
+        pipe->next = NULL;
+        if (list->head)
+            list->head->prev = NULL;
+        else
+            list->tail = NULL;
+    }
+    else if (list->tail == pipe)
+    {
+        list->tail = pipe->prev;
+        list->tail->next = NULL;
+        pipe->prev = NULL;
+    }
+    else
+    {
+        pipe->prev->next = pipe->next;
+        pipe->next->prev = pipe->prev;
+        pipe->prev = NULL;
+        pipe->next = NULL;
+    }
+}
+
+
+/**
+ * Initialize a USB port for use. This must be called before any
+ * other access to the Octeon USB port is made. The port starts
+ * off in the disabled state.
+ *
+ * @param state  Pointer to an empty cvmx_usb_state_t structure
+ *               that will be populated by the initialize call.
+ *               This structure is then passed to all other USB
+ *               functions.
+ * @param usb_port_number
+ *               Which Octeon USB port to initialize.
+ * @param flags  Flags to control hardware initialization. See
+ *               cvmx_usb_initialize_flags_t for the flag
+ *               definitions. Some flags are mandatory.
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+cvmx_usb_status_t cvmx_usb_initialize(cvmx_usb_state_t *state,
+                                      int usb_port_number,
+                                      cvmx_usb_initialize_flags_t flags)
+{
+    cvmx_usbnx_clk_ctl_t usbn_clk_ctl;
+    cvmx_usbnx_usbp_ctl_status_t usbn_usbp_ctl_status;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    usb->init_flags = flags;
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    CVMX_USB_LOG_PARAM("%d", usb_port_number);
+    CVMX_USB_LOG_PARAM("0x%x", flags);
+
+    /* Make sure that state is large enough to store the internal state */
+    if (sizeof(*state) < sizeof(*usb))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    /* At first allow 0-1 for the usb port number */
+    if ((usb_port_number < 0) || (usb_port_number > 1))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    /* For all chips except 52XX there is only one port */
+    if (!OCTEON_IS_MODEL(OCTEON_CN52XX) && (usb_port_number > 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    /* Try to determine clock type automatically */
+    if ((flags & (CVMX_USB_INITIALIZE_FLAGS_CLOCK_XO_XI |
+                  CVMX_USB_INITIALIZE_FLAGS_CLOCK_XO_GND)) == 0)
+    {
+        if (octeon_usb_get_clock_type() == USB_CLOCK_TYPE_CRYSTAL_12)
+            flags |= CVMX_USB_INITIALIZE_FLAGS_CLOCK_XO_XI;  /* Only 12 MHZ crystals are supported */
+        else
+            flags |= CVMX_USB_INITIALIZE_FLAGS_CLOCK_XO_GND;
+    }
+
+    if (flags & CVMX_USB_INITIALIZE_FLAGS_CLOCK_XO_GND)
+    {
+        /* Check for auto ref clock frequency */
+        if (!(flags & CVMX_USB_INITIALIZE_FLAGS_CLOCK_MHZ_MASK))
+            switch (octeon_usb_get_clock_type())
+            {
+                case USB_CLOCK_TYPE_REF_12:
+                    flags |= CVMX_USB_INITIALIZE_FLAGS_CLOCK_12MHZ;
+                    break;
+                case USB_CLOCK_TYPE_REF_24:
+                    flags |= CVMX_USB_INITIALIZE_FLAGS_CLOCK_24MHZ;
+                    break;
+                case USB_CLOCK_TYPE_REF_48:
+                    flags |= CVMX_USB_INITIALIZE_FLAGS_CLOCK_48MHZ;
+                    break;
+                default:
+                    CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+                    break;
+            }
+    }
+
+    memset(usb, 0, sizeof(usb));
+    usb->init_flags = flags;
+
+    /* Initialize the USB state structure */
+    {
+        int i;
+        usb->index = usb_port_number;
+
+        /* Initialize the transaction double linked list */
+        usb->free_transaction_head = NULL;
+        usb->free_transaction_tail = NULL;
+        for (i=0; i<MAX_TRANSACTIONS; i++)
+            __cvmx_usb_free_transaction(usb, usb->transaction + i);
+        for (i=0; i<MAX_PIPES; i++)
+            __cvmx_usb_append_pipe(&usb->free_pipes, usb->pipe + i);
+    }
+
+    /* Power On Reset and PHY Initialization */
+
+    /* 1. Wait for DCOK to assert (nothing to do) */
+    /* 2a. Write USBN0/1_CLK_CTL[POR] = 1 and
+        USBN0/1_CLK_CTL[HRST,PRST,HCLK_RST] = 0 */
+    usbn_clk_ctl.u64 = __cvmx_usb_read_csr64(usb, CVMX_USBNX_CLK_CTL(usb->index));
+    usbn_clk_ctl.s.por = 1;
+    usbn_clk_ctl.s.hrst = 0;
+    usbn_clk_ctl.s.prst = 0;
+    usbn_clk_ctl.s.hclk_rst = 0;
+    usbn_clk_ctl.s.enable = 0;
+    /* 2b. Select the USB reference clock/crystal parameters by writing
+        appropriate values to USBN0/1_CLK_CTL[P_C_SEL, P_RTYPE, P_COM_ON] */
+    if (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_CLOCK_XO_GND)
+    {
+        /* The USB port uses 12/24/48MHz 2.5V board clock
+            source at USB_XO. USB_XI should be tied to GND.
+            Most Octeon evaluation boards require this setting */
+        if (OCTEON_IS_MODEL(OCTEON_CN3XXX))
+        {
+            usbn_clk_ctl.cn31xx.p_rclk  = 1; /* From CN31XX,CN30XX manual */
+            usbn_clk_ctl.cn31xx.p_xenbn = 0;
+        }
+        else if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN50XX))
+            usbn_clk_ctl.cn56xx.p_rtype = 2; /* From CN56XX,CN50XX manual */
+        else
+            usbn_clk_ctl.cn52xx.p_rtype = 1; /* From CN52XX manual */
+
+        switch (flags & CVMX_USB_INITIALIZE_FLAGS_CLOCK_MHZ_MASK)
+        {
+            case CVMX_USB_INITIALIZE_FLAGS_CLOCK_12MHZ:
+                usbn_clk_ctl.s.p_c_sel = 0;
+                break;
+            case CVMX_USB_INITIALIZE_FLAGS_CLOCK_24MHZ:
+                usbn_clk_ctl.s.p_c_sel = 1;
+                break;
+            case CVMX_USB_INITIALIZE_FLAGS_CLOCK_48MHZ:
+                usbn_clk_ctl.s.p_c_sel = 2;
+                break;
+        }
+    }
+    else
+    {
+        /* The USB port uses a 12MHz crystal as clock source
+            at USB_XO and USB_XI */
+        if (OCTEON_IS_MODEL(OCTEON_CN3XXX))
+        {
+            usbn_clk_ctl.cn31xx.p_rclk  = 1; /* From CN31XX,CN30XX manual */
+            usbn_clk_ctl.cn31xx.p_xenbn = 1;
+        }
+        else if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN50XX))
+            usbn_clk_ctl.cn56xx.p_rtype = 0; /* From CN56XX,CN50XX manual */
+        else
+            usbn_clk_ctl.cn52xx.p_rtype = 0; /* From CN52XX manual */
+
+        usbn_clk_ctl.s.p_c_sel = 0;
+    }
+    /* 2c. Select the HCLK via writing USBN0/1_CLK_CTL[DIVIDE, DIVIDE2] and
+        setting USBN0/1_CLK_CTL[ENABLE] = 1.  Divide the core clock down such
+        that USB is as close as possible to 125Mhz */
+    {
+        int divisor = (octeon_get_clock_rate()+125000000-1)/125000000;
+        if (divisor < 4)  /* Lower than 4 doesn't seem to work properly */
+            divisor = 4;
+        usbn_clk_ctl.s.divide = divisor;
+        usbn_clk_ctl.s.divide2 = 0;
+    }
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_CLK_CTL(usb->index),
+                           usbn_clk_ctl.u64);
+    /* 2d. Write USBN0/1_CLK_CTL[HCLK_RST] = 1 */
+    usbn_clk_ctl.s.hclk_rst = 1;
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_CLK_CTL(usb->index),
+                           usbn_clk_ctl.u64);
+    /* 2e.  Wait 64 core-clock cycles for HCLK to stabilize */
+    cvmx_wait(64);
+    /* 3. Program the power-on reset field in the USBN clock-control register:
+        USBN_CLK_CTL[POR] = 0 */
+    usbn_clk_ctl.s.por = 0;
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_CLK_CTL(usb->index),
+                           usbn_clk_ctl.u64);
+    /* 4. Wait 1 ms for PHY clock to start */
+    cvmx_wait_usec(1000);
+    /* 5. Program the Reset input from automatic test equipment field in the
+        USBP control and status register: USBN_USBP_CTL_STATUS[ATE_RESET] = 1 */
+    usbn_usbp_ctl_status.u64 = __cvmx_usb_read_csr64(usb, CVMX_USBNX_USBP_CTL_STATUS(usb->index));
+    usbn_usbp_ctl_status.s.ate_reset = 1;
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_USBP_CTL_STATUS(usb->index),
+                           usbn_usbp_ctl_status.u64);
+    /* 6. Wait 10 cycles */
+    cvmx_wait(10);
+    /* 7. Clear ATE_RESET field in the USBN clock-control register:
+        USBN_USBP_CTL_STATUS[ATE_RESET] = 0 */
+    usbn_usbp_ctl_status.s.ate_reset = 0;
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_USBP_CTL_STATUS(usb->index),
+                           usbn_usbp_ctl_status.u64);
+    /* 8. Program the PHY reset field in the USBN clock-control register:
+        USBN_CLK_CTL[PRST] = 1 */
+    usbn_clk_ctl.s.prst = 1;
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_CLK_CTL(usb->index),
+                           usbn_clk_ctl.u64);
+    /* 9. Program the USBP control and status register to select host or
+        device mode. USBN_USBP_CTL_STATUS[HST_MODE] = 0 for host, = 1 for
+        device */
+    usbn_usbp_ctl_status.s.hst_mode = 0;
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_USBP_CTL_STATUS(usb->index),
+                           usbn_usbp_ctl_status.u64);
+    /* 10. Wait 1 us */
+    cvmx_wait_usec(1);
+    /* 11. Program the hreset_n field in the USBN clock-control register:
+        USBN_CLK_CTL[HRST] = 1 */
+    usbn_clk_ctl.s.hrst = 1;
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_CLK_CTL(usb->index),
+                           usbn_clk_ctl.u64);
+    /* 12. Proceed to USB core initialization */
+    usbn_clk_ctl.s.enable = 1;
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_CLK_CTL(usb->index),
+                           usbn_clk_ctl.u64);
+    cvmx_wait_usec(1);
+
+    /* USB Core Initialization */
+
+    /* 1. Read USBC_GHWCFG1, USBC_GHWCFG2, USBC_GHWCFG3, USBC_GHWCFG4 to
+        determine USB core configuration parameters. */
+    /* Nothing needed */
+    /* 2. Program the following fields in the global AHB configuration
+        register (USBC_GAHBCFG)
+        DMA mode, USBC_GAHBCFG[DMAEn]: 1 = DMA mode, 0 = slave mode
+        Burst length, USBC_GAHBCFG[HBSTLEN] = 0
+        Nonperiodic TxFIFO empty level (slave mode only),
+        USBC_GAHBCFG[NPTXFEMPLVL]
+        Periodic TxFIFO empty level (slave mode only),
+        USBC_GAHBCFG[PTXFEMPLVL]
+        Global interrupt mask, USBC_GAHBCFG[GLBLINTRMSK] = 1 */
+    {
+        cvmx_usbcx_gahbcfg_t usbcx_gahbcfg;
+        /* Due to an errata, CN31XX doesn't support DMA */
+        if (OCTEON_IS_MODEL(OCTEON_CN31XX))
+            usb->init_flags |= CVMX_USB_INITIALIZE_FLAGS_NO_DMA;
+        usbcx_gahbcfg.u32 = 0;
+        usbcx_gahbcfg.s.dmaen = !(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA);
+        if (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA)
+            usb->idle_hardware_channels = 0x1;  /* Only use one channel with non DMA */
+        else if (OCTEON_IS_MODEL(OCTEON_CN5XXX))
+            usb->idle_hardware_channels = 0xf7; /* CN5XXX have an errata with channel 3 */
+        else
+            usb->idle_hardware_channels = 0xff;
+        usbcx_gahbcfg.s.hbstlen = 0;
+        usbcx_gahbcfg.s.nptxfemplvl = 1;
+        usbcx_gahbcfg.s.ptxfemplvl = 1;
+        usbcx_gahbcfg.s.glblintrmsk = 1;
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_GAHBCFG(usb->index),
+                               usbcx_gahbcfg.u32);
+    }
+    /* 3. Program the following fields in USBC_GUSBCFG register.
+        HS/FS timeout calibration, USBC_GUSBCFG[TOUTCAL] = 0
+        ULPI DDR select, USBC_GUSBCFG[DDRSEL] = 0
+        USB turnaround time, USBC_GUSBCFG[USBTRDTIM] = 0x5
+        PHY low-power clock select, USBC_GUSBCFG[PHYLPWRCLKSEL] = 0 */
+    {
+        cvmx_usbcx_gusbcfg_t usbcx_gusbcfg;
+        usbcx_gusbcfg.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_GUSBCFG(usb->index));
+        usbcx_gusbcfg.s.toutcal = 0;
+        usbcx_gusbcfg.s.ddrsel = 0;
+        usbcx_gusbcfg.s.usbtrdtim = 0x5;
+        usbcx_gusbcfg.s.phylpwrclksel = 0;
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_GUSBCFG(usb->index),
+                               usbcx_gusbcfg.u32);
+    }
+    /* 4. The software must unmask the following bits in the USBC_GINTMSK
+        register.
+        OTG interrupt mask, USBC_GINTMSK[OTGINTMSK] = 1
+        Mode mismatch interrupt mask, USBC_GINTMSK[MODEMISMSK] = 1 */
+    {
+        cvmx_usbcx_gintmsk_t usbcx_gintmsk;
+        int channel;
+
+        usbcx_gintmsk.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_GINTMSK(usb->index));
+        usbcx_gintmsk.s.otgintmsk = 1;
+        usbcx_gintmsk.s.modemismsk = 1;
+        usbcx_gintmsk.s.hchintmsk = 1;
+        usbcx_gintmsk.s.sofmsk = 0;
+        /* We need RX FIFO interrupts if we don't have DMA */
+        if (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA)
+            usbcx_gintmsk.s.rxflvlmsk = 1;
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_GINTMSK(usb->index),
+                               usbcx_gintmsk.u32);
+
+        /* Disable all channel interrupts. We'll enable them per channel later */
+        for (channel=0; channel<8; channel++)
+            __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCINTMSKX(channel, usb->index), 0);
+    }
+
+    {
+        /* Host Port Initialization */
+        if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_INFO))
+            cvmx_dprintf("%s: USB%d is in host mode\n", __FUNCTION__, usb->index);
+
+        /* 1. Program the host-port interrupt-mask field to unmask,
+            USBC_GINTMSK[PRTINT] = 1 */
+        USB_SET_FIELD32(CVMX_USBCX_GINTMSK(usb->index), cvmx_usbcx_gintmsk_t,
+                        prtintmsk, 1);
+        USB_SET_FIELD32(CVMX_USBCX_GINTMSK(usb->index), cvmx_usbcx_gintmsk_t,
+                        disconnintmsk, 1);
+        /* 2. Program the USBC_HCFG register to select full-speed host or
+            high-speed host. */
+        {
+            cvmx_usbcx_hcfg_t usbcx_hcfg;
+            usbcx_hcfg.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCFG(usb->index));
+            usbcx_hcfg.s.fslssupp = 0;
+            usbcx_hcfg.s.fslspclksel = 0;
+            __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCFG(usb->index), usbcx_hcfg.u32);
+        }
+        /* 3. Program the port power bit to drive VBUS on the USB,
+            USBC_HPRT[PRTPWR] = 1 */
+        USB_SET_FIELD32(CVMX_USBCX_HPRT(usb->index), cvmx_usbcx_hprt_t, prtpwr, 1);
+
+        /* Steps 4-15 from the manual are done later in the port enable */
+    }
+
+    CVMX_USB_RETURN(CVMX_USB_SUCCESS);
+}
+
+
+/**
+ * Shutdown a USB port after a call to cvmx_usb_initialize().
+ * The port should be disabled with all pipes closed when this
+ * function is called.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+cvmx_usb_status_t cvmx_usb_shutdown(cvmx_usb_state_t *state)
+{
+    cvmx_usbnx_clk_ctl_t usbn_clk_ctl;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+
+    /* Make sure all pipes are closed */
+    if (usb->idle_pipes.head ||
+        usb->active_pipes[CVMX_USB_TRANSFER_ISOCHRONOUS].head ||
+        usb->active_pipes[CVMX_USB_TRANSFER_INTERRUPT].head ||
+        usb->active_pipes[CVMX_USB_TRANSFER_CONTROL].head ||
+        usb->active_pipes[CVMX_USB_TRANSFER_BULK].head)
+        CVMX_USB_RETURN(CVMX_USB_BUSY);
+
+    /* Disable the clocks and put them in power on reset */
+    usbn_clk_ctl.u64 = __cvmx_usb_read_csr64(usb, CVMX_USBNX_CLK_CTL(usb->index));
+    usbn_clk_ctl.s.enable = 1;
+    usbn_clk_ctl.s.por = 1;
+    usbn_clk_ctl.s.hclk_rst = 1;
+    usbn_clk_ctl.s.prst = 0;
+    usbn_clk_ctl.s.hrst = 0;
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_CLK_CTL(usb->index),
+                           usbn_clk_ctl.u64);
+    CVMX_USB_RETURN(CVMX_USB_SUCCESS);
+}
+
+
+/**
+ * Enable a USB port. After this call succeeds, the USB port is
+ * online and servicing requests.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+cvmx_usb_status_t cvmx_usb_enable(cvmx_usb_state_t *state)
+{
+    cvmx_usbcx_ghwcfg3_t usbcx_ghwcfg3;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+
+    usb->usbcx_hprt.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HPRT(usb->index));
+
+    /* If the port is already enabled the just return. We don't need to do
+        anything */
+    if (usb->usbcx_hprt.s.prtena)
+        CVMX_USB_RETURN(CVMX_USB_SUCCESS);
+
+    /* If there is nothing plugged into the port then fail immediately */
+    if (!usb->usbcx_hprt.s.prtconnsts)
+    {
+        if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_INFO))
+            cvmx_dprintf("%s: USB%d Nothing plugged into the port\n", __FUNCTION__, usb->index);
+        CVMX_USB_RETURN(CVMX_USB_TIMEOUT);
+    }
+
+    /* Program the port reset bit to start the reset process */
+    USB_SET_FIELD32(CVMX_USBCX_HPRT(usb->index), cvmx_usbcx_hprt_t, prtrst, 1);
+
+    /* Wait at least 50ms (high speed), or 10ms (full speed) for the reset
+        process to complete. */
+    cvmx_wait_usec(50000);
+
+    /* Program the port reset bit to 0, USBC_HPRT[PRTRST] = 0 */
+    USB_SET_FIELD32(CVMX_USBCX_HPRT(usb->index), cvmx_usbcx_hprt_t, prtrst, 0);
+
+    /* Wait for the USBC_HPRT[PRTENA]. */
+    if (CVMX_WAIT_FOR_FIELD32(CVMX_USBCX_HPRT(usb->index), cvmx_usbcx_hprt_t,
+                              prtena, ==, 1, 100000))
+    {
+        if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_INFO))
+            cvmx_dprintf("%s: Timeout waiting for the port to finish reset\n",
+                         __FUNCTION__);
+        CVMX_USB_RETURN(CVMX_USB_TIMEOUT);
+    }
+
+    /* Read the port speed field to get the enumerated speed, USBC_HPRT[PRTSPD]. */
+    usb->usbcx_hprt.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HPRT(usb->index));
+    if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_INFO))
+        cvmx_dprintf("%s: USB%d is in %s speed mode\n", __FUNCTION__, usb->index,
+                     (usb->usbcx_hprt.s.prtspd == CVMX_USB_SPEED_HIGH) ? "high" :
+                     (usb->usbcx_hprt.s.prtspd == CVMX_USB_SPEED_FULL) ? "full" :
+                     "low");
+
+    usbcx_ghwcfg3.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_GHWCFG3(usb->index));
+
+    /* 13. Program the USBC_GRXFSIZ register to select the size of the receive
+        FIFO (25%). */
+    USB_SET_FIELD32(CVMX_USBCX_GRXFSIZ(usb->index), cvmx_usbcx_grxfsiz_t,
+                    rxfdep, usbcx_ghwcfg3.s.dfifodepth / 4);
+    /* 14. Program the USBC_GNPTXFSIZ register to select the size and the
+        start address of the non- periodic transmit FIFO for nonperiodic
+        transactions (50%). */
+    {
+        cvmx_usbcx_gnptxfsiz_t siz;
+        siz.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_GNPTXFSIZ(usb->index));
+        siz.s.nptxfdep = usbcx_ghwcfg3.s.dfifodepth / 2;
+        siz.s.nptxfstaddr = usbcx_ghwcfg3.s.dfifodepth / 4;
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_GNPTXFSIZ(usb->index), siz.u32);
+    }
+    /* 15. Program the USBC_HPTXFSIZ register to select the size and start
+        address of the periodic transmit FIFO for periodic transactions (25%). */
+    {
+        cvmx_usbcx_hptxfsiz_t siz;
+        siz.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HPTXFSIZ(usb->index));
+        siz.s.ptxfsize = usbcx_ghwcfg3.s.dfifodepth / 4;
+        siz.s.ptxfstaddr = 3 * usbcx_ghwcfg3.s.dfifodepth / 4;
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_HPTXFSIZ(usb->index), siz.u32);
+    }
+    /* Flush all FIFOs */
+    USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index), cvmx_usbcx_grstctl_t, txfnum, 0x10);
+    USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index), cvmx_usbcx_grstctl_t, txfflsh, 1);
+    CVMX_WAIT_FOR_FIELD32(CVMX_USBCX_GRSTCTL(usb->index), cvmx_usbcx_grstctl_t,
+                          txfflsh, ==, 0, 100);
+    USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index), cvmx_usbcx_grstctl_t, rxfflsh, 1);
+    CVMX_WAIT_FOR_FIELD32(CVMX_USBCX_GRSTCTL(usb->index), cvmx_usbcx_grstctl_t,
+                          rxfflsh, ==, 0, 100);
+
+    CVMX_USB_RETURN(CVMX_USB_SUCCESS);
+}
+
+
+/**
+ * Disable a USB port. After this call the USB port will not
+ * generate data transfers and will not generate events.
+ * Transactions in process will fail and call their
+ * associated callbacks.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+cvmx_usb_status_t cvmx_usb_disable(cvmx_usb_state_t *state)
+{
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+
+    /* Disable the port */
+    USB_SET_FIELD32(CVMX_USBCX_HPRT(usb->index), cvmx_usbcx_hprt_t, prtena, 1);
+    CVMX_USB_RETURN(CVMX_USB_SUCCESS);
+}
+
+
+/**
+ * Get the current state of the USB port. Use this call to
+ * determine if the usb port has anything connected, is enabled,
+ * or has some sort of error condition. The return value of this
+ * call has "changed" bits to signal of the value of some fields
+ * have changed between calls. These "changed" fields are based
+ * on the last call to cvmx_usb_set_status(). In order to clear
+ * them, you must update the status through cvmx_usb_set_status().
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return Port status information
+ */
+cvmx_usb_port_status_t cvmx_usb_get_status(cvmx_usb_state_t *state)
+{
+    cvmx_usbcx_hprt_t usbc_hprt;
+    cvmx_usb_port_status_t result;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    memset(&result, 0, sizeof(result));
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+
+    usbc_hprt.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HPRT(usb->index));
+    result.port_enabled = usbc_hprt.s.prtena;
+    result.port_over_current = usbc_hprt.s.prtovrcurract;
+    result.port_powered = usbc_hprt.s.prtpwr;
+    result.port_speed = usbc_hprt.s.prtspd;
+    result.connected = usbc_hprt.s.prtconnsts;
+    result.connect_change = (result.connected != usb->port_status.connected);
+
+    if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_CALLS))
+        cvmx_dprintf("%*s%s: returned port enabled=%d, over_current=%d, powered=%d, speed=%d, connected=%d, connect_change=%d\n",
+                     2*(--usb->indent), "", __FUNCTION__,
+                     result.port_enabled,
+                     result.port_over_current,
+                     result.port_powered,
+                     result.port_speed,
+                     result.connected,
+                     result.connect_change);
+    return result;
+}
+
+
+/**
+ * Set the current state of the USB port. The status is used as
+ * a reference for the "changed" bits returned by
+ * cvmx_usb_get_status(). Other than serving as a reference, the
+ * status passed to this function is not used. No fields can be
+ * changed through this call.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param port_status
+ *               Port status to set, most like returned by cvmx_usb_get_status()
+ */
+void cvmx_usb_set_status(cvmx_usb_state_t *state, cvmx_usb_port_status_t port_status)
+{
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    usb->port_status = port_status;
+    CVMX_USB_RETURN_NOTHING();
+}
+
+
+/**
+ * @INTERNAL
+ * Convert a USB transaction into a handle
+ *
+ * @param usb    USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param transaction
+ *               Transaction to get handle for
+ *
+ * @return Handle
+ */
+static inline int __cvmx_usb_get_submit_handle(cvmx_usb_internal_state_t *usb,
+                                        cvmx_usb_transaction_t *transaction)
+{
+    return ((unsigned long)transaction - (unsigned long)usb->transaction) /
+            sizeof(*transaction);
+}
+
+
+/**
+ * @INTERNAL
+ * Convert a USB pipe into a handle
+ *
+ * @param usb    USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param pipe   Pipe to get handle for
+ *
+ * @return Handle
+ */
+static inline int __cvmx_usb_get_pipe_handle(cvmx_usb_internal_state_t *usb,
+                                        cvmx_usb_pipe_t *pipe)
+{
+    return ((unsigned long)pipe - (unsigned long)usb->pipe) / sizeof(*pipe);
+}
+
+
+/**
+ * Open a virtual pipe between the host and a USB device. A pipe
+ * must be opened before data can be transferred between a device
+ * and Octeon.
+ *
+ * @param state      USB device state populated by
+ *                   cvmx_usb_initialize().
+ * @param flags      Optional pipe flags defined in
+ *                   cvmx_usb_pipe_flags_t.
+ * @param device_addr
+ *                   USB device address to open the pipe to
+ *                   (0-127).
+ * @param endpoint_num
+ *                   USB endpoint number to open the pipe to
+ *                   (0-15).
+ * @param device_speed
+ *                   The speed of the device the pipe is going
+ *                   to. This must match the device's speed,
+ *                   which may be different than the port speed.
+ * @param max_packet The maximum packet length the device can
+ *                   transmit/receive (low speed=0-8, full
+ *                   speed=0-1023, high speed=0-1024). This value
+ *                   comes from the standard endpoint descriptor
+ *                   field wMaxPacketSize bits <10:0>.
+ * @param transfer_type
+ *                   The type of transfer this pipe is for.
+ * @param transfer_dir
+ *                   The direction the pipe is in. This is not
+ *                   used for control pipes.
+ * @param interval   For ISOCHRONOUS and INTERRUPT transfers,
+ *                   this is how often the transfer is scheduled
+ *                   for. All other transfers should specify
+ *                   zero. The units are in frames (8000/sec at
+ *                   high speed, 1000/sec for full speed).
+ * @param multi_count
+ *                   For high speed devices, this is the maximum
+ *                   allowed number of packet per microframe.
+ *                   Specify zero for non high speed devices. This
+ *                   value comes from the standard endpoint descriptor
+ *                   field wMaxPacketSize bits <12:11>.
+ * @param hub_device_addr
+ *                   Hub device address this device is connected
+ *                   to. Devices connected directly to Octeon
+ *                   use zero. This is only used when the device
+ *                   is full/low speed behind a high speed hub.
+ *                   The address will be of the high speed hub,
+ *                   not and full speed hubs after it.
+ * @param hub_port   Which port on the hub the device is
+ *                   connected. Use zero for devices connected
+ *                   directly to Octeon. Like hub_device_addr,
+ *                   this is only used for full/low speed
+ *                   devices behind a high speed hub.
+ *
+ * @return A non negative value is a pipe handle. Negative
+ *         values are failure codes from cvmx_usb_status_t.
+ */
+int cvmx_usb_open_pipe(cvmx_usb_state_t *state, cvmx_usb_pipe_flags_t flags,
+                       int device_addr, int endpoint_num,
+                       cvmx_usb_speed_t device_speed, int max_packet,
+                       cvmx_usb_transfer_t transfer_type,
+                       cvmx_usb_direction_t transfer_dir, int interval,
+                       int multi_count, int hub_device_addr, int hub_port)
+{
+    cvmx_usb_pipe_t *pipe;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    CVMX_USB_LOG_PARAM("0x%x", flags);
+    CVMX_USB_LOG_PARAM("%d", device_addr);
+    CVMX_USB_LOG_PARAM("%d", endpoint_num);
+    CVMX_USB_LOG_PARAM("%d", device_speed);
+    CVMX_USB_LOG_PARAM("%d", max_packet);
+    CVMX_USB_LOG_PARAM("%d", transfer_type);
+    CVMX_USB_LOG_PARAM("%d", transfer_dir);
+    CVMX_USB_LOG_PARAM("%d", interval);
+    CVMX_USB_LOG_PARAM("%d", multi_count);
+    CVMX_USB_LOG_PARAM("%d", hub_device_addr);
+    CVMX_USB_LOG_PARAM("%d", hub_port);
+
+    if (cvmx_unlikely((device_addr < 0) || (device_addr > MAX_USB_ADDRESS)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely((endpoint_num < 0) || (endpoint_num > MAX_USB_ENDPOINT)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(device_speed > CVMX_USB_SPEED_LOW))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely((max_packet <= 0) || (max_packet > 1024)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(transfer_type > CVMX_USB_TRANSFER_INTERRUPT))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely((transfer_dir != CVMX_USB_DIRECTION_OUT) &&
+        (transfer_dir != CVMX_USB_DIRECTION_IN)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(interval < 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely((transfer_type == CVMX_USB_TRANSFER_CONTROL) && interval))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(multi_count < 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely((device_speed != CVMX_USB_SPEED_HIGH) &&
+        (multi_count != 0)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely((hub_device_addr < 0) || (hub_device_addr > MAX_USB_ADDRESS)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely((hub_port < 0) || (hub_port > MAX_USB_HUB_PORT)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    /* Find a free pipe */
+    pipe = usb->free_pipes.head;
+    if (!pipe)
+        CVMX_USB_RETURN(CVMX_USB_NO_MEMORY);
+    __cvmx_usb_remove_pipe(&usb->free_pipes, pipe);
+    pipe->flags = flags | __CVMX_USB_PIPE_FLAGS_OPEN;
+    if ((device_speed == CVMX_USB_SPEED_HIGH) &&
+        (transfer_dir == CVMX_USB_DIRECTION_OUT) &&
+        (transfer_type == CVMX_USB_TRANSFER_BULK))
+        pipe->flags |= __CVMX_USB_PIPE_FLAGS_NEED_PING;
+    pipe->device_addr = device_addr;
+    pipe->endpoint_num = endpoint_num;
+    pipe->device_speed = device_speed;
+    pipe->max_packet = max_packet;
+    pipe->transfer_type = transfer_type;
+    pipe->transfer_dir = transfer_dir;
+    /* All pipes use interval to rate limit NAK processing. Force an interval
+        if one wasn't supplied */
+    if (!interval)
+        interval = 1;
+    if (__cvmx_usb_pipe_needs_split(usb, pipe))
+    {
+        pipe->interval = interval*8;
+        /* Force start splits to be schedule on uFrame 0 */
+        pipe->next_tx_frame = ((usb->frame_number+7)&~7) + pipe->interval;
+    }
+    else
+    {
+        pipe->interval = interval;
+        pipe->next_tx_frame = usb->frame_number + pipe->interval;
+    }
+    pipe->multi_count = multi_count;
+    pipe->hub_device_addr = hub_device_addr;
+    pipe->hub_port = hub_port;
+    pipe->pid_toggle = 0;
+    pipe->split_sc_frame = -1;
+    __cvmx_usb_append_pipe(&usb->idle_pipes, pipe);
+
+    /* We don't need to tell the hardware about this pipe yet since
+        it doesn't have any submitted requests */
+
+    CVMX_USB_RETURN(__cvmx_usb_get_pipe_handle(usb, pipe));
+}
+
+
+/**
+ * @INTERNAL
+ * Poll the RX FIFOs and remove data as needed. This function is only used
+ * in non DMA mode. It is very important that this function be called quickly
+ * enough to prevent FIFO overflow.
+ *
+ * @param usb     USB device state populated by
+ *                cvmx_usb_initialize().
+ */
+static void __cvmx_usb_poll_rx_fifo(cvmx_usb_internal_state_t *usb)
+{
+    cvmx_usbcx_grxstsph_t rx_status;
+    int channel;
+    int bytes;
+    uint64_t address;
+    uint32_t *ptr;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", usb);
+
+    rx_status.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_GRXSTSPH(usb->index));
+    /* Only read data if IN data is there */
+    if (rx_status.s.pktsts != 2)
+        CVMX_USB_RETURN_NOTHING();
+    /* Check if no data is available */
+    if (!rx_status.s.bcnt)
+        CVMX_USB_RETURN_NOTHING();
+
+    channel = rx_status.s.chnum;
+    bytes = rx_status.s.bcnt;
+    if (!bytes)
+        CVMX_USB_RETURN_NOTHING();
+
+    /* Get where the DMA engine would have written this data */
+    address = __cvmx_usb_read_csr64(usb, CVMX_USBNX_DMA0_INB_CHN0(usb->index) + channel*8);
+    ptr = cvmx_phys_to_ptr(address);
+    __cvmx_usb_write_csr64(usb, CVMX_USBNX_DMA0_INB_CHN0(usb->index) + channel*8, address + bytes);
+
+    /* Loop writing the FIFO data for this packet into memory */
+    while (bytes > 0)
+    {
+        *ptr++ = __cvmx_usb_read_csr32(usb, USB_FIFO_ADDRESS(channel, usb->index));
+        bytes -= 4;
+    }
+    CVMX_SYNCW;
+
+    CVMX_USB_RETURN_NOTHING();
+}
+
+
+/**
+ * Fill the TX hardware fifo with data out of the software
+ * fifos
+ *
+ * @param usb       USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param fifo      Software fifo to use
+ * @param available Amount of space in the hardware fifo
+ *
+ * @return Non zero if the hardware fifo was too small and needs
+ *         to be serviced again.
+ */
+static int __cvmx_usb_fill_tx_hw(cvmx_usb_internal_state_t *usb, cvmx_usb_tx_fifo_t *fifo, int available)
+{
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", usb);
+    CVMX_USB_LOG_PARAM("%p", fifo);
+    CVMX_USB_LOG_PARAM("%d", available);
+
+    /* We're done either when there isn't anymore space or the software FIFO
+        is empty */
+    while (available && (fifo->head != fifo->tail))
+    {
+        int i = fifo->tail;
+        const uint32_t *ptr = cvmx_phys_to_ptr(fifo->entry[i].address);
+        uint64_t csr_address = USB_FIFO_ADDRESS(fifo->entry[i].channel, usb->index) ^ 4;
+        int words = available;
+
+        /* Limit the amount of data to waht the SW fifo has */
+        if (fifo->entry[i].size <= available)
+        {
+            words = fifo->entry[i].size;
+            fifo->tail++;
+            if (fifo->tail > MAX_CHANNELS)
+                fifo->tail = 0;
+        }
+
+        /* Update the next locations and counts */
+        available -= words;
+        fifo->entry[i].address += words * 4;
+        fifo->entry[i].size -= words;
+
+        /* Write the HW fifo data. The read every three writes is due
+            to an errata on CN3XXX chips */
+        while (words > 3)
+        {
+            cvmx_write64_uint32(csr_address, *ptr++);
+            cvmx_write64_uint32(csr_address, *ptr++);
+            cvmx_write64_uint32(csr_address, *ptr++);
+            cvmx_read64_uint64(CVMX_USBNX_DMA0_INB_CHN0(usb->index));
+            words -= 3;
+        }
+        cvmx_write64_uint32(csr_address, *ptr++);
+        if (--words)
+        {
+            cvmx_write64_uint32(csr_address, *ptr++);
+            if (--words)
+                cvmx_write64_uint32(csr_address, *ptr++);
+        }
+        cvmx_read64_uint64(CVMX_USBNX_DMA0_INB_CHN0(usb->index));
+    }
+    CVMX_USB_RETURN(fifo->head != fifo->tail);
+}
+
+
+/**
+ * Check the hardware FIFOs and fill them as needed
+ *
+ * @param usb    USB device state populated by
+ *               cvmx_usb_initialize().
+ */
+static void __cvmx_usb_poll_tx_fifo(cvmx_usb_internal_state_t *usb)
+{
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", usb);
+
+    if (usb->periodic.head != usb->periodic.tail)
+    {
+        cvmx_usbcx_hptxsts_t tx_status;
+        tx_status.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HPTXSTS(usb->index));
+        if (__cvmx_usb_fill_tx_hw(usb, &usb->periodic, tx_status.s.ptxfspcavail))
+            USB_SET_FIELD32(CVMX_USBCX_GINTMSK(usb->index), cvmx_usbcx_gintmsk_t, ptxfempmsk, 1);
+        else
+            USB_SET_FIELD32(CVMX_USBCX_GINTMSK(usb->index), cvmx_usbcx_gintmsk_t, ptxfempmsk, 0);
+    }
+
+    if (usb->nonperiodic.head != usb->nonperiodic.tail)
+    {
+        cvmx_usbcx_gnptxsts_t tx_status;
+        tx_status.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_GNPTXSTS(usb->index));
+        if (__cvmx_usb_fill_tx_hw(usb, &usb->nonperiodic, tx_status.s.nptxfspcavail))
+            USB_SET_FIELD32(CVMX_USBCX_GINTMSK(usb->index), cvmx_usbcx_gintmsk_t, nptxfempmsk, 1);
+        else
+            USB_SET_FIELD32(CVMX_USBCX_GINTMSK(usb->index), cvmx_usbcx_gintmsk_t, nptxfempmsk, 0);
+    }
+
+    CVMX_USB_RETURN_NOTHING();
+}
+
+
+/**
+ * @INTERNAL
+ * Fill the TX FIFO with an outgoing packet
+ *
+ * @param usb     USB device state populated by
+ *                cvmx_usb_initialize().
+ * @param channel Channel number to get packet from
+ */
+static void __cvmx_usb_fill_tx_fifo(cvmx_usb_internal_state_t *usb, int channel)
+{
+    cvmx_usbcx_hccharx_t hcchar;
+    cvmx_usbcx_hcspltx_t usbc_hcsplt;
+    cvmx_usbcx_hctsizx_t usbc_hctsiz;
+    cvmx_usb_tx_fifo_t *fifo;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", usb);
+    CVMX_USB_LOG_PARAM("%d", channel);
+
+    /* We only need to fill data on outbound channels */
+    hcchar.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCCHARX(channel, usb->index));
+    if (hcchar.s.epdir != CVMX_USB_DIRECTION_OUT)
+        CVMX_USB_RETURN_NOTHING();
+
+    /* OUT Splits only have data on the start and not the complete */
+    usbc_hcsplt.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCSPLTX(channel, usb->index));
+    if (usbc_hcsplt.s.spltena && usbc_hcsplt.s.compsplt)
+        CVMX_USB_RETURN_NOTHING();
+
+    /* Find out how many bytes we need to fill and convert it into 32bit words */
+    usbc_hctsiz.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCTSIZX(channel, usb->index));
+    if (!usbc_hctsiz.s.xfersize)
+        CVMX_USB_RETURN_NOTHING();
+
+    if ((hcchar.s.eptype == CVMX_USB_TRANSFER_INTERRUPT) ||
+        (hcchar.s.eptype == CVMX_USB_TRANSFER_ISOCHRONOUS))
+        fifo = &usb->periodic;
+    else
+        fifo = &usb->nonperiodic;
+
+    fifo->entry[fifo->head].channel = channel;
+    fifo->entry[fifo->head].address = __cvmx_usb_read_csr64(usb, CVMX_USBNX_DMA0_OUTB_CHN0(usb->index) + channel*8);
+    fifo->entry[fifo->head].size = (usbc_hctsiz.s.xfersize+3)>>2;
+    fifo->head++;
+    if (fifo->head > MAX_CHANNELS)
+        fifo->head = 0;
+
+    __cvmx_usb_poll_tx_fifo(usb);
+
+    CVMX_USB_RETURN_NOTHING();
+}
+
+/**
+ * @INTERNAL
+ * Perform channel specific setup for Control transactions. All
+ * the generic stuff will already have been done in
+ * __cvmx_usb_start_channel()
+ *
+ * @param usb     USB device state populated by
+ *                cvmx_usb_initialize().
+ * @param channel Channel to setup
+ * @param pipe    Pipe for control transaction
+ */
+static void __cvmx_usb_start_channel_control(cvmx_usb_internal_state_t *usb,
+                                             int channel,
+                                             cvmx_usb_pipe_t *pipe)
+{
+    cvmx_usb_transaction_t *transaction = pipe->head;
+    cvmx_usb_control_header_t *header = cvmx_phys_to_ptr(transaction->control_header);
+    int bytes_to_transfer = transaction->buffer_length - transaction->actual_bytes;
+    int packets_to_transfer;
+    cvmx_usbcx_hctsizx_t usbc_hctsiz;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", usb);
+    CVMX_USB_LOG_PARAM("%d", channel);
+    CVMX_USB_LOG_PARAM("%p", pipe);
+
+    usbc_hctsiz.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCTSIZX(channel, usb->index));
+
+    switch (transaction->stage)
+    {
+        case CVMX_USB_STAGE_NON_CONTROL:
+        case CVMX_USB_STAGE_NON_CONTROL_SPLIT_COMPLETE:
+            cvmx_dprintf("%s: ERROR - Non control stage\n", __FUNCTION__);
+            break;
+        case CVMX_USB_STAGE_SETUP:
+            usbc_hctsiz.s.pid = 3; /* Setup */
+            bytes_to_transfer = sizeof(*header);
+            /* All Control operations start with a setup going OUT */
+            USB_SET_FIELD32(CVMX_USBCX_HCCHARX(channel, usb->index), cvmx_usbcx_hccharx_t, epdir, CVMX_USB_DIRECTION_OUT);
+            /* Setup send the control header instead of the buffer data. The
+                buffer data will be used in the next stage */
+            __cvmx_usb_write_csr64(usb, CVMX_USBNX_DMA0_OUTB_CHN0(usb->index) + channel*8, transaction->control_header);
+            break;
+        case CVMX_USB_STAGE_SETUP_SPLIT_COMPLETE:
+            usbc_hctsiz.s.pid = 3; /* Setup */
+            bytes_to_transfer = 0;
+            /* All Control operations start with a setup going OUT */
+            USB_SET_FIELD32(CVMX_USBCX_HCCHARX(channel, usb->index), cvmx_usbcx_hccharx_t, epdir, CVMX_USB_DIRECTION_OUT);
+            USB_SET_FIELD32(CVMX_USBCX_HCSPLTX(channel, usb->index), cvmx_usbcx_hcspltx_t, compsplt, 1);
+            break;
+        case CVMX_USB_STAGE_DATA:
+            usbc_hctsiz.s.pid = __cvmx_usb_get_data_pid(pipe);
+            if (__cvmx_usb_pipe_needs_split(usb, pipe))
+            {
+                if (header->s.request_type & 0x80)
+                    bytes_to_transfer = 0;
+                else if (bytes_to_transfer > pipe->max_packet)
+                    bytes_to_transfer = pipe->max_packet;
+            }
+            USB_SET_FIELD32(CVMX_USBCX_HCCHARX(channel, usb->index),
+                            cvmx_usbcx_hccharx_t, epdir,
+                            ((header->s.request_type & 0x80) ?
+                             CVMX_USB_DIRECTION_IN :
+                             CVMX_USB_DIRECTION_OUT));
+            break;
+        case CVMX_USB_STAGE_DATA_SPLIT_COMPLETE:
+            usbc_hctsiz.s.pid = __cvmx_usb_get_data_pid(pipe);
+            if (!(header->s.request_type & 0x80))
+                bytes_to_transfer = 0;
+            USB_SET_FIELD32(CVMX_USBCX_HCCHARX(channel, usb->index),
+                            cvmx_usbcx_hccharx_t, epdir,
+                            ((header->s.request_type & 0x80) ?
+                             CVMX_USB_DIRECTION_IN :
+                             CVMX_USB_DIRECTION_OUT));
+            USB_SET_FIELD32(CVMX_USBCX_HCSPLTX(channel, usb->index), cvmx_usbcx_hcspltx_t, compsplt, 1);
+            break;
+        case CVMX_USB_STAGE_STATUS:
+            usbc_hctsiz.s.pid = __cvmx_usb_get_data_pid(pipe);
+            bytes_to_transfer = 0;
+            USB_SET_FIELD32(CVMX_USBCX_HCCHARX(channel, usb->index), cvmx_usbcx_hccharx_t, epdir,
+                            ((header->s.request_type & 0x80) ?
+                             CVMX_USB_DIRECTION_OUT :
+                             CVMX_USB_DIRECTION_IN));
+            break;
+        case CVMX_USB_STAGE_STATUS_SPLIT_COMPLETE:
+            usbc_hctsiz.s.pid = __cvmx_usb_get_data_pid(pipe);
+            bytes_to_transfer = 0;
+            USB_SET_FIELD32(CVMX_USBCX_HCCHARX(channel, usb->index), cvmx_usbcx_hccharx_t, epdir,
+                            ((header->s.request_type & 0x80) ?
+                             CVMX_USB_DIRECTION_OUT :
+                             CVMX_USB_DIRECTION_IN));
+            USB_SET_FIELD32(CVMX_USBCX_HCSPLTX(channel, usb->index), cvmx_usbcx_hcspltx_t, compsplt, 1);
+            break;
+    }
+
+    /* Make sure the transfer never exceeds the byte limit of the hardware.
+        Further bytes will be sent as continued transactions */
+    if (bytes_to_transfer > MAX_TRANSFER_BYTES)
+    {
+        /* Round MAX_TRANSFER_BYTES to a multiple of out packet size */
+        bytes_to_transfer = MAX_TRANSFER_BYTES / pipe->max_packet;
+        bytes_to_transfer *= pipe->max_packet;
+    }
+
+    /* Calculate the number of packets to transfer. If the length is zero
+        we still need to transfer one packet */
+    packets_to_transfer = (bytes_to_transfer + pipe->max_packet - 1) / pipe->max_packet;
+    if (packets_to_transfer == 0)
+        packets_to_transfer = 1;
+    else if ((packets_to_transfer>1) && (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA))
+    {
+        /* Limit to one packet when not using DMA. Channels must be restarted
+            between every packet for IN transactions, so there is no reason to
+            do multiple packets in a row */
+        packets_to_transfer = 1;
+        bytes_to_transfer = packets_to_transfer * pipe->max_packet;
+    }
+    else if (packets_to_transfer > MAX_TRANSFER_PACKETS)
+    {
+        /* Limit the number of packet and data transferred to what the
+            hardware can handle */
+        packets_to_transfer = MAX_TRANSFER_PACKETS;
+        bytes_to_transfer = packets_to_transfer * pipe->max_packet;
+    }
+
+    usbc_hctsiz.s.xfersize = bytes_to_transfer;
+    usbc_hctsiz.s.pktcnt = packets_to_transfer;
+
+    __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCTSIZX(channel, usb->index), usbc_hctsiz.u32);
+    CVMX_USB_RETURN_NOTHING();
+}
+
+
+/**
+ * @INTERNAL
+ * Start a channel to perform the pipe's head transaction
+ *
+ * @param usb     USB device state populated by
+ *                cvmx_usb_initialize().
+ * @param channel Channel to setup
+ * @param pipe    Pipe to start
+ */
+static void __cvmx_usb_start_channel(cvmx_usb_internal_state_t *usb,
+                                     int channel,
+                                     cvmx_usb_pipe_t *pipe)
+{
+    cvmx_usb_transaction_t *transaction = pipe->head;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", usb);
+    CVMX_USB_LOG_PARAM("%d", channel);
+    CVMX_USB_LOG_PARAM("%p", pipe);
+
+    if (cvmx_unlikely((usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_TRANSFERS) ||
+        (pipe->flags & CVMX_USB_PIPE_FLAGS_DEBUG_TRANSFERS)))
+        cvmx_dprintf("%s: Channel %d started. Pipe %d transaction %d stage %d\n",
+                     __FUNCTION__, channel, __cvmx_usb_get_pipe_handle(usb, pipe),
+                     __cvmx_usb_get_submit_handle(usb, transaction),
+                     transaction->stage);
+
+    /* Make sure all writes to the DMA region get flushed */
+    CVMX_SYNCW;
+
+    /* Attach the channel to the pipe */
+    usb->pipe_for_channel[channel] = pipe;
+    pipe->channel = channel;
+    pipe->flags |= __CVMX_USB_PIPE_FLAGS_SCHEDULED;
+
+    /* Mark this channel as in use */
+    usb->idle_hardware_channels &= ~(1<<channel);
+
+    /* Enable the channel interrupt bits */
+    {
+        cvmx_usbcx_hcintx_t usbc_hcint;
+        cvmx_usbcx_hcintmskx_t usbc_hcintmsk;
+        cvmx_usbcx_haintmsk_t usbc_haintmsk;
+
+        /* Clear all channel status bits */
+        usbc_hcint.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCINTX(channel, usb->index));
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCINTX(channel, usb->index), usbc_hcint.u32);
+
+        usbc_hcintmsk.u32 = 0;
+        usbc_hcintmsk.s.chhltdmsk = 1;
+        if (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA)
+        {
+            /* Channels need these extra interrupts when we aren't in DMA mode */
+            usbc_hcintmsk.s.datatglerrmsk = 1;
+            usbc_hcintmsk.s.frmovrunmsk = 1;
+            usbc_hcintmsk.s.bblerrmsk = 1;
+            usbc_hcintmsk.s.xacterrmsk = 1;
+            if (__cvmx_usb_pipe_needs_split(usb, pipe))
+            {
+                /* Splits don't generate xfercompl, so we need ACK and NYET */
+                usbc_hcintmsk.s.nyetmsk = 1;
+                usbc_hcintmsk.s.ackmsk = 1;
+            }
+            usbc_hcintmsk.s.nakmsk = 1;
+            usbc_hcintmsk.s.stallmsk = 1;
+            usbc_hcintmsk.s.xfercomplmsk = 1;
+        }
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCINTMSKX(channel, usb->index), usbc_hcintmsk.u32);
+
+        /* Enable the channel interrupt to propagate */
+        usbc_haintmsk.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HAINTMSK(usb->index));
+        usbc_haintmsk.s.haintmsk |= 1<<channel;
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_HAINTMSK(usb->index), usbc_haintmsk.u32);
+    }
+
+    /* Setup the locations the DMA engines use  */
+    {
+        uint64_t dma_address = transaction->buffer + transaction->actual_bytes;
+        if (transaction->type == CVMX_USB_TRANSFER_ISOCHRONOUS)
+            dma_address = transaction->buffer + transaction->iso_packets[0].offset + transaction->actual_bytes;
+        __cvmx_usb_write_csr64(usb, CVMX_USBNX_DMA0_OUTB_CHN0(usb->index) + channel*8, dma_address);
+        __cvmx_usb_write_csr64(usb, CVMX_USBNX_DMA0_INB_CHN0(usb->index) + channel*8, dma_address);
+    }
+
+    /* Setup both the size of the transfer and the SPLIT characteristics */
+    {
+        cvmx_usbcx_hcspltx_t usbc_hcsplt = {.u32 = 0};
+        cvmx_usbcx_hctsizx_t usbc_hctsiz = {.u32 = 0};
+        int packets_to_transfer;
+        int bytes_to_transfer = transaction->buffer_length - transaction->actual_bytes;
+
+        /* ISOCHRONOUS transactions store each individual transfer size in the
+            packet structure, not the global buffer_length */
+        if (transaction->type == CVMX_USB_TRANSFER_ISOCHRONOUS)
+            bytes_to_transfer = transaction->iso_packets[0].length - transaction->actual_bytes;
+
+        /* We need to do split transactions when we are talking to non high
+            speed devices that are behind a high speed hub */
+        if (__cvmx_usb_pipe_needs_split(usb, pipe))
+        {
+            /* On the start split phase (stage is even) record the frame number we
+                will need to send the split complete. We only store the lower two bits
+                since the time ahead can only be two frames */
+            if ((transaction->stage&1) == 0)
+            {
+                if (transaction->type == CVMX_USB_TRANSFER_BULK)
+                    pipe->split_sc_frame = (usb->frame_number + 1) & 0x7f;
+                else
+                    pipe->split_sc_frame = (usb->frame_number + 2) & 0x7f;
+            }
+            else
+                pipe->split_sc_frame = -1;
+
+            usbc_hcsplt.s.spltena = 1;
+            usbc_hcsplt.s.hubaddr = pipe->hub_device_addr;
+            usbc_hcsplt.s.prtaddr = pipe->hub_port;
+            usbc_hcsplt.s.compsplt = (transaction->stage == CVMX_USB_STAGE_NON_CONTROL_SPLIT_COMPLETE);
+
+            /* SPLIT transactions can only ever transmit one data packet so
+                limit the transfer size to the max packet size */
+            if (bytes_to_transfer > pipe->max_packet)
+                bytes_to_transfer = pipe->max_packet;
+
+            /* ISOCHRONOUS OUT splits are unique in that they limit
+                data transfers to 188 byte chunks representing the
+                begin/middle/end of the data or all */
+            if (!usbc_hcsplt.s.compsplt &&
+                (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) &&
+                (pipe->transfer_type == CVMX_USB_TRANSFER_ISOCHRONOUS))
+            {
+                /* Clear the split complete frame number as there isn't going
+                    to be a split complete */
+                pipe->split_sc_frame = -1;
+                /* See if we've started this transfer and sent data */
+                if (transaction->actual_bytes == 0)
+                {
+                    /* Nothing sent yet, this is either a begin or the
+                        entire payload */
+                    if (bytes_to_transfer <= 188)
+                        usbc_hcsplt.s.xactpos = 3; /* Entire payload in one go */
+                    else
+                        usbc_hcsplt.s.xactpos = 2; /* First part of payload */
+                }
+                else
+                {
+                    /* Continuing the previous data, we must either be
+                        in the middle or at the end */
+                    if (bytes_to_transfer <= 188)
+                        usbc_hcsplt.s.xactpos = 1; /* End of payload */
+                    else
+                        usbc_hcsplt.s.xactpos = 0; /* Middle of payload */
+                }
+                /* Again, the transfer size is limited to 188 bytes */
+                if (bytes_to_transfer > 188)
+                    bytes_to_transfer = 188;
+            }
+        }
+
+        /* Make sure the transfer never exceeds the byte limit of the hardware.
+            Further bytes will be sent as continued transactions */
+        if (bytes_to_transfer > MAX_TRANSFER_BYTES)
+        {
+            /* Round MAX_TRANSFER_BYTES to a multiple of out packet size */
+            bytes_to_transfer = MAX_TRANSFER_BYTES / pipe->max_packet;
+            bytes_to_transfer *= pipe->max_packet;
+        }
+
+        /* Calculate the number of packets to transfer. If the length is zero
+            we still need to transfer one packet */
+        packets_to_transfer = (bytes_to_transfer + pipe->max_packet - 1) / pipe->max_packet;
+        if (packets_to_transfer == 0)
+            packets_to_transfer = 1;
+        else if ((packets_to_transfer>1) && (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA))
+        {
+            /* Limit to one packet when not using DMA. Channels must be restarted
+                between every packet for IN transactions, so there is no reason to
+                do multiple packets in a row */
+            packets_to_transfer = 1;
+            bytes_to_transfer = packets_to_transfer * pipe->max_packet;
+        }
+        else if (packets_to_transfer > MAX_TRANSFER_PACKETS)
+        {
+            /* Limit the number of packet and data transferred to what the
+                hardware can handle */
+            packets_to_transfer = MAX_TRANSFER_PACKETS;
+            bytes_to_transfer = packets_to_transfer * pipe->max_packet;
+        }
+
+        usbc_hctsiz.s.xfersize = bytes_to_transfer;
+        usbc_hctsiz.s.pktcnt = packets_to_transfer;
+
+        /* Update the DATA0/DATA1 toggle */
+        usbc_hctsiz.s.pid = __cvmx_usb_get_data_pid(pipe);
+        /* High speed pipes may need a hardware ping before they start */
+        if (pipe->flags & __CVMX_USB_PIPE_FLAGS_NEED_PING)
+            usbc_hctsiz.s.dopng = 1;
+
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCSPLTX(channel, usb->index), usbc_hcsplt.u32);
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCTSIZX(channel, usb->index), usbc_hctsiz.u32);
+    }
+
+    /* Setup the Host Channel Characteristics Register */
+    {
+        cvmx_usbcx_hccharx_t usbc_hcchar = {.u32 = 0};
+
+        /* Set the startframe odd/even properly. This is only used for periodic */
+        usbc_hcchar.s.oddfrm = usb->frame_number&1;
+
+        /* Set the number of back to back packets allowed by this endpoint.
+            Split transactions interpret "ec" as the number of immediate
+            retries of failure. These retries happen too quickly, so we
+            disable these entirely for splits */
+        if (__cvmx_usb_pipe_needs_split(usb, pipe))
+            usbc_hcchar.s.ec = 1;
+        else if (pipe->multi_count < 1)
+            usbc_hcchar.s.ec = 1;
+        else if (pipe->multi_count > 3)
+            usbc_hcchar.s.ec = 3;
+        else
+            usbc_hcchar.s.ec = pipe->multi_count;
+
+        /* Set the rest of the endpoint specific settings */
+        usbc_hcchar.s.devaddr = pipe->device_addr;
+        usbc_hcchar.s.eptype = transaction->type;
+        usbc_hcchar.s.lspddev = (pipe->device_speed == CVMX_USB_SPEED_LOW);
+        usbc_hcchar.s.epdir = pipe->transfer_dir;
+        usbc_hcchar.s.epnum = pipe->endpoint_num;
+        usbc_hcchar.s.mps = pipe->max_packet;
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCCHARX(channel, usb->index), usbc_hcchar.u32);
+    }
+
+    /* Do transaction type specific fixups as needed */
+    switch (transaction->type)
+    {
+        case CVMX_USB_TRANSFER_CONTROL:
+            __cvmx_usb_start_channel_control(usb, channel, pipe);
+            break;
+        case CVMX_USB_TRANSFER_BULK:
+        case CVMX_USB_TRANSFER_INTERRUPT:
+            break;
+        case CVMX_USB_TRANSFER_ISOCHRONOUS:
+            if (!__cvmx_usb_pipe_needs_split(usb, pipe))
+            {
+                /* ISO transactions require different PIDs depending on direction
+                    and how many packets are needed */
+                if (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT)
+                {
+                    if (pipe->multi_count < 2) /* Need DATA0 */
+                        USB_SET_FIELD32(CVMX_USBCX_HCTSIZX(channel, usb->index), cvmx_usbcx_hctsizx_t, pid, 0);
+                    else /* Need MDATA */
+                        USB_SET_FIELD32(CVMX_USBCX_HCTSIZX(channel, usb->index), cvmx_usbcx_hctsizx_t, pid, 3);
+                }
+            }
+            break;
+    }
+    {
+        cvmx_usbcx_hctsizx_t usbc_hctsiz = {.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCTSIZX(channel, usb->index))};
+        transaction->xfersize = usbc_hctsiz.s.xfersize;
+        transaction->pktcnt = usbc_hctsiz.s.pktcnt;
+    }
+    /* Remeber when we start a split transaction */
+    if (__cvmx_usb_pipe_needs_split(usb, pipe))
+        usb->active_split = transaction;
+    USB_SET_FIELD32(CVMX_USBCX_HCCHARX(channel, usb->index), cvmx_usbcx_hccharx_t, chena, 1);
+    if (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA)
+        __cvmx_usb_fill_tx_fifo(usb, channel);
+    CVMX_USB_RETURN_NOTHING();
+}
+
+
+/**
+ * @INTERNAL
+ * Find a pipe that is ready to be scheduled to hardware.
+ * @param usb    USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param list   Pipe list to search
+ * @param current_frame
+ *               Frame counter to use as a time reference.
+ *
+ * @return Pipe or NULL if none are ready
+ */
+static cvmx_usb_pipe_t *__cvmx_usb_find_ready_pipe(cvmx_usb_internal_state_t *usb, cvmx_usb_pipe_list_t *list, uint64_t current_frame)
+{
+    cvmx_usb_pipe_t *pipe = list->head;
+    while (pipe)
+    {
+        if (!(pipe->flags & __CVMX_USB_PIPE_FLAGS_SCHEDULED) && pipe->head &&
+            (pipe->next_tx_frame <= current_frame) &&
+            ((pipe->split_sc_frame == -1) || ((((int)current_frame - (int)pipe->split_sc_frame) & 0x7f) < 0x40)) &&
+            (!usb->active_split || (usb->active_split == pipe->head)))
+        {
+            CVMX_PREFETCH(pipe, 128);
+            CVMX_PREFETCH(pipe->head, 0);
+            return pipe;
+        }
+        pipe = pipe->next;
+    }
+    return NULL;
+}
+
+
+/**
+ * @INTERNAL
+ * Called whenever a pipe might need to be scheduled to the
+ * hardware.
+ *
+ * @param usb    USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param is_sof True if this schedule was called on a SOF interrupt.
+ */
+static void __cvmx_usb_schedule(cvmx_usb_internal_state_t *usb, int is_sof)
+{
+    int channel;
+    cvmx_usb_pipe_t *pipe;
+    int need_sof;
+    cvmx_usb_transfer_t ttype;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", usb);
+
+    if (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA)
+    {
+        /* Without DMA we need to be careful to not schedule something at the end of a frame and cause an overrun */
+        cvmx_usbcx_hfnum_t hfnum = {.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HFNUM(usb->index))};
+        cvmx_usbcx_hfir_t hfir = {.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HFIR(usb->index))};
+        if (hfnum.s.frrem < hfir.s.frint/4)
+            goto done;
+    }
+
+    while (usb->idle_hardware_channels)
+    {
+        /* Find an idle channel */
+        CVMX_CLZ(channel, usb->idle_hardware_channels);
+        channel = 31 - channel;
+        if (cvmx_unlikely(channel > 7))
+        {
+            if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_INFO))
+                cvmx_dprintf("%s: Idle hardware channels has a channel higher than 7. This is wrong\n", __FUNCTION__);
+            break;
+        }
+
+        /* Find a pipe needing service */
+        pipe = NULL;
+        if (is_sof)
+        {
+            /* Only process periodic pipes on SOF interrupts. This way we are
+                sure that the periodic data is sent in the beginning of the
+                frame */
+            pipe = __cvmx_usb_find_ready_pipe(usb, usb->active_pipes + CVMX_USB_TRANSFER_ISOCHRONOUS, usb->frame_number);
+            if (cvmx_likely(!pipe))
+                pipe = __cvmx_usb_find_ready_pipe(usb, usb->active_pipes + CVMX_USB_TRANSFER_INTERRUPT, usb->frame_number);
+        }
+        if (cvmx_likely(!pipe))
+        {
+            pipe = __cvmx_usb_find_ready_pipe(usb, usb->active_pipes + CVMX_USB_TRANSFER_CONTROL, usb->frame_number);
+            if (cvmx_likely(!pipe))
+                pipe = __cvmx_usb_find_ready_pipe(usb, usb->active_pipes + CVMX_USB_TRANSFER_BULK, usb->frame_number);
+        }
+        if (!pipe)
+            break;
+
+        CVMX_USB_LOG_PARAM("%d", channel);
+        CVMX_USB_LOG_PARAM("%p", pipe);
+
+        if (cvmx_unlikely((usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_TRANSFERS) ||
+            (pipe->flags & CVMX_USB_PIPE_FLAGS_DEBUG_TRANSFERS)))
+        {
+            cvmx_usb_transaction_t *transaction = pipe->head;
+            const cvmx_usb_control_header_t *header = (transaction->control_header) ? cvmx_phys_to_ptr(transaction->control_header) : NULL;
+            const char *dir = (pipe->transfer_dir == CVMX_USB_DIRECTION_IN) ? "IN" : "OUT";
+            const char *type;
+            switch (pipe->transfer_type)
+            {
+                case CVMX_USB_TRANSFER_CONTROL:
+                    type = "SETUP";
+                    dir = (header->s.request_type & 0x80) ? "IN" : "OUT";
+                    break;
+                case CVMX_USB_TRANSFER_ISOCHRONOUS:
+                    type = "ISOCHRONOUS";
+                    break;
+                case CVMX_USB_TRANSFER_BULK:
+                    type = "BULK";
+                    break;
+                default: /* CVMX_USB_TRANSFER_INTERRUPT */
+                    type = "INTERRUPT";
+                    break;
+            }
+            cvmx_dprintf("%s: Starting pipe %d, transaction %d on channel %d. %s %s len=%d header=0x%llx\n",
+                         __FUNCTION__, __cvmx_usb_get_pipe_handle(usb, pipe),
+                         __cvmx_usb_get_submit_handle(usb, transaction),
+                         channel, type, dir,
+                         transaction->buffer_length,
+                         (header) ? (unsigned long long)header->u64 : 0ull);
+        }
+        __cvmx_usb_start_channel(usb, channel, pipe);
+    }
+
+done:
+    /* Only enable SOF interrupts when we have transactions pending in the
+        future that might need to be scheduled */
+    need_sof = 0;
+    for (ttype=CVMX_USB_TRANSFER_CONTROL; ttype<=CVMX_USB_TRANSFER_INTERRUPT; ttype++)
+    {
+        pipe = usb->active_pipes[ttype].head;
+        while (pipe)
+        {
+            if (pipe->next_tx_frame > usb->frame_number)
+            {
+                need_sof = 1;
+                break;
+            }
+            pipe=pipe->next;
+        }
+    }
+    USB_SET_FIELD32(CVMX_USBCX_GINTMSK(usb->index), cvmx_usbcx_gintmsk_t, sofmsk, need_sof);
+    CVMX_USB_RETURN_NOTHING();
+}
+
+
+/**
+ * @INTERNAL
+ * Call a user's callback for a specific reason.
+ *
+ * @param usb    USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param pipe   Pipe the callback is for or NULL
+ * @param transaction
+ *               Transaction the callback is for or NULL
+ * @param reason Reason this callback is being called
+ * @param complete_code
+ *               Completion code for the transaction, if any
+ */
+static void __cvmx_usb_perform_callback(cvmx_usb_internal_state_t *usb,
+                                        cvmx_usb_pipe_t *pipe,
+                                        cvmx_usb_transaction_t *transaction,
+                                        cvmx_usb_callback_t reason,
+                                        cvmx_usb_complete_t complete_code)
+{
+    cvmx_usb_callback_func_t callback = usb->callback[reason];
+    void *user_data = usb->callback_data[reason];
+    int submit_handle = -1;
+    int pipe_handle = -1;
+    int bytes_transferred = 0;
+
+    if (pipe)
+        pipe_handle = __cvmx_usb_get_pipe_handle(usb, pipe);
+
+    if (transaction)
+    {
+        submit_handle = __cvmx_usb_get_submit_handle(usb, transaction);
+        bytes_transferred = transaction->actual_bytes;
+        /* Transactions are allowed to override the default callback */
+        if ((reason == CVMX_USB_CALLBACK_TRANSFER_COMPLETE) && transaction->callback)
+        {
+            callback = transaction->callback;
+            user_data = transaction->callback_data;
+        }
+    }
+
+    if (!callback)
+        return;
+
+    if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_CALLBACKS))
+        cvmx_dprintf("%*s%s: calling callback %p(usb=%p, complete_code=%s, "
+                     "pipe_handle=%d, submit_handle=%d, bytes_transferred=%d, user_data=%p);\n",
+                     2*usb->indent, "", __FUNCTION__, callback, usb,
+                     __cvmx_usb_complete_to_string(complete_code),
+                     pipe_handle, submit_handle, bytes_transferred, user_data);
+
+    callback((cvmx_usb_state_t *)usb, reason, complete_code, pipe_handle, submit_handle,
+             bytes_transferred, user_data);
+
+    if (cvmx_unlikely(usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_CALLBACKS))
+        cvmx_dprintf("%*s%s: callback %p complete\n", 2*usb->indent, "",
+                      __FUNCTION__, callback);
+}
+
+
+/**
+ * @INTERNAL
+ * Signal the completion of a transaction and free it. The
+ * transaction will be removed from the pipe transaction list.
+ *
+ * @param usb    USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param pipe   Pipe the transaction is on
+ * @param transaction
+ *               Transaction that completed
+ * @param complete_code
+ *               Completion code
+ */
+static void __cvmx_usb_perform_complete(cvmx_usb_internal_state_t * usb,
+                                        cvmx_usb_pipe_t *pipe,
+                                        cvmx_usb_transaction_t *transaction,
+                                        cvmx_usb_complete_t complete_code)
+{
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", usb);
+    CVMX_USB_LOG_PARAM("%p", pipe);
+    CVMX_USB_LOG_PARAM("%p", transaction);
+    CVMX_USB_LOG_PARAM("%d", complete_code);
+
+    /* If this was a split then clear our split in progress marker */
+    if (usb->active_split == transaction)
+        usb->active_split = NULL;
+
+    /* Isochronous transactions need extra processing as they might not be done
+        after a single data transfer */
+    if (cvmx_unlikely(transaction->type == CVMX_USB_TRANSFER_ISOCHRONOUS))
+    {
+        /* Update the number of bytes transferred in this ISO packet */
+        transaction->iso_packets[0].length = transaction->actual_bytes;
+        transaction->iso_packets[0].status = complete_code;
+
+        /* If there are more ISOs pending and we succeeded, schedule the next
+            one */
+        if ((transaction->iso_number_packets > 1) && (complete_code == CVMX_USB_COMPLETE_SUCCESS))
+        {
+            transaction->actual_bytes = 0;      /* No bytes transferred for this packet as of yet */
+            transaction->iso_number_packets--;  /* One less ISO waiting to transfer */
+            transaction->iso_packets++;         /* Increment to the next location in our packet array */
+            transaction->stage = CVMX_USB_STAGE_NON_CONTROL;
+            goto done;
+        }
+    }
+
+    /* Remove the transaction from the pipe list */
+    if (transaction->next)
+        transaction->next->prev = transaction->prev;
+    else
+        pipe->tail = transaction->prev;
+    if (transaction->prev)
+        transaction->prev->next = transaction->next;
+    else
+        pipe->head = transaction->next;
+    if (!pipe->head)
+    {
+        __cvmx_usb_remove_pipe(usb->active_pipes + pipe->transfer_type, pipe);
+        __cvmx_usb_append_pipe(&usb->idle_pipes, pipe);
+
+    }
+    __cvmx_usb_perform_callback(usb, pipe, transaction,
+                                CVMX_USB_CALLBACK_TRANSFER_COMPLETE,
+                                complete_code);
+    __cvmx_usb_free_transaction(usb, transaction);
+done:
+    CVMX_USB_RETURN_NOTHING();
+}
+
+
+/**
+ * @INTERNAL
+ * Submit a usb transaction to a pipe. Called for all types
+ * of transactions.
+ *
+ * @param usb
+ * @param pipe_handle
+ *                  Which pipe to submit to. Will be validated in this function.
+ * @param type      Transaction type
+ * @param flags     Flags for the transaction
+ * @param buffer    User buffer for the transaction
+ * @param buffer_length
+ *                  User buffer's length in bytes
+ * @param control_header
+ *                  For control transactions, the 8 byte standard header
+ * @param iso_start_frame
+ *                  For ISO transactions, the start frame
+ * @param iso_number_packets
+ *                  For ISO, the number of packet in the transaction.
+ * @param iso_packets
+ *                  A description of each ISO packet
+ * @param callback  User callback to call when the transaction completes
+ * @param user_data User's data for the callback
+ *
+ * @return Submit handle or negative on failure. Matches the result
+ *         in the external API.
+ */
+static int __cvmx_usb_submit_transaction(cvmx_usb_internal_state_t *usb,
+                                         int pipe_handle,
+                                         cvmx_usb_transfer_t type,
+                                         int flags,
+                                         uint64_t buffer,
+                                         int buffer_length,
+                                         uint64_t control_header,
+                                         int iso_start_frame,
+                                         int iso_number_packets,
+                                         cvmx_usb_iso_packet_t *iso_packets,
+                                         cvmx_usb_callback_func_t callback,
+                                         void *user_data)
+{
+    int submit_handle;
+    cvmx_usb_transaction_t *transaction;
+    cvmx_usb_pipe_t *pipe = usb->pipe + pipe_handle;
+
+    CVMX_USB_LOG_CALLED();
+    if (cvmx_unlikely((pipe_handle < 0) || (pipe_handle >= MAX_PIPES)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    /* Fail if the pipe isn't open */
+    if (cvmx_unlikely((pipe->flags & __CVMX_USB_PIPE_FLAGS_OPEN) == 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(pipe->transfer_type != type))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    transaction = __cvmx_usb_alloc_transaction(usb);
+    if (cvmx_unlikely(!transaction))
+        CVMX_USB_RETURN(CVMX_USB_NO_MEMORY);
+
+    transaction->type = type;
+    transaction->flags |= flags;
+    transaction->buffer = buffer;
+    transaction->buffer_length = buffer_length;
+    transaction->control_header = control_header;
+    transaction->iso_start_frame = iso_start_frame; // FIXME: This is not used, implement it
+    transaction->iso_number_packets = iso_number_packets;
+    transaction->iso_packets = iso_packets;
+    transaction->callback = callback;
+    transaction->callback_data = user_data;
+    if (transaction->type == CVMX_USB_TRANSFER_CONTROL)
+        transaction->stage = CVMX_USB_STAGE_SETUP;
+    else
+        transaction->stage = CVMX_USB_STAGE_NON_CONTROL;
+
+    transaction->next = NULL;
+    if (pipe->tail)
+    {
+        transaction->prev = pipe->tail;
+        transaction->prev->next = transaction;
+    }
+    else
+    {
+        if (pipe->next_tx_frame < usb->frame_number)
+            pipe->next_tx_frame = usb->frame_number + pipe->interval -
+                (usb->frame_number - pipe->next_tx_frame) % pipe->interval;
+        transaction->prev = NULL;
+        pipe->head = transaction;
+        __cvmx_usb_remove_pipe(&usb->idle_pipes, pipe);
+        __cvmx_usb_append_pipe(usb->active_pipes + pipe->transfer_type, pipe);
+    }
+    pipe->tail = transaction;
+
+    submit_handle = __cvmx_usb_get_submit_handle(usb, transaction);
+
+    /* We may need to schedule the pipe if this was the head of the pipe */
+    if (!transaction->prev)
+        __cvmx_usb_schedule(usb, 0);
+
+    CVMX_USB_RETURN(submit_handle);
+}
+
+
+/**
+ * Call to submit a USB Bulk transfer to a pipe.
+ *
+ * @param state     USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param pipe_handle
+ *                  Handle to the pipe for the transfer.
+ * @param buffer    Physical address of the data buffer in
+ *                  memory. Note that this is NOT A POINTER, but
+ *                  the full 64bit physical address of the
+ *                  buffer. This may be zero if buffer_length is
+ *                  zero.
+ * @param buffer_length
+ *                  Length of buffer in bytes.
+ * @param callback  Function to call when this transaction
+ *                  completes. If the return value of this
+ *                  function isn't an error, then this function
+ *                  is guaranteed to be called when the
+ *                  transaction completes. If this parameter is
+ *                  NULL, then the generic callback registered
+ *                  through cvmx_usb_register_callback is
+ *                  called. If both are NULL, then there is no
+ *                  way to know when a transaction completes.
+ * @param user_data User supplied data returned when the
+ *                  callback is called. This is only used if
+ *                  callback in not NULL.
+ *
+ * @return A submitted transaction handle or negative on
+ *         failure. Negative values are failure codes from
+ *         cvmx_usb_status_t.
+ */
+int cvmx_usb_submit_bulk(cvmx_usb_state_t *state, int pipe_handle,
+                                uint64_t buffer, int buffer_length,
+                                cvmx_usb_callback_func_t callback,
+                                void *user_data)
+{
+    int submit_handle;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    CVMX_USB_LOG_PARAM("%d", pipe_handle);
+    CVMX_USB_LOG_PARAM("0x%llx", (unsigned long long)buffer);
+    CVMX_USB_LOG_PARAM("%d", buffer_length);
+
+    /* Pipe handle checking is done later in a common place */
+    if (cvmx_unlikely(!buffer))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(buffer_length < 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    submit_handle = __cvmx_usb_submit_transaction(usb, pipe_handle,
+                                         CVMX_USB_TRANSFER_BULK,
+                                         0, /* flags */
+                                         buffer,
+                                         buffer_length,
+                                         0, /* control_header */
+                                         0, /* iso_start_frame */
+                                         0, /* iso_number_packets */
+                                         NULL, /* iso_packets */
+                                         callback,
+                                         user_data);
+    CVMX_USB_RETURN(submit_handle);
+}
+
+
+/**
+ * Call to submit a USB Interrupt transfer to a pipe.
+ *
+ * @param state     USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param pipe_handle
+ *                  Handle to the pipe for the transfer.
+ * @param buffer    Physical address of the data buffer in
+ *                  memory. Note that this is NOT A POINTER, but
+ *                  the full 64bit physical address of the
+ *                  buffer. This may be zero if buffer_length is
+ *                  zero.
+ * @param buffer_length
+ *                  Length of buffer in bytes.
+ * @param callback  Function to call when this transaction
+ *                  completes. If the return value of this
+ *                  function isn't an error, then this function
+ *                  is guaranteed to be called when the
+ *                  transaction completes. If this parameter is
+ *                  NULL, then the generic callback registered
+ *                  through cvmx_usb_register_callback is
+ *                  called. If both are NULL, then there is no
+ *                  way to know when a transaction completes.
+ * @param user_data User supplied data returned when the
+ *                  callback is called. This is only used if
+ *                  callback in not NULL.
+ *
+ * @return A submitted transaction handle or negative on
+ *         failure. Negative values are failure codes from
+ *         cvmx_usb_status_t.
+ */
+int cvmx_usb_submit_interrupt(cvmx_usb_state_t *state, int pipe_handle,
+                              uint64_t buffer, int buffer_length,
+                              cvmx_usb_callback_func_t callback,
+                              void *user_data)
+{
+    int submit_handle;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    CVMX_USB_LOG_PARAM("%d", pipe_handle);
+    CVMX_USB_LOG_PARAM("0x%llx", (unsigned long long)buffer);
+    CVMX_USB_LOG_PARAM("%d", buffer_length);
+
+    /* Pipe handle checking is done later in a common place */
+    if (cvmx_unlikely(!buffer))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(buffer_length < 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    submit_handle = __cvmx_usb_submit_transaction(usb, pipe_handle,
+                                         CVMX_USB_TRANSFER_INTERRUPT,
+                                         0, /* flags */
+                                         buffer,
+                                         buffer_length,
+                                         0, /* control_header */
+                                         0, /* iso_start_frame */
+                                         0, /* iso_number_packets */
+                                         NULL, /* iso_packets */
+                                         callback,
+                                         user_data);
+    CVMX_USB_RETURN(submit_handle);
+}
+
+
+/**
+ * Call to submit a USB Control transfer to a pipe.
+ *
+ * @param state     USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param pipe_handle
+ *                  Handle to the pipe for the transfer.
+ * @param control_header
+ *                  USB 8 byte control header physical address.
+ *                  Note that this is NOT A POINTER, but the
+ *                  full 64bit physical address of the buffer.
+ * @param buffer    Physical address of the data buffer in
+ *                  memory. Note that this is NOT A POINTER, but
+ *                  the full 64bit physical address of the
+ *                  buffer. This may be zero if buffer_length is
+ *                  zero.
+ * @param buffer_length
+ *                  Length of buffer in bytes.
+ * @param callback  Function to call when this transaction
+ *                  completes. If the return value of this
+ *                  function isn't an error, then this function
+ *                  is guaranteed to be called when the
+ *                  transaction completes. If this parameter is
+ *                  NULL, then the generic callback registered
+ *                  through cvmx_usb_register_callback is
+ *                  called. If both are NULL, then there is no
+ *                  way to know when a transaction completes.
+ * @param user_data User supplied data returned when the
+ *                  callback is called. This is only used if
+ *                  callback in not NULL.
+ *
+ * @return A submitted transaction handle or negative on
+ *         failure. Negative values are failure codes from
+ *         cvmx_usb_status_t.
+ */
+int cvmx_usb_submit_control(cvmx_usb_state_t *state, int pipe_handle,
+                            uint64_t control_header,
+                            uint64_t buffer, int buffer_length,
+                            cvmx_usb_callback_func_t callback,
+                            void *user_data)
+{
+    int submit_handle;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+    cvmx_usb_control_header_t *header = cvmx_phys_to_ptr(control_header);
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    CVMX_USB_LOG_PARAM("%d", pipe_handle);
+    CVMX_USB_LOG_PARAM("0x%llx", (unsigned long long)control_header);
+    CVMX_USB_LOG_PARAM("0x%llx", (unsigned long long)buffer);
+    CVMX_USB_LOG_PARAM("%d", buffer_length);
+
+    /* Pipe handle checking is done later in a common place */
+    if (cvmx_unlikely(!control_header))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    /* Some drivers send a buffer with a zero length. God only knows why */
+    if (cvmx_unlikely(buffer && (buffer_length < 0)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(!buffer && (buffer_length != 0)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if ((header->s.request_type & 0x80) == 0)
+        buffer_length = cvmx_le16_to_cpu(header->s.length);
+
+    submit_handle = __cvmx_usb_submit_transaction(usb, pipe_handle,
+                                         CVMX_USB_TRANSFER_CONTROL,
+                                         0, /* flags */
+                                         buffer,
+                                         buffer_length,
+                                         control_header,
+                                         0, /* iso_start_frame */
+                                         0, /* iso_number_packets */
+                                         NULL, /* iso_packets */
+                                         callback,
+                                         user_data);
+    CVMX_USB_RETURN(submit_handle);
+}
+
+
+/**
+ * Call to submit a USB Isochronous transfer to a pipe.
+ *
+ * @param state     USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param pipe_handle
+ *                  Handle to the pipe for the transfer.
+ * @param start_frame
+ *                  Number of frames into the future to schedule
+ *                  this transaction.
+ * @param flags     Flags to control the transfer. See
+ *                  cvmx_usb_isochronous_flags_t for the flag
+ *                  definitions.
+ * @param number_packets
+ *                  Number of sequential packets to transfer.
+ *                  "packets" is a pointer to an array of this
+ *                  many packet structures.
+ * @param packets   Description of each transfer packet as
+ *                  defined by cvmx_usb_iso_packet_t. The array
+ *                  pointed to here must stay valid until the
+ *                  complete callback is called.
+ * @param buffer    Physical address of the data buffer in
+ *                  memory. Note that this is NOT A POINTER, but
+ *                  the full 64bit physical address of the
+ *                  buffer. This may be zero if buffer_length is
+ *                  zero.
+ * @param buffer_length
+ *                  Length of buffer in bytes.
+ * @param callback  Function to call when this transaction
+ *                  completes. If the return value of this
+ *                  function isn't an error, then this function
+ *                  is guaranteed to be called when the
+ *                  transaction completes. If this parameter is
+ *                  NULL, then the generic callback registered
+ *                  through cvmx_usb_register_callback is
+ *                  called. If both are NULL, then there is no
+ *                  way to know when a transaction completes.
+ * @param user_data User supplied data returned when the
+ *                  callback is called. This is only used if
+ *                  callback in not NULL.
+ *
+ * @return A submitted transaction handle or negative on
+ *         failure. Negative values are failure codes from
+ *         cvmx_usb_status_t.
+ */
+int cvmx_usb_submit_isochronous(cvmx_usb_state_t *state, int pipe_handle,
+                                int start_frame, int flags,
+                                int number_packets,
+                                cvmx_usb_iso_packet_t packets[],
+                                uint64_t buffer, int buffer_length,
+                                cvmx_usb_callback_func_t callback,
+                                void *user_data)
+{
+    int submit_handle;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    CVMX_USB_LOG_PARAM("%d", pipe_handle);
+    CVMX_USB_LOG_PARAM("%d", start_frame);
+    CVMX_USB_LOG_PARAM("0x%x", flags);
+    CVMX_USB_LOG_PARAM("%d", number_packets);
+    CVMX_USB_LOG_PARAM("%p", packets);
+    CVMX_USB_LOG_PARAM("0x%llx", (unsigned long long)buffer);
+    CVMX_USB_LOG_PARAM("%d", buffer_length);
+
+    /* Pipe handle checking is done later in a common place */
+    if (cvmx_unlikely(start_frame < 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(flags & ~(CVMX_USB_ISOCHRONOUS_FLAGS_ALLOW_SHORT | CVMX_USB_ISOCHRONOUS_FLAGS_ASAP)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(number_packets < 1))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(!packets))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(!buffer))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(buffer_length < 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    submit_handle = __cvmx_usb_submit_transaction(usb, pipe_handle,
+                                         CVMX_USB_TRANSFER_ISOCHRONOUS,
+                                         flags,
+                                         buffer,
+                                         buffer_length,
+                                         0, /* control_header */
+                                         start_frame,
+                                         number_packets,
+                                         packets,
+                                         callback,
+                                         user_data);
+    CVMX_USB_RETURN(submit_handle);
+}
+
+
+/**
+ * Cancel one outstanding request in a pipe. Canceling a request
+ * can fail if the transaction has already completed before cancel
+ * is called. Even after a successful cancel call, it may take
+ * a frame or two for the cvmx_usb_poll() function to call the
+ * associated callback.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param pipe_handle
+ *               Pipe handle to cancel requests in.
+ * @param submit_handle
+ *               Handle to transaction to cancel, returned by the submit function.
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+cvmx_usb_status_t cvmx_usb_cancel(cvmx_usb_state_t *state, int pipe_handle,
+                                  int submit_handle)
+{
+    cvmx_usb_transaction_t *transaction;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+    cvmx_usb_pipe_t *pipe = usb->pipe + pipe_handle;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    CVMX_USB_LOG_PARAM("%d", pipe_handle);
+    CVMX_USB_LOG_PARAM("%d", submit_handle);
+
+    if (cvmx_unlikely((pipe_handle < 0) || (pipe_handle >= MAX_PIPES)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely((submit_handle < 0) || (submit_handle >= MAX_TRANSACTIONS)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    /* Fail if the pipe isn't open */
+    if (cvmx_unlikely((pipe->flags & __CVMX_USB_PIPE_FLAGS_OPEN) == 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    transaction = usb->transaction + submit_handle;
+
+    /* Fail if this transaction already completed */
+    if (cvmx_unlikely((transaction->flags & __CVMX_USB_TRANSACTION_FLAGS_IN_USE) == 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    /* If the transaction is the HEAD of the queue and scheduled. We need to
+        treat it special */
+    if ((pipe->head == transaction) &&
+        (pipe->flags & __CVMX_USB_PIPE_FLAGS_SCHEDULED))
+    {
+        cvmx_usbcx_hccharx_t usbc_hcchar;
+
+        usb->pipe_for_channel[pipe->channel] = NULL;
+        pipe->flags &= ~__CVMX_USB_PIPE_FLAGS_SCHEDULED;
+
+        CVMX_SYNCW;
+
+        usbc_hcchar.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCCHARX(pipe->channel, usb->index));
+        /* If the channel isn't enabled then the transaction already completed */
+        if (usbc_hcchar.s.chena)
+        {
+            usbc_hcchar.s.chdis = 1;
+            __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCCHARX(pipe->channel, usb->index), usbc_hcchar.u32);
+        }
+    }
+    __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_CANCEL);
+    CVMX_USB_RETURN(CVMX_USB_SUCCESS);
+}
+
+
+/**
+ * Cancel all outstanding requests in a pipe. Logically all this
+ * does is call cvmx_usb_cancel() in a loop.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param pipe_handle
+ *               Pipe handle to cancel requests in.
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+cvmx_usb_status_t cvmx_usb_cancel_all(cvmx_usb_state_t *state, int pipe_handle)
+{
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+    cvmx_usb_pipe_t *pipe = usb->pipe + pipe_handle;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    CVMX_USB_LOG_PARAM("%d", pipe_handle);
+    if (cvmx_unlikely((pipe_handle < 0) || (pipe_handle >= MAX_PIPES)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    /* Fail if the pipe isn't open */
+    if (cvmx_unlikely((pipe->flags & __CVMX_USB_PIPE_FLAGS_OPEN) == 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    /* Simply loop through and attempt to cancel each transaction */
+    while (pipe->head)
+    {
+        cvmx_usb_status_t result = cvmx_usb_cancel(state, pipe_handle,
+            __cvmx_usb_get_submit_handle(usb, pipe->head));
+        if (cvmx_unlikely(result != CVMX_USB_SUCCESS))
+            CVMX_USB_RETURN(result);
+    }
+    CVMX_USB_RETURN(CVMX_USB_SUCCESS);
+}
+
+
+/**
+ * Close a pipe created with cvmx_usb_open_pipe().
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param pipe_handle
+ *               Pipe handle to close.
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t. CVMX_USB_BUSY is returned if the
+ *         pipe has outstanding transfers.
+ */
+cvmx_usb_status_t cvmx_usb_close_pipe(cvmx_usb_state_t *state, int pipe_handle)
+{
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+    cvmx_usb_pipe_t *pipe = usb->pipe + pipe_handle;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    CVMX_USB_LOG_PARAM("%d", pipe_handle);
+    if (cvmx_unlikely((pipe_handle < 0) || (pipe_handle >= MAX_PIPES)))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    /* Fail if the pipe isn't open */
+    if (cvmx_unlikely((pipe->flags & __CVMX_USB_PIPE_FLAGS_OPEN) == 0))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    /* Fail if the pipe has pending transactions */
+    if (cvmx_unlikely(pipe->head))
+        CVMX_USB_RETURN(CVMX_USB_BUSY);
+
+    pipe->flags = 0;
+    __cvmx_usb_remove_pipe(&usb->idle_pipes, pipe);
+    __cvmx_usb_append_pipe(&usb->free_pipes, pipe);
+
+    CVMX_USB_RETURN(CVMX_USB_SUCCESS);
+}
+
+
+/**
+ * Register a function to be called when various USB events occur.
+ *
+ * @param state     USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param reason    Which event to register for.
+ * @param callback  Function to call when the event occurs.
+ * @param user_data User data parameter to the function.
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+cvmx_usb_status_t cvmx_usb_register_callback(cvmx_usb_state_t *state,
+                                             cvmx_usb_callback_t reason,
+                                             cvmx_usb_callback_func_t callback,
+                                             void *user_data)
+{
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+    CVMX_USB_LOG_PARAM("%d", reason);
+    CVMX_USB_LOG_PARAM("%p", callback);
+    CVMX_USB_LOG_PARAM("%p", user_data);
+    if (cvmx_unlikely(reason >= __CVMX_USB_CALLBACK_END))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+    if (cvmx_unlikely(!callback))
+        CVMX_USB_RETURN(CVMX_USB_INVALID_PARAM);
+
+    usb->callback[reason] = callback;
+    usb->callback_data[reason] = user_data;
+
+    CVMX_USB_RETURN(CVMX_USB_SUCCESS);
+}
+
+
+/**
+ * Get the current USB protocol level frame number. The frame
+ * number is always in the range of 0-0x7ff.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return USB frame number
+ */
+int cvmx_usb_get_frame_number(cvmx_usb_state_t *state)
+{
+    int frame_number;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+    cvmx_usbcx_hfnum_t usbc_hfnum;
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+
+    usbc_hfnum.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HFNUM(usb->index));
+    frame_number = usbc_hfnum.s.frnum;
+
+    CVMX_USB_RETURN(frame_number);
+}
+
+
+/**
+ * @INTERNAL
+ * Poll a channel for status
+ *
+ * @param usb     USB device
+ * @param channel Channel to poll
+ *
+ * @return Zero on success
+ */
+static int __cvmx_usb_poll_channel(cvmx_usb_internal_state_t *usb, int channel)
+{
+    cvmx_usbcx_hcintx_t usbc_hcint;
+    cvmx_usbcx_hctsizx_t usbc_hctsiz;
+    cvmx_usbcx_hccharx_t usbc_hcchar;
+    cvmx_usb_pipe_t *pipe;
+    cvmx_usb_transaction_t *transaction;
+    int bytes_this_transfer;
+    int bytes_in_last_packet;
+    int packets_processed;
+    int buffer_space_left;
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", usb);
+    CVMX_USB_LOG_PARAM("%d", channel);
+
+    /* Read the interrupt status bits for the channel */
+    usbc_hcint.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCINTX(channel, usb->index));
+
+    if (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA)
+    {
+        usbc_hcchar.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCCHARX(channel, usb->index));
+
+        if (usbc_hcchar.s.chena && usbc_hcchar.s.chdis)
+        {
+            /* There seems to be a bug in CN31XX which can cause interrupt
+                IN transfers to get stuck until we do a write of HCCHARX
+                without changing things */
+            __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCCHARX(channel, usb->index), usbc_hcchar.u32);
+            CVMX_USB_RETURN(0);
+        }
+
+        /* In non DMA mode the channels don't halt themselves. We need to
+            manually disable channels that are left running */
+        if (!usbc_hcint.s.chhltd)
+        {
+            if (usbc_hcchar.s.chena)
+            {
+                cvmx_usbcx_hcintmskx_t hcintmsk;
+                /* Disable all interrupts except CHHLTD */
+                hcintmsk.u32 = 0;
+                hcintmsk.s.chhltdmsk = 1;
+                __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCINTMSKX(channel, usb->index), hcintmsk.u32);
+                usbc_hcchar.s.chdis = 1;
+                __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCCHARX(channel, usb->index), usbc_hcchar.u32);
+                CVMX_USB_RETURN(0);
+            }
+            else if (usbc_hcint.s.xfercompl)
+            {
+                /* Successful IN/OUT with transfer complete. Channel halt isn't needed */
+            }
+            else
+            {
+                cvmx_dprintf("USB%d: Channel %d interrupt without halt\n", usb->index, channel);
+                CVMX_USB_RETURN(0);
+            }
+        }
+    }
+    else
+    {
+        /* There is are no interrupts that we need to process when the channel is
+            still running */
+        if (!usbc_hcint.s.chhltd)
+            CVMX_USB_RETURN(0);
+    }
+
+    /* Disable the channel interrupts now that it is done */
+    __cvmx_usb_write_csr32(usb, CVMX_USBCX_HCINTMSKX(channel, usb->index), 0);
+    usb->idle_hardware_channels |= (1<<channel);
+
+    /* Make sure this channel is tied to a valid pipe */
+    pipe = usb->pipe_for_channel[channel];
+    CVMX_PREFETCH(pipe, 0);
+    CVMX_PREFETCH(pipe, 128);
+    if (!pipe)
+        CVMX_USB_RETURN(0);
+    transaction = pipe->head;
+    CVMX_PREFETCH0(transaction);
+
+    /* Disconnect this pipe from the HW channel. Later the schedule function will
+        figure out which pipe needs to go */
+    usb->pipe_for_channel[channel] = NULL;
+    pipe->flags &= ~__CVMX_USB_PIPE_FLAGS_SCHEDULED;
+
+    /* Read the channel config info so we can figure out how much data
+        transfered */
+    usbc_hcchar.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCCHARX(channel, usb->index));
+    usbc_hctsiz.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HCTSIZX(channel, usb->index));
+
+    /* Calculating the number of bytes successfully transferred is dependent on
+        the transfer direction */
+    packets_processed = transaction->pktcnt - usbc_hctsiz.s.pktcnt;
+    if (usbc_hcchar.s.epdir)
+    {
+        /* IN transactions are easy. For every byte received the hardware
+            decrements xfersize. All we need to do is subtract the current
+            value of xfersize from its starting value and we know how many
+            bytes were written to the buffer */
+        bytes_this_transfer = transaction->xfersize - usbc_hctsiz.s.xfersize;
+    }
+    else
+    {
+        /* OUT transaction don't decrement xfersize. Instead pktcnt is
+            decremented on every successful packet send. The hardware does
+            this when it receives an ACK, or NYET. If it doesn't
+            receive one of these responses pktcnt doesn't change */
+        bytes_this_transfer = packets_processed * usbc_hcchar.s.mps;
+        /* The last packet may not be a full transfer if we didn't have
+            enough data */
+        if (bytes_this_transfer > transaction->xfersize)
+            bytes_this_transfer = transaction->xfersize;
+    }
+    /* Figure out how many bytes were in the last packet of the transfer */
+    if (packets_processed)
+        bytes_in_last_packet = bytes_this_transfer - (packets_processed-1) * usbc_hcchar.s.mps;
+    else
+        bytes_in_last_packet = bytes_this_transfer;
+
+    /* As a special case, setup transactions output the setup header, not
+        the user's data. For this reason we don't count setup data as bytes
+        transferred */
+    if ((transaction->stage == CVMX_USB_STAGE_SETUP) ||
+        (transaction->stage == CVMX_USB_STAGE_SETUP_SPLIT_COMPLETE))
+        bytes_this_transfer = 0;
+
+    /* Optional debug output */
+    if (cvmx_unlikely((usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_DEBUG_TRANSFERS) ||
+        (pipe->flags & CVMX_USB_PIPE_FLAGS_DEBUG_TRANSFERS)))
+        cvmx_dprintf("%s: Channel %d halted. Pipe %d transaction %d stage %d bytes=%d\n",
+                     __FUNCTION__, channel,
+                     __cvmx_usb_get_pipe_handle(usb, pipe),
+                     __cvmx_usb_get_submit_handle(usb, transaction),
+                     transaction->stage, bytes_this_transfer);
+
+    /* Add the bytes transferred to the running total. It is important that
+        bytes_this_transfer doesn't count any data that needs to be
+        retransmitted */
+    transaction->actual_bytes += bytes_this_transfer;
+    if (transaction->type == CVMX_USB_TRANSFER_ISOCHRONOUS)
+        buffer_space_left = transaction->iso_packets[0].length - transaction->actual_bytes;
+    else
+        buffer_space_left = transaction->buffer_length - transaction->actual_bytes;
+
+    /* We need to remember the PID toggle state for the next transaction. The
+        hardware already updated it for the next transaction */
+    pipe->pid_toggle = !(usbc_hctsiz.s.pid == 0);
+
+    /* For high speed bulk out, assume the next transaction will need to do a
+        ping before proceeding. If this isn't true the ACK processing below
+        will clear this flag */
+    if ((pipe->device_speed == CVMX_USB_SPEED_HIGH) &&
+        (pipe->transfer_type == CVMX_USB_TRANSFER_BULK) &&
+        (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT))
+        pipe->flags |= __CVMX_USB_PIPE_FLAGS_NEED_PING;
+
+    if (usbc_hcint.s.stall)
+    {
+        /* STALL as a response means this transaction cannot be completed
+            because the device can't process transactions. Tell the user. Any
+            data that was transferred will be counted on the actual bytes
+            transferred */
+        pipe->pid_toggle = 0;
+        __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_STALL);
+    }
+    else if (usbc_hcint.s.xacterr)
+    {
+        /* We know at least one packet worked if we get a ACK or NAK. Reset the retry counter */
+        if (usbc_hcint.s.nak || usbc_hcint.s.ack)
+            transaction->retries = 0;
+        transaction->retries++;
+        if (transaction->retries > MAX_RETRIES)
+        {
+            /* XactErr as a response means the device signaled something wrong with
+                the transfer. For example, PID toggle errors cause these */
+            __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_XACTERR);
+        }
+        else
+        {
+            /* If this was a split then clear our split in progress marker */
+            if (usb->active_split == transaction)
+                usb->active_split = NULL;
+            /* Rewind to the beginning of the transaction by anding off the
+                split complete bit */
+            transaction->stage &= ~1;
+            pipe->split_sc_frame = -1;
+            pipe->next_tx_frame += pipe->interval;
+            if (pipe->next_tx_frame < usb->frame_number)
+                pipe->next_tx_frame = usb->frame_number + pipe->interval -
+                    (usb->frame_number - pipe->next_tx_frame) % pipe->interval;
+        }
+    }
+    else if (usbc_hcint.s.bblerr)
+    {
+        /* Babble Error (BblErr) */
+        __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_BABBLEERR);
+    }
+    else if (usbc_hcint.s.datatglerr)
+    {
+        /* We'll retry the exact same transaction again */
+        transaction->retries++;
+    }
+    else if (usbc_hcint.s.nyet)
+    {
+        /* NYET as a response is only allowed in three cases: as a response to
+            a ping, as a response to a split transaction, and as a response to
+            a bulk out. The ping case is handled by hardware, so we only have
+            splits and bulk out */
+        if (!__cvmx_usb_pipe_needs_split(usb, pipe))
+        {
+            transaction->retries = 0;
+            /* If there is more data to go then we need to try again. Otherwise
+                this transaction is complete */
+            if ((buffer_space_left == 0) || (bytes_in_last_packet < pipe->max_packet))
+                __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_SUCCESS);
+        }
+        else
+        {
+            /* Split transactions retry the split complete 4 times then rewind
+                to the start split and do the entire transactions again */
+            transaction->retries++;
+            if ((transaction->retries & 0x3) == 0)
+            {
+                /* Rewind to the beginning of the transaction by anding off the
+                    split complete bit */
+                transaction->stage &= ~1;
+                pipe->split_sc_frame = -1;
+            }
+        }
+    }
+    else if (usbc_hcint.s.ack)
+    {
+        transaction->retries = 0;
+        /* The ACK bit can only be checked after the other error bits. This is
+            because a multi packet transfer may succeed in a number of packets
+            and then get a different response on the last packet. In this case
+            both ACK and the last response bit will be set. If none of the
+            other response bits is set, then the last packet must have been an
+            ACK */
+
+        /* Since we got an ACK, we know we don't need to do a ping on this
+            pipe */
+        pipe->flags &= ~__CVMX_USB_PIPE_FLAGS_NEED_PING;
+
+        switch (transaction->type)
+        {
+            case CVMX_USB_TRANSFER_CONTROL:
+                switch (transaction->stage)
+                {
+                    case CVMX_USB_STAGE_NON_CONTROL:
+                    case CVMX_USB_STAGE_NON_CONTROL_SPLIT_COMPLETE:
+                        /* This should be impossible */
+                        __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_ERROR);
+                        break;
+                    case CVMX_USB_STAGE_SETUP:
+                        pipe->pid_toggle = 1;
+                        if (__cvmx_usb_pipe_needs_split(usb, pipe))
+                            transaction->stage = CVMX_USB_STAGE_SETUP_SPLIT_COMPLETE;
+                        else
+                        {
+                            cvmx_usb_control_header_t *header = cvmx_phys_to_ptr(transaction->control_header);
+                            if (header->s.length)
+                                transaction->stage = CVMX_USB_STAGE_DATA;
+                            else
+                                transaction->stage = CVMX_USB_STAGE_STATUS;
+                        }
+                        break;
+                    case CVMX_USB_STAGE_SETUP_SPLIT_COMPLETE:
+                        {
+                            cvmx_usb_control_header_t *header = cvmx_phys_to_ptr(transaction->control_header);
+                            if (header->s.length)
+                                transaction->stage = CVMX_USB_STAGE_DATA;
+                            else
+                                transaction->stage = CVMX_USB_STAGE_STATUS;
+                        }
+                        break;
+                    case CVMX_USB_STAGE_DATA:
+                        if (__cvmx_usb_pipe_needs_split(usb, pipe))
+                        {
+                            transaction->stage = CVMX_USB_STAGE_DATA_SPLIT_COMPLETE;
+                            /* For setup OUT data that are splits, the hardware
+                                doesn't appear to count transferred data. Here
+                                we manually update the data transferred */
+                            if (!usbc_hcchar.s.epdir)
+                            {
+                                if (buffer_space_left < pipe->max_packet)
+                                    transaction->actual_bytes += buffer_space_left;
+                                else
+                                    transaction->actual_bytes += pipe->max_packet;
+                            }
+                        }
+                        else if ((buffer_space_left == 0) || (bytes_in_last_packet < pipe->max_packet))
+                        {
+                            pipe->pid_toggle = 1;
+                            transaction->stage = CVMX_USB_STAGE_STATUS;
+                        }
+                        break;
+                    case CVMX_USB_STAGE_DATA_SPLIT_COMPLETE:
+                        if ((buffer_space_left == 0) || (bytes_in_last_packet < pipe->max_packet))
+                        {
+                            pipe->pid_toggle = 1;
+                            transaction->stage = CVMX_USB_STAGE_STATUS;
+                        }
+                        else
+                        {
+                            transaction->stage = CVMX_USB_STAGE_DATA;
+                        }
+                        break;
+                    case CVMX_USB_STAGE_STATUS:
+                        if (__cvmx_usb_pipe_needs_split(usb, pipe))
+                            transaction->stage = CVMX_USB_STAGE_STATUS_SPLIT_COMPLETE;
+                        else
+                            __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_SUCCESS);
+                        break;
+                    case CVMX_USB_STAGE_STATUS_SPLIT_COMPLETE:
+                        __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_SUCCESS);
+                        break;
+                }
+                break;
+            case CVMX_USB_TRANSFER_BULK:
+            case CVMX_USB_TRANSFER_INTERRUPT:
+                /* The only time a bulk transfer isn't complete when
+                    it finishes with an ACK is during a split transaction. For
+                    splits we need to continue the transfer if more data is
+                    needed */
+                if (__cvmx_usb_pipe_needs_split(usb, pipe))
+                {
+                    if (transaction->stage == CVMX_USB_STAGE_NON_CONTROL)
+                        transaction->stage = CVMX_USB_STAGE_NON_CONTROL_SPLIT_COMPLETE;
+                    else
+                    {
+                        if (buffer_space_left && (bytes_in_last_packet == pipe->max_packet))
+                            transaction->stage = CVMX_USB_STAGE_NON_CONTROL;
+                        else
+                        {
+                            if (transaction->type == CVMX_USB_TRANSFER_INTERRUPT)
+                                pipe->next_tx_frame += pipe->interval;
+                            __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_SUCCESS);
+                        }
+                    }
+                }
+                else
+                {
+                    if ((pipe->device_speed == CVMX_USB_SPEED_HIGH) &&
+                        (pipe->transfer_type == CVMX_USB_TRANSFER_BULK) &&
+                        (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) &&
+                        (usbc_hcint.s.nak))
+                        pipe->flags |= __CVMX_USB_PIPE_FLAGS_NEED_PING;
+                    if (!buffer_space_left || (bytes_in_last_packet < pipe->max_packet))
+                    {
+                        if (transaction->type == CVMX_USB_TRANSFER_INTERRUPT)
+                            pipe->next_tx_frame += pipe->interval;
+                        __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_SUCCESS);
+                    }
+                }
+                break;
+            case CVMX_USB_TRANSFER_ISOCHRONOUS:
+                if (__cvmx_usb_pipe_needs_split(usb, pipe))
+                {
+                    /* ISOCHRONOUS OUT splits don't require a complete split stage.
+                        Instead they use a sequence of begin OUT splits to transfer
+                        the data 188 bytes at a time. Once the transfer is complete,
+                        the pipe sleeps until the next schedule interval */
+                    if (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT)
+                    {
+                        /* If no space left or this wasn't a max size packet then
+                            this transfer is complete. Otherwise start it again
+                            to send the next 188 bytes */
+                        if (!buffer_space_left || (bytes_this_transfer < 188))
+                        {
+                            pipe->next_tx_frame += pipe->interval;
+                            __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_SUCCESS);
+                        }
+                    }
+                    else
+                    {
+                        if (transaction->stage == CVMX_USB_STAGE_NON_CONTROL_SPLIT_COMPLETE)
+                        {
+                            /* We are in the incoming data phase. Keep getting
+                                data until we run out of space or get a small
+                                packet */
+                            if ((buffer_space_left == 0) || (bytes_in_last_packet < pipe->max_packet))
+                            {
+                                pipe->next_tx_frame += pipe->interval;
+                                __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_SUCCESS);
+                            }
+                        }
+                        else
+                            transaction->stage = CVMX_USB_STAGE_NON_CONTROL_SPLIT_COMPLETE;
+                    }
+                }
+                else
+                {
+                    pipe->next_tx_frame += pipe->interval;
+                    __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_SUCCESS);
+                }
+                break;
+        }
+    }
+    else if (usbc_hcint.s.nak)
+    {
+        /* If this was a split then clear our split in progress marker */
+        if (usb->active_split == transaction)
+            usb->active_split = NULL;
+        /* NAK as a response means the device couldn't accept the transaction,
+            but it should be retried in the future. Rewind to the beginning of
+            the transaction by anding off the split complete bit. Retry in the
+            next interval */
+        transaction->retries = 0;
+        transaction->stage &= ~1;
+        pipe->next_tx_frame += pipe->interval;
+        if (pipe->next_tx_frame < usb->frame_number)
+            pipe->next_tx_frame = usb->frame_number + pipe->interval -
+                (usb->frame_number - pipe->next_tx_frame) % pipe->interval;
+    }
+    else
+    {
+        cvmx_usb_port_status_t port;
+        port = cvmx_usb_get_status((cvmx_usb_state_t *)usb);
+        if (port.port_enabled)
+        {
+            /* We'll retry the exact same transaction again */
+            transaction->retries++;
+        }
+        else
+        {
+            /* We get channel halted interrupts with no result bits sets when the
+                cable is unplugged */
+            __cvmx_usb_perform_complete(usb, pipe, transaction, CVMX_USB_COMPLETE_ERROR);
+        }
+    }
+    CVMX_USB_RETURN(0);
+}
+
+
+/**
+ * Poll the USB block for status and call all needed callback
+ * handlers. This function is meant to be called in the interrupt
+ * handler for the USB controller. It can also be called
+ * periodically in a loop for non-interrupt based operation.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+cvmx_usb_status_t cvmx_usb_poll(cvmx_usb_state_t *state)
+{
+    cvmx_usbcx_hfnum_t usbc_hfnum;
+    cvmx_usbcx_gintsts_t usbc_gintsts;
+    cvmx_usb_internal_state_t *usb = (cvmx_usb_internal_state_t*)state;
+
+    CVMX_PREFETCH(usb, 0);
+    CVMX_PREFETCH(usb, 1*128);
+    CVMX_PREFETCH(usb, 2*128);
+    CVMX_PREFETCH(usb, 3*128);
+    CVMX_PREFETCH(usb, 4*128);
+
+    CVMX_USB_LOG_CALLED();
+    CVMX_USB_LOG_PARAM("%p", state);
+
+    /* Update the frame counter */
+    usbc_hfnum.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HFNUM(usb->index));
+    if ((usb->frame_number&0x3fff) > usbc_hfnum.s.frnum)
+        usb->frame_number += 0x4000;
+    usb->frame_number &= ~0x3fffull;
+    usb->frame_number |= usbc_hfnum.s.frnum;
+
+    /* Read the pending interrupts */
+    usbc_gintsts.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_GINTSTS(usb->index));
+
+    /* Clear the interrupts now that we know about them */
+    __cvmx_usb_write_csr32(usb, CVMX_USBCX_GINTSTS(usb->index), usbc_gintsts.u32);
+
+    if (usbc_gintsts.s.rxflvl)
+    {
+        /* RxFIFO Non-Empty (RxFLvl)
+            Indicates that there is at least one packet pending to be read
+            from the RxFIFO. */
+        /* In DMA mode this is handled by hardware */
+        if (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA)
+            __cvmx_usb_poll_rx_fifo(usb);
+    }
+    if (usbc_gintsts.s.ptxfemp || usbc_gintsts.s.nptxfemp)
+    {
+        /* Fill the Tx FIFOs when not in DMA mode */
+        if (usb->init_flags & CVMX_USB_INITIALIZE_FLAGS_NO_DMA)
+            __cvmx_usb_poll_tx_fifo(usb);
+    }
+    if (usbc_gintsts.s.disconnint || usbc_gintsts.s.prtint)
+    {
+        cvmx_usbcx_hprt_t usbc_hprt;
+        /* Disconnect Detected Interrupt (DisconnInt)
+            Asserted when a device disconnect is detected. */
+
+        /* Host Port Interrupt (PrtInt)
+            The core sets this bit to indicate a change in port status of one
+            of the O2P USB core ports in Host mode. The application must
+            read the Host Port Control and Status (HPRT) register to
+            determine the exact event that caused this interrupt. The
+            application must clear the appropriate status bit in the Host Port
+            Control and Status register to clear this bit. */
+
+        /* Call the user's port callback */
+        __cvmx_usb_perform_callback(usb, NULL, NULL,
+                                    CVMX_USB_CALLBACK_PORT_CHANGED,
+                                    CVMX_USB_COMPLETE_SUCCESS);
+        /* Clear the port change bits */
+        usbc_hprt.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HPRT(usb->index));
+        usbc_hprt.s.prtena = 0;
+        __cvmx_usb_write_csr32(usb, CVMX_USBCX_HPRT(usb->index), usbc_hprt.u32);
+    }
+    if (usbc_gintsts.s.hchint)
+    {
+        /* Host Channels Interrupt (HChInt)
+            The core sets this bit to indicate that an interrupt is pending on
+            one of the channels of the core (in Host mode). The application
+            must read the Host All Channels Interrupt (HAINT) register to
+            determine the exact number of the channel on which the
+            interrupt occurred, and then read the corresponding Host
+            Channel-n Interrupt (HCINTn) register to determine the exact
+            cause of the interrupt. The application must clear the
+            appropriate status bit in the HCINTn register to clear this bit. */
+        cvmx_usbcx_haint_t usbc_haint;
+        usbc_haint.u32 = __cvmx_usb_read_csr32(usb, CVMX_USBCX_HAINT(usb->index));
+        while (usbc_haint.u32)
+        {
+            int channel;
+            CVMX_CLZ(channel, usbc_haint.u32);
+            channel = 31 - channel;
+            __cvmx_usb_poll_channel(usb, channel);
+            usbc_haint.u32 ^= 1<<channel;
+        }
+    }
+
+    __cvmx_usb_schedule(usb, usbc_gintsts.s.sof);
+
+    CVMX_USB_RETURN(CVMX_USB_SUCCESS);
+}
diff --git a/drivers/staging/octeon-usb/cvmx-usb.h b/drivers/staging/octeon-usb/cvmx-usb.h
new file mode 100644
index 0000000..db9cc05
--- /dev/null
+++ b/drivers/staging/octeon-usb/cvmx-usb.h
@@ -0,0 +1,1085 @@
+/***********************license start***************
+ * Copyright (c) 2003-2010  Cavium Networks (support@cavium.com). All rights
+ * reserved.
+ *
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *
+ *   * Redistributions in binary form must reproduce the above
+ *     copyright notice, this list of conditions and the following
+ *     disclaimer in the documentation and/or other materials provided
+ *     with the distribution.
+
+ *   * Neither the name of Cavium Networks nor the names of
+ *     its contributors may be used to endorse or promote products
+ *     derived from this software without specific prior written
+ *     permission.
+
+ * This Software, including technical data, may be subject to U.S. export  control
+ * laws, including the U.S. Export Administration Act and its  associated
+ * regulations, and may be subject to export or import  regulations in other
+ * countries.
+
+ * TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
+ * AND WITH ALL FAULTS AND CAVIUM  NETWORKS MAKES NO PROMISES, REPRESENTATIONS OR
+ * WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT TO
+ * THE SOFTWARE, INCLUDING ITS CONDITION, ITS CONFORMITY TO ANY REPRESENTATION OR
+ * DESCRIPTION, OR THE EXISTENCE OF ANY LATENT OR PATENT DEFECTS, AND CAVIUM
+ * SPECIFICALLY DISCLAIMS ALL IMPLIED (IF ANY) WARRANTIES OF TITLE,
+ * MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, LACK OF
+ * VIRUSES, ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION OR
+ * CORRESPONDENCE TO DESCRIPTION. THE ENTIRE  RISK ARISING OUT OF USE OR
+ * PERFORMANCE OF THE SOFTWARE LIES WITH YOU.
+ ***********************license end**************************************/
+
+
+/**
+ * @file
+ *
+ * "cvmx-usb.h" defines a set of low level USB functions to help
+ * developers create Octeon USB drivers for various operating
+ * systems. These functions provide a generic API to the Octeon
+ * USB blocks, hiding the internal hardware specific
+ * operations.
+ *
+ * At a high level the device driver needs to:
+ *
+ * -# Call cvmx_usb_get_num_ports() to get the number of
+ *  supported ports.
+ * -# Call cvmx_usb_initialize() for each Octeon USB port.
+ * -# Enable the port using cvmx_usb_enable().
+ * -# Either periodically, or in an interrupt handler, call
+ *  cvmx_usb_poll() to service USB events.
+ * -# Manage pipes using cvmx_usb_open_pipe() and
+ *  cvmx_usb_close_pipe().
+ * -# Manage transfers using cvmx_usb_submit_*() and
+ *  cvmx_usb_cancel*().
+ * -# Shutdown USB on unload using cvmx_usb_shutdown().
+ *
+ * To monitor USB status changes, the device driver must use
+ * cvmx_usb_register_callback() to register for events that it
+ * is interested in. Below are a few hints on successfully
+ * implementing a driver on top of this API.
+ *
+ * <h2>Initialization</h2>
+ *
+ * When a driver is first loaded, it is normally not necessary
+ * to bring up the USB port completely. Most operating systems
+ * expect to initialize and enable the port in two independent
+ * steps. Normally an operating system will probe hardware,
+ * initialize anything found, and then enable the hardware.
+ *
+ * In the probe phase you should:
+ * -# Use cvmx_usb_get_num_ports() to determine the number of
+ *  USB port to be supported.
+ * -# Allocate space for a cvmx_usb_state_t structure for each
+ *  port.
+ * -# Tell the operating system about each port
+ *
+ * In the initialization phase you should:
+ * -# Use cvmx_usb_initialize() on each port.
+ * -# Do not call cvmx_usb_enable(). This leaves the USB port in
+ *  the disabled state until the operating system is ready.
+ *
+ * Finally, in the enable phase you should:
+ * -# Call cvmx_usb_enable() on the appropriate port.
+ * -# Note that some operating system use a RESET instead of an
+ *  enable call. To implement RESET, you should call
+ *  cvmx_usb_disable() followed by cvmx_usb_enable().
+ *
+ * <h2>Locking</h2>
+ *
+ * All of the functions in the cvmx-usb API assume exclusive
+ * access to the USB hardware and internal data structures. This
+ * means that the driver must provide locking as necessary.
+ *
+ * In the single CPU state it is normally enough to disable
+ * interrupts before every call to cvmx_usb*() and enable them
+ * again after the call is complete. Keep in mind that it is
+ * very common for the callback handlers to make additional
+ * calls into cvmx-usb, so the disable/enable must be protected
+ * against recursion. As an example, the Linux kernel
+ * local_irq_save() and local_irq_restore() are perfect for this
+ * in the non SMP case.
+ *
+ * In the SMP case, locking is more complicated. For SMP you not
+ * only need to disable interrupts on the local core, but also
+ * take a lock to make sure that another core cannot call
+ * cvmx-usb.
+ *
+ * <h2>Port callback</h2>
+ *
+ * The port callback prototype needs to look as follows:
+ *
+ * void port_callback(cvmx_usb_state_t *usb,
+ *                    cvmx_usb_callback_t reason,
+ *                    cvmx_usb_complete_t status,
+ *                    int pipe_handle,
+ *                    int submit_handle,
+ *                    int bytes_transferred,
+ *                    void *user_data);
+ * - @b usb is the cvmx_usb_state_t for the port.
+ * - @b reason will always be
+ *   CVMX_USB_CALLBACK_PORT_CHANGED.
+ * - @b status will always be CVMX_USB_COMPLETE_SUCCESS.
+ * - @b pipe_handle will always be -1.
+ * - @b submit_handle will always be -1.
+ * - @b bytes_transferred will always be 0.
+ * - @b user_data is the void pointer originally passed along
+ *   with the callback. Use this for any state information you
+ *   need.
+ *
+ * The port callback will be called whenever the user plugs /
+ * unplugs a device from the port. It will not be called when a
+ * device is plugged / unplugged from a hub connected to the
+ * root port. Normally all the callback needs to do is tell the
+ * operating system to poll the root hub for status. Under
+ * Linux, this is performed by calling usb_hcd_poll_rh_status().
+ * In the Linux driver we use @b user_data. to pass around the
+ * Linux "hcd" structure. Once the port callback completes,
+ * Linux automatically calls octeon_usb_hub_status_data() which
+ * uses cvmx_usb_get_status() to determine the root port status.
+ *
+ * <h2>Complete callback</h2>
+ *
+ * The completion callback prototype needs to look as follows:
+ *
+ * void complete_callback(cvmx_usb_state_t *usb,
+ *                        cvmx_usb_callback_t reason,
+ *                        cvmx_usb_complete_t status,
+ *                        int pipe_handle,
+ *                        int submit_handle,
+ *                        int bytes_transferred,
+ *                        void *user_data);
+ * - @b usb is the cvmx_usb_state_t for the port.
+ * - @b reason will always be
+ *   CVMX_USB_CALLBACK_TRANSFER_COMPLETE.
+ * - @b status will be one of the cvmx_usb_complete_t
+ *   enumerations.
+ * - @b pipe_handle is the handle to the pipe the transaction
+ *   was originally submitted on.
+ * - @b submit_handle is the handle returned by the original
+ *   cvmx_usb_submit_* call.
+ * - @b bytes_transferred is the number of bytes successfully
+ *   transferred in the transaction. This will be zero on most
+ *   error conditions.
+ * - @b user_data is the void pointer originally passed along
+ *   with the callback. Use this for any state information you
+ *   need. For example, the Linux "urb" is stored in here in the
+ *   Linux driver.
+ *
+ * In general your callback handler should use @b status and @b
+ * bytes_transferred to tell the operating system the how the
+ * transaction completed. Normally the pipe is not changed in
+ * this callback.
+ *
+ * <h2>Canceling transactions</h2>
+ *
+ * When a transaction is cancelled using cvmx_usb_cancel*(), the
+ * actual length of time until the complete callback is called
+ * can vary greatly. It may be called before cvmx_usb_cancel*()
+ * returns, or it may be called a number of usb frames in the
+ * future once the hardware frees the transaction. In either of
+ * these cases, the complete handler will receive
+ * CVMX_USB_COMPLETE_CANCEL.
+ *
+ * <h2>Handling pipes</h2>
+ *
+ * USB "pipes" is a software construct created by this API to
+ * enable the ordering of usb transactions to a device endpoint.
+ * Octeon's underlying hardware doesn't have any concept
+ * equivalent to "pipes". The hardware instead has eight
+ * channels that can be used simultaneously to have up to eight
+ * transaction in process at the same time. In order to maintain
+ * ordering in a pipe, the transactions for a pipe will only be
+ * active in one hardware channel at a time. From an API user's
+ * perspective, this doesn't matter but it can be helpful to
+ * keep this in mind when you are probing hardware while
+ * debugging.
+ *
+ * Also keep in mind that usb transactions contain state
+ * information about the previous transaction to the same
+ * endpoint. Each transaction has a PID toggle that changes 0/1
+ * between each sub packet. This is maintained in the pipe data
+ * structures. For this reason, you generally cannot create and
+ * destroy a pipe for every transaction. A sequence of
+ * transaction to the same endpoint must use the same pipe.
+ *
+ * <h2>Root Hub</h2>
+ *
+ * Some operating systems view the usb root port as a normal usb
+ * hub. These systems attempt to control the root hub with
+ * messages similar to the usb 2.0 spec for hub control and
+ * status. For these systems it may be necessary to write
+ * function to decode standard usb control messages into
+ * equivalent cvmx-usb API calls. As an example, the following
+ * code is used under Linux for some of the basic hub control
+ * messages.
+ *
+ * @code
+ * static int octeon_usb_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue, u16 wIndex, char *buf, u16 wLength)
+ * {
+ *     cvmx_usb_state_t *usb = (cvmx_usb_state_t *)hcd->hcd_priv;
+ *     cvmx_usb_port_status_t usb_port_status;
+ *     int port_status;
+ *     struct usb_hub_descriptor *desc;
+ *     unsigned long flags;
+ *
+ *     switch (typeReq)
+ *     {
+ *         case ClearHubFeature:
+ *             DEBUG_ROOT_HUB("OcteonUSB: ClearHubFeature\n");
+ *             switch (wValue)
+ *             {
+ *                 case C_HUB_LOCAL_POWER:
+ *                 case C_HUB_OVER_CURRENT:
+ *                     // Nothing required here
+ *                     break;
+ *                 default:
+ *                     return -EINVAL;
+ *             }
+ *             break;
+ *         case ClearPortFeature:
+ *             DEBUG_ROOT_HUB("OcteonUSB: ClearPortFeature");
+ *             if (wIndex != 1)
+ *             {
+ *                 DEBUG_ROOT_HUB(" INVALID\n");
+ *                 return -EINVAL;
+ *             }
+ *
+ *             switch (wValue)
+ *             {
+ *                 case USB_PORT_FEAT_ENABLE:
+ *                     DEBUG_ROOT_HUB(" ENABLE");
+ *                     local_irq_save(flags);
+ *                     cvmx_usb_disable(usb);
+ *                     local_irq_restore(flags);
+ *                     break;
+ *                 case USB_PORT_FEAT_SUSPEND:
+ *                     DEBUG_ROOT_HUB(" SUSPEND");
+ *                     // Not supported on Octeon
+ *                     break;
+ *                 case USB_PORT_FEAT_POWER:
+ *                     DEBUG_ROOT_HUB(" POWER");
+ *                     // Not supported on Octeon
+ *                     break;
+ *                 case USB_PORT_FEAT_INDICATOR:
+ *                     DEBUG_ROOT_HUB(" INDICATOR");
+ *                     // Port inidicator not supported
+ *                     break;
+ *                 case USB_PORT_FEAT_C_CONNECTION:
+ *                     DEBUG_ROOT_HUB(" C_CONNECTION");
+ *                     // Clears drivers internal connect status change flag
+ *                     cvmx_usb_set_status(usb, cvmx_usb_get_status(usb));
+ *                     break;
+ *                 case USB_PORT_FEAT_C_RESET:
+ *                     DEBUG_ROOT_HUB(" C_RESET");
+ *                     // Clears the driver's internal Port Reset Change flag
+ *                     cvmx_usb_set_status(usb, cvmx_usb_get_status(usb));
+ *                     break;
+ *                 case USB_PORT_FEAT_C_ENABLE:
+ *                     DEBUG_ROOT_HUB(" C_ENABLE");
+ *                     // Clears the driver's internal Port Enable/Disable Change flag
+ *                     cvmx_usb_set_status(usb, cvmx_usb_get_status(usb));
+ *                     break;
+ *                 case USB_PORT_FEAT_C_SUSPEND:
+ *                     DEBUG_ROOT_HUB(" C_SUSPEND");
+ *                     // Clears the driver's internal Port Suspend Change flag,
+ *                         which is set when resume signaling on the host port is
+ *                         complete
+ *                     break;
+ *                 case USB_PORT_FEAT_C_OVER_CURRENT:
+ *                     DEBUG_ROOT_HUB(" C_OVER_CURRENT");
+ *                     // Clears the driver's overcurrent Change flag
+ *                     cvmx_usb_set_status(usb, cvmx_usb_get_status(usb));
+ *                     break;
+ *                 default:
+ *                     DEBUG_ROOT_HUB(" UNKNOWN\n");
+ *                     return -EINVAL;
+ *             }
+ *             DEBUG_ROOT_HUB("\n");
+ *             break;
+ *         case GetHubDescriptor:
+ *             DEBUG_ROOT_HUB("OcteonUSB: GetHubDescriptor\n");
+ *             desc = (struct usb_hub_descriptor *)buf;
+ *             desc->bDescLength = 9;
+ *             desc->bDescriptorType = 0x29;
+ *             desc->bNbrPorts = 1;
+ *             desc->wHubCharacteristics = 0x08;
+ *             desc->bPwrOn2PwrGood = 1;
+ *             desc->bHubContrCurrent = 0;
+ *             desc->bitmap[0] = 0;
+ *             desc->bitmap[1] = 0xff;
+ *             break;
+ *         case GetHubStatus:
+ *             DEBUG_ROOT_HUB("OcteonUSB: GetHubStatus\n");
+ *             *(__le32 *)buf = 0;
+ *             break;
+ *         case GetPortStatus:
+ *             DEBUG_ROOT_HUB("OcteonUSB: GetPortStatus");
+ *             if (wIndex != 1)
+ *             {
+ *                 DEBUG_ROOT_HUB(" INVALID\n");
+ *                 return -EINVAL;
+ *             }
+ *
+ *             usb_port_status = cvmx_usb_get_status(usb);
+ *             port_status = 0;
+ *
+ *             if (usb_port_status.connect_change)
+ *             {
+ *                 port_status |= (1 << USB_PORT_FEAT_C_CONNECTION);
+ *                 DEBUG_ROOT_HUB(" C_CONNECTION");
+ *             }
+ *
+ *             if (usb_port_status.port_enabled)
+ *             {
+ *                 port_status |= (1 << USB_PORT_FEAT_C_ENABLE);
+ *                 DEBUG_ROOT_HUB(" C_ENABLE");
+ *             }
+ *
+ *             if (usb_port_status.connected)
+ *             {
+ *                 port_status |= (1 << USB_PORT_FEAT_CONNECTION);
+ *                 DEBUG_ROOT_HUB(" CONNECTION");
+ *             }
+ *
+ *             if (usb_port_status.port_enabled)
+ *             {
+ *                 port_status |= (1 << USB_PORT_FEAT_ENABLE);
+ *                 DEBUG_ROOT_HUB(" ENABLE");
+ *             }
+ *
+ *             if (usb_port_status.port_over_current)
+ *             {
+ *                 port_status |= (1 << USB_PORT_FEAT_OVER_CURRENT);
+ *                 DEBUG_ROOT_HUB(" OVER_CURRENT");
+ *             }
+ *
+ *             if (usb_port_status.port_powered)
+ *             {
+ *                 port_status |= (1 << USB_PORT_FEAT_POWER);
+ *                 DEBUG_ROOT_HUB(" POWER");
+ *             }
+ *
+ *             if (usb_port_status.port_speed == CVMX_USB_SPEED_HIGH)
+ *             {
+ *                 port_status |= (1 << USB_PORT_FEAT_HIGHSPEED);
+ *                 DEBUG_ROOT_HUB(" HIGHSPEED");
+ *             }
+ *             else if (usb_port_status.port_speed == CVMX_USB_SPEED_LOW)
+ *             {
+ *                 port_status |= (1 << USB_PORT_FEAT_LOWSPEED);
+ *                 DEBUG_ROOT_HUB(" LOWSPEED");
+ *             }
+ *
+ *             *((__le32 *)buf) = cpu_to_le32(port_status);
+ *             DEBUG_ROOT_HUB("\n");
+ *             break;
+ *         case SetHubFeature:
+ *             DEBUG_ROOT_HUB("OcteonUSB: SetHubFeature\n");
+ *             // No HUB features supported
+ *             break;
+ *         case SetPortFeature:
+ *             DEBUG_ROOT_HUB("OcteonUSB: SetPortFeature");
+ *             if (wIndex != 1)
+ *             {
+ *                 DEBUG_ROOT_HUB(" INVALID\n");
+ *                 return -EINVAL;
+ *             }
+ *
+ *             switch (wValue)
+ *             {
+ *                 case USB_PORT_FEAT_SUSPEND:
+ *                     DEBUG_ROOT_HUB(" SUSPEND\n");
+ *                     return -EINVAL;
+ *                 case USB_PORT_FEAT_POWER:
+ *                     DEBUG_ROOT_HUB(" POWER\n");
+ *                     return -EINVAL;
+ *                 case USB_PORT_FEAT_RESET:
+ *                     DEBUG_ROOT_HUB(" RESET\n");
+ *                     local_irq_save(flags);
+ *                     cvmx_usb_disable(usb);
+ *                     if (cvmx_usb_enable(usb))
+ *                         DEBUG_ERROR("Failed to enable the port\n");
+ *                     local_irq_restore(flags);
+ *                     return 0;
+ *                 case USB_PORT_FEAT_INDICATOR:
+ *                     DEBUG_ROOT_HUB(" INDICATOR\n");
+ *                     // Not supported
+ *                     break;
+ *                 default:
+ *                     DEBUG_ROOT_HUB(" UNKNOWN\n");
+ *                     return -EINVAL;
+ *             }
+ *             break;
+ *         default:
+ *             DEBUG_ROOT_HUB("OcteonUSB: Unknown root hub request\n");
+ *             return -EINVAL;
+ *     }
+ *     return 0;
+ * }
+ * @endcode
+ *
+ * <h2>Interrupts</h2>
+ *
+ * If you plan on using usb interrupts, cvmx_usb_poll() must be
+ * called on every usb interrupt. It will read the usb state,
+ * call any needed callbacks, and schedule transactions as
+ * needed. Your device driver needs only to hookup an interrupt
+ * handler and call cvmx_usb_poll(). Octeon's usb port 0 causes
+ * CIU bit CIU_INT*_SUM0[USB] to be set (bit 56). For port 1,
+ * CIU bit CIU_INT_SUM1[USB1] is set (bit 17). How these bits
+ * are turned into interrupt numbers is operating system
+ * specific. For Linux, there are the convenient defines
+ * OCTEON_IRQ_USB0 and OCTEON_IRQ_USB1 for the IRQ numbers.
+ *
+ * If you aren't using interrupts, simple call cvmx_usb_poll()
+ * in your main processing loop.
+ *
+ * <hr>$Revision: 32636 $<hr>
+ */
+
+#ifndef __CVMX_USB_H__
+#define __CVMX_USB_H__
+
+#ifdef	__cplusplus
+extern "C" {
+#endif
+
+/**
+ * Enumerations representing the status of function calls.
+ */
+typedef enum
+{
+    CVMX_USB_SUCCESS = 0,           /**< There were no errors */
+    CVMX_USB_INVALID_PARAM = -1,    /**< A parameter to the function was invalid */
+    CVMX_USB_NO_MEMORY = -2,        /**< Insufficient resources were available for the request */
+    CVMX_USB_BUSY = -3,             /**< The resource is busy and cannot service the request */
+    CVMX_USB_TIMEOUT = -4,          /**< Waiting for an action timed out */
+    CVMX_USB_INCORRECT_MODE = -5,   /**< The function call doesn't work in the current USB
+                                         mode. This happens when host only functions are
+                                         called in device mode or vice versa */
+} cvmx_usb_status_t;
+
+/**
+ * Enumerations representing the possible USB device speeds
+ */
+typedef enum
+{
+    CVMX_USB_SPEED_HIGH = 0,        /**< Device is operation at 480Mbps */
+    CVMX_USB_SPEED_FULL = 1,        /**< Device is operation at 12Mbps */
+    CVMX_USB_SPEED_LOW = 2,         /**< Device is operation at 1.5Mbps */
+} cvmx_usb_speed_t;
+
+/**
+ * Enumeration representing the possible USB transfer types.
+ */
+typedef enum
+{
+    CVMX_USB_TRANSFER_CONTROL = 0,      /**< USB transfer type control for hub and status transfers */
+    CVMX_USB_TRANSFER_ISOCHRONOUS = 1,  /**< USB transfer type isochronous for low priority periodic transfers */
+    CVMX_USB_TRANSFER_BULK = 2,         /**< USB transfer type bulk for large low priority transfers */
+    CVMX_USB_TRANSFER_INTERRUPT = 3,    /**< USB transfer type interrupt for high priority periodic transfers */
+} cvmx_usb_transfer_t;
+
+/**
+ * Enumeration of the transfer directions
+ */
+typedef enum
+{
+    CVMX_USB_DIRECTION_OUT,         /**< Data is transferring from Octeon to the device/host */
+    CVMX_USB_DIRECTION_IN,          /**< Data is transferring from the device/host to Octeon */
+} cvmx_usb_direction_t;
+
+/**
+ * Enumeration of all possible status codes passed to callback
+ * functions.
+ */
+typedef enum
+{
+    CVMX_USB_COMPLETE_SUCCESS,      /**< The transaction / operation finished without any errors */
+    CVMX_USB_COMPLETE_SHORT,        /**< FIXME: This is currently not implemented */
+    CVMX_USB_COMPLETE_CANCEL,       /**< The transaction was canceled while in flight by a user call to cvmx_usb_cancel* */
+    CVMX_USB_COMPLETE_ERROR,        /**< The transaction aborted with an unexpected error status */
+    CVMX_USB_COMPLETE_STALL,        /**< The transaction received a USB STALL response from the device */
+    CVMX_USB_COMPLETE_XACTERR,      /**< The transaction failed with an error from the device even after a number of retries */
+    CVMX_USB_COMPLETE_DATATGLERR,   /**< The transaction failed with a data toggle error even after a number of retries */
+    CVMX_USB_COMPLETE_BABBLEERR,    /**< The transaction failed with a babble error */
+    CVMX_USB_COMPLETE_FRAMEERR,     /**< The transaction failed with a frame error even after a number of retries */
+} cvmx_usb_complete_t;
+
+/**
+ * Structure returned containing the USB port status information.
+ */
+typedef struct
+{
+    uint32_t reserved           : 25;
+    uint32_t port_enabled       : 1; /**< 1 = Usb port is enabled, 0 = disabled */
+    uint32_t port_over_current  : 1; /**< 1 = Over current detected, 0 = Over current not detected. Octeon doesn't support over current detection */
+    uint32_t port_powered       : 1; /**< 1 = Port power is being supplied to the device, 0 = power is off. Octeon doesn't support turning port power off */
+    cvmx_usb_speed_t port_speed : 2; /**< Current port speed */
+    uint32_t connected          : 1; /**< 1 = A device is connected to the port, 0 = No device is connected */
+    uint32_t connect_change     : 1; /**< 1 = Device connected state changed since the last set status call */
+} cvmx_usb_port_status_t;
+
+/**
+ * This is the structure of a Control packet header
+ */
+typedef union
+{
+    uint64_t u64;
+    struct
+    {
+        uint64_t request_type   : 8;  /**< Bit 7 tells the direction: 1=IN, 0=OUT */
+        uint64_t request        : 8;  /**< The standard usb request to make */
+        uint64_t value          : 16; /**< Value parameter for the request in little endian format */
+        uint64_t index          : 16; /**< Index for the request in little endian format */
+        uint64_t length         : 16; /**< Length of the data associated with this request in little endian format */
+    } s;
+} cvmx_usb_control_header_t;
+
+/**
+ * Descriptor for Isochronous packets
+ */
+typedef struct
+{
+    int offset;                     /**< This is the offset in bytes into the main buffer where this data is stored */
+    int length;                     /**< This is the length in bytes of the data */
+    cvmx_usb_complete_t status;     /**< This is the status of this individual packet transfer */
+} cvmx_usb_iso_packet_t;
+
+/**
+ * Possible callback reasons for the USB API.
+ */
+typedef enum
+{
+    CVMX_USB_CALLBACK_TRANSFER_COMPLETE,
+                                    /**< A callback of this type is called when a submitted transfer
+                                        completes. The completion callback will be called even if the
+                                        transfer fails or is canceled. The status parameter will
+                                        contain details of why he callback was called. */
+    CVMX_USB_CALLBACK_PORT_CHANGED, /**< The status of the port changed. For example, someone may have
+                                        plugged a device in. The status parameter contains
+                                        CVMX_USB_COMPLETE_SUCCESS. Use cvmx_usb_get_status() to get
+                                        the new port status. */
+    __CVMX_USB_CALLBACK_END         /**< Do not use. Used internally for array bounds */
+} cvmx_usb_callback_t;
+
+/**
+ * USB state internal data. The contents of this structure
+ * may change in future SDKs. No data in it should be referenced
+ * by user's of this API.
+ */
+typedef struct
+{
+    char data[65536];
+} cvmx_usb_state_t;
+
+/**
+ * USB callback functions are always of the following type.
+ * The parameters are as follows:
+ *      - state = USB device state populated by
+ *        cvmx_usb_initialize().
+ *      - reason = The cvmx_usb_callback_t used to register
+ *        the callback.
+ *      - status = The cvmx_usb_complete_t representing the
+ *        status code of a transaction.
+ *      - pipe_handle = The Pipe that caused this callback, or
+ *        -1 if this callback wasn't associated with a pipe.
+ *      - submit_handle = Transfer submit handle causing this
+ *        callback, or -1 if this callback wasn't associated
+ *        with a transfer.
+ *      - Actual number of bytes transfer.
+ *      - user_data = The user pointer supplied to the
+ *        function cvmx_usb_submit() or
+ *        cvmx_usb_register_callback() */
+typedef void (*cvmx_usb_callback_func_t)(cvmx_usb_state_t *state,
+                                         cvmx_usb_callback_t reason,
+                                         cvmx_usb_complete_t status,
+                                         int pipe_handle, int submit_handle,
+                                         int bytes_transferred, void *user_data);
+
+/**
+ * Flags to pass the initialization function.
+ */
+typedef enum
+{
+    CVMX_USB_INITIALIZE_FLAGS_CLOCK_XO_XI = 1<<0,       /**< The USB port uses a 12MHz crystal as clock source
+                                                            at USB_XO and USB_XI. */
+    CVMX_USB_INITIALIZE_FLAGS_CLOCK_XO_GND = 1<<1,      /**< The USB port uses 12/24/48MHz 2.5V board clock
+                                                            source at USB_XO. USB_XI should be tied to GND.*/
+    CVMX_USB_INITIALIZE_FLAGS_CLOCK_AUTO = 0,           /**< Automatically determine clock type based on function
+                                                             in cvmx-helper-board.c. */
+    CVMX_USB_INITIALIZE_FLAGS_CLOCK_MHZ_MASK  = 3<<3,       /**< Mask for clock speed field */
+    CVMX_USB_INITIALIZE_FLAGS_CLOCK_12MHZ = 1<<3,       /**< Speed of reference clock or crystal */
+    CVMX_USB_INITIALIZE_FLAGS_CLOCK_24MHZ = 2<<3,       /**< Speed of reference clock */
+    CVMX_USB_INITIALIZE_FLAGS_CLOCK_48MHZ = 3<<3,       /**< Speed of reference clock */
+    /* Bits 3-4 used to encode the clock frequency */
+    CVMX_USB_INITIALIZE_FLAGS_NO_DMA = 1<<5,            /**< Disable DMA and used polled IO for data transfer use for the USB  */
+    CVMX_USB_INITIALIZE_FLAGS_DEBUG_TRANSFERS = 1<<16,  /**< Enable extra console output for debugging USB transfers */
+    CVMX_USB_INITIALIZE_FLAGS_DEBUG_CALLBACKS = 1<<17,  /**< Enable extra console output for debugging USB callbacks */
+    CVMX_USB_INITIALIZE_FLAGS_DEBUG_INFO = 1<<18,       /**< Enable extra console output for USB informational data */
+    CVMX_USB_INITIALIZE_FLAGS_DEBUG_CALLS = 1<<19,      /**< Enable extra console output for every function call */
+    CVMX_USB_INITIALIZE_FLAGS_DEBUG_CSRS = 1<<20,       /**< Enable extra console output for every CSR access */
+    CVMX_USB_INITIALIZE_FLAGS_DEBUG_ALL = ((CVMX_USB_INITIALIZE_FLAGS_DEBUG_CSRS<<1)-1) - (CVMX_USB_INITIALIZE_FLAGS_DEBUG_TRANSFERS-1),
+} cvmx_usb_initialize_flags_t;
+
+/**
+ * Flags for passing when a pipe is created. Currently no flags
+ * need to be passed.
+ */
+typedef enum
+{
+    CVMX_USB_PIPE_FLAGS_DEBUG_TRANSFERS = 1<<15,/**< Used to display CVMX_USB_INITIALIZE_FLAGS_DEBUG_TRANSFERS for a specific pipe only */
+    __CVMX_USB_PIPE_FLAGS_OPEN = 1<<16,         /**< Used internally to determine if a pipe is open. Do not use */
+    __CVMX_USB_PIPE_FLAGS_SCHEDULED = 1<<17,    /**< Used internally to determine if a pipe is actively using hardware. Do not use */
+    __CVMX_USB_PIPE_FLAGS_NEED_PING = 1<<18,    /**< Used internally to determine if a high speed pipe is in the ping state. Do not use */
+} cvmx_usb_pipe_flags_t;
+
+/**
+ * Return the number of USB ports supported by this Octeon
+ * chip. If the chip doesn't support USB, or is not supported
+ * by this API, a zero will be returned. Most Octeon chips
+ * support one usb port, but some support two ports.
+ * cvmx_usb_initialize() must be called on independent
+ * cvmx_usb_state_t structures.
+ *
+ * @return Number of port, zero if usb isn't supported
+ */
+extern int cvmx_usb_get_num_ports(void);
+
+/**
+ * Initialize a USB port for use. This must be called before any
+ * other access to the Octeon USB port is made. The port starts
+ * off in the disabled state.
+ *
+ * @param state  Pointer to an empty cvmx_usb_state_t structure
+ *               that will be populated by the initialize call.
+ *               This structure is then passed to all other USB
+ *               functions.
+ * @param usb_port_number
+ *               Which Octeon USB port to initialize.
+ * @param flags  Flags to control hardware initialization. See
+ *               cvmx_usb_initialize_flags_t for the flag
+ *               definitions. Some flags are mandatory.
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+extern cvmx_usb_status_t cvmx_usb_initialize(cvmx_usb_state_t *state,
+                                             int usb_port_number,
+                                             cvmx_usb_initialize_flags_t flags);
+
+/**
+ * Shutdown a USB port after a call to cvmx_usb_initialize().
+ * The port should be disabled with all pipes closed when this
+ * function is called.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+extern cvmx_usb_status_t cvmx_usb_shutdown(cvmx_usb_state_t *state);
+
+/**
+ * Enable a USB port. After this call succeeds, the USB port is
+ * online and servicing requests.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+extern cvmx_usb_status_t cvmx_usb_enable(cvmx_usb_state_t *state);
+
+/**
+ * Disable a USB port. After this call the USB port will not
+ * generate data transfers and will not generate events.
+ * Transactions in process will fail and call their
+ * associated callbacks.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+extern cvmx_usb_status_t cvmx_usb_disable(cvmx_usb_state_t *state);
+
+/**
+ * Get the current state of the USB port. Use this call to
+ * determine if the usb port has anything connected, is enabled,
+ * or has some sort of error condition. The return value of this
+ * call has "changed" bits to signal of the value of some fields
+ * have changed between calls. These "changed" fields are based
+ * on the last call to cvmx_usb_set_status(). In order to clear
+ * them, you must update the status through cvmx_usb_set_status().
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return Port status information
+ */
+extern cvmx_usb_port_status_t cvmx_usb_get_status(cvmx_usb_state_t *state);
+
+/**
+ * Set the current state of the USB port. The status is used as
+ * a reference for the "changed" bits returned by
+ * cvmx_usb_get_status(). Other than serving as a reference, the
+ * status passed to this function is not used. No fields can be
+ * changed through this call.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param port_status
+ *               Port status to set, most like returned by cvmx_usb_get_status()
+ */
+extern void cvmx_usb_set_status(cvmx_usb_state_t *state, cvmx_usb_port_status_t port_status);
+
+/**
+ * Open a virtual pipe between the host and a USB device. A pipe
+ * must be opened before data can be transferred between a device
+ * and Octeon.
+ *
+ * @param state      USB device state populated by
+ *                   cvmx_usb_initialize().
+ * @param flags      Optional pipe flags defined in
+ *                   cvmx_usb_pipe_flags_t.
+ * @param device_addr
+ *                   USB device address to open the pipe to
+ *                   (0-127).
+ * @param endpoint_num
+ *                   USB endpoint number to open the pipe to
+ *                   (0-15).
+ * @param device_speed
+ *                   The speed of the device the pipe is going
+ *                   to. This must match the device's speed,
+ *                   which may be different than the port speed.
+ * @param max_packet The maximum packet length the device can
+ *                   transmit/receive (low speed=0-8, full
+ *                   speed=0-1023, high speed=0-1024). This value
+ *                   comes from the standard endpoint descriptor
+ *                   field wMaxPacketSize bits <10:0>.
+ * @param transfer_type
+ *                   The type of transfer this pipe is for.
+ * @param transfer_dir
+ *                   The direction the pipe is in. This is not
+ *                   used for control pipes.
+ * @param interval   For ISOCHRONOUS and INTERRUPT transfers,
+ *                   this is how often the transfer is scheduled
+ *                   for. All other transfers should specify
+ *                   zero. The units are in frames (8000/sec at
+ *                   high speed, 1000/sec for full speed).
+ * @param multi_count
+ *                   For high speed devices, this is the maximum
+ *                   allowed number of packet per microframe.
+ *                   Specify zero for non high speed devices. This
+ *                   value comes from the standard endpoint descriptor
+ *                   field wMaxPacketSize bits <12:11>.
+ * @param hub_device_addr
+ *                   Hub device address this device is connected
+ *                   to. Devices connected directly to Octeon
+ *                   use zero. This is only used when the device
+ *                   is full/low speed behind a high speed hub.
+ *                   The address will be of the high speed hub,
+ *                   not and full speed hubs after it.
+ * @param hub_port   Which port on the hub the device is
+ *                   connected. Use zero for devices connected
+ *                   directly to Octeon. Like hub_device_addr,
+ *                   this is only used for full/low speed
+ *                   devices behind a high speed hub.
+ *
+ * @return A non negative value is a pipe handle. Negative
+ *         values are failure codes from cvmx_usb_status_t.
+ */
+extern int cvmx_usb_open_pipe(cvmx_usb_state_t *state,
+                              cvmx_usb_pipe_flags_t flags,
+                              int device_addr, int endpoint_num,
+                              cvmx_usb_speed_t device_speed, int max_packet,
+                              cvmx_usb_transfer_t transfer_type,
+                              cvmx_usb_direction_t transfer_dir, int interval,
+                              int multi_count, int hub_device_addr,
+                              int hub_port);
+
+/**
+ * Call to submit a USB Bulk transfer to a pipe.
+ *
+ * @param state     USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param pipe_handle
+ *                  Handle to the pipe for the transfer.
+ * @param buffer    Physical address of the data buffer in
+ *                  memory. Note that this is NOT A POINTER, but
+ *                  the full 64bit physical address of the
+ *                  buffer. This may be zero if buffer_length is
+ *                  zero.
+ * @param buffer_length
+ *                  Length of buffer in bytes.
+ * @param callback  Function to call when this transaction
+ *                  completes. If the return value of this
+ *                  function isn't an error, then this function
+ *                  is guaranteed to be called when the
+ *                  transaction completes. If this parameter is
+ *                  NULL, then the generic callback registered
+ *                  through cvmx_usb_register_callback is
+ *                  called. If both are NULL, then there is no
+ *                  way to know when a transaction completes.
+ * @param user_data User supplied data returned when the
+ *                  callback is called. This is only used if
+ *                  callback in not NULL.
+ *
+ * @return A submitted transaction handle or negative on
+ *         failure. Negative values are failure codes from
+ *         cvmx_usb_status_t.
+ */
+extern int cvmx_usb_submit_bulk(cvmx_usb_state_t *state, int pipe_handle,
+                                uint64_t buffer, int buffer_length,
+                                cvmx_usb_callback_func_t callback,
+                                void *user_data);
+
+/**
+ * Call to submit a USB Interrupt transfer to a pipe.
+ *
+ * @param state     USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param pipe_handle
+ *                  Handle to the pipe for the transfer.
+ * @param buffer    Physical address of the data buffer in
+ *                  memory. Note that this is NOT A POINTER, but
+ *                  the full 64bit physical address of the
+ *                  buffer. This may be zero if buffer_length is
+ *                  zero.
+ * @param buffer_length
+ *                  Length of buffer in bytes.
+ * @param callback  Function to call when this transaction
+ *                  completes. If the return value of this
+ *                  function isn't an error, then this function
+ *                  is guaranteed to be called when the
+ *                  transaction completes. If this parameter is
+ *                  NULL, then the generic callback registered
+ *                  through cvmx_usb_register_callback is
+ *                  called. If both are NULL, then there is no
+ *                  way to know when a transaction completes.
+ * @param user_data User supplied data returned when the
+ *                  callback is called. This is only used if
+ *                  callback in not NULL.
+ *
+ * @return A submitted transaction handle or negative on
+ *         failure. Negative values are failure codes from
+ *         cvmx_usb_status_t.
+ */
+extern int cvmx_usb_submit_interrupt(cvmx_usb_state_t *state, int pipe_handle,
+                                     uint64_t buffer, int buffer_length,
+                                     cvmx_usb_callback_func_t callback,
+                                     void *user_data);
+
+/**
+ * Call to submit a USB Control transfer to a pipe.
+ *
+ * @param state     USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param pipe_handle
+ *                  Handle to the pipe for the transfer.
+ * @param control_header
+ *                  USB 8 byte control header physical address.
+ *                  Note that this is NOT A POINTER, but the
+ *                  full 64bit physical address of the buffer.
+ * @param buffer    Physical address of the data buffer in
+ *                  memory. Note that this is NOT A POINTER, but
+ *                  the full 64bit physical address of the
+ *                  buffer. This may be zero if buffer_length is
+ *                  zero.
+ * @param buffer_length
+ *                  Length of buffer in bytes.
+ * @param callback  Function to call when this transaction
+ *                  completes. If the return value of this
+ *                  function isn't an error, then this function
+ *                  is guaranteed to be called when the
+ *                  transaction completes. If this parameter is
+ *                  NULL, then the generic callback registered
+ *                  through cvmx_usb_register_callback is
+ *                  called. If both are NULL, then there is no
+ *                  way to know when a transaction completes.
+ * @param user_data User supplied data returned when the
+ *                  callback is called. This is only used if
+ *                  callback in not NULL.
+ *
+ * @return A submitted transaction handle or negative on
+ *         failure. Negative values are failure codes from
+ *         cvmx_usb_status_t.
+ */
+extern int cvmx_usb_submit_control(cvmx_usb_state_t *state, int pipe_handle,
+                                   uint64_t control_header,
+                                   uint64_t buffer, int buffer_length,
+                                   cvmx_usb_callback_func_t callback,
+                                   void *user_data);
+
+/**
+ * Flags to pass the cvmx_usb_submit_isochronous() function.
+ */
+typedef enum
+{
+    CVMX_USB_ISOCHRONOUS_FLAGS_ALLOW_SHORT = 1<<0,  /**< Do not return an error if a transfer is less than the maximum packet size of the device */
+    CVMX_USB_ISOCHRONOUS_FLAGS_ASAP = 1<<1,         /**< Schedule the transaction as soon as possible */
+} cvmx_usb_isochronous_flags_t;
+
+/**
+ * Call to submit a USB Isochronous transfer to a pipe.
+ *
+ * @param state     USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param pipe_handle
+ *                  Handle to the pipe for the transfer.
+ * @param start_frame
+ *                  Number of frames into the future to schedule
+ *                  this transaction.
+ * @param flags     Flags to control the transfer. See
+ *                  cvmx_usb_isochronous_flags_t for the flag
+ *                  definitions.
+ * @param number_packets
+ *                  Number of sequential packets to transfer.
+ *                  "packets" is a pointer to an array of this
+ *                  many packet structures.
+ * @param packets   Description of each transfer packet as
+ *                  defined by cvmx_usb_iso_packet_t. The array
+ *                  pointed to here must stay valid until the
+ *                  complete callback is called.
+ * @param buffer    Physical address of the data buffer in
+ *                  memory. Note that this is NOT A POINTER, but
+ *                  the full 64bit physical address of the
+ *                  buffer. This may be zero if buffer_length is
+ *                  zero.
+ * @param buffer_length
+ *                  Length of buffer in bytes.
+ * @param callback  Function to call when this transaction
+ *                  completes. If the return value of this
+ *                  function isn't an error, then this function
+ *                  is guaranteed to be called when the
+ *                  transaction completes. If this parameter is
+ *                  NULL, then the generic callback registered
+ *                  through cvmx_usb_register_callback is
+ *                  called. If both are NULL, then there is no
+ *                  way to know when a transaction completes.
+ * @param user_data User supplied data returned when the
+ *                  callback is called. This is only used if
+ *                  callback in not NULL.
+ *
+ * @return A submitted transaction handle or negative on
+ *         failure. Negative values are failure codes from
+ *         cvmx_usb_status_t.
+ */
+extern int cvmx_usb_submit_isochronous(cvmx_usb_state_t *state, int pipe_handle,
+                                       int start_frame, int flags,
+                                       int number_packets,
+                                       cvmx_usb_iso_packet_t packets[],
+                                       uint64_t buffer, int buffer_length,
+                                       cvmx_usb_callback_func_t callback,
+                                       void *user_data);
+
+/**
+ * Cancel one outstanding request in a pipe. Canceling a request
+ * can fail if the transaction has already completed before cancel
+ * is called. Even after a successful cancel call, it may take
+ * a frame or two for the cvmx_usb_poll() function to call the
+ * associated callback.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param pipe_handle
+ *               Pipe handle to cancel requests in.
+ * @param submit_handle
+ *               Handle to transaction to cancel, returned by the submit function.
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+extern cvmx_usb_status_t cvmx_usb_cancel(cvmx_usb_state_t *state,
+                                         int pipe_handle, int submit_handle);
+
+
+/**
+ * Cancel all outstanding requests in a pipe. Logically all this
+ * does is call cvmx_usb_cancel() in a loop.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param pipe_handle
+ *               Pipe handle to cancel requests in.
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+extern cvmx_usb_status_t cvmx_usb_cancel_all(cvmx_usb_state_t *state,
+                                             int pipe_handle);
+
+/**
+ * Close a pipe created with cvmx_usb_open_pipe().
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ * @param pipe_handle
+ *               Pipe handle to close.
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t. CVMX_USB_BUSY is returned if the
+ *         pipe has outstanding transfers.
+ */
+extern cvmx_usb_status_t cvmx_usb_close_pipe(cvmx_usb_state_t *state,
+                                             int pipe_handle);
+
+/**
+ * Register a function to be called when various USB events occur.
+ *
+ * @param state     USB device state populated by
+ *                  cvmx_usb_initialize().
+ * @param reason    Which event to register for.
+ * @param callback  Function to call when the event occurs.
+ * @param user_data User data parameter to the function.
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+extern cvmx_usb_status_t cvmx_usb_register_callback(cvmx_usb_state_t *state,
+                                                    cvmx_usb_callback_t reason,
+                                                    cvmx_usb_callback_func_t callback,
+                                                    void *user_data);
+
+/**
+ * Get the current USB protocol level frame number. The frame
+ * number is always in the range of 0-0x7ff.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return USB frame number
+ */
+extern int cvmx_usb_get_frame_number(cvmx_usb_state_t *state);
+
+/**
+ * Poll the USB block for status and call all needed callback
+ * handlers. This function is meant to be called in the interrupt
+ * handler for the USB controller. It can also be called
+ * periodically in a loop for non-interrupt based operation.
+ *
+ * @param state  USB device state populated by
+ *               cvmx_usb_initialize().
+ *
+ * @return CVMX_USB_SUCCESS or a negative error code defined in
+ *         cvmx_usb_status_t.
+ */
+extern cvmx_usb_status_t cvmx_usb_poll(cvmx_usb_state_t *state);
+
+#ifdef	__cplusplus
+}
+#endif
+
+#endif  /* __CVMX_USB_H__ */
diff --git a/drivers/staging/octeon-usb/cvmx-usbcx-defs.h b/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
new file mode 100644
index 0000000..e3ae545
--- /dev/null
+++ b/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
@@ -0,0 +1,3086 @@
+/***********************license start***************
+ * Copyright (c) 2003-2010  Cavium Networks (support@cavium.com). All rights
+ * reserved.
+ *
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *
+ *   * Redistributions in binary form must reproduce the above
+ *     copyright notice, this list of conditions and the following
+ *     disclaimer in the documentation and/or other materials provided
+ *     with the distribution.
+
+ *   * Neither the name of Cavium Networks nor the names of
+ *     its contributors may be used to endorse or promote products
+ *     derived from this software without specific prior written
+ *     permission.
+
+ * This Software, including technical data, may be subject to U.S. export  control
+ * laws, including the U.S. Export Administration Act and its  associated
+ * regulations, and may be subject to export or import  regulations in other
+ * countries.
+
+ * TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
+ * AND WITH ALL FAULTS AND CAVIUM  NETWORKS MAKES NO PROMISES, REPRESENTATIONS OR
+ * WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT TO
+ * THE SOFTWARE, INCLUDING ITS CONDITION, ITS CONFORMITY TO ANY REPRESENTATION OR
+ * DESCRIPTION, OR THE EXISTENCE OF ANY LATENT OR PATENT DEFECTS, AND CAVIUM
+ * SPECIFICALLY DISCLAIMS ALL IMPLIED (IF ANY) WARRANTIES OF TITLE,
+ * MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, LACK OF
+ * VIRUSES, ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION OR
+ * CORRESPONDENCE TO DESCRIPTION. THE ENTIRE  RISK ARISING OUT OF USE OR
+ * PERFORMANCE OF THE SOFTWARE LIES WITH YOU.
+ ***********************license end**************************************/
+
+
+/**
+ * cvmx-usbcx-defs.h
+ *
+ * Configuration and status register (CSR) type definitions for
+ * Octeon usbcx.
+ *
+ * This file is auto generated. Do not edit.
+ *
+ * <hr>$Revision$<hr>
+ *
+ */
+#ifndef __CVMX_USBCX_TYPEDEFS_H__
+#define __CVMX_USBCX_TYPEDEFS_H__
+
+#define CVMX_USBCX_DAINT(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000818ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DAINTMSK(block_id) (CVMX_ADD_IO_SEG(0x00016F001000081Cull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DCFG(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000800ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DCTL(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000804ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DIEPCTLX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000900ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DIEPINTX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000908ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DIEPMSK(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000810ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DIEPTSIZX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000910ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DOEPCTLX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000B00ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DOEPINTX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000B08ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DOEPMSK(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000814ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DOEPTSIZX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000B10ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DPTXFSIZX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000100ull) + (((offset) & 7) + ((block_id) & 1) * 0x40000000000ull) * 4)
+#define CVMX_USBCX_DSTS(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000808ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DTKNQR1(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000820ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DTKNQR2(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000824ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DTKNQR3(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000830ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DTKNQR4(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000834ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GAHBCFG(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000008ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GHWCFG1(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000044ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GHWCFG2(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000048ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GHWCFG3(block_id) (CVMX_ADD_IO_SEG(0x00016F001000004Cull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GHWCFG4(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000050ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GINTMSK(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000018ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GINTSTS(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000014ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GNPTXFSIZ(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000028ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GNPTXSTS(block_id) (CVMX_ADD_IO_SEG(0x00016F001000002Cull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GOTGCTL(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000000ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GOTGINT(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000004ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRSTCTL(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000010ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRXFSIZ(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000024ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRXSTSPD(block_id) (CVMX_ADD_IO_SEG(0x00016F0010040020ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRXSTSPH(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000020ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRXSTSRD(block_id) (CVMX_ADD_IO_SEG(0x00016F001004001Cull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRXSTSRH(block_id) (CVMX_ADD_IO_SEG(0x00016F001000001Cull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GSNPSID(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000040ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GUSBCFG(block_id) (CVMX_ADD_IO_SEG(0x00016F001000000Cull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HAINT(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000414ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HAINTMSK(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000418ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HCCHARX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000500ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_HCFG(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000400ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HCINTMSKX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F001000050Cull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_HCINTX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000508ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_HCSPLTX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000504ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_HCTSIZX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000510ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_HFIR(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000404ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HFNUM(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000408ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HPRT(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000440ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HPTXFSIZ(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000100ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HPTXSTS(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000410ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_NPTXDFIFOX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010001000ull) + (((offset) & 7) + ((block_id) & 1) * 0x100000000ull) * 4096)
+#define CVMX_USBCX_PCGCCTL(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000E00ull) + ((block_id) & 1) * 0x100000000000ull)
+
+/**
+ * cvmx_usbc#_daint
+ *
+ * Device All Endpoints Interrupt Register (DAINT)
+ *
+ * When a significant event occurs on an endpoint, a Device All Endpoints Interrupt register
+ * interrupts the application using the Device OUT Endpoints Interrupt bit or Device IN Endpoints
+ * Interrupt bit of the Core Interrupt register (GINTSTS.OEPInt or GINTSTS.IEPInt, respectively).
+ * There is one interrupt bit per endpoint, up to a maximum of 16 bits for OUT endpoints and 16
+ * bits for IN endpoints. For a bidirectional endpoint, the corresponding IN and OUT interrupt
+ * bits are used. Bits in this register are set and cleared when the application sets and clears
+ * bits in the corresponding Device Endpoint-n Interrupt register (DIEPINTn/DOEPINTn).
+ */
+union cvmx_usbcx_daint
+{
+	uint32_t u32;
+	struct cvmx_usbcx_daint_s
+	{
+	uint32_t outepint                     : 16; /**< OUT Endpoint Interrupt Bits (OutEPInt)
+                                                         One bit per OUT endpoint:
+                                                         Bit 16 for OUT endpoint 0, bit 31 for OUT endpoint 15 */
+	uint32_t inepint                      : 16; /**< IN Endpoint Interrupt Bits (InEpInt)
+                                                         One bit per IN Endpoint:
+                                                         Bit 0 for IN endpoint 0, bit 15 for endpoint 15 */
+	} s;
+	struct cvmx_usbcx_daint_s             cn30xx;
+	struct cvmx_usbcx_daint_s             cn31xx;
+	struct cvmx_usbcx_daint_s             cn50xx;
+	struct cvmx_usbcx_daint_s             cn52xx;
+	struct cvmx_usbcx_daint_s             cn52xxp1;
+	struct cvmx_usbcx_daint_s             cn56xx;
+	struct cvmx_usbcx_daint_s             cn56xxp1;
+};
+typedef union cvmx_usbcx_daint cvmx_usbcx_daint_t;
+
+/**
+ * cvmx_usbc#_daintmsk
+ *
+ * Device All Endpoints Interrupt Mask Register (DAINTMSK)
+ *
+ * The Device Endpoint Interrupt Mask register works with the Device Endpoint Interrupt register
+ * to interrupt the application when an event occurs on a device endpoint. However, the Device
+ * All Endpoints Interrupt (DAINT) register bit corresponding to that interrupt will still be set.
+ * Mask Interrupt: 1'b0 Unmask Interrupt: 1'b1
+ */
+union cvmx_usbcx_daintmsk
+{
+	uint32_t u32;
+	struct cvmx_usbcx_daintmsk_s
+	{
+	uint32_t outepmsk                     : 16; /**< OUT EP Interrupt Mask Bits (OutEpMsk)
+                                                         One per OUT Endpoint:
+                                                         Bit 16 for OUT EP 0, bit 31 for OUT EP 15 */
+	uint32_t inepmsk                      : 16; /**< IN EP Interrupt Mask Bits (InEpMsk)
+                                                         One bit per IN Endpoint:
+                                                         Bit 0 for IN EP 0, bit 15 for IN EP 15 */
+	} s;
+	struct cvmx_usbcx_daintmsk_s          cn30xx;
+	struct cvmx_usbcx_daintmsk_s          cn31xx;
+	struct cvmx_usbcx_daintmsk_s          cn50xx;
+	struct cvmx_usbcx_daintmsk_s          cn52xx;
+	struct cvmx_usbcx_daintmsk_s          cn52xxp1;
+	struct cvmx_usbcx_daintmsk_s          cn56xx;
+	struct cvmx_usbcx_daintmsk_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_daintmsk cvmx_usbcx_daintmsk_t;
+
+/**
+ * cvmx_usbc#_dcfg
+ *
+ * Device Configuration Register (DCFG)
+ *
+ * This register configures the core in Device mode after power-on or after certain control
+ * commands or enumeration. Do not make changes to this register after initial programming.
+ */
+union cvmx_usbcx_dcfg
+{
+	uint32_t u32;
+	struct cvmx_usbcx_dcfg_s
+	{
+	uint32_t reserved_23_31               : 9;
+	uint32_t epmiscnt                     : 5;  /**< IN Endpoint Mismatch Count (EPMisCnt)
+                                                         The application programs this filed with a count that determines
+                                                         when the core generates an Endpoint Mismatch interrupt
+                                                         (GINTSTS.EPMis). The core loads this value into an internal
+                                                         counter and decrements it. The counter is reloaded whenever
+                                                         there is a match or when the counter expires. The width of this
+                                                         counter depends on the depth of the Token Queue. */
+	uint32_t reserved_13_17               : 5;
+	uint32_t perfrint                     : 2;  /**< Periodic Frame Interval (PerFrInt)
+                                                         Indicates the time within a (micro)frame at which the application
+                                                         must be notified using the End Of Periodic Frame Interrupt. This
+                                                         can be used to determine if all the isochronous traffic for that
+                                                         (micro)frame is complete.
+                                                         * 2'b00: 80% of the (micro)frame interval
+                                                         * 2'b01: 85%
+                                                         * 2'b10: 90%
+                                                         * 2'b11: 95% */
+	uint32_t devaddr                      : 7;  /**< Device Address (DevAddr)
+                                                         The application must program this field after every SetAddress
+                                                         control command. */
+	uint32_t reserved_3_3                 : 1;
+	uint32_t nzstsouthshk                 : 1;  /**< Non-Zero-Length Status OUT Handshake (NZStsOUTHShk)
+                                                         The application can use this field to select the handshake the
+                                                         core sends on receiving a nonzero-length data packet during
+                                                         the OUT transaction of a control transfer's Status stage.
+                                                         * 1'b1: Send a STALL handshake on a nonzero-length status
+                                                                 OUT transaction and do not send the received OUT packet to
+                                                                 the application.
+                                                         * 1'b0: Send the received OUT packet to the application (zero-
+                                                                 length or nonzero-length) and send a handshake based on
+                                                                 the NAK and STALL bits for the endpoint in the Device
+                                                                 Endpoint Control register. */
+	uint32_t devspd                       : 2;  /**< Device Speed (DevSpd)
+                                                         Indicates the speed at which the application requires the core to
+                                                         enumerate, or the maximum speed the application can support.
+                                                         However, the actual bus speed is determined only after the
+                                                         chirp sequence is completed, and is based on the speed of the
+                                                         USB host to which the core is connected. See "Device
+                                                         Initialization" on page 249 for details.
+                                                         * 2'b00: High speed (USB 2.0 PHY clock is 30 MHz or 60 MHz)
+                                                         * 2'b01: Full speed (USB 2.0 PHY clock is 30 MHz or 60 MHz)
+                                                         * 2'b10: Low speed (USB 1.1 transceiver clock is 6 MHz). If
+                                                                  you select 6 MHz LS mode, you must do a soft reset.
+                                                         * 2'b11: Full speed (USB 1.1 transceiver clock is 48 MHz) */
+	} s;
+	struct cvmx_usbcx_dcfg_s              cn30xx;
+	struct cvmx_usbcx_dcfg_s              cn31xx;
+	struct cvmx_usbcx_dcfg_s              cn50xx;
+	struct cvmx_usbcx_dcfg_s              cn52xx;
+	struct cvmx_usbcx_dcfg_s              cn52xxp1;
+	struct cvmx_usbcx_dcfg_s              cn56xx;
+	struct cvmx_usbcx_dcfg_s              cn56xxp1;
+};
+typedef union cvmx_usbcx_dcfg cvmx_usbcx_dcfg_t;
+
+/**
+ * cvmx_usbc#_dctl
+ *
+ * Device Control Register (DCTL)
+ *
+ */
+union cvmx_usbcx_dctl
+{
+	uint32_t u32;
+	struct cvmx_usbcx_dctl_s
+	{
+	uint32_t reserved_12_31               : 20;
+	uint32_t pwronprgdone                 : 1;  /**< Power-On Programming Done (PWROnPrgDone)
+                                                         The application uses this bit to indicate that register
+                                                         programming is completed after a wake-up from Power Down
+                                                         mode. For more information, see "Device Mode Suspend and
+                                                         Resume With Partial Power-Down" on page 357. */
+	uint32_t cgoutnak                     : 1;  /**< Clear Global OUT NAK (CGOUTNak)
+                                                         A write to this field clears the Global OUT NAK. */
+	uint32_t sgoutnak                     : 1;  /**< Set Global OUT NAK (SGOUTNak)
+                                                         A write to this field sets the Global OUT NAK.
+                                                         The application uses this bit to send a NAK handshake on all
+                                                         OUT endpoints.
+                                                         The application should set the this bit only after making sure
+                                                         that the Global OUT NAK Effective bit in the Core Interrupt
+                                                         Register (GINTSTS.GOUTNakEff) is cleared. */
+	uint32_t cgnpinnak                    : 1;  /**< Clear Global Non-Periodic IN NAK (CGNPInNak)
+                                                         A write to this field clears the Global Non-Periodic IN NAK. */
+	uint32_t sgnpinnak                    : 1;  /**< Set Global Non-Periodic IN NAK (SGNPInNak)
+                                                         A write to this field sets the Global Non-Periodic IN NAK.The
+                                                         application uses this bit to send a NAK handshake on all non-
+                                                         periodic IN endpoints. The core can also set this bit when a
+                                                         timeout condition is detected on a non-periodic endpoint.
+                                                         The application should set this bit only after making sure that
+                                                         the Global IN NAK Effective bit in the Core Interrupt Register
+                                                         (GINTSTS.GINNakEff) is cleared. */
+	uint32_t tstctl                       : 3;  /**< Test Control (TstCtl)
+                                                         * 3'b000: Test mode disabled
+                                                         * 3'b001: Test_J mode
+                                                         * 3'b010: Test_K mode
+                                                         * 3'b011: Test_SE0_NAK mode
+                                                         * 3'b100: Test_Packet mode
+                                                         * 3'b101: Test_Force_Enable
+                                                         * Others: Reserved */
+	uint32_t goutnaksts                   : 1;  /**< Global OUT NAK Status (GOUTNakSts)
+                                                         * 1'b0: A handshake is sent based on the FIFO Status and the
+                                                                 NAK and STALL bit settings.
+                                                         * 1'b1: No data is written to the RxFIFO, irrespective of space
+                                                                 availability. Sends a NAK handshake on all packets, except
+                                                                 on SETUP transactions. All isochronous OUT packets are
+                                                                 dropped. */
+	uint32_t gnpinnaksts                  : 1;  /**< Global Non-Periodic IN NAK Status (GNPINNakSts)
+                                                         * 1'b0: A handshake is sent out based on the data availability
+                                                                 in the transmit FIFO.
+                                                         * 1'b1: A NAK handshake is sent out on all non-periodic IN
+                                                                 endpoints, irrespective of the data availability in the transmit
+                                                                 FIFO. */
+	uint32_t sftdiscon                    : 1;  /**< Soft Disconnect (SftDiscon)
+                                                         The application uses this bit to signal the O2P USB core to do a
+                                                         soft disconnect. As long as this bit is set, the host will not see
+                                                         that the device is connected, and the device will not receive
+                                                         signals on the USB. The core stays in the disconnected state
+                                                         until the application clears this bit.
+                                                         The minimum duration for which the core must keep this bit set
+                                                         is specified in Minimum Duration for Soft Disconnect  .
+                                                         * 1'b0: Normal operation. When this bit is cleared after a soft
+                                                         disconnect, the core drives the phy_opmode_o signal on the
+                                                         UTMI+ to 2'b00, which generates a device connect event to
+                                                         the USB host. When the device is reconnected, the USB host
+                                                         restarts device enumeration.
+                                                         * 1'b1: The core drives the phy_opmode_o signal on the
+                                                         UTMI+ to 2'b01, which generates a device disconnect event
+                                                         to the USB host. */
+	uint32_t rmtwkupsig                   : 1;  /**< Remote Wakeup Signaling (RmtWkUpSig)
+                                                         When the application sets this bit, the core initiates remote
+                                                         signaling to wake up the USB host.The application must set this
+                                                         bit to get the core out of Suspended state and must clear this bit
+                                                         after the core comes out of Suspended state. */
+	} s;
+	struct cvmx_usbcx_dctl_s              cn30xx;
+	struct cvmx_usbcx_dctl_s              cn31xx;
+	struct cvmx_usbcx_dctl_s              cn50xx;
+	struct cvmx_usbcx_dctl_s              cn52xx;
+	struct cvmx_usbcx_dctl_s              cn52xxp1;
+	struct cvmx_usbcx_dctl_s              cn56xx;
+	struct cvmx_usbcx_dctl_s              cn56xxp1;
+};
+typedef union cvmx_usbcx_dctl cvmx_usbcx_dctl_t;
+
+/**
+ * cvmx_usbc#_diepctl#
+ *
+ * Device IN Endpoint-n Control Register (DIEPCTLn)
+ *
+ * The application uses the register to control the behaviour of each logical endpoint other than endpoint 0.
+ */
+union cvmx_usbcx_diepctlx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_diepctlx_s
+	{
+	uint32_t epena                        : 1;  /**< Endpoint Enable (EPEna)
+                                                         Indicates that data is ready to be transmitted on the endpoint.
+                                                         The core clears this bit before setting any of the following
+                                                         interrupts on this endpoint:
+                                                         * Endpoint Disabled
+                                                         * Transfer Completed */
+	uint32_t epdis                        : 1;  /**< Endpoint Disable (EPDis)
+                                                         The application sets this bit to stop transmitting data on an
+                                                         endpoint, even before the transfer for that endpoint is complete.
+                                                         The application must wait for the Endpoint Disabled interrupt
+                                                         before treating the endpoint as disabled. The core clears this bit
+                                                         before setting the Endpoint Disabled Interrupt. The application
+                                                         should set this bit only if Endpoint Enable is already set for this
+                                                         endpoint. */
+	uint32_t setd1pid                     : 1;  /**< For Interrupt/BULK enpoints:
+                                                          Set DATA1 PID (SetD1PID)
+                                                          Writing to this field sets the Endpoint Data Pid (DPID) field in
+                                                          this register to DATA1.
+                                                         For Isochronous endpoints:
+                                                          Set Odd (micro)frame (SetOddFr)
+                                                          Writing to this field sets the Even/Odd (micro)frame (EO_FrNum)
+                                                          field to odd (micro)frame. */
+	uint32_t setd0pid                     : 1;  /**< For Interrupt/BULK enpoints:
+                                                          Writing to this field sets the Endpoint Data Pid (DPID) field in
+                                                          this register to DATA0.
+                                                         For Isochronous endpoints:
+                                                          Set Odd (micro)frame (SetEvenFr)
+                                                          Writing to this field sets the Even/Odd (micro)frame (EO_FrNum)
+                                                          field to even (micro)frame. */
+	uint32_t snak                         : 1;  /**< Set NAK (SNAK)
+                                                         A write to this bit sets the NAK bit for the endpoint.
+                                                         Using this bit, the application can control the transmission of
+                                                         NAK handshakes on an endpoint. The core can also set this bit
+                                                         for an endpoint after a SETUP packet is received on the
+                                                         endpoint. */
+	uint32_t cnak                         : 1;  /**< Clear NAK (CNAK)
+                                                         A write to this bit clears the NAK bit for the endpoint. */
+	uint32_t txfnum                       : 4;  /**< TxFIFO Number (TxFNum)
+                                                         Non-periodic endpoints must set this bit to zero.  Periodic
+                                                         endpoints must map this to the corresponding Periodic TxFIFO
+                                                         number.
+                                                         * 4'h0: Non-Periodic TxFIFO
+                                                         * Others: Specified Periodic TxFIFO number */
+	uint32_t stall                        : 1;  /**< STALL Handshake (Stall)
+                                                         For non-control, non-isochronous endpoints:
+                                                          The application sets this bit to stall all tokens from the USB host
+                                                          to this endpoint.  If a NAK bit, Global Non-Periodic IN NAK, or
+                                                          Global OUT NAK is set along with this bit, the STALL bit takes
+                                                          priority.  Only the application can clear this bit, never the core.
+                                                         For control endpoints:
+                                                          The application can only set this bit, and the core clears it, when
+                                                          a SETUP token i received for this endpoint.  If a NAK bit, Global
+                                                          Non-Periodic IN NAK, or Global OUT NAK is set along with this
+                                                          bit, the STALL bit takes priority.  Irrespective of this bit's setting,
+                                                          the core always responds to SETUP data packets with an ACK handshake. */
+	uint32_t reserved_20_20               : 1;
+	uint32_t eptype                       : 2;  /**< Endpoint Type (EPType)
+                                                         This is the transfer type supported by this logical endpoint.
+                                                         * 2'b00: Control
+                                                         * 2'b01: Isochronous
+                                                         * 2'b10: Bulk
+                                                         * 2'b11: Interrupt */
+	uint32_t naksts                       : 1;  /**< NAK Status (NAKSts)
+                                                         Indicates the following:
+                                                         * 1'b0: The core is transmitting non-NAK handshakes based
+                                                                 on the FIFO status
+                                                         * 1'b1: The core is transmitting NAK handshakes on this
+                                                                 endpoint.
+                                                         When either the application or the core sets this bit:
+                                                         * For non-isochronous IN endpoints: The core stops
+                                                           transmitting any data on an IN endpoint, even if data is
+                                                           available in the TxFIFO.
+                                                         * For isochronous IN endpoints: The core sends out a zero-
+                                                           length data packet, even if data is available in the TxFIFO.
+                                                         Irrespective of this bit's setting, the core always responds to
+                                                         SETUP data packets with an ACK handshake. */
+	uint32_t dpid                         : 1;  /**< For interrupt/bulk IN and OUT endpoints:
+                                                          Endpoint Data PID (DPID)
+                                                          Contains the PID of the packet to be received or transmitted on
+                                                          this endpoint.  The application should program the PID of the first
+                                                          packet to be received or transmitted on this endpoint, after the
+                                                          endpoint is activated.  Applications use the SetD1PID and
+                                                          SetD0PID fields of this register to program either DATA0 or
+                                                          DATA1 PID.
+                                                          * 1'b0: DATA0
+                                                          * 1'b1: DATA1
+                                                         For isochronous IN and OUT endpoints:
+                                                          Even/Odd (Micro)Frame (EO_FrNum)
+                                                          Indicates the (micro)frame number in which the core transmits/
+                                                          receives isochronous data for this endpoint.  The application
+                                                          should program the even/odd (micro) frame number in which it
+                                                          intends to transmit/receive isochronous data for this endpoint
+                                                          using the SetEvnFr and SetOddFr fields in this register.
+                                                          * 1'b0: Even (micro)frame
+                                                          * 1'b1: Odd (micro)frame */
+	uint32_t usbactep                     : 1;  /**< USB Active Endpoint (USBActEP)
+                                                         Indicates whether this endpoint is active in the current
+                                                         configuration and interface.  The core clears this bit for all
+                                                         endpoints (other than EP 0) after detecting a USB reset.  After
+                                                         receiving the SetConfiguration and SetInterface commands, the
+                                                         application must program endpoint registers accordingly and set
+                                                         this bit. */
+	uint32_t nextep                       : 4;  /**< Next Endpoint (NextEp)
+                                                         Applies to non-periodic IN endpoints only.
+                                                         Indicates the endpoint number to be fetched after the data for
+                                                         the current endpoint is fetched. The core can access this field,
+                                                         even when the Endpoint Enable (EPEna) bit is not set. This
+                                                         field is not valid in Slave mode. */
+	uint32_t mps                          : 11; /**< Maximum Packet Size (MPS)
+                                                         Applies to IN and OUT endpoints.
+                                                         The application must program this field with the maximum
+                                                         packet size for the current logical endpoint.  This value is in
+                                                         bytes. */
+	} s;
+	struct cvmx_usbcx_diepctlx_s          cn30xx;
+	struct cvmx_usbcx_diepctlx_s          cn31xx;
+	struct cvmx_usbcx_diepctlx_s          cn50xx;
+	struct cvmx_usbcx_diepctlx_s          cn52xx;
+	struct cvmx_usbcx_diepctlx_s          cn52xxp1;
+	struct cvmx_usbcx_diepctlx_s          cn56xx;
+	struct cvmx_usbcx_diepctlx_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_diepctlx cvmx_usbcx_diepctlx_t;
+
+/**
+ * cvmx_usbc#_diepint#
+ *
+ * Device Endpoint-n Interrupt Register (DIEPINTn)
+ *
+ * This register indicates the status of an endpoint with respect to
+ * USB- and AHB-related events. The application must read this register
+ * when the OUT Endpoints Interrupt bit or IN Endpoints Interrupt bit of
+ * the Core Interrupt register (GINTSTS.OEPInt or GINTSTS.IEPInt,
+ * respectively) is set. Before the application can read this register,
+ * it must first read the Device All Endpoints Interrupt (DAINT) register
+ * to get the exact endpoint number for the Device Endpoint-n Interrupt
+ * register. The application must clear the appropriate bit in this register
+ * to clear the corresponding bits in the DAINT and GINTSTS registers.
+ */
+union cvmx_usbcx_diepintx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_diepintx_s
+	{
+	uint32_t reserved_7_31                : 25;
+	uint32_t inepnakeff                   : 1;  /**< IN Endpoint NAK Effective (INEPNakEff)
+                                                         Applies to periodic IN endpoints only.
+                                                         Indicates that the IN endpoint NAK bit set by the application has
+                                                         taken effect in the core. This bit can be cleared when the
+                                                         application clears the IN endpoint NAK by writing to
+                                                         DIEPCTLn.CNAK.
+                                                         This interrupt indicates that the core has sampled the NAK bit
+                                                         set (either by the application or by the core).
+                                                         This interrupt does not necessarily mean that a NAK handshake
+                                                         is sent on the USB. A STALL bit takes priority over a NAK bit. */
+	uint32_t intknepmis                   : 1;  /**< IN Token Received with EP Mismatch (INTknEPMis)
+                                                         Applies to non-periodic IN endpoints only.
+                                                         Indicates that the data in the top of the non-periodic TxFIFO
+                                                         belongs to an endpoint other than the one for which the IN
+                                                         token was received. This interrupt is asserted on the endpoint
+                                                         for which the IN token was received. */
+	uint32_t intkntxfemp                  : 1;  /**< IN Token Received When TxFIFO is Empty (INTknTXFEmp)
+                                                         Applies only to non-periodic IN endpoints.
+                                                         Indicates that an IN token was received when the associated
+                                                         TxFIFO (periodic/non-periodic) was empty. This interrupt is
+                                                         asserted on the endpoint for which the IN token was received. */
+	uint32_t timeout                      : 1;  /**< Timeout Condition (TimeOUT)
+                                                         Applies to non-isochronous IN endpoints only.
+                                                         Indicates that the core has detected a timeout condition on the
+                                                         USB for the last IN token on this endpoint. */
+	uint32_t ahberr                       : 1;  /**< AHB Error (AHBErr)
+                                                         This is generated only in Internal DMA mode when there is an
+                                                         AHB error during an AHB read/write. The application can read
+                                                         the corresponding endpoint DMA address register to get the
+                                                         error address. */
+	uint32_t epdisbld                     : 1;  /**< Endpoint Disabled Interrupt (EPDisbld)
+                                                         This bit indicates that the endpoint is disabled per the
+                                                         application's request. */
+	uint32_t xfercompl                    : 1;  /**< Transfer Completed Interrupt (XferCompl)
+                                                         Indicates that the programmed transfer is complete on the AHB
+                                                         as well as on the USB, for this endpoint. */
+	} s;
+	struct cvmx_usbcx_diepintx_s          cn30xx;
+	struct cvmx_usbcx_diepintx_s          cn31xx;
+	struct cvmx_usbcx_diepintx_s          cn50xx;
+	struct cvmx_usbcx_diepintx_s          cn52xx;
+	struct cvmx_usbcx_diepintx_s          cn52xxp1;
+	struct cvmx_usbcx_diepintx_s          cn56xx;
+	struct cvmx_usbcx_diepintx_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_diepintx cvmx_usbcx_diepintx_t;
+
+/**
+ * cvmx_usbc#_diepmsk
+ *
+ * Device IN Endpoint Common Interrupt Mask Register (DIEPMSK)
+ *
+ * This register works with each of the Device IN Endpoint Interrupt (DIEPINTn) registers
+ * for all endpoints to generate an interrupt per IN endpoint. The IN endpoint interrupt
+ * for a specific status in the DIEPINTn register can be masked by writing to the corresponding
+ * bit in this register. Status bits are masked by default.
+ * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
+ */
+union cvmx_usbcx_diepmsk
+{
+	uint32_t u32;
+	struct cvmx_usbcx_diepmsk_s
+	{
+	uint32_t reserved_7_31                : 25;
+	uint32_t inepnakeffmsk                : 1;  /**< IN Endpoint NAK Effective Mask (INEPNakEffMsk) */
+	uint32_t intknepmismsk                : 1;  /**< IN Token received with EP Mismatch Mask (INTknEPMisMsk) */
+	uint32_t intkntxfempmsk               : 1;  /**< IN Token Received When TxFIFO Empty Mask
+                                                         (INTknTXFEmpMsk) */
+	uint32_t timeoutmsk                   : 1;  /**< Timeout Condition Mask (TimeOUTMsk)
+                                                         (Non-isochronous endpoints) */
+	uint32_t ahberrmsk                    : 1;  /**< AHB Error Mask (AHBErrMsk) */
+	uint32_t epdisbldmsk                  : 1;  /**< Endpoint Disabled Interrupt Mask (EPDisbldMsk) */
+	uint32_t xfercomplmsk                 : 1;  /**< Transfer Completed Interrupt Mask (XferComplMsk) */
+	} s;
+	struct cvmx_usbcx_diepmsk_s           cn30xx;
+	struct cvmx_usbcx_diepmsk_s           cn31xx;
+	struct cvmx_usbcx_diepmsk_s           cn50xx;
+	struct cvmx_usbcx_diepmsk_s           cn52xx;
+	struct cvmx_usbcx_diepmsk_s           cn52xxp1;
+	struct cvmx_usbcx_diepmsk_s           cn56xx;
+	struct cvmx_usbcx_diepmsk_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_diepmsk cvmx_usbcx_diepmsk_t;
+
+/**
+ * cvmx_usbc#_dieptsiz#
+ *
+ * Device Endpoint-n Transfer Size Register (DIEPTSIZn)
+ *
+ * The application must modify this register before enabling the endpoint.
+ * Once the endpoint is enabled using Endpoint Enable bit of the Device Endpoint-n Control registers (DIEPCTLn.EPEna/DOEPCTLn.EPEna),
+ * the core modifies this register. The application can only read this register once the core has cleared the Endpoint Enable bit.
+ * This register is used only for endpoints other than Endpoint 0.
+ */
+union cvmx_usbcx_dieptsizx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_dieptsizx_s
+	{
+	uint32_t reserved_31_31               : 1;
+	uint32_t mc                           : 2;  /**< Multi Count (MC)
+                                                         Applies to IN endpoints only.
+                                                         For periodic IN endpoints, this field indicates the number of
+                                                         packets that must be transmitted per microframe on the USB.
+                                                         The core uses this field to calculate the data PID for
+                                                         isochronous IN endpoints.
+                                                         * 2'b01: 1 packet
+                                                         * 2'b10: 2 packets
+                                                         * 2'b11: 3 packets
+                                                         For non-periodic IN endpoints, this field is valid only in Internal
+                                                         DMA mode. It specifies the number of packets the core should
+                                                         fetch for an IN endpoint before it switches to the endpoint
+                                                         pointed to by the Next Endpoint field of the Device Endpoint-n
+                                                         Control register (DIEPCTLn.NextEp) */
+	uint32_t pktcnt                       : 10; /**< Packet Count (PktCnt)
+                                                         Indicates the total number of USB packets that constitute the
+                                                         Transfer Size amount of data for this endpoint.
+                                                         IN Endpoints: This field is decremented every time a packet
+                                                         (maximum size or short packet) is read from the TxFIFO. */
+	uint32_t xfersize                     : 19; /**< Transfer Size (XferSize)
+                                                         This field contains the transfer size in bytes for the current
+                                                         endpoint.
+                                                         The core only interrupts the application after it has exhausted
+                                                         the transfer size amount of data. The transfer size can be set to
+                                                         the maximum packet size of the endpoint, to be interrupted at
+                                                         the end of each packet.
+                                                         IN Endpoints: The core decrements this field every time a
+                                                         packet from the external memory is written to the TxFIFO. */
+	} s;
+	struct cvmx_usbcx_dieptsizx_s         cn30xx;
+	struct cvmx_usbcx_dieptsizx_s         cn31xx;
+	struct cvmx_usbcx_dieptsizx_s         cn50xx;
+	struct cvmx_usbcx_dieptsizx_s         cn52xx;
+	struct cvmx_usbcx_dieptsizx_s         cn52xxp1;
+	struct cvmx_usbcx_dieptsizx_s         cn56xx;
+	struct cvmx_usbcx_dieptsizx_s         cn56xxp1;
+};
+typedef union cvmx_usbcx_dieptsizx cvmx_usbcx_dieptsizx_t;
+
+/**
+ * cvmx_usbc#_doepctl#
+ *
+ * Device OUT Endpoint-n Control Register (DOEPCTLn)
+ *
+ * The application uses the register to control the behaviour of each logical endpoint other than endpoint 0.
+ */
+union cvmx_usbcx_doepctlx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_doepctlx_s
+	{
+	uint32_t epena                        : 1;  /**< Endpoint Enable (EPEna)
+                                                         Indicates that the application has allocated the memory tp start
+                                                         receiving data from the USB.
+                                                         The core clears this bit before setting any of the following
+                                                         interrupts on this endpoint:
+                                                         * SETUP Phase Done
+                                                         * Endpoint Disabled
+                                                         * Transfer Completed
+                                                         For control OUT endpoints in DMA mode, this bit must be set
+                                                         to be able to transfer SETUP data packets in memory. */
+	uint32_t epdis                        : 1;  /**< Endpoint Disable (EPDis)
+                                                         The application sets this bit to stop transmitting data on an
+                                                         endpoint, even before the transfer for that endpoint is complete.
+                                                         The application must wait for the Endpoint Disabled interrupt
+                                                         before treating the endpoint as disabled. The core clears this bit
+                                                         before setting the Endpoint Disabled Interrupt. The application
+                                                         should set this bit only if Endpoint Enable is already set for this
+                                                         endpoint. */
+	uint32_t setd1pid                     : 1;  /**< For Interrupt/BULK enpoints:
+                                                          Set DATA1 PID (SetD1PID)
+                                                          Writing to this field sets the Endpoint Data Pid (DPID) field in
+                                                          this register to DATA1.
+                                                         For Isochronous endpoints:
+                                                          Set Odd (micro)frame (SetOddFr)
+                                                          Writing to this field sets the Even/Odd (micro)frame (EO_FrNum)
+                                                          field to odd (micro)frame. */
+	uint32_t setd0pid                     : 1;  /**< For Interrupt/BULK enpoints:
+                                                          Writing to this field sets the Endpoint Data Pid (DPID) field in
+                                                          this register to DATA0.
+                                                         For Isochronous endpoints:
+                                                          Set Odd (micro)frame (SetEvenFr)
+                                                          Writing to this field sets the Even/Odd (micro)frame (EO_FrNum)
+                                                          field to even (micro)frame. */
+	uint32_t snak                         : 1;  /**< Set NAK (SNAK)
+                                                         A write to this bit sets the NAK bit for the endpoint.
+                                                         Using this bit, the application can control the transmission of
+                                                         NAK handshakes on an endpoint. The core can also set this bit
+                                                         for an endpoint after a SETUP packet is received on the
+                                                         endpoint. */
+	uint32_t cnak                         : 1;  /**< Clear NAK (CNAK)
+                                                         A write to this bit clears the NAK bit for the endpoint. */
+	uint32_t reserved_22_25               : 4;
+	uint32_t stall                        : 1;  /**< STALL Handshake (Stall)
+                                                         For non-control, non-isochronous endpoints:
+                                                          The application sets this bit to stall all tokens from the USB host
+                                                          to this endpoint.  If a NAK bit, Global Non-Periodic IN NAK, or
+                                                          Global OUT NAK is set along with this bit, the STALL bit takes
+                                                          priority.  Only the application can clear this bit, never the core.
+                                                         For control endpoints:
+                                                          The application can only set this bit, and the core clears it, when
+                                                          a SETUP token i received for this endpoint.  If a NAK bit, Global
+                                                          Non-Periodic IN NAK, or Global OUT NAK is set along with this
+                                                          bit, the STALL bit takes priority.  Irrespective of this bit's setting,
+                                                          the core always responds to SETUP data packets with an ACK handshake. */
+	uint32_t snp                          : 1;  /**< Snoop Mode (Snp)
+                                                         This bit configures the endpoint to Snoop mode.  In Snoop mode,
+                                                         the core does not check the correctness of OUT packets before
+                                                         transferring them to application memory. */
+	uint32_t eptype                       : 2;  /**< Endpoint Type (EPType)
+                                                         This is the transfer type supported by this logical endpoint.
+                                                         * 2'b00: Control
+                                                         * 2'b01: Isochronous
+                                                         * 2'b10: Bulk
+                                                         * 2'b11: Interrupt */
+	uint32_t naksts                       : 1;  /**< NAK Status (NAKSts)
+                                                         Indicates the following:
+                                                         * 1'b0: The core is transmitting non-NAK handshakes based
+                                                                 on the FIFO status
+                                                         * 1'b1: The core is transmitting NAK handshakes on this
+                                                                 endpoint.
+                                                         When either the application or the core sets this bit:
+                                                         * The core stops receiving any data on an OUT endpoint, even
+                                                           if there is space in the RxFIFO to accomodate the incoming
+                                                           packet. */
+	uint32_t dpid                         : 1;  /**< For interrupt/bulk IN and OUT endpoints:
+                                                          Endpoint Data PID (DPID)
+                                                          Contains the PID of the packet to be received or transmitted on
+                                                          this endpoint.  The application should program the PID of the first
+                                                          packet to be received or transmitted on this endpoint, after the
+                                                          endpoint is activated.  Applications use the SetD1PID and
+                                                          SetD0PID fields of this register to program either DATA0 or
+                                                          DATA1 PID.
+                                                          * 1'b0: DATA0
+                                                          * 1'b1: DATA1
+                                                         For isochronous IN and OUT endpoints:
+                                                          Even/Odd (Micro)Frame (EO_FrNum)
+                                                          Indicates the (micro)frame number in which the core transmits/
+                                                          receives isochronous data for this endpoint.  The application
+                                                          should program the even/odd (micro) frame number in which it
+                                                          intends to transmit/receive isochronous data for this endpoint
+                                                          using the SetEvnFr and SetOddFr fields in this register.
+                                                          * 1'b0: Even (micro)frame
+                                                          * 1'b1: Odd (micro)frame */
+	uint32_t usbactep                     : 1;  /**< USB Active Endpoint (USBActEP)
+                                                         Indicates whether this endpoint is active in the current
+                                                         configuration and interface.  The core clears this bit for all
+                                                         endpoints (other than EP 0) after detecting a USB reset.  After
+                                                         receiving the SetConfiguration and SetInterface commands, the
+                                                         application must program endpoint registers accordingly and set
+                                                         this bit. */
+	uint32_t reserved_11_14               : 4;
+	uint32_t mps                          : 11; /**< Maximum Packet Size (MPS)
+                                                         Applies to IN and OUT endpoints.
+                                                         The application must program this field with the maximum
+                                                         packet size for the current logical endpoint.  This value is in
+                                                         bytes. */
+	} s;
+	struct cvmx_usbcx_doepctlx_s          cn30xx;
+	struct cvmx_usbcx_doepctlx_s          cn31xx;
+	struct cvmx_usbcx_doepctlx_s          cn50xx;
+	struct cvmx_usbcx_doepctlx_s          cn52xx;
+	struct cvmx_usbcx_doepctlx_s          cn52xxp1;
+	struct cvmx_usbcx_doepctlx_s          cn56xx;
+	struct cvmx_usbcx_doepctlx_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_doepctlx cvmx_usbcx_doepctlx_t;
+
+/**
+ * cvmx_usbc#_doepint#
+ *
+ * Device Endpoint-n Interrupt Register (DOEPINTn)
+ *
+ * This register indicates the status of an endpoint with respect to USB- and AHB-related events.
+ * The application must read this register when the OUT Endpoints Interrupt bit or IN Endpoints
+ * Interrupt bit of the Core Interrupt register (GINTSTS.OEPInt or GINTSTS.IEPInt, respectively)
+ * is set. Before the application can read this register, it must first read the Device All
+ * Endpoints Interrupt (DAINT) register to get the exact endpoint number for the Device Endpoint-n
+ * Interrupt register. The application must clear the appropriate bit in this register to clear the
+ * corresponding bits in the DAINT and GINTSTS registers.
+ */
+union cvmx_usbcx_doepintx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_doepintx_s
+	{
+	uint32_t reserved_5_31                : 27;
+	uint32_t outtknepdis                  : 1;  /**< OUT Token Received When Endpoint Disabled (OUTTknEPdis)
+                                                         Applies only to control OUT endpoints.
+                                                         Indicates that an OUT token was received when the endpoint
+                                                         was not yet enabled. This interrupt is asserted on the endpoint
+                                                         for which the OUT token was received. */
+	uint32_t setup                        : 1;  /**< SETUP Phase Done (SetUp)
+                                                         Applies to control OUT endpoints only.
+                                                         Indicates that the SETUP phase for the control endpoint is
+                                                         complete and no more back-to-back SETUP packets were
+                                                         received for the current control transfer. On this interrupt, the
+                                                         application can decode the received SETUP data packet. */
+	uint32_t ahberr                       : 1;  /**< AHB Error (AHBErr)
+                                                         This is generated only in Internal DMA mode when there is an
+                                                         AHB error during an AHB read/write. The application can read
+                                                         the corresponding endpoint DMA address register to get the
+                                                         error address. */
+	uint32_t epdisbld                     : 1;  /**< Endpoint Disabled Interrupt (EPDisbld)
+                                                         This bit indicates that the endpoint is disabled per the
+                                                         application's request. */
+	uint32_t xfercompl                    : 1;  /**< Transfer Completed Interrupt (XferCompl)
+                                                         Indicates that the programmed transfer is complete on the AHB
+                                                         as well as on the USB, for this endpoint. */
+	} s;
+	struct cvmx_usbcx_doepintx_s          cn30xx;
+	struct cvmx_usbcx_doepintx_s          cn31xx;
+	struct cvmx_usbcx_doepintx_s          cn50xx;
+	struct cvmx_usbcx_doepintx_s          cn52xx;
+	struct cvmx_usbcx_doepintx_s          cn52xxp1;
+	struct cvmx_usbcx_doepintx_s          cn56xx;
+	struct cvmx_usbcx_doepintx_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_doepintx cvmx_usbcx_doepintx_t;
+
+/**
+ * cvmx_usbc#_doepmsk
+ *
+ * Device OUT Endpoint Common Interrupt Mask Register (DOEPMSK)
+ *
+ * This register works with each of the Device OUT Endpoint Interrupt (DOEPINTn) registers
+ * for all endpoints to generate an interrupt per OUT endpoint. The OUT endpoint interrupt
+ * for a specific status in the DOEPINTn register can be masked by writing into the
+ * corresponding bit in this register. Status bits are masked by default.
+ * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
+ */
+union cvmx_usbcx_doepmsk
+{
+	uint32_t u32;
+	struct cvmx_usbcx_doepmsk_s
+	{
+	uint32_t reserved_5_31                : 27;
+	uint32_t outtknepdismsk               : 1;  /**< OUT Token Received when Endpoint Disabled Mask
+                                                         (OUTTknEPdisMsk)
+                                                         Applies to control OUT endpoints only. */
+	uint32_t setupmsk                     : 1;  /**< SETUP Phase Done Mask (SetUPMsk)
+                                                         Applies to control endpoints only. */
+	uint32_t ahberrmsk                    : 1;  /**< AHB Error (AHBErrMsk) */
+	uint32_t epdisbldmsk                  : 1;  /**< Endpoint Disabled Interrupt Mask (EPDisbldMsk) */
+	uint32_t xfercomplmsk                 : 1;  /**< Transfer Completed Interrupt Mask (XferComplMsk) */
+	} s;
+	struct cvmx_usbcx_doepmsk_s           cn30xx;
+	struct cvmx_usbcx_doepmsk_s           cn31xx;
+	struct cvmx_usbcx_doepmsk_s           cn50xx;
+	struct cvmx_usbcx_doepmsk_s           cn52xx;
+	struct cvmx_usbcx_doepmsk_s           cn52xxp1;
+	struct cvmx_usbcx_doepmsk_s           cn56xx;
+	struct cvmx_usbcx_doepmsk_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_doepmsk cvmx_usbcx_doepmsk_t;
+
+/**
+ * cvmx_usbc#_doeptsiz#
+ *
+ * Device Endpoint-n Transfer Size Register (DOEPTSIZn)
+ *
+ * The application must modify this register before enabling the endpoint.
+ * Once the endpoint is enabled using Endpoint Enable bit of the Device Endpoint-n Control
+ * registers (DOEPCTLn.EPEna/DOEPCTLn.EPEna), the core modifies this register. The application
+ * can only read this register once the core has cleared the Endpoint Enable bit.
+ * This register is used only for endpoints other than Endpoint 0.
+ */
+union cvmx_usbcx_doeptsizx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_doeptsizx_s
+	{
+	uint32_t reserved_31_31               : 1;
+	uint32_t mc                           : 2;  /**< Multi Count (MC)
+                                                         Received Data PID (RxDPID)
+                                                         Applies to isochronous OUT endpoints only.
+                                                         This is the data PID received in the last packet for this endpoint.
+                                                         2'b00: DATA0
+                                                         2'b01: DATA1
+                                                         2'b10: DATA2
+                                                         2'b11: MDATA
+                                                         SETUP Packet Count (SUPCnt)
+                                                         Applies to control OUT Endpoints only.
+                                                         This field specifies the number of back-to-back SETUP data
+                                                         packets the endpoint can receive.
+                                                         2'b01: 1 packet
+                                                         2'b10: 2 packets
+                                                         2'b11: 3 packets */
+	uint32_t pktcnt                       : 10; /**< Packet Count (PktCnt)
+                                                         Indicates the total number of USB packets that constitute the
+                                                         Transfer Size amount of data for this endpoint.
+                                                         OUT Endpoints: This field is decremented every time a
+                                                         packet (maximum size or short packet) is written to the
+                                                         RxFIFO. */
+	uint32_t xfersize                     : 19; /**< Transfer Size (XferSize)
+                                                         This field contains the transfer size in bytes for the current
+                                                         endpoint.
+                                                         The core only interrupts the application after it has exhausted
+                                                         the transfer size amount of data. The transfer size can be set to
+                                                         the maximum packet size of the endpoint, to be interrupted at
+                                                         the end of each packet.
+                                                         OUT Endpoints: The core decrements this field every time a
+                                                         packet is read from the RxFIFO and written to the external
+                                                         memory. */
+	} s;
+	struct cvmx_usbcx_doeptsizx_s         cn30xx;
+	struct cvmx_usbcx_doeptsizx_s         cn31xx;
+	struct cvmx_usbcx_doeptsizx_s         cn50xx;
+	struct cvmx_usbcx_doeptsizx_s         cn52xx;
+	struct cvmx_usbcx_doeptsizx_s         cn52xxp1;
+	struct cvmx_usbcx_doeptsizx_s         cn56xx;
+	struct cvmx_usbcx_doeptsizx_s         cn56xxp1;
+};
+typedef union cvmx_usbcx_doeptsizx cvmx_usbcx_doeptsizx_t;
+
+/**
+ * cvmx_usbc#_dptxfsiz#
+ *
+ * Device Periodic Transmit FIFO-n Size Register (DPTXFSIZ)
+ *
+ * This register holds the memory start address of each periodic TxFIFO to implemented
+ * in Device mode. Each periodic FIFO holds the data for one periodic IN endpoint.
+ * This register is repeated for each periodic FIFO instantiated.
+ */
+union cvmx_usbcx_dptxfsizx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_dptxfsizx_s
+	{
+	uint32_t dptxfsize                    : 16; /**< Device Periodic TxFIFO Size (DPTxFSize)
+                                                         This value is in terms of 32-bit words.
+                                                         * Minimum value is 4
+                                                         * Maximum value is 768 */
+	uint32_t dptxfstaddr                  : 16; /**< Device Periodic TxFIFO RAM Start Address (DPTxFStAddr)
+                                                         Holds the start address in the RAM for this periodic FIFO. */
+	} s;
+	struct cvmx_usbcx_dptxfsizx_s         cn30xx;
+	struct cvmx_usbcx_dptxfsizx_s         cn31xx;
+	struct cvmx_usbcx_dptxfsizx_s         cn50xx;
+	struct cvmx_usbcx_dptxfsizx_s         cn52xx;
+	struct cvmx_usbcx_dptxfsizx_s         cn52xxp1;
+	struct cvmx_usbcx_dptxfsizx_s         cn56xx;
+	struct cvmx_usbcx_dptxfsizx_s         cn56xxp1;
+};
+typedef union cvmx_usbcx_dptxfsizx cvmx_usbcx_dptxfsizx_t;
+
+/**
+ * cvmx_usbc#_dsts
+ *
+ * Device Status Register (DSTS)
+ *
+ * This register indicates the status of the core with respect to USB-related events.
+ * It must be read on interrupts from Device All Interrupts (DAINT) register.
+ */
+union cvmx_usbcx_dsts
+{
+	uint32_t u32;
+	struct cvmx_usbcx_dsts_s
+	{
+	uint32_t reserved_22_31               : 10;
+	uint32_t soffn                        : 14; /**< Frame or Microframe Number of the Received SOF (SOFFN)
+                                                         When the core is operating at high speed, this field contains a
+                                                         microframe number. When the core is operating at full or low
+                                                         speed, this field contains a frame number. */
+	uint32_t reserved_4_7                 : 4;
+	uint32_t errticerr                    : 1;  /**< Erratic Error (ErrticErr)
+                                                         The core sets this bit to report any erratic errors
+                                                         (phy_rxvalid_i/phy_rxvldh_i or phy_rxactive_i is asserted for at
+                                                         least 2 ms, due to PHY error) seen on the UTMI+.
+                                                         Due to erratic errors, the O2P USB core goes into Suspended
+                                                         state and an interrupt is generated to the application with Early
+                                                         Suspend bit of the Core Interrupt register (GINTSTS.ErlySusp).
+                                                         If the early suspend is asserted due to an erratic error, the
+                                                         application can only perform a soft disconnect recover. */
+	uint32_t enumspd                      : 2;  /**< Enumerated Speed (EnumSpd)
+                                                         Indicates the speed at which the O2P USB core has come up
+                                                         after speed detection through a chirp sequence.
+                                                         * 2'b00: High speed (PHY clock is running at 30 or 60 MHz)
+                                                         * 2'b01: Full speed (PHY clock is running at 30 or 60 MHz)
+                                                         * 2'b10: Low speed (PHY clock is running at 6 MHz)
+                                                         * 2'b11: Full speed (PHY clock is running at 48 MHz)
+                                                         Low speed is not supported for devices using a UTMI+ PHY. */
+	uint32_t suspsts                      : 1;  /**< Suspend Status (SuspSts)
+                                                         In Device mode, this bit is set as long as a Suspend condition is
+                                                         detected on the USB. The core enters the Suspended state
+                                                         when there is no activity on the phy_line_state_i signal for an
+                                                         extended period of time. The core comes out of the suspend:
+                                                         * When there is any activity on the phy_line_state_i signal
+                                                         * When the application writes to the Remote Wakeup Signaling
+                                                           bit in the Device Control register (DCTL.RmtWkUpSig). */
+	} s;
+	struct cvmx_usbcx_dsts_s              cn30xx;
+	struct cvmx_usbcx_dsts_s              cn31xx;
+	struct cvmx_usbcx_dsts_s              cn50xx;
+	struct cvmx_usbcx_dsts_s              cn52xx;
+	struct cvmx_usbcx_dsts_s              cn52xxp1;
+	struct cvmx_usbcx_dsts_s              cn56xx;
+	struct cvmx_usbcx_dsts_s              cn56xxp1;
+};
+typedef union cvmx_usbcx_dsts cvmx_usbcx_dsts_t;
+
+/**
+ * cvmx_usbc#_dtknqr1
+ *
+ * Device IN Token Sequence Learning Queue Read Register 1 (DTKNQR1)
+ *
+ * The depth of the IN Token Sequence Learning Queue is specified for Device Mode IN Token
+ * Sequence Learning Queue Depth. The queue is 4 bits wide to store the endpoint number.
+ * A read from this register returns the first 5 endpoint entries of the IN Token Sequence
+ * Learning Queue. When the queue is full, the new token is pushed into the queue and oldest
+ * token is discarded.
+ */
+union cvmx_usbcx_dtknqr1
+{
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr1_s
+	{
+	uint32_t eptkn                        : 24; /**< Endpoint Token (EPTkn)
+                                                         Four bits per token represent the endpoint number of the token:
+                                                         * Bits [31:28]: Endpoint number of Token 5
+                                                         * Bits [27:24]: Endpoint number of Token 4
+                                                         - .......
+                                                         * Bits [15:12]: Endpoint number of Token 1
+                                                         * Bits [11:8]: Endpoint number of Token 0 */
+	uint32_t wrapbit                      : 1;  /**< Wrap Bit (WrapBit)
+                                                         This bit is set when the write pointer wraps. It is cleared when
+                                                         the learning queue is cleared. */
+	uint32_t reserved_5_6                 : 2;
+	uint32_t intknwptr                    : 5;  /**< IN Token Queue Write Pointer (INTknWPtr) */
+	} s;
+	struct cvmx_usbcx_dtknqr1_s           cn30xx;
+	struct cvmx_usbcx_dtknqr1_s           cn31xx;
+	struct cvmx_usbcx_dtknqr1_s           cn50xx;
+	struct cvmx_usbcx_dtknqr1_s           cn52xx;
+	struct cvmx_usbcx_dtknqr1_s           cn52xxp1;
+	struct cvmx_usbcx_dtknqr1_s           cn56xx;
+	struct cvmx_usbcx_dtknqr1_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_dtknqr1 cvmx_usbcx_dtknqr1_t;
+
+/**
+ * cvmx_usbc#_dtknqr2
+ *
+ * Device IN Token Sequence Learning Queue Read Register 2 (DTKNQR2)
+ *
+ * A read from this register returns the next 8 endpoint entries of the learning queue.
+ */
+union cvmx_usbcx_dtknqr2
+{
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr2_s
+	{
+	uint32_t eptkn                        : 32; /**< Endpoint Token (EPTkn)
+                                                         Four bits per token represent the endpoint number of the token:
+                                                         * Bits [31:28]: Endpoint number of Token 13
+                                                         * Bits [27:24]: Endpoint number of Token 12
+                                                         - .......
+                                                         * Bits [7:4]: Endpoint number of Token 7
+                                                         * Bits [3:0]: Endpoint number of Token 6 */
+	} s;
+	struct cvmx_usbcx_dtknqr2_s           cn30xx;
+	struct cvmx_usbcx_dtknqr2_s           cn31xx;
+	struct cvmx_usbcx_dtknqr2_s           cn50xx;
+	struct cvmx_usbcx_dtknqr2_s           cn52xx;
+	struct cvmx_usbcx_dtknqr2_s           cn52xxp1;
+	struct cvmx_usbcx_dtknqr2_s           cn56xx;
+	struct cvmx_usbcx_dtknqr2_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_dtknqr2 cvmx_usbcx_dtknqr2_t;
+
+/**
+ * cvmx_usbc#_dtknqr3
+ *
+ * Device IN Token Sequence Learning Queue Read Register 3 (DTKNQR3)
+ *
+ * A read from this register returns the next 8 endpoint entries of the learning queue.
+ */
+union cvmx_usbcx_dtknqr3
+{
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr3_s
+	{
+	uint32_t eptkn                        : 32; /**< Endpoint Token (EPTkn)
+                                                         Four bits per token represent the endpoint number of the token:
+                                                         * Bits [31:28]: Endpoint number of Token 21
+                                                         * Bits [27:24]: Endpoint number of Token 20
+                                                         - .......
+                                                         * Bits [7:4]: Endpoint number of Token 15
+                                                         * Bits [3:0]: Endpoint number of Token 14 */
+	} s;
+	struct cvmx_usbcx_dtknqr3_s           cn30xx;
+	struct cvmx_usbcx_dtknqr3_s           cn31xx;
+	struct cvmx_usbcx_dtknqr3_s           cn50xx;
+	struct cvmx_usbcx_dtknqr3_s           cn52xx;
+	struct cvmx_usbcx_dtknqr3_s           cn52xxp1;
+	struct cvmx_usbcx_dtknqr3_s           cn56xx;
+	struct cvmx_usbcx_dtknqr3_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_dtknqr3 cvmx_usbcx_dtknqr3_t;
+
+/**
+ * cvmx_usbc#_dtknqr4
+ *
+ * Device IN Token Sequence Learning Queue Read Register 4 (DTKNQR4)
+ *
+ * A read from this register returns the last 8 endpoint entries of the learning queue.
+ */
+union cvmx_usbcx_dtknqr4
+{
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr4_s
+	{
+	uint32_t eptkn                        : 32; /**< Endpoint Token (EPTkn)
+                                                         Four bits per token represent the endpoint number of the token:
+                                                         * Bits [31:28]: Endpoint number of Token 29
+                                                         * Bits [27:24]: Endpoint number of Token 28
+                                                         - .......
+                                                         * Bits [7:4]: Endpoint number of Token 23
+                                                         * Bits [3:0]: Endpoint number of Token 22 */
+	} s;
+	struct cvmx_usbcx_dtknqr4_s           cn30xx;
+	struct cvmx_usbcx_dtknqr4_s           cn31xx;
+	struct cvmx_usbcx_dtknqr4_s           cn50xx;
+	struct cvmx_usbcx_dtknqr4_s           cn52xx;
+	struct cvmx_usbcx_dtknqr4_s           cn52xxp1;
+	struct cvmx_usbcx_dtknqr4_s           cn56xx;
+	struct cvmx_usbcx_dtknqr4_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_dtknqr4 cvmx_usbcx_dtknqr4_t;
+
+/**
+ * cvmx_usbc#_gahbcfg
+ *
+ * Core AHB Configuration Register (GAHBCFG)
+ *
+ * This register can be used to configure the core after power-on or a change in mode of operation.
+ * This register mainly contains AHB system-related configuration parameters. The AHB is the processor
+ * interface to the O2P USB core. In general, software need not know about this interface except to
+ * program the values as specified.
+ *
+ * The application must program this register as part of the O2P USB core initialization.
+ * Do not change this register after the initial programming.
+ */
+union cvmx_usbcx_gahbcfg
+{
+	uint32_t u32;
+	struct cvmx_usbcx_gahbcfg_s
+	{
+	uint32_t reserved_9_31                : 23;
+	uint32_t ptxfemplvl                   : 1;  /**< Periodic TxFIFO Empty Level (PTxFEmpLvl)
+                                                         Software should set this bit to 0x1.
+                                                         Indicates when the Periodic TxFIFO Empty Interrupt bit in the
+                                                         Core Interrupt register (GINTSTS.PTxFEmp) is triggered. This
+                                                         bit is used only in Slave mode.
+                                                         * 1'b0: GINTSTS.PTxFEmp interrupt indicates that the Periodic
+                                                           TxFIFO is half empty
+                                                         * 1'b1: GINTSTS.PTxFEmp interrupt indicates that the Periodic
+                                                           TxFIFO is completely empty */
+	uint32_t nptxfemplvl                  : 1;  /**< Non-Periodic TxFIFO Empty Level (NPTxFEmpLvl)
+                                                         Software should set this bit to 0x1.
+                                                         Indicates when the Non-Periodic TxFIFO Empty Interrupt bit in
+                                                         the Core Interrupt register (GINTSTS.NPTxFEmp) is triggered.
+                                                         This bit is used only in Slave mode.
+                                                         * 1'b0: GINTSTS.NPTxFEmp interrupt indicates that the Non-
+                                                            Periodic TxFIFO is half empty
+                                                         * 1'b1: GINTSTS.NPTxFEmp interrupt indicates that the Non-
+                                                            Periodic TxFIFO is completely empty */
+	uint32_t reserved_6_6                 : 1;
+	uint32_t dmaen                        : 1;  /**< DMA Enable (DMAEn)
+                                                         * 1'b0: Core operates in Slave mode
+                                                         * 1'b1: Core operates in a DMA mode */
+	uint32_t hbstlen                      : 4;  /**< Burst Length/Type (HBstLen)
+                                                         This field has not effect and should be left as 0x0. */
+	uint32_t glblintrmsk                  : 1;  /**< Global Interrupt Mask (GlblIntrMsk)
+                                                         Software should set this field to 0x1.
+                                                         The application uses this bit to mask  or unmask the interrupt
+                                                         line assertion to itself. Irrespective of this bit's setting, the
+                                                         interrupt status registers are updated by the core.
+                                                         * 1'b0: Mask the interrupt assertion to the application.
+                                                         * 1'b1: Unmask the interrupt assertion to the application. */
+	} s;
+	struct cvmx_usbcx_gahbcfg_s           cn30xx;
+	struct cvmx_usbcx_gahbcfg_s           cn31xx;
+	struct cvmx_usbcx_gahbcfg_s           cn50xx;
+	struct cvmx_usbcx_gahbcfg_s           cn52xx;
+	struct cvmx_usbcx_gahbcfg_s           cn52xxp1;
+	struct cvmx_usbcx_gahbcfg_s           cn56xx;
+	struct cvmx_usbcx_gahbcfg_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_gahbcfg cvmx_usbcx_gahbcfg_t;
+
+/**
+ * cvmx_usbc#_ghwcfg1
+ *
+ * User HW Config1 Register (GHWCFG1)
+ *
+ * This register contains the logical endpoint direction(s) of the O2P USB core.
+ */
+union cvmx_usbcx_ghwcfg1
+{
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg1_s
+	{
+	uint32_t epdir                        : 32; /**< Endpoint Direction (epdir)
+                                                         Two bits per endpoint represent the direction.
+                                                         * 2'b00: BIDIR (IN and OUT) endpoint
+                                                         * 2'b01: IN endpoint
+                                                         * 2'b10: OUT endpoint
+                                                         * 2'b11: Reserved
+                                                         Bits [31:30]: Endpoint 15 direction
+                                                         Bits [29:28]: Endpoint 14 direction
+                                                         - ...
+                                                         Bits [3:2]: Endpoint 1 direction
+                                                         Bits[1:0]: Endpoint 0 direction (always BIDIR) */
+	} s;
+	struct cvmx_usbcx_ghwcfg1_s           cn30xx;
+	struct cvmx_usbcx_ghwcfg1_s           cn31xx;
+	struct cvmx_usbcx_ghwcfg1_s           cn50xx;
+	struct cvmx_usbcx_ghwcfg1_s           cn52xx;
+	struct cvmx_usbcx_ghwcfg1_s           cn52xxp1;
+	struct cvmx_usbcx_ghwcfg1_s           cn56xx;
+	struct cvmx_usbcx_ghwcfg1_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_ghwcfg1 cvmx_usbcx_ghwcfg1_t;
+
+/**
+ * cvmx_usbc#_ghwcfg2
+ *
+ * User HW Config2 Register (GHWCFG2)
+ *
+ * This register contains configuration options of the O2P USB core.
+ */
+union cvmx_usbcx_ghwcfg2
+{
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg2_s
+	{
+	uint32_t reserved_31_31               : 1;
+	uint32_t tknqdepth                    : 5;  /**< Device Mode IN Token Sequence Learning Queue Depth
+                                                         (TknQDepth)
+                                                         Range: 0-30 */
+	uint32_t ptxqdepth                    : 2;  /**< Host Mode Periodic Request Queue Depth (PTxQDepth)
+                                                         * 2'b00: 2
+                                                         * 2'b01: 4
+                                                         * 2'b10: 8
+                                                         * Others: Reserved */
+	uint32_t nptxqdepth                   : 2;  /**< Non-Periodic Request Queue Depth (NPTxQDepth)
+                                                         * 2'b00: 2
+                                                         * 2'b01: 4
+                                                         * 2'b10: 8
+                                                         * Others: Reserved */
+	uint32_t reserved_20_21               : 2;
+	uint32_t dynfifosizing                : 1;  /**< Dynamic FIFO Sizing Enabled (DynFifoSizing)
+                                                         * 1'b0: No
+                                                         * 1'b1: Yes */
+	uint32_t periosupport                 : 1;  /**< Periodic OUT Channels Supported in Host Mode
+                                                         (PerioSupport)
+                                                         * 1'b0: No
+                                                         * 1'b1: Yes */
+	uint32_t numhstchnl                   : 4;  /**< Number of Host Channels (NumHstChnl)
+                                                         Indicates the number of host channels supported by the core in
+                                                         Host mode. The range of this field is 0-15: 0 specifies 1
+                                                         channel, 15 specifies 16 channels. */
+	uint32_t numdeveps                    : 4;  /**< Number of Device Endpoints (NumDevEps)
+                                                         Indicates the number of device endpoints supported by the core
+                                                         in Device mode in addition to control endpoint 0. The range of
+                                                         this field is 1-15. */
+	uint32_t fsphytype                    : 2;  /**< Full-Speed PHY Interface Type (FSPhyType)
+                                                         * 2'b00: Full-speed interface not supported
+                                                         * 2'b01: Dedicated full-speed interface
+                                                         * 2'b10: FS pins shared with UTMI+ pins
+                                                         * 2'b11: FS pins shared with ULPI pins */
+	uint32_t hsphytype                    : 2;  /**< High-Speed PHY Interface Type (HSPhyType)
+                                                         * 2'b00: High-Speed interface not supported
+                                                         * 2'b01: UTMI+
+                                                         * 2'b10: ULPI
+                                                         * 2'b11: UTMI+ and ULPI */
+	uint32_t singpnt                      : 1;  /**< Point-to-Point (SingPnt)
+                                                         * 1'b0: Multi-point application
+                                                         * 1'b1: Single-point application */
+	uint32_t otgarch                      : 2;  /**< Architecture (OtgArch)
+                                                         * 2'b00: Slave-Only
+                                                         * 2'b01: External DMA
+                                                         * 2'b10: Internal DMA
+                                                         * Others: Reserved */
+	uint32_t otgmode                      : 3;  /**< Mode of Operation (OtgMode)
+                                                         * 3'b000: HNP- and SRP-Capable OTG (Host & Device)
+                                                         * 3'b001: SRP-Capable OTG (Host & Device)
+                                                         * 3'b010: Non-HNP and Non-SRP Capable OTG (Host &
+                                                         Device)
+                                                         * 3'b011: SRP-Capable Device
+                                                         * 3'b100: Non-OTG Device
+                                                         * 3'b101: SRP-Capable Host
+                                                         * 3'b110: Non-OTG Host
+                                                         * Others: Reserved */
+	} s;
+	struct cvmx_usbcx_ghwcfg2_s           cn30xx;
+	struct cvmx_usbcx_ghwcfg2_s           cn31xx;
+	struct cvmx_usbcx_ghwcfg2_s           cn50xx;
+	struct cvmx_usbcx_ghwcfg2_s           cn52xx;
+	struct cvmx_usbcx_ghwcfg2_s           cn52xxp1;
+	struct cvmx_usbcx_ghwcfg2_s           cn56xx;
+	struct cvmx_usbcx_ghwcfg2_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_ghwcfg2 cvmx_usbcx_ghwcfg2_t;
+
+/**
+ * cvmx_usbc#_ghwcfg3
+ *
+ * User HW Config3 Register (GHWCFG3)
+ *
+ * This register contains the configuration options of the O2P USB core.
+ */
+union cvmx_usbcx_ghwcfg3
+{
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg3_s
+	{
+	uint32_t dfifodepth                   : 16; /**< DFIFO Depth (DfifoDepth)
+                                                         This value is in terms of 32-bit words.
+                                                         * Minimum value is 32
+                                                         * Maximum value is 32768 */
+	uint32_t reserved_13_15               : 3;
+	uint32_t ahbphysync                   : 1;  /**< AHB and PHY Synchronous (AhbPhySync)
+                                                         Indicates whether AHB and PHY clocks are synchronous to
+                                                         each other.
+                                                         * 1'b0: No
+                                                         * 1'b1: Yes
+                                                         This bit is tied to 1. */
+	uint32_t rsttype                      : 1;  /**< Reset Style for Clocked always Blocks in RTL (RstType)
+                                                         * 1'b0: Asynchronous reset is used in the core
+                                                         * 1'b1: Synchronous reset is used in the core */
+	uint32_t optfeature                   : 1;  /**< Optional Features Removed (OptFeature)
+                                                         Indicates whether the User ID register, GPIO interface ports,
+                                                         and SOF toggle and counter ports were removed for gate count
+                                                         optimization. */
+	uint32_t vendor_control_interface_support : 1;/**< Vendor Control Interface Support
+                                                         * 1'b0: Vendor Control Interface is not available on the core.
+                                                         * 1'b1: Vendor Control Interface is available. */
+	uint32_t i2c_selection                : 1;  /**< I2C Selection
+                                                         * 1'b0: I2C Interface is not available on the core.
+                                                         * 1'b1: I2C Interface is available on the core. */
+	uint32_t otgen                        : 1;  /**< OTG Function Enabled (OtgEn)
+                                                         The application uses this bit to indicate the O2P USB core's
+                                                         OTG capabilities.
+                                                         * 1'b0: Not OTG capable
+                                                         * 1'b1: OTG Capable */
+	uint32_t pktsizewidth                 : 3;  /**< Width of Packet Size Counters (PktSizeWidth)
+                                                         * 3'b000: 4 bits
+                                                         * 3'b001: 5 bits
+                                                         * 3'b010: 6 bits
+                                                         * 3'b011: 7 bits
+                                                         * 3'b100: 8 bits
+                                                         * 3'b101: 9 bits
+                                                         * 3'b110: 10 bits
+                                                         * Others: Reserved */
+	uint32_t xfersizewidth                : 4;  /**< Width of Transfer Size Counters (XferSizeWidth)
+                                                         * 4'b0000: 11 bits
+                                                         * 4'b0001: 12 bits
+                                                         - ...
+                                                         * 4'b1000: 19 bits
+                                                         * Others: Reserved */
+	} s;
+	struct cvmx_usbcx_ghwcfg3_s           cn30xx;
+	struct cvmx_usbcx_ghwcfg3_s           cn31xx;
+	struct cvmx_usbcx_ghwcfg3_s           cn50xx;
+	struct cvmx_usbcx_ghwcfg3_s           cn52xx;
+	struct cvmx_usbcx_ghwcfg3_s           cn52xxp1;
+	struct cvmx_usbcx_ghwcfg3_s           cn56xx;
+	struct cvmx_usbcx_ghwcfg3_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_ghwcfg3 cvmx_usbcx_ghwcfg3_t;
+
+/**
+ * cvmx_usbc#_ghwcfg4
+ *
+ * User HW Config4 Register (GHWCFG4)
+ *
+ * This register contains the configuration options of the O2P USB core.
+ */
+union cvmx_usbcx_ghwcfg4
+{
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg4_s
+	{
+	uint32_t reserved_30_31               : 2;
+	uint32_t numdevmodinend               : 4;  /**< Enable dedicatd transmit FIFO for device IN endpoints. */
+	uint32_t endedtrfifo                  : 1;  /**< Enable dedicatd transmit FIFO for device IN endpoints. */
+	uint32_t sessendfltr                  : 1;  /**< "session_end" Filter Enabled (SessEndFltr)
+                                                         * 1'b0: No filter
+                                                         * 1'b1: Filter */
+	uint32_t bvalidfltr                   : 1;  /**< "b_valid" Filter Enabled (BValidFltr)
+                                                         * 1'b0: No filter
+                                                         * 1'b1: Filter */
+	uint32_t avalidfltr                   : 1;  /**< "a_valid" Filter Enabled (AValidFltr)
+                                                         * 1'b0: No filter
+                                                         * 1'b1: Filter */
+	uint32_t vbusvalidfltr                : 1;  /**< "vbus_valid" Filter Enabled (VBusValidFltr)
+                                                         * 1'b0: No filter
+                                                         * 1'b1: Filter */
+	uint32_t iddgfltr                     : 1;  /**< "iddig" Filter Enable (IddgFltr)
+                                                         * 1'b0: No filter
+                                                         * 1'b1: Filter */
+	uint32_t numctleps                    : 4;  /**< Number of Device Mode Control Endpoints in Addition to
+                                                         Endpoint 0 (NumCtlEps)
+                                                         Range: 1-15 */
+	uint32_t phydatawidth                 : 2;  /**< UTMI+ PHY/ULPI-to-Internal UTMI+ Wrapper Data Width
+                                                         (PhyDataWidth)
+                                                         When a ULPI PHY is used, an internal wrapper converts ULPI
+                                                         to UTMI+.
+                                                         * 2'b00: 8 bits
+                                                         * 2'b01: 16 bits
+                                                         * 2'b10: 8/16 bits, software selectable
+                                                         * Others: Reserved */
+	uint32_t reserved_6_13                : 8;
+	uint32_t ahbfreq                      : 1;  /**< Minimum AHB Frequency Less Than 60 MHz (AhbFreq)
+                                                         * 1'b0: No
+                                                         * 1'b1: Yes */
+	uint32_t enablepwropt                 : 1;  /**< Enable Power Optimization? (EnablePwrOpt)
+                                                         * 1'b0: No
+                                                         * 1'b1: Yes */
+	uint32_t numdevperioeps               : 4;  /**< Number of Device Mode Periodic IN Endpoints
+                                                         (NumDevPerioEps)
+                                                         Range: 0-15 */
+	} s;
+	struct cvmx_usbcx_ghwcfg4_cn30xx
+	{
+	uint32_t reserved_25_31               : 7;
+	uint32_t sessendfltr                  : 1;  /**< "session_end" Filter Enabled (SessEndFltr)
+                                                         * 1'b0: No filter
+                                                         * 1'b1: Filter */
+	uint32_t bvalidfltr                   : 1;  /**< "b_valid" Filter Enabled (BValidFltr)
+                                                         * 1'b0: No filter
+                                                         * 1'b1: Filter */
+	uint32_t avalidfltr                   : 1;  /**< "a_valid" Filter Enabled (AValidFltr)
+                                                         * 1'b0: No filter
+                                                         * 1'b1: Filter */
+	uint32_t vbusvalidfltr                : 1;  /**< "vbus_valid" Filter Enabled (VBusValidFltr)
+                                                         * 1'b0: No filter
+                                                         * 1'b1: Filter */
+	uint32_t iddgfltr                     : 1;  /**< "iddig" Filter Enable (IddgFltr)
+                                                         * 1'b0: No filter
+                                                         * 1'b1: Filter */
+	uint32_t numctleps                    : 4;  /**< Number of Device Mode Control Endpoints in Addition to
+                                                         Endpoint 0 (NumCtlEps)
+                                                         Range: 1-15 */
+	uint32_t phydatawidth                 : 2;  /**< UTMI+ PHY/ULPI-to-Internal UTMI+ Wrapper Data Width
+                                                         (PhyDataWidth)
+                                                         When a ULPI PHY is used, an internal wrapper converts ULPI
+                                                         to UTMI+.
+                                                         * 2'b00: 8 bits
+                                                         * 2'b01: 16 bits
+                                                         * 2'b10: 8/16 bits, software selectable
+                                                         * Others: Reserved */
+	uint32_t reserved_6_13                : 8;
+	uint32_t ahbfreq                      : 1;  /**< Minimum AHB Frequency Less Than 60 MHz (AhbFreq)
+                                                         * 1'b0: No
+                                                         * 1'b1: Yes */
+	uint32_t enablepwropt                 : 1;  /**< Enable Power Optimization? (EnablePwrOpt)
+                                                         * 1'b0: No
+                                                         * 1'b1: Yes */
+	uint32_t numdevperioeps               : 4;  /**< Number of Device Mode Periodic IN Endpoints
+                                                         (NumDevPerioEps)
+                                                         Range: 0-15 */
+	} cn30xx;
+	struct cvmx_usbcx_ghwcfg4_cn30xx      cn31xx;
+	struct cvmx_usbcx_ghwcfg4_s           cn50xx;
+	struct cvmx_usbcx_ghwcfg4_s           cn52xx;
+	struct cvmx_usbcx_ghwcfg4_s           cn52xxp1;
+	struct cvmx_usbcx_ghwcfg4_s           cn56xx;
+	struct cvmx_usbcx_ghwcfg4_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_ghwcfg4 cvmx_usbcx_ghwcfg4_t;
+
+/**
+ * cvmx_usbc#_gintmsk
+ *
+ * Core Interrupt Mask Register (GINTMSK)
+ *
+ * This register works with the Core Interrupt register to interrupt the application.
+ * When an interrupt bit is masked, the interrupt associated with that bit will not be generated.
+ * However, the Core Interrupt (GINTSTS) register bit corresponding to that interrupt will still be set.
+ * Mask interrupt: 1'b0, Unmask interrupt: 1'b1
+ */
+union cvmx_usbcx_gintmsk
+{
+	uint32_t u32;
+	struct cvmx_usbcx_gintmsk_s
+	{
+	uint32_t wkupintmsk                   : 1;  /**< Resume/Remote Wakeup Detected Interrupt Mask
+                                                         (WkUpIntMsk) */
+	uint32_t sessreqintmsk                : 1;  /**< Session Request/New Session Detected Interrupt Mask
+                                                         (SessReqIntMsk) */
+	uint32_t disconnintmsk                : 1;  /**< Disconnect Detected Interrupt Mask (DisconnIntMsk) */
+	uint32_t conidstschngmsk              : 1;  /**< Connector ID Status Change Mask (ConIDStsChngMsk) */
+	uint32_t reserved_27_27               : 1;
+	uint32_t ptxfempmsk                   : 1;  /**< Periodic TxFIFO Empty Mask (PTxFEmpMsk) */
+	uint32_t hchintmsk                    : 1;  /**< Host Channels Interrupt Mask (HChIntMsk) */
+	uint32_t prtintmsk                    : 1;  /**< Host Port Interrupt Mask (PrtIntMsk) */
+	uint32_t reserved_23_23               : 1;
+	uint32_t fetsuspmsk                   : 1;  /**< Data Fetch Suspended Mask (FetSuspMsk) */
+	uint32_t incomplpmsk                  : 1;  /**< Incomplete Periodic Transfer Mask (incomplPMsk)
+                                                         Incomplete Isochronous OUT Transfer Mask
+                                                         (incompISOOUTMsk) */
+	uint32_t incompisoinmsk               : 1;  /**< Incomplete Isochronous IN Transfer Mask (incompISOINMsk) */
+	uint32_t oepintmsk                    : 1;  /**< OUT Endpoints Interrupt Mask (OEPIntMsk) */
+	uint32_t inepintmsk                   : 1;  /**< IN Endpoints Interrupt Mask (INEPIntMsk) */
+	uint32_t epmismsk                     : 1;  /**< Endpoint Mismatch Interrupt Mask (EPMisMsk) */
+	uint32_t reserved_16_16               : 1;
+	uint32_t eopfmsk                      : 1;  /**< End of Periodic Frame Interrupt Mask (EOPFMsk) */
+	uint32_t isooutdropmsk                : 1;  /**< Isochronous OUT Packet Dropped Interrupt Mask
+                                                         (ISOOutDropMsk) */
+	uint32_t enumdonemsk                  : 1;  /**< Enumeration Done Mask (EnumDoneMsk) */
+	uint32_t usbrstmsk                    : 1;  /**< USB Reset Mask (USBRstMsk) */
+	uint32_t usbsuspmsk                   : 1;  /**< USB Suspend Mask (USBSuspMsk) */
+	uint32_t erlysuspmsk                  : 1;  /**< Early Suspend Mask (ErlySuspMsk) */
+	uint32_t i2cint                       : 1;  /**< I2C Interrupt Mask (I2CINT) */
+	uint32_t ulpickintmsk                 : 1;  /**< ULPI Carkit Interrupt Mask (ULPICKINTMsk)
+                                                         I2C Carkit Interrupt Mask (I2CCKINTMsk) */
+	uint32_t goutnakeffmsk                : 1;  /**< Global OUT NAK Effective Mask (GOUTNakEffMsk) */
+	uint32_t ginnakeffmsk                 : 1;  /**< Global Non-Periodic IN NAK Effective Mask (GINNakEffMsk) */
+	uint32_t nptxfempmsk                  : 1;  /**< Non-Periodic TxFIFO Empty Mask (NPTxFEmpMsk) */
+	uint32_t rxflvlmsk                    : 1;  /**< Receive FIFO Non-Empty Mask (RxFLvlMsk) */
+	uint32_t sofmsk                       : 1;  /**< Start of (micro)Frame Mask (SofMsk) */
+	uint32_t otgintmsk                    : 1;  /**< OTG Interrupt Mask (OTGIntMsk) */
+	uint32_t modemismsk                   : 1;  /**< Mode Mismatch Interrupt Mask (ModeMisMsk) */
+	uint32_t reserved_0_0                 : 1;
+	} s;
+	struct cvmx_usbcx_gintmsk_s           cn30xx;
+	struct cvmx_usbcx_gintmsk_s           cn31xx;
+	struct cvmx_usbcx_gintmsk_s           cn50xx;
+	struct cvmx_usbcx_gintmsk_s           cn52xx;
+	struct cvmx_usbcx_gintmsk_s           cn52xxp1;
+	struct cvmx_usbcx_gintmsk_s           cn56xx;
+	struct cvmx_usbcx_gintmsk_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_gintmsk cvmx_usbcx_gintmsk_t;
+
+/**
+ * cvmx_usbc#_gintsts
+ *
+ * Core Interrupt Register (GINTSTS)
+ *
+ * This register interrupts the application for system-level events in the current mode of operation
+ * (Device mode or Host mode). It is shown in Interrupt. Some of the bits in this register are valid only in Host mode,
+ * while others are valid in Device mode only. This register also indicates the current mode of operation.
+ * In order to clear the interrupt status bits of type R_SS_WC, the application must write 1'b1 into the bit.
+ * The FIFO status interrupts are read only; once software reads from or writes to the FIFO while servicing these
+ * interrupts, FIFO interrupt conditions are cleared automatically.
+ */
+union cvmx_usbcx_gintsts
+{
+	uint32_t u32;
+	struct cvmx_usbcx_gintsts_s
+	{
+	uint32_t wkupint                      : 1;  /**< Resume/Remote Wakeup Detected Interrupt (WkUpInt)
+                                                         In Device mode, this interrupt is asserted when a resume is
+                                                         detected on the USB. In Host mode, this interrupt is asserted
+                                                         when a remote wakeup is detected on the USB.
+                                                         For more information on how to use this interrupt, see "Partial
+                                                         Power-Down and Clock Gating Programming Model" on
+                                                         page 353. */
+	uint32_t sessreqint                   : 1;  /**< Session Request/New Session Detected Interrupt (SessReqInt)
+                                                         In Host mode, this interrupt is asserted when a session request
+                                                         is detected from the device. In Device mode, this interrupt is
+                                                         asserted when the utmiotg_bvalid signal goes high.
+                                                         For more information on how to use this interrupt, see "Partial
+                                                         Power-Down and Clock Gating Programming Model" on
+                                                         page 353. */
+	uint32_t disconnint                   : 1;  /**< Disconnect Detected Interrupt (DisconnInt)
+                                                         Asserted when a device disconnect is detected. */
+	uint32_t conidstschng                 : 1;  /**< Connector ID Status Change (ConIDStsChng)
+                                                         The core sets this bit when there is a change in connector ID
+                                                         status. */
+	uint32_t reserved_27_27               : 1;
+	uint32_t ptxfemp                      : 1;  /**< Periodic TxFIFO Empty (PTxFEmp)
+                                                         Asserted when the Periodic Transmit FIFO is either half or
+                                                         completely empty and there is space for at least one entry to be
+                                                         written in the Periodic Request Queue. The half or completely
+                                                         empty status is determined by the Periodic TxFIFO Empty Level
+                                                         bit in the Core AHB Configuration register
+                                                         (GAHBCFG.PTxFEmpLvl). */
+	uint32_t hchint                       : 1;  /**< Host Channels Interrupt (HChInt)
+                                                         The core sets this bit to indicate that an interrupt is pending on
+                                                         one of the channels of the core (in Host mode). The application
+                                                         must read the Host All Channels Interrupt (HAINT) register to
+                                                         determine the exact number of the channel on which the
+                                                         interrupt occurred, and then read the corresponding Host
+                                                         Channel-n Interrupt (HCINTn) register to determine the exact
+                                                         cause of the interrupt. The application must clear the
+                                                         appropriate status bit in the HCINTn register to clear this bit. */
+	uint32_t prtint                       : 1;  /**< Host Port Interrupt (PrtInt)
+                                                         The core sets this bit to indicate a change in port status of one
+                                                         of the O2P USB core ports in Host mode. The application must
+                                                         read the Host Port Control and Status (HPRT) register to
+                                                         determine the exact event that caused this interrupt. The
+                                                         application must clear the appropriate status bit in the Host Port
+                                                         Control and Status register to clear this bit. */
+	uint32_t reserved_23_23               : 1;
+	uint32_t fetsusp                      : 1;  /**< Data Fetch Suspended (FetSusp)
+                                                         This interrupt is valid only in DMA mode. This interrupt indicates
+                                                         that the core has stopped fetching data for IN endpoints due to
+                                                         the unavailability of TxFIFO space or Request Queue space.
+                                                         This interrupt is used by the application for an endpoint
+                                                         mismatch algorithm. */
+	uint32_t incomplp                     : 1;  /**< Incomplete Periodic Transfer (incomplP)
+                                                         In Host mode, the core sets this interrupt bit when there are
+                                                         incomplete periodic transactions still pending which are
+                                                         scheduled for the current microframe.
+                                                         Incomplete Isochronous OUT Transfer (incompISOOUT)
+                                                         The Device mode, the core sets this interrupt to indicate that
+                                                         there is at least one isochronous OUT endpoint on which the
+                                                         transfer is not completed in the current microframe. This
+                                                         interrupt is asserted along with the End of Periodic Frame
+                                                         Interrupt (EOPF) bit in this register. */
+	uint32_t incompisoin                  : 1;  /**< Incomplete Isochronous IN Transfer (incompISOIN)
+                                                         The core sets this interrupt to indicate that there is at least one
+                                                         isochronous IN endpoint on which the transfer is not completed
+                                                         in the current microframe. This interrupt is asserted along with
+                                                         the End of Periodic Frame Interrupt (EOPF) bit in this register. */
+	uint32_t oepint                       : 1;  /**< OUT Endpoints Interrupt (OEPInt)
+                                                         The core sets this bit to indicate that an interrupt is pending on
+                                                         one of the OUT endpoints of the core (in Device mode). The
+                                                         application must read the Device All Endpoints Interrupt
+                                                         (DAINT) register to determine the exact number of the OUT
+                                                         endpoint on which the interrupt occurred, and then read the
+                                                         corresponding Device OUT Endpoint-n Interrupt (DOEPINTn)
+                                                         register to determine the exact cause of the interrupt. The
+                                                         application must clear the appropriate status bit in the
+                                                         corresponding DOEPINTn register to clear this bit. */
+	uint32_t iepint                       : 1;  /**< IN Endpoints Interrupt (IEPInt)
+                                                         The core sets this bit to indicate that an interrupt is pending on
+                                                         one of the IN endpoints of the core (in Device mode). The
+                                                         application must read the Device All Endpoints Interrupt
+                                                         (DAINT) register to determine the exact number of the IN
+                                                         endpoint on which the interrupt occurred, and then read the
+                                                         corresponding Device IN Endpoint-n Interrupt (DIEPINTn)
+                                                         register to determine the exact cause of the interrupt. The
+                                                         application must clear the appropriate status bit in the
+                                                         corresponding DIEPINTn register to clear this bit. */
+	uint32_t epmis                        : 1;  /**< Endpoint Mismatch Interrupt (EPMis)
+                                                         Indicates that an IN token has been received for a non-periodic
+                                                         endpoint, but the data for another endpoint is present in the top
+                                                         of the Non-Periodic Transmit FIFO and the IN endpoint
+                                                         mismatch count programmed by the application has expired. */
+	uint32_t reserved_16_16               : 1;
+	uint32_t eopf                         : 1;  /**< End of Periodic Frame Interrupt (EOPF)
+                                                         Indicates that the period specified in the Periodic Frame Interval
+                                                         field of the Device Configuration register (DCFG.PerFrInt) has
+                                                         been reached in the current microframe. */
+	uint32_t isooutdrop                   : 1;  /**< Isochronous OUT Packet Dropped Interrupt (ISOOutDrop)
+                                                         The core sets this bit when it fails to write an isochronous OUT
+                                                         packet into the RxFIFO because the RxFIFO doesn't have
+                                                         enough space to accommodate a maximum packet size packet
+                                                         for the isochronous OUT endpoint. */
+	uint32_t enumdone                     : 1;  /**< Enumeration Done (EnumDone)
+                                                         The core sets this bit to indicate that speed enumeration is
+                                                         complete. The application must read the Device Status (DSTS)
+                                                         register to obtain the enumerated speed. */
+	uint32_t usbrst                       : 1;  /**< USB Reset (USBRst)
+                                                         The core sets this bit to indicate that a reset is detected on the
+                                                         USB. */
+	uint32_t usbsusp                      : 1;  /**< USB Suspend (USBSusp)
+                                                         The core sets this bit to indicate that a suspend was detected
+                                                         on the USB. The core enters the Suspended state when there
+                                                         is no activity on the phy_line_state_i signal for an extended
+                                                         period of time. */
+	uint32_t erlysusp                     : 1;  /**< Early Suspend (ErlySusp)
+                                                         The core sets this bit to indicate that an Idle state has been
+                                                         detected on the USB for 3 ms. */
+	uint32_t i2cint                       : 1;  /**< I2C Interrupt (I2CINT)
+                                                         This bit is always 0x0. */
+	uint32_t ulpickint                    : 1;  /**< ULPI Carkit Interrupt (ULPICKINT)
+                                                         This bit is always 0x0. */
+	uint32_t goutnakeff                   : 1;  /**< Global OUT NAK Effective (GOUTNakEff)
+                                                         Indicates that the Set Global OUT NAK bit in the Device Control
+                                                         register (DCTL.SGOUTNak), set by the application, has taken
+                                                         effect in the core. This bit can be cleared by writing the Clear
+                                                         Global OUT NAK bit in the Device Control register
+                                                         (DCTL.CGOUTNak). */
+	uint32_t ginnakeff                    : 1;  /**< Global IN Non-Periodic NAK Effective (GINNakEff)
+                                                         Indicates that the Set Global Non-Periodic IN NAK bit in the
+                                                         Device Control register (DCTL.SGNPInNak), set by the
+                                                         application, has taken effect in the core. That is, the core has
+                                                         sampled the Global IN NAK bit set by the application. This bit
+                                                         can be cleared by clearing the Clear Global Non-Periodic IN
+                                                         NAK bit in the Device Control register (DCTL.CGNPInNak).
+                                                         This interrupt does not necessarily mean that a NAK handshake
+                                                         is sent out on the USB. The STALL bit takes precedence over
+                                                         the NAK bit. */
+	uint32_t nptxfemp                     : 1;  /**< Non-Periodic TxFIFO Empty (NPTxFEmp)
+                                                         This interrupt is asserted when the Non-Periodic TxFIFO is
+                                                         either half or completely empty, and there is space for at least
+                                                         one entry to be written to the Non-Periodic Transmit Request
+                                                         Queue. The half or completely empty status is determined by
+                                                         the Non-Periodic TxFIFO Empty Level bit in the Core AHB
+                                                         Configuration register (GAHBCFG.NPTxFEmpLvl). */
+	uint32_t rxflvl                       : 1;  /**< RxFIFO Non-Empty (RxFLvl)
+                                                         Indicates that there is at least one packet pending to be read
+                                                         from the RxFIFO. */
+	uint32_t sof                          : 1;  /**< Start of (micro)Frame (Sof)
+                                                         In Host mode, the core sets this bit to indicate that an SOF
+                                                         (FS), micro-SOF (HS), or Keep-Alive (LS) is transmitted on the
+                                                         USB. The application must write a 1 to this bit to clear the
+                                                         interrupt.
+                                                         In Device mode, in the core sets this bit to indicate that an SOF
+                                                         token has been received on the USB. The application can read
+                                                         the Device Status register to get the current (micro)frame
+                                                         number. This interrupt is seen only when the core is operating
+                                                         at either HS or FS. */
+	uint32_t otgint                       : 1;  /**< OTG Interrupt (OTGInt)
+                                                         The core sets this bit to indicate an OTG protocol event. The
+                                                         application must read the OTG Interrupt Status (GOTGINT)
+                                                         register to determine the exact event that caused this interrupt.
+                                                         The application must clear the appropriate status bit in the
+                                                         GOTGINT register to clear this bit. */
+	uint32_t modemis                      : 1;  /**< Mode Mismatch Interrupt (ModeMis)
+                                                         The core sets this bit when the application is trying to access:
+                                                         * A Host mode register, when the core is operating in Device
+                                                         mode
+                                                         * A Device mode register, when the core is operating in Host
+                                                           mode
+                                                           The register access is completed on the AHB with an OKAY
+                                                           response, but is ignored by the core internally and doesn't
+                                                         affect the operation of the core. */
+	uint32_t curmod                       : 1;  /**< Current Mode of Operation (CurMod)
+                                                         Indicates the current mode of operation.
+                                                         * 1'b0: Device mode
+                                                         * 1'b1: Host mode */
+	} s;
+	struct cvmx_usbcx_gintsts_s           cn30xx;
+	struct cvmx_usbcx_gintsts_s           cn31xx;
+	struct cvmx_usbcx_gintsts_s           cn50xx;
+	struct cvmx_usbcx_gintsts_s           cn52xx;
+	struct cvmx_usbcx_gintsts_s           cn52xxp1;
+	struct cvmx_usbcx_gintsts_s           cn56xx;
+	struct cvmx_usbcx_gintsts_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_gintsts cvmx_usbcx_gintsts_t;
+
+/**
+ * cvmx_usbc#_gnptxfsiz
+ *
+ * Non-Periodic Transmit FIFO Size Register (GNPTXFSIZ)
+ *
+ * The application can program the RAM size and the memory start address for the Non-Periodic TxFIFO.
+ */
+union cvmx_usbcx_gnptxfsiz
+{
+	uint32_t u32;
+	struct cvmx_usbcx_gnptxfsiz_s
+	{
+	uint32_t nptxfdep                     : 16; /**< Non-Periodic TxFIFO Depth (NPTxFDep)
+                                                         This value is in terms of 32-bit words.
+                                                         Minimum value is 16
+                                                         Maximum value is 32768 */
+	uint32_t nptxfstaddr                  : 16; /**< Non-Periodic Transmit RAM Start Address (NPTxFStAddr)
+                                                         This field contains the memory start address for Non-Periodic
+                                                         Transmit FIFO RAM. */
+	} s;
+	struct cvmx_usbcx_gnptxfsiz_s         cn30xx;
+	struct cvmx_usbcx_gnptxfsiz_s         cn31xx;
+	struct cvmx_usbcx_gnptxfsiz_s         cn50xx;
+	struct cvmx_usbcx_gnptxfsiz_s         cn52xx;
+	struct cvmx_usbcx_gnptxfsiz_s         cn52xxp1;
+	struct cvmx_usbcx_gnptxfsiz_s         cn56xx;
+	struct cvmx_usbcx_gnptxfsiz_s         cn56xxp1;
+};
+typedef union cvmx_usbcx_gnptxfsiz cvmx_usbcx_gnptxfsiz_t;
+
+/**
+ * cvmx_usbc#_gnptxsts
+ *
+ * Non-Periodic Transmit FIFO/Queue Status Register (GNPTXSTS)
+ *
+ * This read-only register contains the free space information for the Non-Periodic TxFIFO and
+ * the Non-Periodic Transmit Request Queue
+ */
+union cvmx_usbcx_gnptxsts
+{
+	uint32_t u32;
+	struct cvmx_usbcx_gnptxsts_s
+	{
+	uint32_t reserved_31_31               : 1;
+	uint32_t nptxqtop                     : 7;  /**< Top of the Non-Periodic Transmit Request Queue (NPTxQTop)
+                                                         Entry in the Non-Periodic Tx Request Queue that is currently
+                                                         being processed by the MAC.
+                                                         * Bits [30:27]: Channel/endpoint number
+                                                         * Bits [26:25]:
+                                                           - 2'b00: IN/OUT token
+                                                           - 2'b01: Zero-length transmit packet (device IN/host OUT)
+                                                           - 2'b10: PING/CSPLIT token
+                                                           - 2'b11: Channel halt command
+                                                         * Bit [24]: Terminate (last entry for selected channel/endpoint) */
+	uint32_t nptxqspcavail                : 8;  /**< Non-Periodic Transmit Request Queue Space Available
+                                                         (NPTxQSpcAvail)
+                                                         Indicates the amount of free space available in the Non-
+                                                         Periodic Transmit Request Queue. This queue holds both IN
+                                                         and OUT requests in Host mode. Device mode has only IN
+                                                         requests.
+                                                         * 8'h0: Non-Periodic Transmit Request Queue is full
+                                                         * 8'h1: 1 location available
+                                                         * 8'h2: 2 locations available
+                                                         * n: n locations available (0..8)
+                                                         * Others: Reserved */
+	uint32_t nptxfspcavail                : 16; /**< Non-Periodic TxFIFO Space Avail (NPTxFSpcAvail)
+                                                         Indicates the amount of free space available in the Non-
+                                                         Periodic TxFIFO.
+                                                         Values are in terms of 32-bit words.
+                                                         * 16'h0: Non-Periodic TxFIFO is full
+                                                         * 16'h1: 1 word available
+                                                         * 16'h2: 2 words available
+                                                         * 16'hn: n words available (where 0..32768)
+                                                         * 16'h8000: 32768 words available
+                                                         * Others: Reserved */
+	} s;
+	struct cvmx_usbcx_gnptxsts_s          cn30xx;
+	struct cvmx_usbcx_gnptxsts_s          cn31xx;
+	struct cvmx_usbcx_gnptxsts_s          cn50xx;
+	struct cvmx_usbcx_gnptxsts_s          cn52xx;
+	struct cvmx_usbcx_gnptxsts_s          cn52xxp1;
+	struct cvmx_usbcx_gnptxsts_s          cn56xx;
+	struct cvmx_usbcx_gnptxsts_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_gnptxsts cvmx_usbcx_gnptxsts_t;
+
+/**
+ * cvmx_usbc#_gotgctl
+ *
+ * OTG Control and Status Register (GOTGCTL)
+ *
+ * The OTG Control and Status register controls the behavior and reflects the status of the OTG function of the core.:
+ */
+union cvmx_usbcx_gotgctl
+{
+	uint32_t u32;
+	struct cvmx_usbcx_gotgctl_s
+	{
+	uint32_t reserved_20_31               : 12;
+	uint32_t bsesvld                      : 1;  /**< B-Session Valid (BSesVld)
+                                                         Valid only when O2P USB core is configured as a USB device.
+                                                         Indicates the Device mode transceiver status.
+                                                         * 1'b0: B-session is not valid.
+                                                         * 1'b1: B-session is valid. */
+	uint32_t asesvld                      : 1;  /**< A-Session Valid (ASesVld)
+                                                         Valid only when O2P USB core is configured as a USB host.
+                                                         Indicates the Host mode transceiver status.
+                                                         * 1'b0: A-session is not valid
+                                                         * 1'b1: A-session is valid */
+	uint32_t dbnctime                     : 1;  /**< Long/Short Debounce Time (DbncTime)
+                                                         In the present version of the core this bit will only read as '0'. */
+	uint32_t conidsts                     : 1;  /**< Connector ID Status (ConIDSts)
+                                                         Indicates the connector ID status on a connect event.
+                                                         * 1'b0: The O2P USB core is in A-device mode
+                                                         * 1'b1: The O2P USB core is in B-device mode */
+	uint32_t reserved_12_15               : 4;
+	uint32_t devhnpen                     : 1;  /**< Device HNP Enabled (DevHNPEn)
+                                                         Since O2P USB core is not HNP capable this bit is 0x0. */
+	uint32_t hstsethnpen                  : 1;  /**< Host Set HNP Enable (HstSetHNPEn)
+                                                         Since O2P USB core is not HNP capable this bit is 0x0. */
+	uint32_t hnpreq                       : 1;  /**< HNP Request (HNPReq)
+                                                         Since O2P USB core is not HNP capable this bit is 0x0. */
+	uint32_t hstnegscs                    : 1;  /**< Host Negotiation Success (HstNegScs)
+                                                         Since O2P USB core is not HNP capable this bit is 0x0. */
+	uint32_t reserved_2_7                 : 6;
+	uint32_t sesreq                       : 1;  /**< Session Request (SesReq)
+                                                         Since O2P USB core is not SRP capable this bit is 0x0. */
+	uint32_t sesreqscs                    : 1;  /**< Session Request Success (SesReqScs)
+                                                         Since O2P USB core is not SRP capable this bit is 0x0. */
+	} s;
+	struct cvmx_usbcx_gotgctl_s           cn30xx;
+	struct cvmx_usbcx_gotgctl_s           cn31xx;
+	struct cvmx_usbcx_gotgctl_s           cn50xx;
+	struct cvmx_usbcx_gotgctl_s           cn52xx;
+	struct cvmx_usbcx_gotgctl_s           cn52xxp1;
+	struct cvmx_usbcx_gotgctl_s           cn56xx;
+	struct cvmx_usbcx_gotgctl_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_gotgctl cvmx_usbcx_gotgctl_t;
+
+/**
+ * cvmx_usbc#_gotgint
+ *
+ * OTG Interrupt Register (GOTGINT)
+ *
+ * The application reads this register whenever there is an OTG interrupt and clears the bits in this register
+ * to clear the OTG interrupt. It is shown in Interrupt .:
+ */
+union cvmx_usbcx_gotgint
+{
+	uint32_t u32;
+	struct cvmx_usbcx_gotgint_s
+	{
+	uint32_t reserved_20_31               : 12;
+	uint32_t dbncedone                    : 1;  /**< Debounce Done (DbnceDone)
+                                                         In the present version of the code this bit is tied to '0'. */
+	uint32_t adevtoutchg                  : 1;  /**< A-Device Timeout Change (ADevTOUTChg)
+                                                         Since O2P USB core is not HNP or SRP capable this bit is always 0x0. */
+	uint32_t hstnegdet                    : 1;  /**< Host Negotiation Detected (HstNegDet)
+                                                         Since O2P USB core is not HNP or SRP capable this bit is always 0x0. */
+	uint32_t reserved_10_16               : 7;
+	uint32_t hstnegsucstschng             : 1;  /**< Host Negotiation Success Status Change (HstNegSucStsChng)
+                                                         Since O2P USB core is not HNP or SRP capable this bit is always 0x0. */
+	uint32_t sesreqsucstschng             : 1;  /**< Session Request Success Status Change
+                                                         Since O2P USB core is not HNP or SRP capable this bit is always 0x0. */
+	uint32_t reserved_3_7                 : 5;
+	uint32_t sesenddet                    : 1;  /**< Session End Detected (SesEndDet)
+                                                         Since O2P USB core is not HNP or SRP capable this bit is always 0x0. */
+	uint32_t reserved_0_1                 : 2;
+	} s;
+	struct cvmx_usbcx_gotgint_s           cn30xx;
+	struct cvmx_usbcx_gotgint_s           cn31xx;
+	struct cvmx_usbcx_gotgint_s           cn50xx;
+	struct cvmx_usbcx_gotgint_s           cn52xx;
+	struct cvmx_usbcx_gotgint_s           cn52xxp1;
+	struct cvmx_usbcx_gotgint_s           cn56xx;
+	struct cvmx_usbcx_gotgint_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_gotgint cvmx_usbcx_gotgint_t;
+
+/**
+ * cvmx_usbc#_grstctl
+ *
+ * Core Reset Register (GRSTCTL)
+ *
+ * The application uses this register to reset various hardware features inside the core.
+ */
+union cvmx_usbcx_grstctl
+{
+	uint32_t u32;
+	struct cvmx_usbcx_grstctl_s
+	{
+	uint32_t ahbidle                      : 1;  /**< AHB Master Idle (AHBIdle)
+                                                         Indicates that the AHB Master State Machine is in the IDLE
+                                                         condition. */
+	uint32_t dmareq                       : 1;  /**< DMA Request Signal (DMAReq)
+                                                         Indicates that the DMA request is in progress. Used for debug. */
+	uint32_t reserved_11_29               : 19;
+	uint32_t txfnum                       : 5;  /**< TxFIFO Number (TxFNum)
+                                                         This is the FIFO number that must be flushed using the TxFIFO
+                                                         Flush bit. This field must not be changed until the core clears
+                                                         the TxFIFO Flush bit.
+                                                         * 5'h0: Non-Periodic TxFIFO flush
+                                                         * 5'h1: Periodic TxFIFO 1 flush in Device mode or Periodic
+                                                         TxFIFO flush in Host mode
+                                                         * 5'h2: Periodic TxFIFO 2 flush in Device mode
+                                                         - ...
+                                                         * 5'hF: Periodic TxFIFO 15 flush in Device mode
+                                                         * 5'h10: Flush all the Periodic and Non-Periodic TxFIFOs in the
+                                                         core */
+	uint32_t txfflsh                      : 1;  /**< TxFIFO Flush (TxFFlsh)
+                                                         This bit selectively flushes a single or all transmit FIFOs, but
+                                                         cannot do so if the core is in the midst of a transaction.
+                                                         The application must only write this bit after checking that the
+                                                         core is neither writing to the TxFIFO nor reading from the
+                                                         TxFIFO.
+                                                         The application must wait until the core clears this bit before
+                                                         performing any operations. This bit takes 8 clocks (of phy_clk or
+                                                         hclk, whichever is slower) to clear. */
+	uint32_t rxfflsh                      : 1;  /**< RxFIFO Flush (RxFFlsh)
+                                                         The application can flush the entire RxFIFO using this bit, but
+                                                         must first ensure that the core is not in the middle of a
+                                                         transaction.
+                                                         The application must only write to this bit after checking that the
+                                                         core is neither reading from the RxFIFO nor writing to the
+                                                         RxFIFO.
+                                                         The application must wait until the bit is cleared before
+                                                         performing any other operations. This bit will take 8 clocks
+                                                         (slowest of PHY or AHB clock) to clear. */
+	uint32_t intknqflsh                   : 1;  /**< IN Token Sequence Learning Queue Flush (INTknQFlsh)
+                                                         The application writes this bit to flush the IN Token Sequence
+                                                         Learning Queue. */
+	uint32_t frmcntrrst                   : 1;  /**< Host Frame Counter Reset (FrmCntrRst)
+                                                         The application writes this bit to reset the (micro)frame number
+                                                         counter inside the core. When the (micro)frame counter is reset,
+                                                         the subsequent SOF sent out by the core will have a
+                                                         (micro)frame number of 0. */
+	uint32_t hsftrst                      : 1;  /**< HClk Soft Reset (HSftRst)
+                                                         The application uses this bit to flush the control logic in the AHB
+                                                         Clock domain. Only AHB Clock Domain pipelines are reset.
+                                                         * FIFOs are not flushed with this bit.
+                                                         * All state machines in the AHB clock domain are reset to the
+                                                           Idle state after terminating the transactions on the AHB,
+                                                           following the protocol.
+                                                         * CSR control bits used by the AHB clock domain state
+                                                           machines are cleared.
+                                                         * To clear this interrupt, status mask bits that control the
+                                                           interrupt status and are generated by the AHB clock domain
+                                                           state machine are cleared.
+                                                         * Because interrupt status bits are not cleared, the application
+                                                           can get the status of any core events that occurred after it set
+                                                           this bit.
+                                                           This is a self-clearing bit that the core clears after all necessary
+                                                           logic is reset in the core. This may take several clocks,
+                                                           depending on the core's current state. */
+	uint32_t csftrst                      : 1;  /**< Core Soft Reset (CSftRst)
+                                                         Resets the hclk and phy_clock domains as follows:
+                                                         * Clears the interrupts and all the CSR registers except the
+                                                           following register bits:
+                                                           - PCGCCTL.RstPdwnModule
+                                                           - PCGCCTL.GateHclk
+                                                           - PCGCCTL.PwrClmp
+                                                           - PCGCCTL.StopPPhyLPwrClkSelclk
+                                                           - GUSBCFG.PhyLPwrClkSel
+                                                           - GUSBCFG.DDRSel
+                                                           - GUSBCFG.PHYSel
+                                                           - GUSBCFG.FSIntf
+                                                           - GUSBCFG.ULPI_UTMI_Sel
+                                                           - GUSBCFG.PHYIf
+                                                           - HCFG.FSLSPclkSel
+                                                           - DCFG.DevSpd
+                                                         * All module state machines (except the AHB Slave Unit) are
+                                                           reset to the IDLE state, and all the transmit FIFOs and the
+                                                           receive FIFO are flushed.
+                                                         * Any transactions on the AHB Master are terminated as soon
+                                                           as possible, after gracefully completing the last data phase of
+                                                           an AHB transfer. Any transactions on the USB are terminated
+                                                           immediately.
+                                                           The application can write to this bit any time it wants to reset
+                                                           the core. This is a self-clearing bit and the core clears this bit
+                                                           after all the necessary logic is reset in the core, which may take
+                                                           several clocks, depending on the current state of the core.
+                                                           Once this bit is cleared software should wait at least 3 PHY
+                                                           clocks before doing any access to the PHY domain
+                                                           (synchronization delay). Software should also should check that
+                                                           bit 31 of this register is 1 (AHB Master is IDLE) before starting
+                                                           any operation.
+                                                           Typically software reset is used during software development
+                                                           and also when you dynamically change the PHY selection bits
+                                                           in the USB configuration registers listed above. When you
+                                                           change the PHY, the corresponding clock for the PHY is
+                                                           selected and used in the PHY domain. Once a new clock is
+                                                           selected, the PHY domain has to be reset for proper operation. */
+	} s;
+	struct cvmx_usbcx_grstctl_s           cn30xx;
+	struct cvmx_usbcx_grstctl_s           cn31xx;
+	struct cvmx_usbcx_grstctl_s           cn50xx;
+	struct cvmx_usbcx_grstctl_s           cn52xx;
+	struct cvmx_usbcx_grstctl_s           cn52xxp1;
+	struct cvmx_usbcx_grstctl_s           cn56xx;
+	struct cvmx_usbcx_grstctl_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_grstctl cvmx_usbcx_grstctl_t;
+
+/**
+ * cvmx_usbc#_grxfsiz
+ *
+ * Receive FIFO Size Register (GRXFSIZ)
+ *
+ * The application can program the RAM size that must be allocated to the RxFIFO.
+ */
+union cvmx_usbcx_grxfsiz
+{
+	uint32_t u32;
+	struct cvmx_usbcx_grxfsiz_s
+	{
+	uint32_t reserved_16_31               : 16;
+	uint32_t rxfdep                       : 16; /**< RxFIFO Depth (RxFDep)
+                                                         This value is in terms of 32-bit words.
+                                                         * Minimum value is 16
+                                                         * Maximum value is 32768 */
+	} s;
+	struct cvmx_usbcx_grxfsiz_s           cn30xx;
+	struct cvmx_usbcx_grxfsiz_s           cn31xx;
+	struct cvmx_usbcx_grxfsiz_s           cn50xx;
+	struct cvmx_usbcx_grxfsiz_s           cn52xx;
+	struct cvmx_usbcx_grxfsiz_s           cn52xxp1;
+	struct cvmx_usbcx_grxfsiz_s           cn56xx;
+	struct cvmx_usbcx_grxfsiz_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_grxfsiz cvmx_usbcx_grxfsiz_t;
+
+/**
+ * cvmx_usbc#_grxstspd
+ *
+ * Receive Status Debug Read Register, Device Mode (GRXSTSPD)
+ *
+ * A read to the Receive Status Read and Pop register returns and additionally pops the top data entry out of the RxFIFO.
+ * This Description is only valid when the core is in Device Mode.  For Host Mode use USBC_GRXSTSPH instead.
+ * NOTE: GRXSTSPH and GRXSTSPD are physically the same register and share the same offset in the O2P USB core.
+ *       The offset difference shown in this document is for software clarity and is actually ignored by the
+ *       hardware.
+ */
+union cvmx_usbcx_grxstspd
+{
+	uint32_t u32;
+	struct cvmx_usbcx_grxstspd_s
+	{
+	uint32_t reserved_25_31               : 7;
+	uint32_t fn                           : 4;  /**< Frame Number (FN)
+                                                         This is the least significant 4 bits of the (micro)frame number in
+                                                         which the packet is received on the USB.  This field is supported
+                                                         only when the isochronous OUT endpoints are supported. */
+	uint32_t pktsts                       : 4;  /**< Packet Status (PktSts)
+                                                         Indicates the status of the received packet
+                                                         * 4'b0001: Glogal OUT NAK (triggers an interrupt)
+                                                         * 4'b0010: OUT data packet received
+                                                         * 4'b0100: SETUP transaction completed (triggers an interrupt)
+                                                         * 4'b0110: SETUP data packet received
+                                                         * Others: Reserved */
+	uint32_t dpid                         : 2;  /**< Data PID (DPID)
+                                                         * 2'b00: DATA0
+                                                         * 2'b10: DATA1
+                                                         * 2'b01: DATA2
+                                                         * 2'b11: MDATA */
+	uint32_t bcnt                         : 11; /**< Byte Count (BCnt)
+                                                         Indicates the byte count of the received data packet */
+	uint32_t epnum                        : 4;  /**< Endpoint Number (EPNum)
+                                                         Indicates the endpoint number to which the current received
+                                                         packet belongs. */
+	} s;
+	struct cvmx_usbcx_grxstspd_s          cn30xx;
+	struct cvmx_usbcx_grxstspd_s          cn31xx;
+	struct cvmx_usbcx_grxstspd_s          cn50xx;
+	struct cvmx_usbcx_grxstspd_s          cn52xx;
+	struct cvmx_usbcx_grxstspd_s          cn52xxp1;
+	struct cvmx_usbcx_grxstspd_s          cn56xx;
+	struct cvmx_usbcx_grxstspd_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_grxstspd cvmx_usbcx_grxstspd_t;
+
+/**
+ * cvmx_usbc#_grxstsph
+ *
+ * Receive Status Read and Pop Register, Host Mode (GRXSTSPH)
+ *
+ * A read to the Receive Status Read and Pop register returns and additionally pops the top data entry out of the RxFIFO.
+ * This Description is only valid when the core is in Host Mode.  For Device Mode use USBC_GRXSTSPD instead.
+ * NOTE: GRXSTSPH and GRXSTSPD are physically the same register and share the same offset in the O2P USB core.
+ *       The offset difference shown in this document is for software clarity and is actually ignored by the
+ *       hardware.
+ */
+union cvmx_usbcx_grxstsph
+{
+	uint32_t u32;
+	struct cvmx_usbcx_grxstsph_s
+	{
+	uint32_t reserved_21_31               : 11;
+	uint32_t pktsts                       : 4;  /**< Packet Status (PktSts)
+                                                         Indicates the status of the received packet
+                                                         * 4'b0010: IN data packet received
+                                                         * 4'b0011: IN transfer completed (triggers an interrupt)
+                                                         * 4'b0101: Data toggle error (triggers an interrupt)
+                                                         * 4'b0111: Channel halted (triggers an interrupt)
+                                                         * Others: Reserved */
+	uint32_t dpid                         : 2;  /**< Data PID (DPID)
+                                                         * 2'b00: DATA0
+                                                         * 2'b10: DATA1
+                                                         * 2'b01: DATA2
+                                                         * 2'b11: MDATA */
+	uint32_t bcnt                         : 11; /**< Byte Count (BCnt)
+                                                         Indicates the byte count of the received IN data packet */
+	uint32_t chnum                        : 4;  /**< Channel Number (ChNum)
+                                                         Indicates the channel number to which the current received
+                                                         packet belongs. */
+	} s;
+	struct cvmx_usbcx_grxstsph_s          cn30xx;
+	struct cvmx_usbcx_grxstsph_s          cn31xx;
+	struct cvmx_usbcx_grxstsph_s          cn50xx;
+	struct cvmx_usbcx_grxstsph_s          cn52xx;
+	struct cvmx_usbcx_grxstsph_s          cn52xxp1;
+	struct cvmx_usbcx_grxstsph_s          cn56xx;
+	struct cvmx_usbcx_grxstsph_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_grxstsph cvmx_usbcx_grxstsph_t;
+
+/**
+ * cvmx_usbc#_grxstsrd
+ *
+ * Receive Status Debug Read Register, Device Mode (GRXSTSRD)
+ *
+ * A read to the Receive Status Debug Read register returns the contents of the top of the Receive FIFO.
+ * This Description is only valid when the core is in Device Mode.  For Host Mode use USBC_GRXSTSRH instead.
+ * NOTE: GRXSTSRH and GRXSTSRD are physically the same register and share the same offset in the O2P USB core.
+ *       The offset difference shown in this document is for software clarity and is actually ignored by the
+ *       hardware.
+ */
+union cvmx_usbcx_grxstsrd
+{
+	uint32_t u32;
+	struct cvmx_usbcx_grxstsrd_s
+	{
+	uint32_t reserved_25_31               : 7;
+	uint32_t fn                           : 4;  /**< Frame Number (FN)
+                                                         This is the least significant 4 bits of the (micro)frame number in
+                                                         which the packet is received on the USB.  This field is supported
+                                                         only when the isochronous OUT endpoints are supported. */
+	uint32_t pktsts                       : 4;  /**< Packet Status (PktSts)
+                                                         Indicates the status of the received packet
+                                                         * 4'b0001: Glogal OUT NAK (triggers an interrupt)
+                                                         * 4'b0010: OUT data packet received
+                                                         * 4'b0100: SETUP transaction completed (triggers an interrupt)
+                                                         * 4'b0110: SETUP data packet received
+                                                         * Others: Reserved */
+	uint32_t dpid                         : 2;  /**< Data PID (DPID)
+                                                         * 2'b00: DATA0
+                                                         * 2'b10: DATA1
+                                                         * 2'b01: DATA2
+                                                         * 2'b11: MDATA */
+	uint32_t bcnt                         : 11; /**< Byte Count (BCnt)
+                                                         Indicates the byte count of the received data packet */
+	uint32_t epnum                        : 4;  /**< Endpoint Number (EPNum)
+                                                         Indicates the endpoint number to which the current received
+                                                         packet belongs. */
+	} s;
+	struct cvmx_usbcx_grxstsrd_s          cn30xx;
+	struct cvmx_usbcx_grxstsrd_s          cn31xx;
+	struct cvmx_usbcx_grxstsrd_s          cn50xx;
+	struct cvmx_usbcx_grxstsrd_s          cn52xx;
+	struct cvmx_usbcx_grxstsrd_s          cn52xxp1;
+	struct cvmx_usbcx_grxstsrd_s          cn56xx;
+	struct cvmx_usbcx_grxstsrd_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_grxstsrd cvmx_usbcx_grxstsrd_t;
+
+/**
+ * cvmx_usbc#_grxstsrh
+ *
+ * Receive Status Debug Read Register, Host Mode (GRXSTSRH)
+ *
+ * A read to the Receive Status Debug Read register returns the contents of the top of the Receive FIFO.
+ * This Description is only valid when the core is in Host Mode.  For Device Mode use USBC_GRXSTSRD instead.
+ * NOTE: GRXSTSRH and GRXSTSRD are physically the same register and share the same offset in the O2P USB core.
+ *       The offset difference shown in this document is for software clarity and is actually ignored by the
+ *       hardware.
+ */
+union cvmx_usbcx_grxstsrh
+{
+	uint32_t u32;
+	struct cvmx_usbcx_grxstsrh_s
+	{
+	uint32_t reserved_21_31               : 11;
+	uint32_t pktsts                       : 4;  /**< Packet Status (PktSts)
+                                                         Indicates the status of the received packet
+                                                         * 4'b0010: IN data packet received
+                                                         * 4'b0011: IN transfer completed (triggers an interrupt)
+                                                         * 4'b0101: Data toggle error (triggers an interrupt)
+                                                         * 4'b0111: Channel halted (triggers an interrupt)
+                                                         * Others: Reserved */
+	uint32_t dpid                         : 2;  /**< Data PID (DPID)
+                                                         * 2'b00: DATA0
+                                                         * 2'b10: DATA1
+                                                         * 2'b01: DATA2
+                                                         * 2'b11: MDATA */
+	uint32_t bcnt                         : 11; /**< Byte Count (BCnt)
+                                                         Indicates the byte count of the received IN data packet */
+	uint32_t chnum                        : 4;  /**< Channel Number (ChNum)
+                                                         Indicates the channel number to which the current received
+                                                         packet belongs. */
+	} s;
+	struct cvmx_usbcx_grxstsrh_s          cn30xx;
+	struct cvmx_usbcx_grxstsrh_s          cn31xx;
+	struct cvmx_usbcx_grxstsrh_s          cn50xx;
+	struct cvmx_usbcx_grxstsrh_s          cn52xx;
+	struct cvmx_usbcx_grxstsrh_s          cn52xxp1;
+	struct cvmx_usbcx_grxstsrh_s          cn56xx;
+	struct cvmx_usbcx_grxstsrh_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_grxstsrh cvmx_usbcx_grxstsrh_t;
+
+/**
+ * cvmx_usbc#_gsnpsid
+ *
+ * Synopsys ID Register (GSNPSID)
+ *
+ * This is a read-only register that contains the release number of the core being used.
+ */
+union cvmx_usbcx_gsnpsid
+{
+	uint32_t u32;
+	struct cvmx_usbcx_gsnpsid_s
+	{
+	uint32_t synopsysid                   : 32; /**< 0x4F54\<version\>A, release number of the core being used.
+                                                         0x4F54220A => pass1.x,  0x4F54240A => pass2.x */
+	} s;
+	struct cvmx_usbcx_gsnpsid_s           cn30xx;
+	struct cvmx_usbcx_gsnpsid_s           cn31xx;
+	struct cvmx_usbcx_gsnpsid_s           cn50xx;
+	struct cvmx_usbcx_gsnpsid_s           cn52xx;
+	struct cvmx_usbcx_gsnpsid_s           cn52xxp1;
+	struct cvmx_usbcx_gsnpsid_s           cn56xx;
+	struct cvmx_usbcx_gsnpsid_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_gsnpsid cvmx_usbcx_gsnpsid_t;
+
+/**
+ * cvmx_usbc#_gusbcfg
+ *
+ * Core USB Configuration Register (GUSBCFG)
+ *
+ * This register can be used to configure the core after power-on or a changing to Host mode or Device mode.
+ * It contains USB and USB-PHY related configuration parameters. The application must program this register
+ * before starting any transactions on either the AHB or the USB.
+ * Do not make changes to this register after the initial programming.
+ */
+union cvmx_usbcx_gusbcfg
+{
+	uint32_t u32;
+	struct cvmx_usbcx_gusbcfg_s
+	{
+	uint32_t reserved_17_31               : 15;
+	uint32_t otgi2csel                    : 1;  /**< UTMIFS or I2C Interface Select (OtgI2CSel)
+                                                         This bit is always 0x0. */
+	uint32_t phylpwrclksel                : 1;  /**< PHY Low-Power Clock Select (PhyLPwrClkSel)
+                                                         Software should set this bit to 0x0.
+                                                         Selects either 480-MHz or 48-MHz (low-power) PHY mode. In
+                                                         FS and LS modes, the PHY can usually operate on a 48-MHz
+                                                         clock to save power.
+                                                         * 1'b0: 480-MHz Internal PLL clock
+                                                         * 1'b1: 48-MHz External Clock
+                                                         In 480 MHz mode, the UTMI interface operates at either 60 or
+                                                         30-MHz, depending upon whether 8- or 16-bit data width is
+                                                         selected. In 48-MHz mode, the UTMI interface operates at 48
+                                                         MHz in FS mode and at either 48 or 6 MHz in LS mode
+                                                         (depending on the PHY vendor).
+                                                         This bit drives the utmi_fsls_low_power core output signal, and
+                                                         is valid only for UTMI+ PHYs. */
+	uint32_t reserved_14_14               : 1;
+	uint32_t usbtrdtim                    : 4;  /**< USB Turnaround Time (USBTrdTim)
+                                                         Sets the turnaround time in PHY clocks.
+                                                         Specifies the response time for a MAC request to the Packet
+                                                         FIFO Controller (PFC) to fetch data from the DFIFO (SPRAM).
+                                                         This must be programmed to 0x5. */
+	uint32_t hnpcap                       : 1;  /**< HNP-Capable (HNPCap)
+                                                         This bit is always 0x0. */
+	uint32_t srpcap                       : 1;  /**< SRP-Capable (SRPCap)
+                                                         This bit is always 0x0. */
+	uint32_t ddrsel                       : 1;  /**< ULPI DDR Select (DDRSel)
+                                                         Software should set this bit to 0x0. */
+	uint32_t physel                       : 1;  /**< USB 2.0 High-Speed PHY or USB 1.1 Full-Speed Serial
+                                                         Software should set this bit to 0x0. */
+	uint32_t fsintf                       : 1;  /**< Full-Speed Serial Interface Select (FSIntf)
+                                                         Software should set this bit to 0x0. */
+	uint32_t ulpi_utmi_sel                : 1;  /**< ULPI or UTMI+ Select (ULPI_UTMI_Sel)
+                                                         This bit is always 0x0. */
+	uint32_t phyif                        : 1;  /**< PHY Interface (PHYIf)
+                                                         This bit is always 0x1. */
+	uint32_t toutcal                      : 3;  /**< HS/FS Timeout Calibration (TOutCal)
+                                                         The number of PHY clocks that the application programs in this
+                                                         field is added to the high-speed/full-speed interpacket timeout
+                                                         duration in the core to account for any additional delays
+                                                         introduced by the PHY. This may be required, since the delay
+                                                         introduced by the PHY in generating the linestate condition may
+                                                         vary from one PHY to another.
+                                                         The USB standard timeout value for high-speed operation is
+                                                         736 to 816 (inclusive) bit times. The USB standard timeout
+                                                         value for full-speed operation is 16 to 18 (inclusive) bit times.
+                                                         The application must program this field based on the speed of
+                                                         enumeration. The number of bit times added per PHY clock are:
+                                                         High-speed operation:
+                                                         * One 30-MHz PHY clock = 16 bit times
+                                                         * One 60-MHz PHY clock = 8 bit times
+                                                         Full-speed operation:
+                                                         * One 30-MHz PHY clock = 0.4 bit times
+                                                         * One 60-MHz PHY clock = 0.2 bit times
+                                                         * One 48-MHz PHY clock = 0.25 bit times */
+	} s;
+	struct cvmx_usbcx_gusbcfg_s           cn30xx;
+	struct cvmx_usbcx_gusbcfg_s           cn31xx;
+	struct cvmx_usbcx_gusbcfg_s           cn50xx;
+	struct cvmx_usbcx_gusbcfg_s           cn52xx;
+	struct cvmx_usbcx_gusbcfg_s           cn52xxp1;
+	struct cvmx_usbcx_gusbcfg_s           cn56xx;
+	struct cvmx_usbcx_gusbcfg_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_gusbcfg cvmx_usbcx_gusbcfg_t;
+
+/**
+ * cvmx_usbc#_haint
+ *
+ * Host All Channels Interrupt Register (HAINT)
+ *
+ * When a significant event occurs on a channel, the Host All Channels Interrupt register
+ * interrupts the application using the Host Channels Interrupt bit of the Core Interrupt
+ * register (GINTSTS.HChInt). This is shown in Interrupt . There is one interrupt bit per
+ * channel, up to a maximum of 16 bits. Bits in this register are set and cleared when the
+ * application sets and clears bits in the corresponding Host Channel-n Interrupt register.
+ */
+union cvmx_usbcx_haint
+{
+	uint32_t u32;
+	struct cvmx_usbcx_haint_s
+	{
+	uint32_t reserved_16_31               : 16;
+	uint32_t haint                        : 16; /**< Channel Interrupts (HAINT)
+                                                         One bit per channel: Bit 0 for Channel 0, bit 15 for Channel 15 */
+	} s;
+	struct cvmx_usbcx_haint_s             cn30xx;
+	struct cvmx_usbcx_haint_s             cn31xx;
+	struct cvmx_usbcx_haint_s             cn50xx;
+	struct cvmx_usbcx_haint_s             cn52xx;
+	struct cvmx_usbcx_haint_s             cn52xxp1;
+	struct cvmx_usbcx_haint_s             cn56xx;
+	struct cvmx_usbcx_haint_s             cn56xxp1;
+};
+typedef union cvmx_usbcx_haint cvmx_usbcx_haint_t;
+
+/**
+ * cvmx_usbc#_haintmsk
+ *
+ * Host All Channels Interrupt Mask Register (HAINTMSK)
+ *
+ * The Host All Channel Interrupt Mask register works with the Host All Channel Interrupt
+ * register to interrupt the application when an event occurs on a channel. There is one
+ * interrupt mask bit per channel, up to a maximum of 16 bits.
+ * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
+ */
+union cvmx_usbcx_haintmsk
+{
+	uint32_t u32;
+	struct cvmx_usbcx_haintmsk_s
+	{
+	uint32_t reserved_16_31               : 16;
+	uint32_t haintmsk                     : 16; /**< Channel Interrupt Mask (HAINTMsk)
+                                                         One bit per channel: Bit 0 for channel 0, bit 15 for channel 15 */
+	} s;
+	struct cvmx_usbcx_haintmsk_s          cn30xx;
+	struct cvmx_usbcx_haintmsk_s          cn31xx;
+	struct cvmx_usbcx_haintmsk_s          cn50xx;
+	struct cvmx_usbcx_haintmsk_s          cn52xx;
+	struct cvmx_usbcx_haintmsk_s          cn52xxp1;
+	struct cvmx_usbcx_haintmsk_s          cn56xx;
+	struct cvmx_usbcx_haintmsk_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_haintmsk cvmx_usbcx_haintmsk_t;
+
+/**
+ * cvmx_usbc#_hcchar#
+ *
+ * Host Channel-n Characteristics Register (HCCHAR)
+ *
+ */
+union cvmx_usbcx_hccharx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hccharx_s
+	{
+	uint32_t chena                        : 1;  /**< Channel Enable (ChEna)
+                                                         This field is set by the application and cleared by the OTG host.
+                                                         * 1'b0: Channel disabled
+                                                         * 1'b1: Channel enabled */
+	uint32_t chdis                        : 1;  /**< Channel Disable (ChDis)
+                                                         The application sets this bit to stop transmitting/receiving data
+                                                         on a channel, even before the transfer for that channel is
+                                                         complete. The application must wait for the Channel Disabled
+                                                         interrupt before treating the channel as disabled. */
+	uint32_t oddfrm                       : 1;  /**< Odd Frame (OddFrm)
+                                                         This field is set (reset) by the application to indicate that the
+                                                         OTG host must perform a transfer in an odd (micro)frame. This
+                                                         field is applicable for only periodic (isochronous and interrupt)
+                                                         transactions.
+                                                         * 1'b0: Even (micro)frame
+                                                         * 1'b1: Odd (micro)frame */
+	uint32_t devaddr                      : 7;  /**< Device Address (DevAddr)
+                                                         This field selects the specific device serving as the data source
+                                                         or sink. */
+	uint32_t ec                           : 2;  /**< Multi Count (MC) / Error Count (EC)
+                                                         When the Split Enable bit of the Host Channel-n Split Control
+                                                         register (HCSPLTn.SpltEna) is reset (1'b0), this field indicates
+                                                         to the host the number of transactions that should be executed
+                                                         per microframe for this endpoint.
+                                                         * 2'b00: Reserved. This field yields undefined results.
+                                                         * 2'b01: 1 transaction
+                                                         * 2'b10: 2 transactions to be issued for this endpoint per
+                                                                  microframe
+                                                         * 2'b11: 3 transactions to be issued for this endpoint per
+                                                                  microframe
+                                                         When HCSPLTn.SpltEna is set (1'b1), this field indicates the
+                                                         number of immediate retries to be performed for a periodic split
+                                                         transactions on transaction errors. This field must be set to at
+                                                         least 2'b01. */
+	uint32_t eptype                       : 2;  /**< Endpoint Type (EPType)
+                                                         Indicates the transfer type selected.
+                                                         * 2'b00: Control
+                                                         * 2'b01: Isochronous
+                                                         * 2'b10: Bulk
+                                                         * 2'b11: Interrupt */
+	uint32_t lspddev                      : 1;  /**< Low-Speed Device (LSpdDev)
+                                                         This field is set by the application to indicate that this channel is
+                                                         communicating to a low-speed device. */
+	uint32_t reserved_16_16               : 1;
+	uint32_t epdir                        : 1;  /**< Endpoint Direction (EPDir)
+                                                         Indicates whether the transaction is IN or OUT.
+                                                         * 1'b0: OUT
+                                                         * 1'b1: IN */
+	uint32_t epnum                        : 4;  /**< Endpoint Number (EPNum)
+                                                         Indicates the endpoint number on the device serving as the
+                                                         data source or sink. */
+	uint32_t mps                          : 11; /**< Maximum Packet Size (MPS)
+                                                         Indicates the maximum packet size of the associated endpoint. */
+	} s;
+	struct cvmx_usbcx_hccharx_s           cn30xx;
+	struct cvmx_usbcx_hccharx_s           cn31xx;
+	struct cvmx_usbcx_hccharx_s           cn50xx;
+	struct cvmx_usbcx_hccharx_s           cn52xx;
+	struct cvmx_usbcx_hccharx_s           cn52xxp1;
+	struct cvmx_usbcx_hccharx_s           cn56xx;
+	struct cvmx_usbcx_hccharx_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_hccharx cvmx_usbcx_hccharx_t;
+
+/**
+ * cvmx_usbc#_hcfg
+ *
+ * Host Configuration Register (HCFG)
+ *
+ * This register configures the core after power-on. Do not make changes to this register after initializing the host.
+ */
+union cvmx_usbcx_hcfg
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hcfg_s
+	{
+	uint32_t reserved_3_31                : 29;
+	uint32_t fslssupp                     : 1;  /**< FS- and LS-Only Support (FSLSSupp)
+                                                         The application uses this bit to control the core's enumeration
+                                                         speed. Using this bit, the application can make the core
+                                                         enumerate as a FS host, even if the connected device supports
+                                                         HS traffic. Do not make changes to this field after initial
+                                                         programming.
+                                                         * 1'b0: HS/FS/LS, based on the maximum speed supported by
+                                                           the connected device
+                                                         * 1'b1: FS/LS-only, even if the connected device can support HS */
+	uint32_t fslspclksel                  : 2;  /**< FS/LS PHY Clock Select (FSLSPclkSel)
+                                                         When the core is in FS Host mode
+                                                         * 2'b00: PHY clock is running at 30/60 MHz
+                                                         * 2'b01: PHY clock is running at 48 MHz
+                                                         * Others: Reserved
+                                                         When the core is in LS Host mode
+                                                         * 2'b00: PHY clock is running at 30/60 MHz. When the
+                                                                  UTMI+/ULPI PHY Low Power mode is not selected, use
+                                                                  30/60 MHz.
+                                                         * 2'b01: PHY clock is running at 48 MHz. When the UTMI+
+                                                                  PHY Low Power mode is selected, use 48MHz if the PHY
+                                                                  supplies a 48 MHz clock during LS mode.
+                                                         * 2'b10: PHY clock is running at 6 MHz. In USB 1.1 FS mode,
+                                                                  use 6 MHz when the UTMI+ PHY Low Power mode is
+                                                                  selected and the PHY supplies a 6 MHz clock during LS
+                                                                  mode. If you select a 6 MHz clock during LS mode, you must
+                                                                  do a soft reset.
+                                                         * 2'b11: Reserved */
+	} s;
+	struct cvmx_usbcx_hcfg_s              cn30xx;
+	struct cvmx_usbcx_hcfg_s              cn31xx;
+	struct cvmx_usbcx_hcfg_s              cn50xx;
+	struct cvmx_usbcx_hcfg_s              cn52xx;
+	struct cvmx_usbcx_hcfg_s              cn52xxp1;
+	struct cvmx_usbcx_hcfg_s              cn56xx;
+	struct cvmx_usbcx_hcfg_s              cn56xxp1;
+};
+typedef union cvmx_usbcx_hcfg cvmx_usbcx_hcfg_t;
+
+/**
+ * cvmx_usbc#_hcint#
+ *
+ * Host Channel-n Interrupt Register (HCINT)
+ *
+ * This register indicates the status of a channel with respect to USB- and AHB-related events.
+ * The application must read this register when the Host Channels Interrupt bit of the Core Interrupt
+ * register (GINTSTS.HChInt) is set. Before the application can read this register, it must first read
+ * the Host All Channels Interrupt (HAINT) register to get the exact channel number for the Host Channel-n
+ * Interrupt register. The application must clear the appropriate bit in this register to clear the
+ * corresponding bits in the HAINT and GINTSTS registers.
+ */
+union cvmx_usbcx_hcintx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hcintx_s
+	{
+	uint32_t reserved_11_31               : 21;
+	uint32_t datatglerr                   : 1;  /**< Data Toggle Error (DataTglErr) */
+	uint32_t frmovrun                     : 1;  /**< Frame Overrun (FrmOvrun) */
+	uint32_t bblerr                       : 1;  /**< Babble Error (BblErr) */
+	uint32_t xacterr                      : 1;  /**< Transaction Error (XactErr) */
+	uint32_t nyet                         : 1;  /**< NYET Response Received Interrupt (NYET) */
+	uint32_t ack                          : 1;  /**< ACK Response Received Interrupt (ACK) */
+	uint32_t nak                          : 1;  /**< NAK Response Received Interrupt (NAK) */
+	uint32_t stall                        : 1;  /**< STALL Response Received Interrupt (STALL) */
+	uint32_t ahberr                       : 1;  /**< This bit is always 0x0. */
+	uint32_t chhltd                       : 1;  /**< Channel Halted (ChHltd)
+                                                         Indicates the transfer completed abnormally either because of
+                                                         any USB transaction error or in response to disable request by
+                                                         the application. */
+	uint32_t xfercompl                    : 1;  /**< Transfer Completed (XferCompl)
+                                                         Transfer completed normally without any errors. */
+	} s;
+	struct cvmx_usbcx_hcintx_s            cn30xx;
+	struct cvmx_usbcx_hcintx_s            cn31xx;
+	struct cvmx_usbcx_hcintx_s            cn50xx;
+	struct cvmx_usbcx_hcintx_s            cn52xx;
+	struct cvmx_usbcx_hcintx_s            cn52xxp1;
+	struct cvmx_usbcx_hcintx_s            cn56xx;
+	struct cvmx_usbcx_hcintx_s            cn56xxp1;
+};
+typedef union cvmx_usbcx_hcintx cvmx_usbcx_hcintx_t;
+
+/**
+ * cvmx_usbc#_hcintmsk#
+ *
+ * Host Channel-n Interrupt Mask Register (HCINTMSKn)
+ *
+ * This register reflects the mask for each channel status described in the previous section.
+ * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
+ */
+union cvmx_usbcx_hcintmskx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hcintmskx_s
+	{
+	uint32_t reserved_11_31               : 21;
+	uint32_t datatglerrmsk                : 1;  /**< Data Toggle Error Mask (DataTglErrMsk) */
+	uint32_t frmovrunmsk                  : 1;  /**< Frame Overrun Mask (FrmOvrunMsk) */
+	uint32_t bblerrmsk                    : 1;  /**< Babble Error Mask (BblErrMsk) */
+	uint32_t xacterrmsk                   : 1;  /**< Transaction Error Mask (XactErrMsk) */
+	uint32_t nyetmsk                      : 1;  /**< NYET Response Received Interrupt Mask (NyetMsk) */
+	uint32_t ackmsk                       : 1;  /**< ACK Response Received Interrupt Mask (AckMsk) */
+	uint32_t nakmsk                       : 1;  /**< NAK Response Received Interrupt Mask (NakMsk) */
+	uint32_t stallmsk                     : 1;  /**< STALL Response Received Interrupt Mask (StallMsk) */
+	uint32_t ahberrmsk                    : 1;  /**< AHB Error Mask (AHBErrMsk) */
+	uint32_t chhltdmsk                    : 1;  /**< Channel Halted Mask (ChHltdMsk) */
+	uint32_t xfercomplmsk                 : 1;  /**< Transfer Completed Mask (XferComplMsk) */
+	} s;
+	struct cvmx_usbcx_hcintmskx_s         cn30xx;
+	struct cvmx_usbcx_hcintmskx_s         cn31xx;
+	struct cvmx_usbcx_hcintmskx_s         cn50xx;
+	struct cvmx_usbcx_hcintmskx_s         cn52xx;
+	struct cvmx_usbcx_hcintmskx_s         cn52xxp1;
+	struct cvmx_usbcx_hcintmskx_s         cn56xx;
+	struct cvmx_usbcx_hcintmskx_s         cn56xxp1;
+};
+typedef union cvmx_usbcx_hcintmskx cvmx_usbcx_hcintmskx_t;
+
+/**
+ * cvmx_usbc#_hcsplt#
+ *
+ * Host Channel-n Split Control Register (HCSPLT)
+ *
+ */
+union cvmx_usbcx_hcspltx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hcspltx_s
+	{
+	uint32_t spltena                      : 1;  /**< Split Enable (SpltEna)
+                                                         The application sets this field to indicate that this channel is
+                                                         enabled to perform split transactions. */
+	uint32_t reserved_17_30               : 14;
+	uint32_t compsplt                     : 1;  /**< Do Complete Split (CompSplt)
+                                                         The application sets this field to request the OTG host to
+                                                         perform a complete split transaction. */
+	uint32_t xactpos                      : 2;  /**< Transaction Position (XactPos)
+                                                         This field is used to determine whether to send all, first, middle,
+                                                         or last payloads with each OUT transaction.
+                                                         * 2'b11: All. This is the entire data payload is of this transaction
+                                                                  (which is less than or equal to 188 bytes).
+                                                         * 2'b10: Begin. This is the first data payload of this transaction
+                                                                  (which is larger than 188 bytes).
+                                                         * 2'b00: Mid. This is the middle payload of this transaction
+                                                                  (which is larger than 188 bytes).
+                                                         * 2'b01: End. This is the last payload of this transaction (which
+                                                                  is larger than 188 bytes). */
+	uint32_t hubaddr                      : 7;  /**< Hub Address (HubAddr)
+                                                         This field holds the device address of the transaction
+                                                         translator's hub. */
+	uint32_t prtaddr                      : 7;  /**< Port Address (PrtAddr)
+                                                         This field is the port number of the recipient transaction
+                                                         translator. */
+	} s;
+	struct cvmx_usbcx_hcspltx_s           cn30xx;
+	struct cvmx_usbcx_hcspltx_s           cn31xx;
+	struct cvmx_usbcx_hcspltx_s           cn50xx;
+	struct cvmx_usbcx_hcspltx_s           cn52xx;
+	struct cvmx_usbcx_hcspltx_s           cn52xxp1;
+	struct cvmx_usbcx_hcspltx_s           cn56xx;
+	struct cvmx_usbcx_hcspltx_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_hcspltx cvmx_usbcx_hcspltx_t;
+
+/**
+ * cvmx_usbc#_hctsiz#
+ *
+ * Host Channel-n Transfer Size Register (HCTSIZ)
+ *
+ */
+union cvmx_usbcx_hctsizx
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hctsizx_s
+	{
+	uint32_t dopng                        : 1;  /**< Do Ping (DoPng)
+                                                         Setting this field to 1 directs the host to do PING protocol. */
+	uint32_t pid                          : 2;  /**< PID (Pid)
+                                                         The application programs this field with the type of PID to use
+                                                         for the initial transaction. The host will maintain this field for the
+                                                         rest of the transfer.
+                                                         * 2'b00: DATA0
+                                                         * 2'b01: DATA2
+                                                         * 2'b10: DATA1
+                                                         * 2'b11: MDATA (non-control)/SETUP (control) */
+	uint32_t pktcnt                       : 10; /**< Packet Count (PktCnt)
+                                                         This field is programmed by the application with the expected
+                                                         number of packets to be transmitted (OUT) or received (IN).
+                                                         The host decrements this count on every successful
+                                                         transmission or reception of an OUT/IN packet. Once this count
+                                                         reaches zero, the application is interrupted to indicate normal
+                                                         completion. */
+	uint32_t xfersize                     : 19; /**< Transfer Size (XferSize)
+                                                         For an OUT, this field is the number of data bytes the host will
+                                                         send during the transfer.
+                                                         For an IN, this field is the buffer size that the application has
+                                                         reserved for the transfer. The application is expected to
+                                                         program this field as an integer multiple of the maximum packet
+                                                         size for IN transactions (periodic and non-periodic). */
+	} s;
+	struct cvmx_usbcx_hctsizx_s           cn30xx;
+	struct cvmx_usbcx_hctsizx_s           cn31xx;
+	struct cvmx_usbcx_hctsizx_s           cn50xx;
+	struct cvmx_usbcx_hctsizx_s           cn52xx;
+	struct cvmx_usbcx_hctsizx_s           cn52xxp1;
+	struct cvmx_usbcx_hctsizx_s           cn56xx;
+	struct cvmx_usbcx_hctsizx_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_hctsizx cvmx_usbcx_hctsizx_t;
+
+/**
+ * cvmx_usbc#_hfir
+ *
+ * Host Frame Interval Register (HFIR)
+ *
+ * This register stores the frame interval information for the current speed to which the O2P USB core has enumerated.
+ */
+union cvmx_usbcx_hfir
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hfir_s
+	{
+	uint32_t reserved_16_31               : 16;
+	uint32_t frint                        : 16; /**< Frame Interval (FrInt)
+                                                         The value that the application programs to this field specifies
+                                                         the interval between two consecutive SOFs (FS) or micro-
+                                                         SOFs (HS) or Keep-Alive tokens (HS). This field contains the
+                                                         number of PHY clocks that constitute the required frame
+                                                         interval. The default value set in this field for a FS operation
+                                                         when the PHY clock frequency is 60 MHz. The application can
+                                                         write a value to this register only after the Port Enable bit of
+                                                         the Host Port Control and Status register (HPRT.PrtEnaPort)
+                                                         has been set. If no value is programmed, the core calculates
+                                                         the value based on the PHY clock specified in the FS/LS PHY
+                                                         Clock Select field of the Host Configuration register
+                                                         (HCFG.FSLSPclkSel). Do not change the value of this field
+                                                         after the initial configuration.
+                                                         * 125 us (PHY clock frequency for HS)
+                                                         * 1 ms (PHY clock frequency for FS/LS) */
+	} s;
+	struct cvmx_usbcx_hfir_s              cn30xx;
+	struct cvmx_usbcx_hfir_s              cn31xx;
+	struct cvmx_usbcx_hfir_s              cn50xx;
+	struct cvmx_usbcx_hfir_s              cn52xx;
+	struct cvmx_usbcx_hfir_s              cn52xxp1;
+	struct cvmx_usbcx_hfir_s              cn56xx;
+	struct cvmx_usbcx_hfir_s              cn56xxp1;
+};
+typedef union cvmx_usbcx_hfir cvmx_usbcx_hfir_t;
+
+/**
+ * cvmx_usbc#_hfnum
+ *
+ * Host Frame Number/Frame Time Remaining Register (HFNUM)
+ *
+ * This register indicates the current frame number.
+ * It also indicates the time remaining (in terms of the number of PHY clocks)
+ * in the current (micro)frame.
+ */
+union cvmx_usbcx_hfnum
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hfnum_s
+	{
+	uint32_t frrem                        : 16; /**< Frame Time Remaining (FrRem)
+                                                         Indicates the amount of time remaining in the current
+                                                         microframe (HS) or frame (FS/LS), in terms of PHY clocks.
+                                                         This field decrements on each PHY clock. When it reaches
+                                                         zero, this field is reloaded with the value in the Frame Interval
+                                                         register and a new SOF is transmitted on the USB. */
+	uint32_t frnum                        : 16; /**< Frame Number (FrNum)
+                                                         This field increments when a new SOF is transmitted on the
+                                                         USB, and is reset to 0 when it reaches 16'h3FFF. */
+	} s;
+	struct cvmx_usbcx_hfnum_s             cn30xx;
+	struct cvmx_usbcx_hfnum_s             cn31xx;
+	struct cvmx_usbcx_hfnum_s             cn50xx;
+	struct cvmx_usbcx_hfnum_s             cn52xx;
+	struct cvmx_usbcx_hfnum_s             cn52xxp1;
+	struct cvmx_usbcx_hfnum_s             cn56xx;
+	struct cvmx_usbcx_hfnum_s             cn56xxp1;
+};
+typedef union cvmx_usbcx_hfnum cvmx_usbcx_hfnum_t;
+
+/**
+ * cvmx_usbc#_hprt
+ *
+ * Host Port Control and Status Register (HPRT)
+ *
+ * This register is available in both Host and Device modes.
+ * Currently, the OTG Host supports only one port.
+ * A single register holds USB port-related information such as USB reset, enable, suspend, resume,
+ * connect status, and test mode for each port. The R_SS_WC bits in this register can trigger an
+ * interrupt to the application through the Host Port Interrupt bit of the Core Interrupt
+ * register (GINTSTS.PrtInt). On a Port Interrupt, the application must read this register and clear
+ * the bit that caused the interrupt. For the R_SS_WC bits, the application must write a 1 to the bit
+ * to clear the interrupt.
+ */
+union cvmx_usbcx_hprt
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hprt_s
+	{
+	uint32_t reserved_19_31               : 13;
+	uint32_t prtspd                       : 2;  /**< Port Speed (PrtSpd)
+                                                         Indicates the speed of the device attached to this port.
+                                                         * 2'b00: High speed
+                                                         * 2'b01: Full speed
+                                                         * 2'b10: Low speed
+                                                         * 2'b11: Reserved */
+	uint32_t prttstctl                    : 4;  /**< Port Test Control (PrtTstCtl)
+                                                         The application writes a nonzero value to this field to put
+                                                         the port into a Test mode, and the corresponding pattern is
+                                                         signaled on the port.
+                                                         * 4'b0000: Test mode disabled
+                                                         * 4'b0001: Test_J mode
+                                                         * 4'b0010: Test_K mode
+                                                         * 4'b0011: Test_SE0_NAK mode
+                                                         * 4'b0100: Test_Packet mode
+                                                         * 4'b0101: Test_Force_Enable
+                                                         * Others: Reserved
+                                                         PrtSpd must be zero (i.e. the interface must be in high-speed
+                                                         mode) to use the PrtTstCtl test modes. */
+	uint32_t prtpwr                       : 1;  /**< Port Power (PrtPwr)
+                                                         The application uses this field to control power to this port,
+                                                         and the core clears this bit on an overcurrent condition.
+                                                         * 1'b0: Power off
+                                                         * 1'b1: Power on */
+	uint32_t prtlnsts                     : 2;  /**< Port Line Status (PrtLnSts)
+                                                         Indicates the current logic level USB data lines
+                                                         * Bit [10]: Logic level of D-
+                                                         * Bit [11]: Logic level of D+ */
+	uint32_t reserved_9_9                 : 1;
+	uint32_t prtrst                       : 1;  /**< Port Reset (PrtRst)
+                                                         When the application sets this bit, a reset sequence is
+                                                         started on this port. The application must time the reset
+                                                         period and clear this bit after the reset sequence is
+                                                         complete.
+                                                         * 1'b0: Port not in reset
+                                                         * 1'b1: Port in reset
+                                                         The application must leave this bit set for at least a
+                                                         minimum duration mentioned below to start a reset on the
+                                                         port. The application can leave it set for another 10 ms in
+                                                         addition to the required minimum duration, before clearing
+                                                         the bit, even though there is no maximum limit set by the
+                                                         USB standard.
+                                                         * High speed: 50 ms
+                                                         * Full speed/Low speed: 10 ms */
+	uint32_t prtsusp                      : 1;  /**< Port Suspend (PrtSusp)
+                                                         The application sets this bit to put this port in Suspend
+                                                         mode. The core only stops sending SOFs when this is set.
+                                                         To stop the PHY clock, the application must set the Port
+                                                         Clock Stop bit, which will assert the suspend input pin of
+                                                         the PHY.
+                                                         The read value of this bit reflects the current suspend
+                                                         status of the port. This bit is cleared by the core after a
+                                                         remote wakeup signal is detected or the application sets
+                                                         the Port Reset bit or Port Resume bit in this register or the
+                                                         Resume/Remote Wakeup Detected Interrupt bit or
+                                                         Disconnect Detected Interrupt bit in the Core Interrupt
+                                                         register (GINTSTS.WkUpInt or GINTSTS.DisconnInt,
+                                                         respectively).
+                                                         * 1'b0: Port not in Suspend mode
+                                                         * 1'b1: Port in Suspend mode */
+	uint32_t prtres                       : 1;  /**< Port Resume (PrtRes)
+                                                         The application sets this bit to drive resume signaling on
+                                                         the port. The core continues to drive the resume signal
+                                                         until the application clears this bit.
+                                                         If the core detects a USB remote wakeup sequence, as
+                                                         indicated by the Port Resume/Remote Wakeup Detected
+                                                         Interrupt bit of the Core Interrupt register
+                                                         (GINTSTS.WkUpInt), the core starts driving resume
+                                                         signaling without application intervention and clears this bit
+                                                         when it detects a disconnect condition. The read value of
+                                                         this bit indicates whether the core is currently driving
+                                                         resume signaling.
+                                                         * 1'b0: No resume driven
+                                                         * 1'b1: Resume driven */
+	uint32_t prtovrcurrchng               : 1;  /**< Port Overcurrent Change (PrtOvrCurrChng)
+                                                         The core sets this bit when the status of the Port
+                                                         Overcurrent Active bit (bit 4) in this register changes. */
+	uint32_t prtovrcurract                : 1;  /**< Port Overcurrent Active (PrtOvrCurrAct)
+                                                         Indicates the overcurrent condition of the port.
+                                                         * 1'b0: No overcurrent condition
+                                                         * 1'b1: Overcurrent condition */
+	uint32_t prtenchng                    : 1;  /**< Port Enable/Disable Change (PrtEnChng)
+                                                         The core sets this bit when the status of the Port Enable bit
+                                                         [2] of this register changes. */
+	uint32_t prtena                       : 1;  /**< Port Enable (PrtEna)
+                                                         A port is enabled only by the core after a reset sequence,
+                                                         and is disabled by an overcurrent condition, a disconnect
+                                                         condition, or by the application clearing this bit. The
+                                                         application cannot set this bit by a register write. It can only
+                                                         clear it to disable the port. This bit does not trigger any
+                                                         interrupt to the application.
+                                                         * 1'b0: Port disabled
+                                                         * 1'b1: Port enabled */
+	uint32_t prtconndet                   : 1;  /**< Port Connect Detected (PrtConnDet)
+                                                         The core sets this bit when a device connection is detected
+                                                         to trigger an interrupt to the application using the Host Port
+                                                         Interrupt bit of the Core Interrupt register (GINTSTS.PrtInt).
+                                                         The application must write a 1 to this bit to clear the
+                                                         interrupt. */
+	uint32_t prtconnsts                   : 1;  /**< Port Connect Status (PrtConnSts)
+                                                         * 0: No device is attached to the port.
+                                                         * 1: A device is attached to the port. */
+	} s;
+	struct cvmx_usbcx_hprt_s              cn30xx;
+	struct cvmx_usbcx_hprt_s              cn31xx;
+	struct cvmx_usbcx_hprt_s              cn50xx;
+	struct cvmx_usbcx_hprt_s              cn52xx;
+	struct cvmx_usbcx_hprt_s              cn52xxp1;
+	struct cvmx_usbcx_hprt_s              cn56xx;
+	struct cvmx_usbcx_hprt_s              cn56xxp1;
+};
+typedef union cvmx_usbcx_hprt cvmx_usbcx_hprt_t;
+
+/**
+ * cvmx_usbc#_hptxfsiz
+ *
+ * Host Periodic Transmit FIFO Size Register (HPTXFSIZ)
+ *
+ * This register holds the size and the memory start address of the Periodic TxFIFO, as shown in Figures 310 and 311.
+ */
+union cvmx_usbcx_hptxfsiz
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hptxfsiz_s
+	{
+	uint32_t ptxfsize                     : 16; /**< Host Periodic TxFIFO Depth (PTxFSize)
+                                                         This value is in terms of 32-bit words.
+                                                         * Minimum value is 16
+                                                         * Maximum value is 32768 */
+	uint32_t ptxfstaddr                   : 16; /**< Host Periodic TxFIFO Start Address (PTxFStAddr) */
+	} s;
+	struct cvmx_usbcx_hptxfsiz_s          cn30xx;
+	struct cvmx_usbcx_hptxfsiz_s          cn31xx;
+	struct cvmx_usbcx_hptxfsiz_s          cn50xx;
+	struct cvmx_usbcx_hptxfsiz_s          cn52xx;
+	struct cvmx_usbcx_hptxfsiz_s          cn52xxp1;
+	struct cvmx_usbcx_hptxfsiz_s          cn56xx;
+	struct cvmx_usbcx_hptxfsiz_s          cn56xxp1;
+};
+typedef union cvmx_usbcx_hptxfsiz cvmx_usbcx_hptxfsiz_t;
+
+/**
+ * cvmx_usbc#_hptxsts
+ *
+ * Host Periodic Transmit FIFO/Queue Status Register (HPTXSTS)
+ *
+ * This read-only register contains the free space information for the Periodic TxFIFO and
+ * the Periodic Transmit Request Queue
+ */
+union cvmx_usbcx_hptxsts
+{
+	uint32_t u32;
+	struct cvmx_usbcx_hptxsts_s
+	{
+	uint32_t ptxqtop                      : 8;  /**< Top of the Periodic Transmit Request Queue (PTxQTop)
+                                                         This indicates the entry in the Periodic Tx Request Queue that
+                                                         is currently being processes by the MAC.
+                                                         This register is used for debugging.
+                                                         * Bit [31]: Odd/Even (micro)frame
+                                                           - 1'b0: send in even (micro)frame
+                                                           - 1'b1: send in odd (micro)frame
+                                                         * Bits [30:27]: Channel/endpoint number
+                                                         * Bits [26:25]: Type
+                                                           - 2'b00: IN/OUT
+                                                           - 2'b01: Zero-length packet
+                                                           - 2'b10: CSPLIT
+                                                           - 2'b11: Disable channel command
+                                                         * Bit [24]: Terminate (last entry for the selected
+                                                           channel/endpoint) */
+	uint32_t ptxqspcavail                 : 8;  /**< Periodic Transmit Request Queue Space Available
+                                                         (PTxQSpcAvail)
+                                                         Indicates the number of free locations available to be written in
+                                                         the Periodic Transmit Request Queue. This queue holds both
+                                                         IN and OUT requests.
+                                                         * 8'h0: Periodic Transmit Request Queue is full
+                                                         * 8'h1: 1 location available
+                                                         * 8'h2: 2 locations available
+                                                         * n: n locations available (0..8)
+                                                         * Others: Reserved */
+	uint32_t ptxfspcavail                 : 16; /**< Periodic Transmit Data FIFO Space Available (PTxFSpcAvail)
+                                                         Indicates the number of free locations available to be written to
+                                                         in the Periodic TxFIFO.
+                                                         Values are in terms of 32-bit words
+                                                         * 16'h0: Periodic TxFIFO is full
+                                                         * 16'h1: 1 word available
+                                                         * 16'h2: 2 words available
+                                                         * 16'hn: n words available (where 0..32768)
+                                                         * 16'h8000: 32768 words available
+                                                         * Others: Reserved */
+	} s;
+	struct cvmx_usbcx_hptxsts_s           cn30xx;
+	struct cvmx_usbcx_hptxsts_s           cn31xx;
+	struct cvmx_usbcx_hptxsts_s           cn50xx;
+	struct cvmx_usbcx_hptxsts_s           cn52xx;
+	struct cvmx_usbcx_hptxsts_s           cn52xxp1;
+	struct cvmx_usbcx_hptxsts_s           cn56xx;
+	struct cvmx_usbcx_hptxsts_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_hptxsts cvmx_usbcx_hptxsts_t;
+
+/**
+ * cvmx_usbc#_nptxdfifo#
+ *
+ * NPTX Data Fifo (NPTXDFIFO)
+ *
+ * A slave mode application uses this register to access the Tx FIFO for channel n.
+ */
+union cvmx_usbcx_nptxdfifox
+{
+	uint32_t u32;
+	struct cvmx_usbcx_nptxdfifox_s
+	{
+	uint32_t data                         : 32; /**< Reserved */
+	} s;
+	struct cvmx_usbcx_nptxdfifox_s        cn30xx;
+	struct cvmx_usbcx_nptxdfifox_s        cn31xx;
+	struct cvmx_usbcx_nptxdfifox_s        cn50xx;
+	struct cvmx_usbcx_nptxdfifox_s        cn52xx;
+	struct cvmx_usbcx_nptxdfifox_s        cn52xxp1;
+	struct cvmx_usbcx_nptxdfifox_s        cn56xx;
+	struct cvmx_usbcx_nptxdfifox_s        cn56xxp1;
+};
+typedef union cvmx_usbcx_nptxdfifox cvmx_usbcx_nptxdfifox_t;
+
+/**
+ * cvmx_usbc#_pcgcctl
+ *
+ * Power and Clock Gating Control Register (PCGCCTL)
+ *
+ * The application can use this register to control the core's power-down and clock gating features.
+ */
+union cvmx_usbcx_pcgcctl
+{
+	uint32_t u32;
+	struct cvmx_usbcx_pcgcctl_s
+	{
+	uint32_t reserved_5_31                : 27;
+	uint32_t physuspended                 : 1;  /**< PHY Suspended. (PhySuspended)
+                                                         Indicates that the PHY has been suspended. After the
+                                                         application sets the Stop Pclk bit (bit 0), this bit is updated once
+                                                         the PHY is suspended.
+                                                         Since the UTMI+ PHY suspend is controlled through a port, the
+                                                         UTMI+ PHY is suspended immediately after Stop Pclk is set.
+                                                         However, the ULPI PHY takes a few clocks to suspend,
+                                                         because the suspend information is conveyed through the ULPI
+                                                         protocol to the ULPI PHY. */
+	uint32_t rstpdwnmodule                : 1;  /**< Reset Power-Down Modules (RstPdwnModule)
+                                                         This bit is valid only in Partial Power-Down mode. The
+                                                         application sets this bit when the power is turned off. The
+                                                         application clears this bit after the power is turned on and the
+                                                         PHY clock is up. */
+	uint32_t pwrclmp                      : 1;  /**< Power Clamp (PwrClmp)
+                                                         This bit is only valid in Partial Power-Down mode. The
+                                                         application sets this bit before the power is turned off to clamp
+                                                         the signals between the power-on modules and the power-off
+                                                         modules. The application clears the bit to disable the clamping
+                                                         before the power is turned on. */
+	uint32_t gatehclk                     : 1;  /**< Gate Hclk (GateHclk)
+                                                         The application sets this bit to gate hclk to modules other than
+                                                         the AHB Slave and Master and wakeup logic when the USB is
+                                                         suspended or the session is not valid. The application clears
+                                                         this bit when the USB is resumed or a new session starts. */
+	uint32_t stoppclk                     : 1;  /**< Stop Pclk (StopPclk)
+                                                         The application sets this bit to stop the PHY clock (phy_clk)
+                                                         when the USB is suspended, the session is not valid, or the
+                                                         device is disconnected. The application clears this bit when the
+                                                         USB is resumed or a new session starts. */
+	} s;
+	struct cvmx_usbcx_pcgcctl_s           cn30xx;
+	struct cvmx_usbcx_pcgcctl_s           cn31xx;
+	struct cvmx_usbcx_pcgcctl_s           cn50xx;
+	struct cvmx_usbcx_pcgcctl_s           cn52xx;
+	struct cvmx_usbcx_pcgcctl_s           cn52xxp1;
+	struct cvmx_usbcx_pcgcctl_s           cn56xx;
+	struct cvmx_usbcx_pcgcctl_s           cn56xxp1;
+};
+typedef union cvmx_usbcx_pcgcctl cvmx_usbcx_pcgcctl_t;
+
+#endif
diff --git a/drivers/staging/octeon-usb/cvmx-usbnx-defs.h b/drivers/staging/octeon-usb/cvmx-usbnx-defs.h
new file mode 100644
index 0000000..73ddee0
--- /dev/null
+++ b/drivers/staging/octeon-usb/cvmx-usbnx-defs.h
@@ -0,0 +1,1596 @@
+/***********************license start***************
+ * Copyright (c) 2003-2010  Cavium Networks (support@cavium.com). All rights
+ * reserved.
+ *
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *
+ *   * Redistributions in binary form must reproduce the above
+ *     copyright notice, this list of conditions and the following
+ *     disclaimer in the documentation and/or other materials provided
+ *     with the distribution.
+
+ *   * Neither the name of Cavium Networks nor the names of
+ *     its contributors may be used to endorse or promote products
+ *     derived from this software without specific prior written
+ *     permission.
+
+ * This Software, including technical data, may be subject to U.S. export  control
+ * laws, including the U.S. Export Administration Act and its  associated
+ * regulations, and may be subject to export or import  regulations in other
+ * countries.
+
+ * TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
+ * AND WITH ALL FAULTS AND CAVIUM  NETWORKS MAKES NO PROMISES, REPRESENTATIONS OR
+ * WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT TO
+ * THE SOFTWARE, INCLUDING ITS CONDITION, ITS CONFORMITY TO ANY REPRESENTATION OR
+ * DESCRIPTION, OR THE EXISTENCE OF ANY LATENT OR PATENT DEFECTS, AND CAVIUM
+ * SPECIFICALLY DISCLAIMS ALL IMPLIED (IF ANY) WARRANTIES OF TITLE,
+ * MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, LACK OF
+ * VIRUSES, ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION OR
+ * CORRESPONDENCE TO DESCRIPTION. THE ENTIRE  RISK ARISING OUT OF USE OR
+ * PERFORMANCE OF THE SOFTWARE LIES WITH YOU.
+ ***********************license end**************************************/
+
+
+/**
+ * cvmx-usbnx-defs.h
+ *
+ * Configuration and status register (CSR) type definitions for
+ * Octeon usbnx.
+ *
+ * This file is auto generated. Do not edit.
+ *
+ * <hr>$Revision$<hr>
+ *
+ */
+#ifndef __CVMX_USBNX_TYPEDEFS_H__
+#define __CVMX_USBNX_TYPEDEFS_H__
+
+#define CVMX_USBNX_BIST_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800680007F8ull) + ((block_id) & 1) * 0x10000000ull)
+#define CVMX_USBNX_CLK_CTL(block_id) (CVMX_ADD_IO_SEG(0x0001180068000010ull) + ((block_id) & 1) * 0x10000000ull)
+#define CVMX_USBNX_CTL_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000800ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_INB_CHN0(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000818ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_INB_CHN1(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000820ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_INB_CHN2(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000828ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_INB_CHN3(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000830ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_INB_CHN4(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000838ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_INB_CHN5(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000840ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_INB_CHN6(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000848ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_INB_CHN7(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000850ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_OUTB_CHN0(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000858ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_OUTB_CHN1(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000860ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_OUTB_CHN2(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000868ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_OUTB_CHN3(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000870ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_OUTB_CHN4(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000878ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_OUTB_CHN5(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000880ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_OUTB_CHN6(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000888ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA0_OUTB_CHN7(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000890ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_DMA_TEST(block_id) (CVMX_ADD_IO_SEG(0x00016F0000000808ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBNX_INT_ENB(block_id) (CVMX_ADD_IO_SEG(0x0001180068000008ull) + ((block_id) & 1) * 0x10000000ull)
+#define CVMX_USBNX_INT_SUM(block_id) (CVMX_ADD_IO_SEG(0x0001180068000000ull) + ((block_id) & 1) * 0x10000000ull)
+#define CVMX_USBNX_USBP_CTL_STATUS(block_id) (CVMX_ADD_IO_SEG(0x0001180068000018ull) + ((block_id) & 1) * 0x10000000ull)
+
+/**
+ * cvmx_usbn#_bist_status
+ *
+ * USBN_BIST_STATUS = USBN's Control and Status
+ *
+ * Contain general control bits and status information for the USBN.
+ */
+union cvmx_usbnx_bist_status
+{
+	uint64_t u64;
+	struct cvmx_usbnx_bist_status_s
+	{
+	uint64_t reserved_7_63                : 57;
+	uint64_t u2nc_bis                     : 1;  /**< Bist status U2N CTL FIFO Memory. */
+	uint64_t u2nf_bis                     : 1;  /**< Bist status U2N FIFO Memory. */
+	uint64_t e2hc_bis                     : 1;  /**< Bist status E2H CTL FIFO Memory. */
+	uint64_t n2uf_bis                     : 1;  /**< Bist status N2U  FIFO Memory. */
+	uint64_t usbc_bis                     : 1;  /**< Bist status USBC FIFO Memory. */
+	uint64_t nif_bis                      : 1;  /**< Bist status for Inbound Memory. */
+	uint64_t nof_bis                      : 1;  /**< Bist status for Outbound Memory. */
+	} s;
+	struct cvmx_usbnx_bist_status_cn30xx
+	{
+	uint64_t reserved_3_63                : 61;
+	uint64_t usbc_bis                     : 1;  /**< Bist status USBC FIFO Memory. */
+	uint64_t nif_bis                      : 1;  /**< Bist status for Inbound Memory. */
+	uint64_t nof_bis                      : 1;  /**< Bist status for Outbound Memory. */
+	} cn30xx;
+	struct cvmx_usbnx_bist_status_cn30xx  cn31xx;
+	struct cvmx_usbnx_bist_status_s       cn50xx;
+	struct cvmx_usbnx_bist_status_s       cn52xx;
+	struct cvmx_usbnx_bist_status_s       cn52xxp1;
+	struct cvmx_usbnx_bist_status_s       cn56xx;
+	struct cvmx_usbnx_bist_status_s       cn56xxp1;
+};
+typedef union cvmx_usbnx_bist_status cvmx_usbnx_bist_status_t;
+
+/**
+ * cvmx_usbn#_clk_ctl
+ *
+ * USBN_CLK_CTL = USBN's Clock Control
+ *
+ * This register is used to control the frequency of the hclk and the hreset and phy_rst signals.
+ */
+union cvmx_usbnx_clk_ctl
+{
+	uint64_t u64;
+	struct cvmx_usbnx_clk_ctl_s
+	{
+	uint64_t reserved_20_63               : 44;
+	uint64_t divide2                      : 2;  /**< The 'hclk' used by the USB subsystem is derived
+                                                         from the eclk.
+                                                         Also see the field DIVIDE. DIVIDE2<1> must currently
+                                                         be zero because it is not implemented, so the maximum
+                                                         ratio of eclk/hclk is currently 16.
+                                                         The actual divide number for hclk is:
+                                                         (DIVIDE2 + 1) * (DIVIDE + 1) */
+	uint64_t hclk_rst                     : 1;  /**< When this field is '0' the HCLK-DIVIDER used to
+                                                         generate the hclk in the USB Subsystem is held
+                                                         in reset. This bit must be set to '0' before
+                                                         changing the value os DIVIDE in this register.
+                                                         The reset to the HCLK_DIVIDERis also asserted
+                                                         when core reset is asserted. */
+	uint64_t p_x_on                       : 1;  /**< Force USB-PHY on during suspend.
+                                                         '1' USB-PHY XO block is powered-down during
+                                                             suspend.
+                                                         '0' USB-PHY XO block is powered-up during
+                                                             suspend.
+                                                         The value of this field must be set while POR is
+                                                         active. */
+	uint64_t reserved_14_15               : 2;
+	uint64_t p_com_on                     : 1;  /**< '0' Force USB-PHY XO Bias, Bandgap and PLL to
+                                                             remain powered in Suspend Mode.
+                                                         '1' The USB-PHY XO Bias, Bandgap and PLL are
+                                                             powered down in suspend mode.
+                                                         The value of this field must be set while POR is
+                                                         active. */
+	uint64_t p_c_sel                      : 2;  /**< Phy clock speed select.
+                                                         Selects the reference clock / crystal frequency.
+                                                         '11': Reserved
+                                                         '10': 48 MHz (reserved when a crystal is used)
+                                                         '01': 24 MHz (reserved when a crystal is used)
+                                                         '00': 12 MHz
+                                                         The value of this field must be set while POR is
+                                                         active.
+                                                         NOTE: if a crystal is used as a reference clock,
+                                                         this field must be set to 12 MHz. */
+	uint64_t cdiv_byp                     : 1;  /**< Used to enable the bypass input to the USB_CLK_DIV. */
+	uint64_t sd_mode                      : 2;  /**< Scaledown mode for the USBC. Control timing events
+                                                         in the USBC, for normal operation this must be '0'. */
+	uint64_t s_bist                       : 1;  /**< Starts bist on the hclk memories, during the '0'
+                                                         to '1' transition. */
+	uint64_t por                          : 1;  /**< Power On Reset for the PHY.
+                                                         Resets all the PHYS registers and state machines. */
+	uint64_t enable                       : 1;  /**< When '1' allows the generation of the hclk. When
+                                                         '0' the hclk will not be generated. SEE DIVIDE
+                                                         field of this register. */
+	uint64_t prst                         : 1;  /**< When this field is '0' the reset associated with
+                                                         the phy_clk functionality in the USB Subsystem is
+                                                         help in reset. This bit should not be set to '1'
+                                                         until the time it takes 6 clocks (hclk or phy_clk,
+                                                         whichever is slower) has passed. Under normal
+                                                         operation once this bit is set to '1' it should not
+                                                         be set to '0'. */
+	uint64_t hrst                         : 1;  /**< When this field is '0' the reset associated with
+                                                         the hclk functioanlity in the USB Subsystem is
+                                                         held in reset.This bit should not be set to '1'
+                                                         until 12ms after phy_clk is stable. Under normal
+                                                         operation, once this bit is set to '1' it should
+                                                         not be set to '0'. */
+	uint64_t divide                       : 3;  /**< The frequency of 'hclk' used by the USB subsystem
+                                                         is the eclk frequency divided by the value of
+                                                         (DIVIDE2 + 1) * (DIVIDE + 1), also see the field
+                                                         DIVIDE2 of this register.
+                                                         The hclk frequency should be less than 125Mhz.
+                                                         After writing a value to this field the SW should
+                                                         read the field for the value written.
+                                                         The ENABLE field of this register should not be set
+                                                         until AFTER this field is set and then read. */
+	} s;
+	struct cvmx_usbnx_clk_ctl_cn30xx
+	{
+	uint64_t reserved_18_63               : 46;
+	uint64_t hclk_rst                     : 1;  /**< When this field is '0' the HCLK-DIVIDER used to
+                                                         generate the hclk in the USB Subsystem is held
+                                                         in reset. This bit must be set to '0' before
+                                                         changing the value os DIVIDE in this register.
+                                                         The reset to the HCLK_DIVIDERis also asserted
+                                                         when core reset is asserted. */
+	uint64_t p_x_on                       : 1;  /**< Force USB-PHY on during suspend.
+                                                         '1' USB-PHY XO block is powered-down during
+                                                             suspend.
+                                                         '0' USB-PHY XO block is powered-up during
+                                                             suspend.
+                                                         The value of this field must be set while POR is
+                                                         active. */
+	uint64_t p_rclk                       : 1;  /**< Phy refrence clock enable.
+                                                         '1' The PHY PLL uses the XO block output as a
+                                                         reference.
+                                                         '0' Reserved. */
+	uint64_t p_xenbn                      : 1;  /**< Phy external clock enable.
+                                                         '1' The XO block uses the clock from a crystal.
+                                                         '0' The XO block uses an external clock supplied
+                                                             on the XO pin. USB_XI should be tied to
+                                                             ground for this usage. */
+	uint64_t p_com_on                     : 1;  /**< '0' Force USB-PHY XO Bias, Bandgap and PLL to
+                                                             remain powered in Suspend Mode.
+                                                         '1' The USB-PHY XO Bias, Bandgap and PLL are
+                                                             powered down in suspend mode.
+                                                         The value of this field must be set while POR is
+                                                         active. */
+	uint64_t p_c_sel                      : 2;  /**< Phy clock speed select.
+                                                         Selects the reference clock / crystal frequency.
+                                                         '11': Reserved
+                                                         '10': 48 MHz
+                                                         '01': 24 MHz
+                                                         '00': 12 MHz
+                                                         The value of this field must be set while POR is
+                                                         active. */
+	uint64_t cdiv_byp                     : 1;  /**< Used to enable the bypass input to the USB_CLK_DIV. */
+	uint64_t sd_mode                      : 2;  /**< Scaledown mode for the USBC. Control timing events
+                                                         in the USBC, for normal operation this must be '0'. */
+	uint64_t s_bist                       : 1;  /**< Starts bist on the hclk memories, during the '0'
+                                                         to '1' transition. */
+	uint64_t por                          : 1;  /**< Power On Reset for the PHY.
+                                                         Resets all the PHYS registers and state machines. */
+	uint64_t enable                       : 1;  /**< When '1' allows the generation of the hclk. When
+                                                         '0' the hclk will not be generated. */
+	uint64_t prst                         : 1;  /**< When this field is '0' the reset associated with
+                                                         the phy_clk functionality in the USB Subsystem is
+                                                         help in reset. This bit should not be set to '1'
+                                                         until the time it takes 6 clocks (hclk or phy_clk,
+                                                         whichever is slower) has passed. Under normal
+                                                         operation once this bit is set to '1' it should not
+                                                         be set to '0'. */
+	uint64_t hrst                         : 1;  /**< When this field is '0' the reset associated with
+                                                         the hclk functioanlity in the USB Subsystem is
+                                                         held in reset.This bit should not be set to '1'
+                                                         until 12ms after phy_clk is stable. Under normal
+                                                         operation, once this bit is set to '1' it should
+                                                         not be set to '0'. */
+	uint64_t divide                       : 3;  /**< The 'hclk' used by the USB subsystem is derived
+                                                         from the eclk. The eclk will be divided by the
+                                                         value of this field +1 to determine the hclk
+                                                         frequency. (Also see HRST of this register).
+                                                         The hclk frequency must be less than 125 MHz. */
+	} cn30xx;
+	struct cvmx_usbnx_clk_ctl_cn30xx      cn31xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx
+	{
+	uint64_t reserved_20_63               : 44;
+	uint64_t divide2                      : 2;  /**< The 'hclk' used by the USB subsystem is derived
+                                                         from the eclk.
+                                                         Also see the field DIVIDE. DIVIDE2<1> must currently
+                                                         be zero because it is not implemented, so the maximum
+                                                         ratio of eclk/hclk is currently 16.
+                                                         The actual divide number for hclk is:
+                                                         (DIVIDE2 + 1) * (DIVIDE + 1) */
+	uint64_t hclk_rst                     : 1;  /**< When this field is '0' the HCLK-DIVIDER used to
+                                                         generate the hclk in the USB Subsystem is held
+                                                         in reset. This bit must be set to '0' before
+                                                         changing the value os DIVIDE in this register.
+                                                         The reset to the HCLK_DIVIDERis also asserted
+                                                         when core reset is asserted. */
+	uint64_t reserved_16_16               : 1;
+	uint64_t p_rtype                      : 2;  /**< PHY reference clock type
+                                                         '0' The USB-PHY uses a 12MHz crystal as a clock
+                                                             source at the USB_XO and USB_XI pins
+                                                         '1' Reserved
+                                                         '2' The USB_PHY uses 12/24/48MHz 2.5V board clock
+                                                             at the USB_XO pin. USB_XI should be tied to
+                                                             ground in this case.
+                                                         '3' Reserved
+                                                         (bit 14 was P_XENBN on 3xxx)
+                                                         (bit 15 was P_RCLK on 3xxx) */
+	uint64_t p_com_on                     : 1;  /**< '0' Force USB-PHY XO Bias, Bandgap and PLL to
+                                                             remain powered in Suspend Mode.
+                                                         '1' The USB-PHY XO Bias, Bandgap and PLL are
+                                                             powered down in suspend mode.
+                                                         The value of this field must be set while POR is
+                                                         active. */
+	uint64_t p_c_sel                      : 2;  /**< Phy clock speed select.
+                                                         Selects the reference clock / crystal frequency.
+                                                         '11': Reserved
+                                                         '10': 48 MHz (reserved when a crystal is used)
+                                                         '01': 24 MHz (reserved when a crystal is used)
+                                                         '00': 12 MHz
+                                                         The value of this field must be set while POR is
+                                                         active.
+                                                         NOTE: if a crystal is used as a reference clock,
+                                                         this field must be set to 12 MHz. */
+	uint64_t cdiv_byp                     : 1;  /**< Used to enable the bypass input to the USB_CLK_DIV. */
+	uint64_t sd_mode                      : 2;  /**< Scaledown mode for the USBC. Control timing events
+                                                         in the USBC, for normal operation this must be '0'. */
+	uint64_t s_bist                       : 1;  /**< Starts bist on the hclk memories, during the '0'
+                                                         to '1' transition. */
+	uint64_t por                          : 1;  /**< Power On Reset for the PHY.
+                                                         Resets all the PHYS registers and state machines. */
+	uint64_t enable                       : 1;  /**< When '1' allows the generation of the hclk. When
+                                                         '0' the hclk will not be generated. SEE DIVIDE
+                                                         field of this register. */
+	uint64_t prst                         : 1;  /**< When this field is '0' the reset associated with
+                                                         the phy_clk functionality in the USB Subsystem is
+                                                         help in reset. This bit should not be set to '1'
+                                                         until the time it takes 6 clocks (hclk or phy_clk,
+                                                         whichever is slower) has passed. Under normal
+                                                         operation once this bit is set to '1' it should not
+                                                         be set to '0'. */
+	uint64_t hrst                         : 1;  /**< When this field is '0' the reset associated with
+                                                         the hclk functioanlity in the USB Subsystem is
+                                                         held in reset.This bit should not be set to '1'
+                                                         until 12ms after phy_clk is stable. Under normal
+                                                         operation, once this bit is set to '1' it should
+                                                         not be set to '0'. */
+	uint64_t divide                       : 3;  /**< The frequency of 'hclk' used by the USB subsystem
+                                                         is the eclk frequency divided by the value of
+                                                         (DIVIDE2 + 1) * (DIVIDE + 1), also see the field
+                                                         DIVIDE2 of this register.
+                                                         The hclk frequency should be less than 125Mhz.
+                                                         After writing a value to this field the SW should
+                                                         read the field for the value written.
+                                                         The ENABLE field of this register should not be set
+                                                         until AFTER this field is set and then read. */
+	} cn50xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx      cn52xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx      cn52xxp1;
+	struct cvmx_usbnx_clk_ctl_cn50xx      cn56xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx      cn56xxp1;
+};
+typedef union cvmx_usbnx_clk_ctl cvmx_usbnx_clk_ctl_t;
+
+/**
+ * cvmx_usbn#_ctl_status
+ *
+ * USBN_CTL_STATUS = USBN's Control And Status Register
+ *
+ * Contains general control and status information for the USBN block.
+ */
+union cvmx_usbnx_ctl_status
+{
+	uint64_t u64;
+	struct cvmx_usbnx_ctl_status_s
+	{
+	uint64_t reserved_6_63                : 58;
+	uint64_t dma_0pag                     : 1;  /**< When '1' sets the DMA engine will set the zero-Page
+                                                         bit in the L2C store operation to the IOB. */
+	uint64_t dma_stt                      : 1;  /**< When '1' sets the DMA engine to use STT operations. */
+	uint64_t dma_test                     : 1;  /**< When '1' sets the DMA engine into Test-Mode.
+                                                         For normal operation this bit should be '0'. */
+	uint64_t inv_a2                       : 1;  /**< When '1' causes the address[2] driven on the AHB
+                                                         for USB-CORE FIFO access to be inverted. Also data
+                                                         writen to and read from the AHB will have it byte
+                                                         order swapped. If the orginal order was A-B-C-D the
+                                                         new byte order will be D-C-B-A. */
+	uint64_t l2c_emod                     : 2;  /**< Endian format for data from/to the L2C.
+                                                         IN:   A-B-C-D-E-F-G-H
+                                                         OUT0: A-B-C-D-E-F-G-H
+                                                         OUT1: H-G-F-E-D-C-B-A
+                                                         OUT2: D-C-B-A-H-G-F-E
+                                                         OUT3: E-F-G-H-A-B-C-D */
+	} s;
+	struct cvmx_usbnx_ctl_status_s        cn30xx;
+	struct cvmx_usbnx_ctl_status_s        cn31xx;
+	struct cvmx_usbnx_ctl_status_s        cn50xx;
+	struct cvmx_usbnx_ctl_status_s        cn52xx;
+	struct cvmx_usbnx_ctl_status_s        cn52xxp1;
+	struct cvmx_usbnx_ctl_status_s        cn56xx;
+	struct cvmx_usbnx_ctl_status_s        cn56xxp1;
+};
+typedef union cvmx_usbnx_ctl_status cvmx_usbnx_ctl_status_t;
+
+/**
+ * cvmx_usbn#_dma0_inb_chn0
+ *
+ * USBN_DMA0_INB_CHN0 = USBN's Inbound DMA for USB0 Channel0
+ *
+ * Contains the starting address for use when USB0 writes to L2C via Channel0.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_inb_chn0
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn0_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Write to L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn0_s     cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s     cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s     cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s     cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s     cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn0_s     cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s     cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_inb_chn0 cvmx_usbnx_dma0_inb_chn0_t;
+
+/**
+ * cvmx_usbn#_dma0_inb_chn1
+ *
+ * USBN_DMA0_INB_CHN1 = USBN's Inbound DMA for USB0 Channel1
+ *
+ * Contains the starting address for use when USB0 writes to L2C via Channel1.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_inb_chn1
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn1_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Write to L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn1_s     cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s     cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s     cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s     cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s     cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn1_s     cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s     cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_inb_chn1 cvmx_usbnx_dma0_inb_chn1_t;
+
+/**
+ * cvmx_usbn#_dma0_inb_chn2
+ *
+ * USBN_DMA0_INB_CHN2 = USBN's Inbound DMA for USB0 Channel2
+ *
+ * Contains the starting address for use when USB0 writes to L2C via Channel2.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_inb_chn2
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn2_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Write to L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn2_s     cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s     cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s     cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s     cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s     cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn2_s     cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s     cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_inb_chn2 cvmx_usbnx_dma0_inb_chn2_t;
+
+/**
+ * cvmx_usbn#_dma0_inb_chn3
+ *
+ * USBN_DMA0_INB_CHN3 = USBN's Inbound DMA for USB0 Channel3
+ *
+ * Contains the starting address for use when USB0 writes to L2C via Channel3.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_inb_chn3
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn3_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Write to L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn3_s     cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s     cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s     cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s     cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s     cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn3_s     cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s     cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_inb_chn3 cvmx_usbnx_dma0_inb_chn3_t;
+
+/**
+ * cvmx_usbn#_dma0_inb_chn4
+ *
+ * USBN_DMA0_INB_CHN4 = USBN's Inbound DMA for USB0 Channel4
+ *
+ * Contains the starting address for use when USB0 writes to L2C via Channel4.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_inb_chn4
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn4_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Write to L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn4_s     cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s     cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s     cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s     cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s     cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn4_s     cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s     cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_inb_chn4 cvmx_usbnx_dma0_inb_chn4_t;
+
+/**
+ * cvmx_usbn#_dma0_inb_chn5
+ *
+ * USBN_DMA0_INB_CHN5 = USBN's Inbound DMA for USB0 Channel5
+ *
+ * Contains the starting address for use when USB0 writes to L2C via Channel5.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_inb_chn5
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn5_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Write to L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn5_s     cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s     cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s     cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s     cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s     cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn5_s     cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s     cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_inb_chn5 cvmx_usbnx_dma0_inb_chn5_t;
+
+/**
+ * cvmx_usbn#_dma0_inb_chn6
+ *
+ * USBN_DMA0_INB_CHN6 = USBN's Inbound DMA for USB0 Channel6
+ *
+ * Contains the starting address for use when USB0 writes to L2C via Channel6.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_inb_chn6
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn6_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Write to L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn6_s     cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s     cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s     cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s     cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s     cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn6_s     cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s     cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_inb_chn6 cvmx_usbnx_dma0_inb_chn6_t;
+
+/**
+ * cvmx_usbn#_dma0_inb_chn7
+ *
+ * USBN_DMA0_INB_CHN7 = USBN's Inbound DMA for USB0 Channel7
+ *
+ * Contains the starting address for use when USB0 writes to L2C via Channel7.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_inb_chn7
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn7_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Write to L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn7_s     cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s     cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s     cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s     cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s     cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn7_s     cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s     cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_inb_chn7 cvmx_usbnx_dma0_inb_chn7_t;
+
+/**
+ * cvmx_usbn#_dma0_outb_chn0
+ *
+ * USBN_DMA0_OUTB_CHN0 = USBN's Outbound DMA for USB0 Channel0
+ *
+ * Contains the starting address for use when USB0 reads from L2C via Channel0.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_outb_chn0
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn0_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Read from L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn0_s    cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s    cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s    cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s    cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s    cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn0_s    cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s    cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_outb_chn0 cvmx_usbnx_dma0_outb_chn0_t;
+
+/**
+ * cvmx_usbn#_dma0_outb_chn1
+ *
+ * USBN_DMA0_OUTB_CHN1 = USBN's Outbound DMA for USB0 Channel1
+ *
+ * Contains the starting address for use when USB0 reads from L2C via Channel1.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_outb_chn1
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn1_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Read from L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn1_s    cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s    cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s    cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s    cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s    cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn1_s    cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s    cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_outb_chn1 cvmx_usbnx_dma0_outb_chn1_t;
+
+/**
+ * cvmx_usbn#_dma0_outb_chn2
+ *
+ * USBN_DMA0_OUTB_CHN2 = USBN's Outbound DMA for USB0 Channel2
+ *
+ * Contains the starting address for use when USB0 reads from L2C via Channel2.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_outb_chn2
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn2_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Read from L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn2_s    cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s    cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s    cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s    cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s    cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn2_s    cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s    cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_outb_chn2 cvmx_usbnx_dma0_outb_chn2_t;
+
+/**
+ * cvmx_usbn#_dma0_outb_chn3
+ *
+ * USBN_DMA0_OUTB_CHN3 = USBN's Outbound DMA for USB0 Channel3
+ *
+ * Contains the starting address for use when USB0 reads from L2C via Channel3.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_outb_chn3
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn3_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Read from L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn3_s    cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s    cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s    cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s    cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s    cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn3_s    cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s    cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_outb_chn3 cvmx_usbnx_dma0_outb_chn3_t;
+
+/**
+ * cvmx_usbn#_dma0_outb_chn4
+ *
+ * USBN_DMA0_OUTB_CHN4 = USBN's Outbound DMA for USB0 Channel4
+ *
+ * Contains the starting address for use when USB0 reads from L2C via Channel4.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_outb_chn4
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn4_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Read from L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn4_s    cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s    cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s    cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s    cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s    cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn4_s    cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s    cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_outb_chn4 cvmx_usbnx_dma0_outb_chn4_t;
+
+/**
+ * cvmx_usbn#_dma0_outb_chn5
+ *
+ * USBN_DMA0_OUTB_CHN5 = USBN's Outbound DMA for USB0 Channel5
+ *
+ * Contains the starting address for use when USB0 reads from L2C via Channel5.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_outb_chn5
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn5_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Read from L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn5_s    cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s    cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s    cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s    cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s    cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn5_s    cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s    cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_outb_chn5 cvmx_usbnx_dma0_outb_chn5_t;
+
+/**
+ * cvmx_usbn#_dma0_outb_chn6
+ *
+ * USBN_DMA0_OUTB_CHN6 = USBN's Outbound DMA for USB0 Channel6
+ *
+ * Contains the starting address for use when USB0 reads from L2C via Channel6.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_outb_chn6
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn6_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Read from L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn6_s    cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s    cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s    cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s    cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s    cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn6_s    cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s    cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_outb_chn6 cvmx_usbnx_dma0_outb_chn6_t;
+
+/**
+ * cvmx_usbn#_dma0_outb_chn7
+ *
+ * USBN_DMA0_OUTB_CHN7 = USBN's Outbound DMA for USB0 Channel7
+ *
+ * Contains the starting address for use when USB0 reads from L2C via Channel7.
+ * Writing of this register sets the base address.
+ */
+union cvmx_usbnx_dma0_outb_chn7
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn7_s
+	{
+	uint64_t reserved_36_63               : 28;
+	uint64_t addr                         : 36; /**< Base address for DMA Read from L2C. */
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn7_s    cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s    cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s    cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s    cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s    cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn7_s    cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s    cn56xxp1;
+};
+typedef union cvmx_usbnx_dma0_outb_chn7 cvmx_usbnx_dma0_outb_chn7_t;
+
+/**
+ * cvmx_usbn#_dma_test
+ *
+ * USBN_DMA_TEST = USBN's DMA TestRegister
+ *
+ * This register can cause the external DMA engine to the USB-Core to make transfers from/to L2C/USB-FIFOs
+ */
+union cvmx_usbnx_dma_test
+{
+	uint64_t u64;
+	struct cvmx_usbnx_dma_test_s
+	{
+	uint64_t reserved_40_63               : 24;
+	uint64_t done                         : 1;  /**< This field is set when a DMA completes. Writing a
+                                                         '1' to this field clears this bit. */
+	uint64_t req                          : 1;  /**< DMA Request. Writing a 1 to this register
+                                                         will cause a DMA request as specified in the other
+                                                         fields of this register to take place. This field
+                                                         will always read as '0'. */
+	uint64_t f_addr                       : 18; /**< The address to read from in the Data-Fifo. */
+	uint64_t count                        : 11; /**< DMA Request Count. */
+	uint64_t channel                      : 5;  /**< DMA Channel/Enpoint. */
+	uint64_t burst                        : 4;  /**< DMA Burst Size. */
+	} s;
+	struct cvmx_usbnx_dma_test_s          cn30xx;
+	struct cvmx_usbnx_dma_test_s          cn31xx;
+	struct cvmx_usbnx_dma_test_s          cn50xx;
+	struct cvmx_usbnx_dma_test_s          cn52xx;
+	struct cvmx_usbnx_dma_test_s          cn52xxp1;
+	struct cvmx_usbnx_dma_test_s          cn56xx;
+	struct cvmx_usbnx_dma_test_s          cn56xxp1;
+};
+typedef union cvmx_usbnx_dma_test cvmx_usbnx_dma_test_t;
+
+/**
+ * cvmx_usbn#_int_enb
+ *
+ * USBN_INT_ENB = USBN's Interrupt Enable
+ *
+ * The USBN's interrupt enable register.
+ */
+union cvmx_usbnx_int_enb
+{
+	uint64_t u64;
+	struct cvmx_usbnx_int_enb_s
+	{
+	uint64_t reserved_38_63               : 26;
+	uint64_t nd4o_dpf                     : 1;  /**< When set (1) and bit 37 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nd4o_dpe                     : 1;  /**< When set (1) and bit 36 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nd4o_rpf                     : 1;  /**< When set (1) and bit 35 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nd4o_rpe                     : 1;  /**< When set (1) and bit 34 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t ltl_f_pf                     : 1;  /**< When set (1) and bit 33 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t ltl_f_pe                     : 1;  /**< When set (1) and bit 32 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t u2n_c_pe                     : 1;  /**< When set (1) and bit 31 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t u2n_c_pf                     : 1;  /**< When set (1) and bit 30 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t u2n_d_pf                     : 1;  /**< When set (1) and bit 29 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t u2n_d_pe                     : 1;  /**< When set (1) and bit 28 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t n2u_pe                       : 1;  /**< When set (1) and bit 27 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t n2u_pf                       : 1;  /**< When set (1) and bit 26 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t uod_pf                       : 1;  /**< When set (1) and bit 25 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t uod_pe                       : 1;  /**< When set (1) and bit 24 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rq_q3_e                      : 1;  /**< When set (1) and bit 23 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rq_q3_f                      : 1;  /**< When set (1) and bit 22 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rq_q2_e                      : 1;  /**< When set (1) and bit 21 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rq_q2_f                      : 1;  /**< When set (1) and bit 20 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rg_fi_f                      : 1;  /**< When set (1) and bit 19 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rg_fi_e                      : 1;  /**< When set (1) and bit 18 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t l2_fi_f                      : 1;  /**< When set (1) and bit 17 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t l2_fi_e                      : 1;  /**< When set (1) and bit 16 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t l2c_a_f                      : 1;  /**< When set (1) and bit 15 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t l2c_s_e                      : 1;  /**< When set (1) and bit 14 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t dcred_f                      : 1;  /**< When set (1) and bit 13 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t dcred_e                      : 1;  /**< When set (1) and bit 12 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t lt_pu_f                      : 1;  /**< When set (1) and bit 11 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t lt_po_e                      : 1;  /**< When set (1) and bit 10 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nt_pu_f                      : 1;  /**< When set (1) and bit 9 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nt_po_e                      : 1;  /**< When set (1) and bit 8 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t pt_pu_f                      : 1;  /**< When set (1) and bit 7 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t pt_po_e                      : 1;  /**< When set (1) and bit 6 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t lr_pu_f                      : 1;  /**< When set (1) and bit 5 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t lr_po_e                      : 1;  /**< When set (1) and bit 4 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nr_pu_f                      : 1;  /**< When set (1) and bit 3 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nr_po_e                      : 1;  /**< When set (1) and bit 2 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t pr_pu_f                      : 1;  /**< When set (1) and bit 1 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t pr_po_e                      : 1;  /**< When set (1) and bit 0 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	} s;
+	struct cvmx_usbnx_int_enb_s           cn30xx;
+	struct cvmx_usbnx_int_enb_s           cn31xx;
+	struct cvmx_usbnx_int_enb_cn50xx
+	{
+	uint64_t reserved_38_63               : 26;
+	uint64_t nd4o_dpf                     : 1;  /**< When set (1) and bit 37 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nd4o_dpe                     : 1;  /**< When set (1) and bit 36 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nd4o_rpf                     : 1;  /**< When set (1) and bit 35 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nd4o_rpe                     : 1;  /**< When set (1) and bit 34 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t ltl_f_pf                     : 1;  /**< When set (1) and bit 33 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t ltl_f_pe                     : 1;  /**< When set (1) and bit 32 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t reserved_26_31               : 6;
+	uint64_t uod_pf                       : 1;  /**< When set (1) and bit 25 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t uod_pe                       : 1;  /**< When set (1) and bit 24 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rq_q3_e                      : 1;  /**< When set (1) and bit 23 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rq_q3_f                      : 1;  /**< When set (1) and bit 22 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rq_q2_e                      : 1;  /**< When set (1) and bit 21 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rq_q2_f                      : 1;  /**< When set (1) and bit 20 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rg_fi_f                      : 1;  /**< When set (1) and bit 19 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t rg_fi_e                      : 1;  /**< When set (1) and bit 18 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t l2_fi_f                      : 1;  /**< When set (1) and bit 17 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t l2_fi_e                      : 1;  /**< When set (1) and bit 16 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t l2c_a_f                      : 1;  /**< When set (1) and bit 15 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t l2c_s_e                      : 1;  /**< When set (1) and bit 14 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t dcred_f                      : 1;  /**< When set (1) and bit 13 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t dcred_e                      : 1;  /**< When set (1) and bit 12 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t lt_pu_f                      : 1;  /**< When set (1) and bit 11 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t lt_po_e                      : 1;  /**< When set (1) and bit 10 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nt_pu_f                      : 1;  /**< When set (1) and bit 9 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nt_po_e                      : 1;  /**< When set (1) and bit 8 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t pt_pu_f                      : 1;  /**< When set (1) and bit 7 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t pt_po_e                      : 1;  /**< When set (1) and bit 6 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t lr_pu_f                      : 1;  /**< When set (1) and bit 5 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t lr_po_e                      : 1;  /**< When set (1) and bit 4 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nr_pu_f                      : 1;  /**< When set (1) and bit 3 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t nr_po_e                      : 1;  /**< When set (1) and bit 2 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t pr_pu_f                      : 1;  /**< When set (1) and bit 1 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	uint64_t pr_po_e                      : 1;  /**< When set (1) and bit 0 of the USBN_INT_SUM
+                                                         register is asserted the USBN will assert an
+                                                         interrupt. */
+	} cn50xx;
+	struct cvmx_usbnx_int_enb_cn50xx      cn52xx;
+	struct cvmx_usbnx_int_enb_cn50xx      cn52xxp1;
+	struct cvmx_usbnx_int_enb_cn50xx      cn56xx;
+	struct cvmx_usbnx_int_enb_cn50xx      cn56xxp1;
+};
+typedef union cvmx_usbnx_int_enb cvmx_usbnx_int_enb_t;
+
+/**
+ * cvmx_usbn#_int_sum
+ *
+ * USBN_INT_SUM = USBN's Interrupt Summary Register
+ *
+ * Contains the diffrent interrupt summary bits of the USBN.
+ */
+union cvmx_usbnx_int_sum
+{
+	uint64_t u64;
+	struct cvmx_usbnx_int_sum_s
+	{
+	uint64_t reserved_38_63               : 26;
+	uint64_t nd4o_dpf                     : 1;  /**< NCB DMA Out Data Fifo Push Full. */
+	uint64_t nd4o_dpe                     : 1;  /**< NCB DMA Out Data Fifo Pop Empty. */
+	uint64_t nd4o_rpf                     : 1;  /**< NCB DMA Out Request Fifo Push Full. */
+	uint64_t nd4o_rpe                     : 1;  /**< NCB DMA Out Request Fifo Pop Empty. */
+	uint64_t ltl_f_pf                     : 1;  /**< L2C Transfer Length Fifo Push Full. */
+	uint64_t ltl_f_pe                     : 1;  /**< L2C Transfer Length Fifo Pop Empty. */
+	uint64_t u2n_c_pe                     : 1;  /**< U2N Control Fifo Pop Empty. */
+	uint64_t u2n_c_pf                     : 1;  /**< U2N Control Fifo Push Full. */
+	uint64_t u2n_d_pf                     : 1;  /**< U2N Data Fifo Push Full. */
+	uint64_t u2n_d_pe                     : 1;  /**< U2N Data Fifo Pop Empty. */
+	uint64_t n2u_pe                       : 1;  /**< N2U Fifo Pop Empty. */
+	uint64_t n2u_pf                       : 1;  /**< N2U Fifo Push Full. */
+	uint64_t uod_pf                       : 1;  /**< UOD Fifo Push Full. */
+	uint64_t uod_pe                       : 1;  /**< UOD Fifo Pop Empty. */
+	uint64_t rq_q3_e                      : 1;  /**< Request Queue-3 Fifo Pushed When Full. */
+	uint64_t rq_q3_f                      : 1;  /**< Request Queue-3 Fifo Pushed When Full. */
+	uint64_t rq_q2_e                      : 1;  /**< Request Queue-2 Fifo Pushed When Full. */
+	uint64_t rq_q2_f                      : 1;  /**< Request Queue-2 Fifo Pushed When Full. */
+	uint64_t rg_fi_f                      : 1;  /**< Register Request Fifo Pushed When Full. */
+	uint64_t rg_fi_e                      : 1;  /**< Register Request Fifo Pushed When Full. */
+	uint64_t lt_fi_f                      : 1;  /**< L2C Request Fifo Pushed When Full. */
+	uint64_t lt_fi_e                      : 1;  /**< L2C Request Fifo Pushed When Full. */
+	uint64_t l2c_a_f                      : 1;  /**< L2C Credit Count Added When Full. */
+	uint64_t l2c_s_e                      : 1;  /**< L2C Credit Count Subtracted When Empty. */
+	uint64_t dcred_f                      : 1;  /**< Data CreditFifo Pushed When Full. */
+	uint64_t dcred_e                      : 1;  /**< Data Credit Fifo Pushed When Full. */
+	uint64_t lt_pu_f                      : 1;  /**< L2C Trasaction Fifo Pushed When Full. */
+	uint64_t lt_po_e                      : 1;  /**< L2C Trasaction Fifo Popped When Full. */
+	uint64_t nt_pu_f                      : 1;  /**< NPI Trasaction Fifo Pushed When Full. */
+	uint64_t nt_po_e                      : 1;  /**< NPI Trasaction Fifo Popped When Full. */
+	uint64_t pt_pu_f                      : 1;  /**< PP  Trasaction Fifo Pushed When Full. */
+	uint64_t pt_po_e                      : 1;  /**< PP  Trasaction Fifo Popped When Full. */
+	uint64_t lr_pu_f                      : 1;  /**< L2C Request Fifo Pushed When Full. */
+	uint64_t lr_po_e                      : 1;  /**< L2C Request Fifo Popped When Empty. */
+	uint64_t nr_pu_f                      : 1;  /**< NPI Request Fifo Pushed When Full. */
+	uint64_t nr_po_e                      : 1;  /**< NPI Request Fifo Popped When Empty. */
+	uint64_t pr_pu_f                      : 1;  /**< PP  Request Fifo Pushed When Full. */
+	uint64_t pr_po_e                      : 1;  /**< PP  Request Fifo Popped When Empty. */
+	} s;
+	struct cvmx_usbnx_int_sum_s           cn30xx;
+	struct cvmx_usbnx_int_sum_s           cn31xx;
+	struct cvmx_usbnx_int_sum_cn50xx
+	{
+	uint64_t reserved_38_63               : 26;
+	uint64_t nd4o_dpf                     : 1;  /**< NCB DMA Out Data Fifo Push Full. */
+	uint64_t nd4o_dpe                     : 1;  /**< NCB DMA Out Data Fifo Pop Empty. */
+	uint64_t nd4o_rpf                     : 1;  /**< NCB DMA Out Request Fifo Push Full. */
+	uint64_t nd4o_rpe                     : 1;  /**< NCB DMA Out Request Fifo Pop Empty. */
+	uint64_t ltl_f_pf                     : 1;  /**< L2C Transfer Length Fifo Push Full. */
+	uint64_t ltl_f_pe                     : 1;  /**< L2C Transfer Length Fifo Pop Empty. */
+	uint64_t reserved_26_31               : 6;
+	uint64_t uod_pf                       : 1;  /**< UOD Fifo Push Full. */
+	uint64_t uod_pe                       : 1;  /**< UOD Fifo Pop Empty. */
+	uint64_t rq_q3_e                      : 1;  /**< Request Queue-3 Fifo Pushed When Full. */
+	uint64_t rq_q3_f                      : 1;  /**< Request Queue-3 Fifo Pushed When Full. */
+	uint64_t rq_q2_e                      : 1;  /**< Request Queue-2 Fifo Pushed When Full. */
+	uint64_t rq_q2_f                      : 1;  /**< Request Queue-2 Fifo Pushed When Full. */
+	uint64_t rg_fi_f                      : 1;  /**< Register Request Fifo Pushed When Full. */
+	uint64_t rg_fi_e                      : 1;  /**< Register Request Fifo Pushed When Full. */
+	uint64_t lt_fi_f                      : 1;  /**< L2C Request Fifo Pushed When Full. */
+	uint64_t lt_fi_e                      : 1;  /**< L2C Request Fifo Pushed When Full. */
+	uint64_t l2c_a_f                      : 1;  /**< L2C Credit Count Added When Full. */
+	uint64_t l2c_s_e                      : 1;  /**< L2C Credit Count Subtracted When Empty. */
+	uint64_t dcred_f                      : 1;  /**< Data CreditFifo Pushed When Full. */
+	uint64_t dcred_e                      : 1;  /**< Data Credit Fifo Pushed When Full. */
+	uint64_t lt_pu_f                      : 1;  /**< L2C Trasaction Fifo Pushed When Full. */
+	uint64_t lt_po_e                      : 1;  /**< L2C Trasaction Fifo Popped When Full. */
+	uint64_t nt_pu_f                      : 1;  /**< NPI Trasaction Fifo Pushed When Full. */
+	uint64_t nt_po_e                      : 1;  /**< NPI Trasaction Fifo Popped When Full. */
+	uint64_t pt_pu_f                      : 1;  /**< PP  Trasaction Fifo Pushed When Full. */
+	uint64_t pt_po_e                      : 1;  /**< PP  Trasaction Fifo Popped When Full. */
+	uint64_t lr_pu_f                      : 1;  /**< L2C Request Fifo Pushed When Full. */
+	uint64_t lr_po_e                      : 1;  /**< L2C Request Fifo Popped When Empty. */
+	uint64_t nr_pu_f                      : 1;  /**< NPI Request Fifo Pushed When Full. */
+	uint64_t nr_po_e                      : 1;  /**< NPI Request Fifo Popped When Empty. */
+	uint64_t pr_pu_f                      : 1;  /**< PP  Request Fifo Pushed When Full. */
+	uint64_t pr_po_e                      : 1;  /**< PP  Request Fifo Popped When Empty. */
+	} cn50xx;
+	struct cvmx_usbnx_int_sum_cn50xx      cn52xx;
+	struct cvmx_usbnx_int_sum_cn50xx      cn52xxp1;
+	struct cvmx_usbnx_int_sum_cn50xx      cn56xx;
+	struct cvmx_usbnx_int_sum_cn50xx      cn56xxp1;
+};
+typedef union cvmx_usbnx_int_sum cvmx_usbnx_int_sum_t;
+
+/**
+ * cvmx_usbn#_usbp_ctl_status
+ *
+ * USBN_USBP_CTL_STATUS = USBP Control And Status Register
+ *
+ * Contains general control and status information for the USBN block.
+ */
+union cvmx_usbnx_usbp_ctl_status
+{
+	uint64_t u64;
+	struct cvmx_usbnx_usbp_ctl_status_s
+	{
+	uint64_t txrisetune                   : 1;  /**< HS Transmitter Rise/Fall Time Adjustment */
+	uint64_t txvreftune                   : 4;  /**< HS DC Voltage Level Adjustment */
+	uint64_t txfslstune                   : 4;  /**< FS/LS Source Impedence Adjustment */
+	uint64_t txhsxvtune                   : 2;  /**< Transmitter High-Speed Crossover Adjustment */
+	uint64_t sqrxtune                     : 3;  /**< Squelch Threshold Adjustment */
+	uint64_t compdistune                  : 3;  /**< Disconnect Threshold Adjustment */
+	uint64_t otgtune                      : 3;  /**< VBUS Valid Threshold Adjustment */
+	uint64_t otgdisable                   : 1;  /**< OTG Block Disable */
+	uint64_t portreset                    : 1;  /**< Per_Port Reset */
+	uint64_t drvvbus                      : 1;  /**< Drive VBUS */
+	uint64_t lsbist                       : 1;  /**< Low-Speed BIST Enable. */
+	uint64_t fsbist                       : 1;  /**< Full-Speed BIST Enable. */
+	uint64_t hsbist                       : 1;  /**< High-Speed BIST Enable. */
+	uint64_t bist_done                    : 1;  /**< PHY Bist Done.
+                                                         Asserted at the end of the PHY BIST sequence. */
+	uint64_t bist_err                     : 1;  /**< PHY Bist Error.
+                                                         Indicates an internal error was detected during
+                                                         the BIST sequence. */
+	uint64_t tdata_out                    : 4;  /**< PHY Test Data Out.
+                                                         Presents either internaly generated signals or
+                                                         test register contents, based upon the value of
+                                                         test_data_out_sel. */
+	uint64_t siddq                        : 1;  /**< Drives the USBP (USB-PHY) SIDDQ input.
+                                                         Normally should be set to zero.
+                                                         When customers have no intent to use USB PHY
+                                                         interface, they should:
+                                                           - still provide 3.3V to USB_VDD33, and
+                                                           - tie USB_REXT to 3.3V supply, and
+                                                           - set USBN*_USBP_CTL_STATUS[SIDDQ]=1 */
+	uint64_t txpreemphasistune            : 1;  /**< HS Transmitter Pre-Emphasis Enable */
+	uint64_t dma_bmode                    : 1;  /**< When set to 1 the L2C DMA address will be updated
+                                                         with byte-counts between packets. When set to 0
+                                                         the L2C DMA address is incremented to the next
+                                                         4-byte aligned address after adding byte-count. */
+	uint64_t usbc_end                     : 1;  /**< Bigendian input to the USB Core. This should be
+                                                         set to '0' for operation. */
+	uint64_t usbp_bist                    : 1;  /**< PHY, This is cleared '0' to run BIST on the USBP. */
+	uint64_t tclk                         : 1;  /**< PHY Test Clock, used to load TDATA_IN to the USBP. */
+	uint64_t dp_pulld                     : 1;  /**< PHY DP_PULLDOWN input to the USB-PHY.
+                                                         This signal enables the pull-down resistance on
+                                                         the D+ line. '1' pull down-resistance is connected
+                                                         to D+/ '0' pull down resistance is not connected
+                                                         to D+. When an A/B device is acting as a host
+                                                         (downstream-facing port), dp_pulldown and
+                                                         dm_pulldown are enabled. This must not toggle
+                                                         during normal opeartion. */
+	uint64_t dm_pulld                     : 1;  /**< PHY DM_PULLDOWN input to the USB-PHY.
+                                                         This signal enables the pull-down resistance on
+                                                         the D- line. '1' pull down-resistance is connected
+                                                         to D-. '0' pull down resistance is not connected
+                                                         to D-. When an A/B device is acting as a host
+                                                         (downstream-facing port), dp_pulldown and
+                                                         dm_pulldown are enabled. This must not toggle
+                                                         during normal opeartion. */
+	uint64_t hst_mode                     : 1;  /**< When '0' the USB is acting as HOST, when '1'
+                                                         USB is acting as device. This field needs to be
+                                                         set while the USB is in reset. */
+	uint64_t tuning                       : 4;  /**< Transmitter Tuning for High-Speed Operation.
+                                                         Tunes the current supply and rise/fall output
+                                                         times for high-speed operation.
+                                                         [20:19] == 11: Current supply increased
+                                                         approximately 9%
+                                                         [20:19] == 10: Current supply increased
+                                                         approximately 4.5%
+                                                         [20:19] == 01: Design default.
+                                                         [20:19] == 00: Current supply decreased
+                                                         approximately 4.5%
+                                                         [22:21] == 11: Rise and fall times are increased.
+                                                         [22:21] == 10: Design default.
+                                                         [22:21] == 01: Rise and fall times are decreased.
+                                                         [22:21] == 00: Rise and fall times are decreased
+                                                         further as compared to the 01 setting. */
+	uint64_t tx_bs_enh                    : 1;  /**< Transmit Bit Stuffing on [15:8].
+                                                         Enables or disables bit stuffing on data[15:8]
+                                                         when bit-stuffing is enabled. */
+	uint64_t tx_bs_en                     : 1;  /**< Transmit Bit Stuffing on [7:0].
+                                                         Enables or disables bit stuffing on data[7:0]
+                                                         when bit-stuffing is enabled. */
+	uint64_t loop_enb                     : 1;  /**< PHY Loopback Test Enable.
+                                                         '1': During data transmission the receive is
+                                                         enabled.
+                                                         '0': During data transmission the receive is
+                                                         disabled.
+                                                         Must be '0' for normal operation. */
+	uint64_t vtest_enb                    : 1;  /**< Analog Test Pin Enable.
+                                                         '1' The PHY's analog_test pin is enabled for the
+                                                         input and output of applicable analog test signals.
+                                                         '0' THe analog_test pin is disabled. */
+	uint64_t bist_enb                     : 1;  /**< Built-In Self Test Enable.
+                                                         Used to activate BIST in the PHY. */
+	uint64_t tdata_sel                    : 1;  /**< Test Data Out Select.
+                                                         '1' test_data_out[3:0] (PHY) register contents
+                                                         are output. '0' internaly generated signals are
+                                                         output. */
+	uint64_t taddr_in                     : 4;  /**< Mode Address for Test Interface.
+                                                         Specifies the register address for writing to or
+                                                         reading from the PHY test interface register. */
+	uint64_t tdata_in                     : 8;  /**< Internal Testing Register Input Data and Select
+                                                         This is a test bus. Data is present on [3:0],
+                                                         and its corresponding select (enable) is present
+                                                         on bits [7:4]. */
+	uint64_t ate_reset                    : 1;  /**< Reset input from automatic test equipment.
+                                                         This is a test signal. When the USB Core is
+                                                         powered up (not in Susned Mode), an automatic
+                                                         tester can use this to disable phy_clock and
+                                                         free_clk, then re-eanable them with an aligned
+                                                         phase.
+                                                         '1': The phy_clk and free_clk outputs are
+                                                         disabled. "0": The phy_clock and free_clk outputs
+                                                         are available within a specific period after the
+                                                         de-assertion. */
+	} s;
+	struct cvmx_usbnx_usbp_ctl_status_cn30xx
+	{
+	uint64_t reserved_38_63               : 26;
+	uint64_t bist_done                    : 1;  /**< PHY Bist Done.
+                                                         Asserted at the end of the PHY BIST sequence. */
+	uint64_t bist_err                     : 1;  /**< PHY Bist Error.
+                                                         Indicates an internal error was detected during
+                                                         the BIST sequence. */
+	uint64_t tdata_out                    : 4;  /**< PHY Test Data Out.
+                                                         Presents either internaly generated signals or
+                                                         test register contents, based upon the value of
+                                                         test_data_out_sel. */
+	uint64_t reserved_30_31               : 2;
+	uint64_t dma_bmode                    : 1;  /**< When set to 1 the L2C DMA address will be updated
+                                                         with byte-counts between packets. When set to 0
+                                                         the L2C DMA address is incremented to the next
+                                                         4-byte aligned address after adding byte-count. */
+	uint64_t usbc_end                     : 1;  /**< Bigendian input to the USB Core. This should be
+                                                         set to '0' for operation. */
+	uint64_t usbp_bist                    : 1;  /**< PHY, This is cleared '0' to run BIST on the USBP. */
+	uint64_t tclk                         : 1;  /**< PHY Test Clock, used to load TDATA_IN to the USBP. */
+	uint64_t dp_pulld                     : 1;  /**< PHY DP_PULLDOWN input to the USB-PHY.
+                                                         This signal enables the pull-down resistance on
+                                                         the D+ line. '1' pull down-resistance is connected
+                                                         to D+/ '0' pull down resistance is not connected
+                                                         to D+. When an A/B device is acting as a host
+                                                         (downstream-facing port), dp_pulldown and
+                                                         dm_pulldown are enabled. This must not toggle
+                                                         during normal opeartion. */
+	uint64_t dm_pulld                     : 1;  /**< PHY DM_PULLDOWN input to the USB-PHY.
+                                                         This signal enables the pull-down resistance on
+                                                         the D- line. '1' pull down-resistance is connected
+                                                         to D-. '0' pull down resistance is not connected
+                                                         to D-. When an A/B device is acting as a host
+                                                         (downstream-facing port), dp_pulldown and
+                                                         dm_pulldown are enabled. This must not toggle
+                                                         during normal opeartion. */
+	uint64_t hst_mode                     : 1;  /**< When '0' the USB is acting as HOST, when '1'
+                                                         USB is acting as device. This field needs to be
+                                                         set while the USB is in reset. */
+	uint64_t tuning                       : 4;  /**< Transmitter Tuning for High-Speed Operation.
+                                                         Tunes the current supply and rise/fall output
+                                                         times for high-speed operation.
+                                                         [20:19] == 11: Current supply increased
+                                                         approximately 9%
+                                                         [20:19] == 10: Current supply increased
+                                                         approximately 4.5%
+                                                         [20:19] == 01: Design default.
+                                                         [20:19] == 00: Current supply decreased
+                                                         approximately 4.5%
+                                                         [22:21] == 11: Rise and fall times are increased.
+                                                         [22:21] == 10: Design default.
+                                                         [22:21] == 01: Rise and fall times are decreased.
+                                                         [22:21] == 00: Rise and fall times are decreased
+                                                         further as compared to the 01 setting. */
+	uint64_t tx_bs_enh                    : 1;  /**< Transmit Bit Stuffing on [15:8].
+                                                         Enables or disables bit stuffing on data[15:8]
+                                                         when bit-stuffing is enabled. */
+	uint64_t tx_bs_en                     : 1;  /**< Transmit Bit Stuffing on [7:0].
+                                                         Enables or disables bit stuffing on data[7:0]
+                                                         when bit-stuffing is enabled. */
+	uint64_t loop_enb                     : 1;  /**< PHY Loopback Test Enable.
+                                                         '1': During data transmission the receive is
+                                                         enabled.
+                                                         '0': During data transmission the receive is
+                                                         disabled.
+                                                         Must be '0' for normal operation. */
+	uint64_t vtest_enb                    : 1;  /**< Analog Test Pin Enable.
+                                                         '1' The PHY's analog_test pin is enabled for the
+                                                         input and output of applicable analog test signals.
+                                                         '0' THe analog_test pin is disabled. */
+	uint64_t bist_enb                     : 1;  /**< Built-In Self Test Enable.
+                                                         Used to activate BIST in the PHY. */
+	uint64_t tdata_sel                    : 1;  /**< Test Data Out Select.
+                                                         '1' test_data_out[3:0] (PHY) register contents
+                                                         are output. '0' internaly generated signals are
+                                                         output. */
+	uint64_t taddr_in                     : 4;  /**< Mode Address for Test Interface.
+                                                         Specifies the register address for writing to or
+                                                         reading from the PHY test interface register. */
+	uint64_t tdata_in                     : 8;  /**< Internal Testing Register Input Data and Select
+                                                         This is a test bus. Data is present on [3:0],
+                                                         and its corresponding select (enable) is present
+                                                         on bits [7:4]. */
+	uint64_t ate_reset                    : 1;  /**< Reset input from automatic test equipment.
+                                                         This is a test signal. When the USB Core is
+                                                         powered up (not in Susned Mode), an automatic
+                                                         tester can use this to disable phy_clock and
+                                                         free_clk, then re-eanable them with an aligned
+                                                         phase.
+                                                         '1': The phy_clk and free_clk outputs are
+                                                         disabled. "0": The phy_clock and free_clk outputs
+                                                         are available within a specific period after the
+                                                         de-assertion. */
+	} cn30xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn30xx cn31xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx
+	{
+	uint64_t txrisetune                   : 1;  /**< HS Transmitter Rise/Fall Time Adjustment */
+	uint64_t txvreftune                   : 4;  /**< HS DC Voltage Level Adjustment */
+	uint64_t txfslstune                   : 4;  /**< FS/LS Source Impedence Adjustment */
+	uint64_t txhsxvtune                   : 2;  /**< Transmitter High-Speed Crossover Adjustment */
+	uint64_t sqrxtune                     : 3;  /**< Squelch Threshold Adjustment */
+	uint64_t compdistune                  : 3;  /**< Disconnect Threshold Adjustment */
+	uint64_t otgtune                      : 3;  /**< VBUS Valid Threshold Adjustment */
+	uint64_t otgdisable                   : 1;  /**< OTG Block Disable */
+	uint64_t portreset                    : 1;  /**< Per_Port Reset */
+	uint64_t drvvbus                      : 1;  /**< Drive VBUS */
+	uint64_t lsbist                       : 1;  /**< Low-Speed BIST Enable. */
+	uint64_t fsbist                       : 1;  /**< Full-Speed BIST Enable. */
+	uint64_t hsbist                       : 1;  /**< High-Speed BIST Enable. */
+	uint64_t bist_done                    : 1;  /**< PHY Bist Done.
+                                                         Asserted at the end of the PHY BIST sequence. */
+	uint64_t bist_err                     : 1;  /**< PHY Bist Error.
+                                                         Indicates an internal error was detected during
+                                                         the BIST sequence. */
+	uint64_t tdata_out                    : 4;  /**< PHY Test Data Out.
+                                                         Presents either internaly generated signals or
+                                                         test register contents, based upon the value of
+                                                         test_data_out_sel. */
+	uint64_t reserved_31_31               : 1;
+	uint64_t txpreemphasistune            : 1;  /**< HS Transmitter Pre-Emphasis Enable */
+	uint64_t dma_bmode                    : 1;  /**< When set to 1 the L2C DMA address will be updated
+                                                         with byte-counts between packets. When set to 0
+                                                         the L2C DMA address is incremented to the next
+                                                         4-byte aligned address after adding byte-count. */
+	uint64_t usbc_end                     : 1;  /**< Bigendian input to the USB Core. This should be
+                                                         set to '0' for operation. */
+	uint64_t usbp_bist                    : 1;  /**< PHY, This is cleared '0' to run BIST on the USBP. */
+	uint64_t tclk                         : 1;  /**< PHY Test Clock, used to load TDATA_IN to the USBP. */
+	uint64_t dp_pulld                     : 1;  /**< PHY DP_PULLDOWN input to the USB-PHY.
+                                                         This signal enables the pull-down resistance on
+                                                         the D+ line. '1' pull down-resistance is connected
+                                                         to D+/ '0' pull down resistance is not connected
+                                                         to D+. When an A/B device is acting as a host
+                                                         (downstream-facing port), dp_pulldown and
+                                                         dm_pulldown are enabled. This must not toggle
+                                                         during normal opeartion. */
+	uint64_t dm_pulld                     : 1;  /**< PHY DM_PULLDOWN input to the USB-PHY.
+                                                         This signal enables the pull-down resistance on
+                                                         the D- line. '1' pull down-resistance is connected
+                                                         to D-. '0' pull down resistance is not connected
+                                                         to D-. When an A/B device is acting as a host
+                                                         (downstream-facing port), dp_pulldown and
+                                                         dm_pulldown are enabled. This must not toggle
+                                                         during normal opeartion. */
+	uint64_t hst_mode                     : 1;  /**< When '0' the USB is acting as HOST, when '1'
+                                                         USB is acting as device. This field needs to be
+                                                         set while the USB is in reset. */
+	uint64_t reserved_19_22               : 4;
+	uint64_t tx_bs_enh                    : 1;  /**< Transmit Bit Stuffing on [15:8].
+                                                         Enables or disables bit stuffing on data[15:8]
+                                                         when bit-stuffing is enabled. */
+	uint64_t tx_bs_en                     : 1;  /**< Transmit Bit Stuffing on [7:0].
+                                                         Enables or disables bit stuffing on data[7:0]
+                                                         when bit-stuffing is enabled. */
+	uint64_t loop_enb                     : 1;  /**< PHY Loopback Test Enable.
+                                                         '1': During data transmission the receive is
+                                                         enabled.
+                                                         '0': During data transmission the receive is
+                                                         disabled.
+                                                         Must be '0' for normal operation. */
+	uint64_t vtest_enb                    : 1;  /**< Analog Test Pin Enable.
+                                                         '1' The PHY's analog_test pin is enabled for the
+                                                         input and output of applicable analog test signals.
+                                                         '0' THe analog_test pin is disabled. */
+	uint64_t bist_enb                     : 1;  /**< Built-In Self Test Enable.
+                                                         Used to activate BIST in the PHY. */
+	uint64_t tdata_sel                    : 1;  /**< Test Data Out Select.
+                                                         '1' test_data_out[3:0] (PHY) register contents
+                                                         are output. '0' internaly generated signals are
+                                                         output. */
+	uint64_t taddr_in                     : 4;  /**< Mode Address for Test Interface.
+                                                         Specifies the register address for writing to or
+                                                         reading from the PHY test interface register. */
+	uint64_t tdata_in                     : 8;  /**< Internal Testing Register Input Data and Select
+                                                         This is a test bus. Data is present on [3:0],
+                                                         and its corresponding select (enable) is present
+                                                         on bits [7:4]. */
+	uint64_t ate_reset                    : 1;  /**< Reset input from automatic test equipment.
+                                                         This is a test signal. When the USB Core is
+                                                         powered up (not in Susned Mode), an automatic
+                                                         tester can use this to disable phy_clock and
+                                                         free_clk, then re-eanable them with an aligned
+                                                         phase.
+                                                         '1': The phy_clk and free_clk outputs are
+                                                         disabled. "0": The phy_clock and free_clk outputs
+                                                         are available within a specific period after the
+                                                         de-assertion. */
+	} cn50xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn52xx
+	{
+	uint64_t txrisetune                   : 1;  /**< HS Transmitter Rise/Fall Time Adjustment */
+	uint64_t txvreftune                   : 4;  /**< HS DC Voltage Level Adjustment */
+	uint64_t txfslstune                   : 4;  /**< FS/LS Source Impedence Adjustment */
+	uint64_t txhsxvtune                   : 2;  /**< Transmitter High-Speed Crossover Adjustment */
+	uint64_t sqrxtune                     : 3;  /**< Squelch Threshold Adjustment */
+	uint64_t compdistune                  : 3;  /**< Disconnect Threshold Adjustment */
+	uint64_t otgtune                      : 3;  /**< VBUS Valid Threshold Adjustment */
+	uint64_t otgdisable                   : 1;  /**< OTG Block Disable */
+	uint64_t portreset                    : 1;  /**< Per_Port Reset */
+	uint64_t drvvbus                      : 1;  /**< Drive VBUS */
+	uint64_t lsbist                       : 1;  /**< Low-Speed BIST Enable. */
+	uint64_t fsbist                       : 1;  /**< Full-Speed BIST Enable. */
+	uint64_t hsbist                       : 1;  /**< High-Speed BIST Enable. */
+	uint64_t bist_done                    : 1;  /**< PHY Bist Done.
+                                                         Asserted at the end of the PHY BIST sequence. */
+	uint64_t bist_err                     : 1;  /**< PHY Bist Error.
+                                                         Indicates an internal error was detected during
+                                                         the BIST sequence. */
+	uint64_t tdata_out                    : 4;  /**< PHY Test Data Out.
+                                                         Presents either internaly generated signals or
+                                                         test register contents, based upon the value of
+                                                         test_data_out_sel. */
+	uint64_t siddq                        : 1;  /**< Drives the USBP (USB-PHY) SIDDQ input.
+                                                         Normally should be set to zero.
+                                                         When customers have no intent to use USB PHY
+                                                         interface, they should:
+                                                           - still provide 3.3V to USB_VDD33, and
+                                                           - tie USB_REXT to 3.3V supply, and
+                                                           - set USBN*_USBP_CTL_STATUS[SIDDQ]=1 */
+	uint64_t txpreemphasistune            : 1;  /**< HS Transmitter Pre-Emphasis Enable */
+	uint64_t dma_bmode                    : 1;  /**< When set to 1 the L2C DMA address will be updated
+                                                         with byte-counts between packets. When set to 0
+                                                         the L2C DMA address is incremented to the next
+                                                         4-byte aligned address after adding byte-count. */
+	uint64_t usbc_end                     : 1;  /**< Bigendian input to the USB Core. This should be
+                                                         set to '0' for operation. */
+	uint64_t usbp_bist                    : 1;  /**< PHY, This is cleared '0' to run BIST on the USBP. */
+	uint64_t tclk                         : 1;  /**< PHY Test Clock, used to load TDATA_IN to the USBP. */
+	uint64_t dp_pulld                     : 1;  /**< PHY DP_PULLDOWN input to the USB-PHY.
+                                                         This signal enables the pull-down resistance on
+                                                         the D+ line. '1' pull down-resistance is connected
+                                                         to D+/ '0' pull down resistance is not connected
+                                                         to D+. When an A/B device is acting as a host
+                                                         (downstream-facing port), dp_pulldown and
+                                                         dm_pulldown are enabled. This must not toggle
+                                                         during normal opeartion. */
+	uint64_t dm_pulld                     : 1;  /**< PHY DM_PULLDOWN input to the USB-PHY.
+                                                         This signal enables the pull-down resistance on
+                                                         the D- line. '1' pull down-resistance is connected
+                                                         to D-. '0' pull down resistance is not connected
+                                                         to D-. When an A/B device is acting as a host
+                                                         (downstream-facing port), dp_pulldown and
+                                                         dm_pulldown are enabled. This must not toggle
+                                                         during normal opeartion. */
+	uint64_t hst_mode                     : 1;  /**< When '0' the USB is acting as HOST, when '1'
+                                                         USB is acting as device. This field needs to be
+                                                         set while the USB is in reset. */
+	uint64_t reserved_19_22               : 4;
+	uint64_t tx_bs_enh                    : 1;  /**< Transmit Bit Stuffing on [15:8].
+                                                         Enables or disables bit stuffing on data[15:8]
+                                                         when bit-stuffing is enabled. */
+	uint64_t tx_bs_en                     : 1;  /**< Transmit Bit Stuffing on [7:0].
+                                                         Enables or disables bit stuffing on data[7:0]
+                                                         when bit-stuffing is enabled. */
+	uint64_t loop_enb                     : 1;  /**< PHY Loopback Test Enable.
+                                                         '1': During data transmission the receive is
+                                                         enabled.
+                                                         '0': During data transmission the receive is
+                                                         disabled.
+                                                         Must be '0' for normal operation. */
+	uint64_t vtest_enb                    : 1;  /**< Analog Test Pin Enable.
+                                                         '1' The PHY's analog_test pin is enabled for the
+                                                         input and output of applicable analog test signals.
+                                                         '0' THe analog_test pin is disabled. */
+	uint64_t bist_enb                     : 1;  /**< Built-In Self Test Enable.
+                                                         Used to activate BIST in the PHY. */
+	uint64_t tdata_sel                    : 1;  /**< Test Data Out Select.
+                                                         '1' test_data_out[3:0] (PHY) register contents
+                                                         are output. '0' internaly generated signals are
+                                                         output. */
+	uint64_t taddr_in                     : 4;  /**< Mode Address for Test Interface.
+                                                         Specifies the register address for writing to or
+                                                         reading from the PHY test interface register. */
+	uint64_t tdata_in                     : 8;  /**< Internal Testing Register Input Data and Select
+                                                         This is a test bus. Data is present on [3:0],
+                                                         and its corresponding select (enable) is present
+                                                         on bits [7:4]. */
+	uint64_t ate_reset                    : 1;  /**< Reset input from automatic test equipment.
+                                                         This is a test signal. When the USB Core is
+                                                         powered up (not in Susned Mode), an automatic
+                                                         tester can use this to disable phy_clock and
+                                                         free_clk, then re-eanable them with an aligned
+                                                         phase.
+                                                         '1': The phy_clk and free_clk outputs are
+                                                         disabled. "0": The phy_clock and free_clk outputs
+                                                         are available within a specific period after the
+                                                         de-assertion. */
+	} cn52xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx cn52xxp1;
+	struct cvmx_usbnx_usbp_ctl_status_cn52xx cn56xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx cn56xxp1;
+};
+typedef union cvmx_usbnx_usbp_ctl_status cvmx_usbnx_usbp_ctl_status_t;
+
+#endif
diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
new file mode 100644
index 0000000..b78bd19
--- /dev/null
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -0,0 +1,854 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Cavium Networks
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/platform_device.h>
+#include <linux/usb.h>
+
+#include <asm/time.h>
+#include <asm/delay.h>
+
+#include <asm/octeon/cvmx.h>
+#include "cvmx-usb.h"
+#include <asm/octeon/cvmx-iob-defs.h>
+
+#include <linux/usb/hcd.h>
+
+//#define DEBUG_CALL(format, ...)         printk(format, ##__VA_ARGS__)
+#define DEBUG_CALL(format, ...)         do {} while (0)
+//#define DEBUG_SUBMIT(format, ...)       printk(format, ##__VA_ARGS__)
+#define DEBUG_SUBMIT(format, ...)       do {} while (0)
+//#define DEBUG_ROOT_HUB(format, ...)     printk(format, ##__VA_ARGS__)
+#define DEBUG_ROOT_HUB(format, ...)     do {} while (0)
+//#define DEBUG_ERROR(format, ...)        printk(format, ##__VA_ARGS__)
+#define DEBUG_ERROR(format, ...)        do {} while (0)
+#define DEBUG_FATAL(format, ...)        printk(format, ##__VA_ARGS__)
+
+struct octeon_hcd {
+    spinlock_t lock;
+    cvmx_usb_state_t usb;
+    struct tasklet_struct dequeue_tasklet;
+    struct list_head dequeue_list;
+};
+
+/* convert between an HCD pointer and the corresponding struct octeon_hcd */
+static inline struct octeon_hcd *hcd_to_octeon(struct usb_hcd *hcd)
+{
+	return (struct octeon_hcd *)(hcd->hcd_priv);
+}
+
+static inline struct usb_hcd *octeon_to_hcd(struct octeon_hcd *p)
+{
+	return container_of((void *)p, struct usb_hcd, hcd_priv);
+}
+
+static inline struct octeon_hcd *cvmx_usb_to_octeon(cvmx_usb_state_t *p)
+{
+	return container_of(p, struct octeon_hcd, usb);
+}
+
+static irqreturn_t octeon_usb_irq(struct usb_hcd *hcd)
+{
+    struct octeon_hcd *priv = hcd_to_octeon(hcd);
+    unsigned long flags;
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+    spin_lock_irqsave(&priv->lock, flags);
+    cvmx_usb_poll(&priv->usb);
+    spin_unlock_irqrestore(&priv->lock, flags);
+    return IRQ_HANDLED;
+}
+
+static void octeon_usb_port_callback(cvmx_usb_state_t *usb,
+                                     cvmx_usb_callback_t reason,
+                                     cvmx_usb_complete_t status,
+                                     int pipe_handle,
+                                     int submit_handle,
+                                     int bytes_transferred,
+                                     void *user_data)
+{
+    struct octeon_hcd *priv = cvmx_usb_to_octeon(usb);
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+    spin_unlock(&priv->lock);
+    usb_hcd_poll_rh_status(octeon_to_hcd(priv));
+    spin_lock(&priv->lock);
+}
+
+static int octeon_usb_start(struct usb_hcd *hcd)
+{
+    struct octeon_hcd *priv = hcd_to_octeon(hcd);
+    unsigned long flags;
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+    hcd->state = HC_STATE_RUNNING;
+    spin_lock_irqsave(&priv->lock, flags);
+    cvmx_usb_register_callback(&priv->usb, CVMX_USB_CALLBACK_PORT_CHANGED,
+                               octeon_usb_port_callback, NULL);
+    spin_unlock_irqrestore(&priv->lock, flags);
+    return 0;
+}
+
+static void octeon_usb_stop(struct usb_hcd *hcd)
+{
+    struct octeon_hcd *priv = hcd_to_octeon(hcd);
+    unsigned long flags;
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+    spin_lock_irqsave(&priv->lock, flags);
+    cvmx_usb_register_callback(&priv->usb, CVMX_USB_CALLBACK_PORT_CHANGED,
+                               NULL, NULL);
+    spin_unlock_irqrestore(&priv->lock, flags);
+    hcd->state = HC_STATE_HALT;
+}
+
+static int octeon_usb_get_frame_number(struct usb_hcd *hcd)
+{
+    struct octeon_hcd *priv = hcd_to_octeon(hcd);
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+    return cvmx_usb_get_frame_number(&priv->usb);
+}
+
+static void octeon_usb_urb_complete_callback(cvmx_usb_state_t *usb,
+                                             cvmx_usb_callback_t reason,
+                                             cvmx_usb_complete_t status,
+                                             int pipe_handle,
+                                             int submit_handle,
+                                             int bytes_transferred,
+                                             void *user_data)
+{
+    struct octeon_hcd *priv = cvmx_usb_to_octeon(usb);
+    struct urb *urb = user_data;
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+    urb->actual_length = bytes_transferred;
+    urb->hcpriv = NULL;
+
+	if (!list_empty(&urb->urb_list)) {
+		/*
+		 * It is on the dequeue_list, but we are going to call
+		 * usb_hcd_giveback_urb(), so we must clear it from
+		 * the list.  We got to it before the
+		 * octeon_usb_urb_dequeue_work() tasklet did.
+		 */
+		list_del(&urb->urb_list);
+		/* No longer on the dequeue_list. */
+		INIT_LIST_HEAD(&urb->urb_list);
+	}
+
+    /* For Isochronous transactions we need to update the URB packet status
+        list from data in our private copy */
+    if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS)
+    {
+        int i;
+        /* The pointer to the private list is stored in the setup_packet field */
+        cvmx_usb_iso_packet_t *iso_packet = (cvmx_usb_iso_packet_t *)urb->setup_packet;
+        /* Recalculate the transfer size by adding up each packet */
+        urb->actual_length = 0;
+        for (i=0; i<urb->number_of_packets; i++)
+        {
+            if (iso_packet[i].status == CVMX_USB_COMPLETE_SUCCESS)
+            {
+                urb->iso_frame_desc[i].status = 0;
+                urb->iso_frame_desc[i].actual_length = iso_packet[i].length;
+                urb->actual_length += urb->iso_frame_desc[i].actual_length;
+            }
+            else
+            {
+                DEBUG_ERROR("%s: ISOCHRONOUS packet=%d of %d status=%d pipe=%d submit=%d size=%d\n",
+                            __FUNCTION__, i, urb->number_of_packets,
+                            iso_packet[i].status, pipe_handle,
+                            submit_handle, iso_packet[i].length);
+                urb->iso_frame_desc[i].status = -EREMOTEIO;
+            }
+        }
+        /* Free the private list now that we don't need it anymore */
+        kfree(iso_packet);
+        urb->setup_packet = NULL;
+    }
+
+    switch (status)
+    {
+        case CVMX_USB_COMPLETE_SUCCESS:
+            urb->status = 0;
+            break;
+        case CVMX_USB_COMPLETE_CANCEL:
+            if (urb->status == 0)
+                urb->status = -ENOENT;
+            break;
+        case CVMX_USB_COMPLETE_STALL:
+            DEBUG_ERROR("%s: status=stall pipe=%d submit=%d size=%d\n", __FUNCTION__, pipe_handle, submit_handle, bytes_transferred);
+            urb->status = -EPIPE;
+            break;
+        case CVMX_USB_COMPLETE_BABBLEERR:
+            DEBUG_ERROR("%s: status=babble pipe=%d submit=%d size=%d\n", __FUNCTION__, pipe_handle, submit_handle, bytes_transferred);
+            urb->status = -EPIPE;
+            break;
+        case CVMX_USB_COMPLETE_SHORT:
+            DEBUG_ERROR("%s: status=short pipe=%d submit=%d size=%d\n", __FUNCTION__, pipe_handle, submit_handle, bytes_transferred);
+            urb->status = -EREMOTEIO;
+            break;
+        case CVMX_USB_COMPLETE_ERROR:
+        case CVMX_USB_COMPLETE_XACTERR:
+        case CVMX_USB_COMPLETE_DATATGLERR:
+        case CVMX_USB_COMPLETE_FRAMEERR:
+            DEBUG_ERROR("%s: status=%d pipe=%d submit=%d size=%d\n", __FUNCTION__, status, pipe_handle, submit_handle, bytes_transferred);
+            urb->status = -EPROTO;
+            break;
+    }
+    spin_unlock(&priv->lock);
+    usb_hcd_giveback_urb(octeon_to_hcd(priv), urb, urb->status);
+    spin_lock(&priv->lock);
+}
+
+static int octeon_usb_urb_enqueue(struct usb_hcd *hcd,
+                                  struct urb *urb,
+                                  gfp_t mem_flags)
+{
+    struct octeon_hcd *priv = hcd_to_octeon(hcd);
+    int submit_handle = -1;
+    int pipe_handle;
+    unsigned long flags;
+    cvmx_usb_iso_packet_t *iso_packet;
+    struct usb_host_endpoint *ep = urb->ep;
+
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+
+    urb->status = 0;
+    INIT_LIST_HEAD(&urb->urb_list); /* not enqueued on dequeue_list */
+    spin_lock_irqsave(&priv->lock, flags);
+
+    if (!ep->hcpriv)
+    {
+        cvmx_usb_transfer_t transfer_type;
+        cvmx_usb_speed_t speed;
+        int split_device = 0;
+        int split_port = 0;
+        switch (usb_pipetype(urb->pipe))
+        {
+            case PIPE_ISOCHRONOUS:
+                transfer_type = CVMX_USB_TRANSFER_ISOCHRONOUS;
+                break;
+            case PIPE_INTERRUPT:
+                transfer_type = CVMX_USB_TRANSFER_INTERRUPT;
+                break;
+            case PIPE_CONTROL:
+                transfer_type = CVMX_USB_TRANSFER_CONTROL;
+                break;
+            default:
+                transfer_type = CVMX_USB_TRANSFER_BULK;
+                break;
+        }
+        switch (urb->dev->speed)
+        {
+            case USB_SPEED_LOW:
+                speed = CVMX_USB_SPEED_LOW;
+                break;
+            case USB_SPEED_FULL:
+                speed = CVMX_USB_SPEED_FULL;
+                break;
+            default:
+                speed = CVMX_USB_SPEED_HIGH;
+                break;
+        }
+        /* For slow devices on high speed ports we need to find the hub that
+            does the speed translation so we know where to send the split
+            transactions */
+        if (speed != CVMX_USB_SPEED_HIGH)
+        {
+            /* Start at this device and work our way up the usb tree */
+            struct usb_device *dev = urb->dev;
+            while (dev->parent)
+            {
+                /* If our parent is high speed then he'll receive the splits */
+                if (dev->parent->speed == USB_SPEED_HIGH)
+                {
+                    split_device = dev->parent->devnum;
+                    split_port = dev->portnum;
+                    break;
+                }
+                /* Move up the tree one level. If we make it all the way up the
+                    tree, then the port must not be in high speed mode and we
+                    don't need a split */
+                dev = dev->parent;
+            }
+        }
+        pipe_handle = cvmx_usb_open_pipe(&priv->usb,
+                                         0,
+                                         usb_pipedevice(urb->pipe),
+                                         usb_pipeendpoint(urb->pipe),
+                                         speed,
+                                         le16_to_cpu(ep->desc.wMaxPacketSize) & 0x7ff,
+                                         transfer_type,
+                                         usb_pipein(urb->pipe) ? CVMX_USB_DIRECTION_IN : CVMX_USB_DIRECTION_OUT,
+                                         urb->interval,
+                                         (le16_to_cpu(ep->desc.wMaxPacketSize)>>11) & 0x3,
+                                         split_device,
+                                         split_port);
+        if (pipe_handle < 0)
+        {
+            spin_unlock_irqrestore(&priv->lock, flags);
+            DEBUG_ERROR("OcteonUSB: %s failed to create pipe\n", __FUNCTION__);
+            return -ENOMEM;
+        }
+        ep->hcpriv = (void*)(0x10000L + pipe_handle);
+    }
+    else
+        pipe_handle = 0xffff & (long)ep->hcpriv;
+
+    switch (usb_pipetype(urb->pipe))
+    {
+        case PIPE_ISOCHRONOUS:
+            DEBUG_SUBMIT("OcteonUSB: %s submit isochronous to %d.%d\n", __FUNCTION__, usb_pipedevice(urb->pipe), usb_pipeendpoint(urb->pipe));
+            /* Allocate a structure to use for our private list of isochronous
+                packets */
+            iso_packet = kmalloc(urb->number_of_packets * sizeof(cvmx_usb_iso_packet_t), GFP_ATOMIC);
+            if (iso_packet)
+            {
+                int i;
+                /* Fill the list with the data from the URB */
+                for (i=0; i<urb->number_of_packets; i++)
+                {
+                    iso_packet[i].offset = urb->iso_frame_desc[i].offset;
+                    iso_packet[i].length = urb->iso_frame_desc[i].length;
+                    iso_packet[i].status = CVMX_USB_COMPLETE_ERROR;
+                }
+                /* Store a pointer to the list in uthe URB setup_pakcet field.
+                    We know this currently isn't being used and this saves us
+                    a bunch of logic */
+                urb->setup_packet = (char*)iso_packet;
+                submit_handle = cvmx_usb_submit_isochronous(&priv->usb, pipe_handle,
+                                                            urb->start_frame,
+                                                            0 /* flags */,
+                                                            urb->number_of_packets,
+                                                            iso_packet,
+                                                            urb->transfer_dma,
+                                                            urb->transfer_buffer_length,
+                                                            octeon_usb_urb_complete_callback,
+                                                            urb);
+                /* If submit failed we need to free our private packet list */
+                if (submit_handle < 0)
+                {
+                    urb->setup_packet = NULL;
+                    kfree(iso_packet);
+                }
+            }
+            break;
+        case PIPE_INTERRUPT:
+            DEBUG_SUBMIT("OcteonUSB: %s submit interrupt to %d.%d\n", __FUNCTION__, usb_pipedevice(urb->pipe), usb_pipeendpoint(urb->pipe));
+            submit_handle = cvmx_usb_submit_interrupt(&priv->usb, pipe_handle,
+                                                      urb->transfer_dma,
+                                                      urb->transfer_buffer_length,
+                                                      octeon_usb_urb_complete_callback,
+                                                      urb);
+            break;
+        case PIPE_CONTROL:
+            DEBUG_SUBMIT("OcteonUSB: %s submit control to %d.%d\n", __FUNCTION__, usb_pipedevice(urb->pipe), usb_pipeendpoint(urb->pipe));
+            submit_handle = cvmx_usb_submit_control(&priv->usb, pipe_handle,
+                                                    urb->setup_dma,
+                                                    urb->transfer_dma,
+                                                    urb->transfer_buffer_length,
+                                                    octeon_usb_urb_complete_callback,
+                                                    urb);
+            break;
+        case PIPE_BULK:
+            DEBUG_SUBMIT("OcteonUSB: %s submit bulk to %d.%d\n", __FUNCTION__, usb_pipedevice(urb->pipe), usb_pipeendpoint(urb->pipe));
+            submit_handle = cvmx_usb_submit_bulk(&priv->usb, pipe_handle,
+                                                 urb->transfer_dma,
+                                                 urb->transfer_buffer_length,
+                                                 octeon_usb_urb_complete_callback,
+                                                 urb);
+            break;
+    }
+    if (submit_handle < 0)
+    {
+        spin_unlock_irqrestore(&priv->lock, flags);
+        DEBUG_ERROR("OcteonUSB: %s failed to submit\n", __FUNCTION__);
+        return -ENOMEM;
+    }
+    urb->hcpriv = (void*)(long)(((submit_handle & 0xffff) << 16) | pipe_handle);
+    spin_unlock_irqrestore(&priv->lock, flags);
+    return 0;
+}
+
+static void octeon_usb_urb_dequeue_work(unsigned long arg)
+{
+    unsigned long flags;
+    struct octeon_hcd *priv = (struct octeon_hcd *)arg;
+
+    spin_lock_irqsave(&priv->lock, flags);
+
+    while (!list_empty(&priv->dequeue_list)) {
+        int pipe_handle;
+        int submit_handle;
+        struct urb *urb = container_of(priv->dequeue_list.next, struct urb, urb_list);
+        list_del(&urb->urb_list);
+        /* not enqueued on dequeue_list */
+        INIT_LIST_HEAD(&urb->urb_list);
+        pipe_handle = 0xffff & (long)urb->hcpriv;
+        submit_handle = ((long)urb->hcpriv) >> 16;
+        cvmx_usb_cancel(&priv->usb, pipe_handle, submit_handle);
+    }
+
+    spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int octeon_usb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
+{
+    struct octeon_hcd *priv = hcd_to_octeon(hcd);
+    unsigned long flags;
+
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+
+    if (!urb->dev)
+        return -EINVAL;
+
+    spin_lock_irqsave(&priv->lock, flags);
+
+    urb->status = status;
+    list_add_tail(&urb->urb_list, &priv->dequeue_list);
+
+    spin_unlock_irqrestore(&priv->lock, flags);
+
+    tasklet_schedule(&priv->dequeue_tasklet);
+
+    return 0;
+}
+
+static void octeon_usb_endpoint_disable(struct usb_hcd *hcd, struct usb_host_endpoint *ep)
+{
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+    if (ep->hcpriv)
+    {
+        struct octeon_hcd *priv = hcd_to_octeon(hcd);
+        int pipe_handle = 0xffff & (long)ep->hcpriv;
+        unsigned long flags;
+        spin_lock_irqsave(&priv->lock, flags);
+        cvmx_usb_cancel_all(&priv->usb, pipe_handle);
+        if (cvmx_usb_close_pipe(&priv->usb, pipe_handle))
+            DEBUG_ERROR("OcteonUSB: Closing pipe %d failed\n", pipe_handle);
+        spin_unlock_irqrestore(&priv->lock, flags);
+        ep->hcpriv = NULL;
+    }
+}
+
+static int octeon_usb_hub_status_data(struct usb_hcd *hcd, char *buf)
+{
+    struct octeon_hcd *priv = hcd_to_octeon(hcd);
+    cvmx_usb_port_status_t port_status;
+    unsigned long flags;
+
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+
+    spin_lock_irqsave(&priv->lock, flags);
+    port_status = cvmx_usb_get_status(&priv->usb);
+    spin_unlock_irqrestore(&priv->lock, flags);
+    buf[0] = 0;
+    buf[0] = port_status.connect_change << 1;
+
+    return(buf[0] != 0);
+}
+
+static int octeon_usb_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue, u16 wIndex, char *buf, u16 wLength)
+{
+    struct octeon_hcd *priv = hcd_to_octeon(hcd);
+    cvmx_usb_port_status_t usb_port_status;
+    int port_status;
+    struct usb_hub_descriptor *desc;
+    unsigned long flags;
+
+    switch (typeReq)
+    {
+        case ClearHubFeature:
+            DEBUG_ROOT_HUB("OcteonUSB: ClearHubFeature\n");
+            switch (wValue)
+            {
+                case C_HUB_LOCAL_POWER:
+                case C_HUB_OVER_CURRENT:
+                    /* Nothing required here */
+                    break;
+                default:
+                    return -EINVAL;
+            }
+            break;
+        case ClearPortFeature:
+            DEBUG_ROOT_HUB("OcteonUSB: ClearPortFeature");
+            if (wIndex != 1)
+            {
+                DEBUG_ROOT_HUB(" INVALID\n");
+                return -EINVAL;
+            }
+
+            switch (wValue)
+            {
+                case USB_PORT_FEAT_ENABLE:
+                    DEBUG_ROOT_HUB(" ENABLE");
+                    spin_lock_irqsave(&priv->lock, flags);
+                    cvmx_usb_disable(&priv->usb);
+                    spin_unlock_irqrestore(&priv->lock, flags);
+                    break;
+                case USB_PORT_FEAT_SUSPEND:
+                    DEBUG_ROOT_HUB(" SUSPEND");
+                    /* Not supported on Octeon */
+                    break;
+                case USB_PORT_FEAT_POWER:
+                    DEBUG_ROOT_HUB(" POWER");
+                    /* Not supported on Octeon */
+                    break;
+                case USB_PORT_FEAT_INDICATOR:
+                    DEBUG_ROOT_HUB(" INDICATOR");
+                    /* Port inidicator not supported */
+                    break;
+                case USB_PORT_FEAT_C_CONNECTION:
+                    DEBUG_ROOT_HUB(" C_CONNECTION");
+                    /* Clears drivers internal connect status change flag */
+                    spin_lock_irqsave(&priv->lock, flags);
+                    cvmx_usb_set_status(&priv->usb, cvmx_usb_get_status(&priv->usb));
+                    spin_unlock_irqrestore(&priv->lock, flags);
+                    break;
+                case USB_PORT_FEAT_C_RESET:
+                    DEBUG_ROOT_HUB(" C_RESET");
+                    /* Clears the driver's internal Port Reset Change flag */
+                    spin_lock_irqsave(&priv->lock, flags);
+                    cvmx_usb_set_status(&priv->usb, cvmx_usb_get_status(&priv->usb));
+                    spin_unlock_irqrestore(&priv->lock, flags);
+                    break;
+                case USB_PORT_FEAT_C_ENABLE:
+                    DEBUG_ROOT_HUB(" C_ENABLE");
+                    /* Clears the driver's internal Port Enable/Disable Change flag */
+                    spin_lock_irqsave(&priv->lock, flags);
+                    cvmx_usb_set_status(&priv->usb, cvmx_usb_get_status(&priv->usb));
+                    spin_unlock_irqrestore(&priv->lock, flags);
+                    break;
+                case USB_PORT_FEAT_C_SUSPEND:
+                    DEBUG_ROOT_HUB(" C_SUSPEND");
+                    /* Clears the driver's internal Port Suspend Change flag,
+                        which is set when resume signaling on the host port is
+                        complete */
+                    break;
+                case USB_PORT_FEAT_C_OVER_CURRENT:
+                    DEBUG_ROOT_HUB(" C_OVER_CURRENT");
+                    /* Clears the driver's overcurrent Change flag */
+                    spin_lock_irqsave(&priv->lock, flags);
+                    cvmx_usb_set_status(&priv->usb, cvmx_usb_get_status(&priv->usb));
+                    spin_unlock_irqrestore(&priv->lock, flags);
+                    break;
+                default:
+                    DEBUG_ROOT_HUB(" UNKNOWN\n");
+                    return -EINVAL;
+            }
+            DEBUG_ROOT_HUB("\n");
+            break;
+        case GetHubDescriptor:
+            DEBUG_ROOT_HUB("OcteonUSB: GetHubDescriptor\n");
+            desc = (struct usb_hub_descriptor *)buf;
+            desc->bDescLength = 9;
+            desc->bDescriptorType = 0x29;
+            desc->bNbrPorts = 1;
+            desc->wHubCharacteristics = 0x08;
+            desc->bPwrOn2PwrGood = 1;
+            desc->bHubContrCurrent = 0;
+            desc->u.hs.DeviceRemovable[0] = 0;
+            desc->u.hs.DeviceRemovable[1] = 0xff;
+            break;
+        case GetHubStatus:
+            DEBUG_ROOT_HUB("OcteonUSB: GetHubStatus\n");
+            *(__le32 *)buf = 0;
+            break;
+        case GetPortStatus:
+            DEBUG_ROOT_HUB("OcteonUSB: GetPortStatus");
+            if (wIndex != 1)
+            {
+                DEBUG_ROOT_HUB(" INVALID\n");
+                return -EINVAL;
+            }
+
+            spin_lock_irqsave(&priv->lock, flags);
+            usb_port_status = cvmx_usb_get_status(&priv->usb);
+            spin_unlock_irqrestore(&priv->lock, flags);
+            port_status = 0;
+
+            if (usb_port_status.connect_change)
+            {
+                port_status |= (1 << USB_PORT_FEAT_C_CONNECTION);
+                DEBUG_ROOT_HUB(" C_CONNECTION");
+            }
+
+            if (usb_port_status.port_enabled)
+            {
+                port_status |= (1 << USB_PORT_FEAT_C_ENABLE);
+                DEBUG_ROOT_HUB(" C_ENABLE");
+            }
+
+            if (usb_port_status.connected)
+            {
+                port_status |= (1 << USB_PORT_FEAT_CONNECTION);
+                DEBUG_ROOT_HUB(" CONNECTION");
+            }
+
+            if (usb_port_status.port_enabled)
+            {
+                port_status |= (1 << USB_PORT_FEAT_ENABLE);
+                DEBUG_ROOT_HUB(" ENABLE");
+            }
+
+            if (usb_port_status.port_over_current)
+            {
+                port_status |= (1 << USB_PORT_FEAT_OVER_CURRENT);
+                DEBUG_ROOT_HUB(" OVER_CURRENT");
+            }
+
+            if (usb_port_status.port_powered)
+            {
+                port_status |= (1 << USB_PORT_FEAT_POWER);
+                DEBUG_ROOT_HUB(" POWER");
+            }
+
+            if (usb_port_status.port_speed == CVMX_USB_SPEED_HIGH)
+            {
+		port_status |= USB_PORT_STAT_HIGH_SPEED;
+                DEBUG_ROOT_HUB(" HIGHSPEED");
+            }
+            else if (usb_port_status.port_speed == CVMX_USB_SPEED_LOW)
+            {
+                port_status |= (1 << USB_PORT_FEAT_LOWSPEED);
+                DEBUG_ROOT_HUB(" LOWSPEED");
+            }
+
+            *((__le32 *)buf) = cpu_to_le32(port_status);
+            DEBUG_ROOT_HUB("\n");
+            break;
+        case SetHubFeature:
+            DEBUG_ROOT_HUB("OcteonUSB: SetHubFeature\n");
+            /* No HUB features supported */
+            break;
+        case SetPortFeature:
+            DEBUG_ROOT_HUB("OcteonUSB: SetPortFeature");
+            if (wIndex != 1)
+            {
+                DEBUG_ROOT_HUB(" INVALID\n");
+                return -EINVAL;
+            }
+
+            switch (wValue)
+            {
+                case USB_PORT_FEAT_SUSPEND:
+                    DEBUG_ROOT_HUB(" SUSPEND\n");
+                    return -EINVAL;
+                case USB_PORT_FEAT_POWER:
+                    DEBUG_ROOT_HUB(" POWER\n");
+                    return -EINVAL;
+                case USB_PORT_FEAT_RESET:
+                    DEBUG_ROOT_HUB(" RESET\n");
+                    spin_lock_irqsave(&priv->lock, flags);
+                    cvmx_usb_disable(&priv->usb);
+                    if (cvmx_usb_enable(&priv->usb))
+                        DEBUG_ERROR("Failed to enable the port\n");
+                    spin_unlock_irqrestore(&priv->lock, flags);
+                    return 0;
+                case USB_PORT_FEAT_INDICATOR:
+                    DEBUG_ROOT_HUB(" INDICATOR\n");
+                    /* Not supported */
+                    break;
+                default:
+                    DEBUG_ROOT_HUB(" UNKNOWN\n");
+                    return -EINVAL;
+            }
+            break;
+        default:
+            DEBUG_ROOT_HUB("OcteonUSB: Unknown root hub request\n");
+            return -EINVAL;
+    }
+    return 0;
+}
+
+
+static const struct hc_driver octeon_hc_driver = {
+    .description =      "Octeon USB",
+    .product_desc =     "Octeon Host Controller",
+    .hcd_priv_size =    sizeof(struct octeon_hcd),
+    .irq =              octeon_usb_irq,
+    .flags =            HCD_MEMORY | HCD_USB2,
+    .start =            octeon_usb_start,
+    .stop =             octeon_usb_stop,
+    .urb_enqueue =      octeon_usb_urb_enqueue,
+    .urb_dequeue =      octeon_usb_urb_dequeue,
+    .endpoint_disable = octeon_usb_endpoint_disable,
+    .get_frame_number = octeon_usb_get_frame_number,
+    .hub_status_data =  octeon_usb_hub_status_data,
+    .hub_control =      octeon_usb_hub_control,
+};
+
+
+static int octeon_usb_driver_probe(struct device *dev)
+{
+    int status;
+    int usb_num = to_platform_device(dev)->id;
+    int irq = platform_get_irq(to_platform_device(dev), 0);
+    struct octeon_hcd *priv;
+    struct usb_hcd *hcd;
+    unsigned long flags;
+
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+
+    /* Set the DMA mask to 64bits so we get buffers already translated for
+        DMA */
+    dev->coherent_dma_mask = ~0;
+    dev->dma_mask = &dev->coherent_dma_mask;
+
+    hcd = usb_create_hcd(&octeon_hc_driver, dev, dev_name(dev));
+    if (!hcd)
+    {
+        DEBUG_FATAL("OcteonUSB: Failed to allocate memory for HCD\n");
+        return -1;
+    }
+    hcd->uses_new_polling = 1;
+    priv = (struct octeon_hcd *)hcd->hcd_priv;
+
+    spin_lock_init(&priv->lock);
+
+    tasklet_init(&priv->dequeue_tasklet, octeon_usb_urb_dequeue_work, (unsigned long)priv);
+    INIT_LIST_HEAD(&priv->dequeue_list);
+
+    //status = cvmx_usb_initialize(&priv->usb, usb_num, CVMX_USB_INITIALIZE_FLAGS_CLOCK_AUTO | CVMX_USB_INITIALIZE_FLAGS_DEBUG_INFO | CVMX_USB_INITIALIZE_FLAGS_DEBUG_TRANSFERS | CVMX_USB_INITIALIZE_FLAGS_DEBUG_CALLBACKS);
+    status = cvmx_usb_initialize(&priv->usb, usb_num, CVMX_USB_INITIALIZE_FLAGS_CLOCK_AUTO);
+    if (status)
+    {
+        DEBUG_FATAL("OcteonUSB: USB initialization failed with %d\n", status);
+        kfree(hcd);
+        return -1;
+    }
+
+    /* This delay is needed for CN3010, but I don't know why... */
+    mdelay(10);
+
+    spin_lock_irqsave(&priv->lock, flags);
+    cvmx_usb_poll(&priv->usb);
+    spin_unlock_irqrestore(&priv->lock, flags);
+
+    status = usb_add_hcd(hcd, irq, IRQF_SHARED);
+    if (status)
+    {
+        DEBUG_FATAL("OcteonUSB: USB add HCD failed with %d\n", status);
+        kfree(hcd);
+        return -1;
+    }
+
+    printk("OcteonUSB: Registered HCD for port %d on irq %d\n", usb_num, irq);
+
+    return 0;
+}
+
+static int octeon_usb_driver_remove(struct device *dev)
+{
+    int status;
+    struct usb_hcd *hcd = dev_get_drvdata(dev);
+    struct octeon_hcd *priv = hcd_to_octeon(hcd);
+    unsigned long flags;
+
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+
+    usb_remove_hcd(hcd);
+    tasklet_kill(&priv->dequeue_tasklet);
+    spin_lock_irqsave(&priv->lock, flags);
+    status = cvmx_usb_shutdown(&priv->usb);
+    spin_unlock_irqrestore(&priv->lock, flags);
+    if (status)
+        DEBUG_FATAL("OcteonUSB: USB shutdown failed with %d\n", status);
+
+    kfree(hcd);
+
+    return 0;
+}
+
+static struct device_driver octeon_usb_driver = {
+    .name       = "OcteonUSB",
+    .bus        = &platform_bus_type,
+    .probe      = octeon_usb_driver_probe,
+    .remove     = octeon_usb_driver_remove,
+};
+
+
+#define MAX_USB_PORTS   10
+struct platform_device *pdev_glob[MAX_USB_PORTS];
+static int octeon_usb_registered;
+static int __init octeon_usb_module_init(void)
+{
+    int num_devices = cvmx_usb_get_num_ports();
+    int device;
+
+    if (usb_disabled() || num_devices == 0)
+	return -ENODEV;
+
+    if (driver_register(&octeon_usb_driver))
+    {
+        DEBUG_FATAL("OcteonUSB: Failed to register driver\n");
+        return -ENOMEM;
+    }
+    octeon_usb_registered = 1;
+    printk("OcteonUSB: Detected %d ports\n", num_devices);
+
+	/*
+	 * Only cn52XX and cn56XX have DWC_OTG USB hardware and the
+	 * IOB priority registers.  Under heavy network load USB
+	 * hardware can be starved by the IOB causing a crash.  Give
+	 * it a priority boost if it has been waiting more than 400
+	 * cycles to avoid this situation.
+	 *
+	 * Testing indicates that a cnt_val of 8192 is not sufficient,
+	 * but no failures are seen with 4096.  We choose a value of
+	 * 400 to give a safety factor of 10.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX) || OCTEON_IS_MODEL(OCTEON_CN56XX)) {
+		union cvmx_iob_n2c_l2c_pri_cnt pri_cnt;
+
+		pri_cnt.u64 = 0;
+		pri_cnt.s.cnt_enb = 1;
+		pri_cnt.s.cnt_val = 400;
+		cvmx_write_csr(CVMX_IOB_N2C_L2C_PRI_CNT, pri_cnt.u64);
+	}
+
+    for (device = 0; device < num_devices; device++)
+    {
+        struct resource irq_resource;
+        struct platform_device *pdev;
+        memset(&irq_resource, 0, sizeof(irq_resource));
+        irq_resource.start = (device==0) ? OCTEON_IRQ_USB0 : OCTEON_IRQ_USB1;
+        irq_resource.end = irq_resource.start;
+        irq_resource.flags = IORESOURCE_IRQ;
+        pdev = platform_device_register_simple((char*)octeon_usb_driver.name, device, &irq_resource, 1);
+        if (!pdev)
+        {
+            DEBUG_FATAL("OcteonUSB: Failed to allocate platform device for USB%d\n", device);
+            return -ENOMEM;
+        }
+        if (device < MAX_USB_PORTS)
+            pdev_glob[device] = pdev;
+
+    }
+    return 0;
+}
+
+static void __exit octeon_usb_module_cleanup(void)
+{
+    int i;
+    DEBUG_CALL("OcteonUSB: %s called\n", __FUNCTION__);
+    for (i = 0; i <MAX_USB_PORTS; i++)
+        if (pdev_glob[i])
+        {
+            platform_device_unregister(pdev_glob[i]);
+            pdev_glob[i] = NULL;
+        }
+	if (octeon_usb_registered)
+		driver_unregister(&octeon_usb_driver);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium Networks <support@caviumnetworks.com>");
+MODULE_DESCRIPTION("Cavium Networks Octeon USB Host driver.");
+module_init(octeon_usb_module_init);
+module_exit(octeon_usb_module_cleanup);
-- 
1.7.10.4
