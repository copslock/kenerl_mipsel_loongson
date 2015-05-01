Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:41:04 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49112 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026386AbbEATiASLbCU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:38:00 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 39A0C56F430;
        Fri,  1 May 2015 22:37:57 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id gJuFgRO4k61B; Fri,  1 May 2015 22:37:52 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id D9EB45BC00E;
        Fri,  1 May 2015 22:37:48 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 11/11] MIPS: OCTEON: move all ethernet-specific headers to staging
Date:   Fri,  1 May 2015 22:37:13 +0300
Message-Id: <1430509033-12113-12-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47198
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

Move all ethernet-specific headers to staging.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/include/asm/octeon/cvmx-helper-board.h   |  70 -------
 arch/mips/include/asm/octeon/cvmx-helper.h         | 124 ------------
 .../asm => drivers/staging}/octeon/cvmx-address.h  |   0
 .../staging}/octeon/cvmx-asxx-defs.h               |   0
 drivers/staging/octeon/cvmx-cmd-queue.c            |  11 +-
 .../staging}/octeon/cvmx-cmd-queue.h               |   4 +-
 .../asm => drivers/staging}/octeon/cvmx-dbg-defs.h |   0
 .../asm => drivers/staging}/octeon/cvmx-fau.h      |   0
 .../asm => drivers/staging}/octeon/cvmx-fpa-defs.h |   0
 .../asm => drivers/staging}/octeon/cvmx-fpa.h      |   4 +-
 drivers/staging/octeon/cvmx-helper-ethernet.c      |  25 ++-
 drivers/staging/octeon/cvmx-helper-ethernet.h      | 219 +++++++++++++++++++++
 drivers/staging/octeon/cvmx-helper-loop.c          |   6 +-
 .../staging}/octeon/cvmx-helper-loop.h             |   0
 drivers/staging/octeon/cvmx-helper-npi.c           |   6 +-
 .../staging}/octeon/cvmx-helper-npi.h              |   0
 drivers/staging/octeon/cvmx-helper-rgmii.c         |  17 +-
 .../staging}/octeon/cvmx-helper-rgmii.h            |   2 +
 drivers/staging/octeon/cvmx-helper-sgmii.c         |  11 +-
 .../staging}/octeon/cvmx-helper-sgmii.h            |   2 +
 drivers/staging/octeon/cvmx-helper-spi.c           |   9 +-
 .../staging}/octeon/cvmx-helper-spi.h              |   2 +
 drivers/staging/octeon/cvmx-helper-util.c          |  18 +-
 .../staging}/octeon/cvmx-helper-util.h             |   3 +
 drivers/staging/octeon/cvmx-helper-xaui.c          |  11 +-
 .../staging}/octeon/cvmx-helper-xaui.h             |   2 +
 drivers/staging/octeon/cvmx-interrupt-decodes.c    |  11 +-
 drivers/staging/octeon/cvmx-interrupt-rsl.c        |   5 +-
 .../asm => drivers/staging}/octeon/cvmx-ipd.h      |   3 +-
 drivers/staging/octeon/cvmx-link.c                 |  15 +-
 .../asm => drivers/staging}/octeon/cvmx-mdio.h     |   0
 .../staging}/octeon/cvmx-pcsx-defs.h               |   0
 .../staging}/octeon/cvmx-pcsxx-defs.h              |   0
 .../asm => drivers/staging}/octeon/cvmx-pip-defs.h |   0
 .../asm => drivers/staging}/octeon/cvmx-pip.h      |   6 +-
 .../asm => drivers/staging}/octeon/cvmx-pko-defs.h |   0
 drivers/staging/octeon/cvmx-pko.c                  |   6 +-
 .../asm => drivers/staging}/octeon/cvmx-pko.h      |   8 +-
 .../asm => drivers/staging}/octeon/cvmx-pow.h      |   5 +-
 .../asm => drivers/staging}/octeon/cvmx-scratch.h  |   0
 drivers/staging/octeon/cvmx-spi.c                  |  12 +-
 .../staging}/octeon/cvmx-spxx-defs.h               |   0
 .../staging}/octeon/cvmx-srxx-defs.h               |   0
 .../staging}/octeon/cvmx-stxx-defs.h               |   0
 .../asm => drivers/staging}/octeon/cvmx-wqe.h      |   0
 drivers/staging/octeon/ethernet-mem.c              |   6 +-
 drivers/staging/octeon/ethernet-rgmii.c            |  18 +-
 drivers/staging/octeon/ethernet-rx.c               |  24 ++-
 drivers/staging/octeon/ethernet-rx.h               |   4 +-
 drivers/staging/octeon/ethernet-spi.c              |  17 +-
 drivers/staging/octeon/ethernet-tx.c               |  19 +-
 drivers/staging/octeon/ethernet-xaui.c             |  14 +-
 drivers/staging/octeon/ethernet.c                  |  40 ++--
 drivers/staging/octeon/octeon-ethernet.h           |   3 +-
 54 files changed, 390 insertions(+), 372 deletions(-)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-address.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-asxx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-cmd-queue.h (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-dbg-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-fau.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-fpa-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-fpa.h (99%)
 create mode 100644 drivers/staging/octeon/cvmx-helper-ethernet.h
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-loop.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-npi.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-rgmii.h (98%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-sgmii.h (98%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-spi.h (98%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-util.h (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-xaui.h (98%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-ipd.h (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-mdio.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pcsx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pcsxx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pip-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pip.h (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pko-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pko.h (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pow.h (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-scratch.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-spxx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-srxx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-stxx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-wqe.h (100%)

diff --git a/arch/mips/include/asm/octeon/cvmx-helper-board.h b/arch/mips/include/asm/octeon/cvmx-helper-board.h
index 8933203..b066504 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-board.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-board.h
@@ -43,14 +43,6 @@ enum cvmx_helper_board_usb_clock_types {
 	USB_CLOCK_TYPE_CRYSTAL_12,
 };
 
-typedef enum {
-	set_phy_link_flags_autoneg = 0x1,
-	set_phy_link_flags_flow_control_dont_touch = 0x0 << 1,
-	set_phy_link_flags_flow_control_enable = 0x1 << 1,
-	set_phy_link_flags_flow_control_disable = 0x2 << 1,
-	set_phy_link_flags_flow_control_mask = 0x3 << 1,	/* Mask for 2 bit wide flow control field */
-} cvmx_helper_board_set_phy_link_flags_types_t;
-
 /*
  * Fake IPD port, the RGMII/MII interface may use different PHY, use
  * this macro to return appropriate MIX address to read the PHY.
@@ -58,16 +50,6 @@ typedef enum {
 #define CVMX_HELPER_BOARD_MGMT_IPD_PORT	    -10
 
 /**
- * cvmx_override_board_link_get(int ipd_port) is a function
- * pointer. It is meant to allow customization of the process of
- * talking to a PHY to determine link speed. It is called every
- * time a PHY must be polled for link status. Users should set
- * this pointer to a function before calling any cvmx-helper
- * operations.
- */
-extern cvmx_helper_link_info_t(*cvmx_override_board_link_get) (int ipd_port);
-
-/**
  * Return the MII PHY address associated with the given IPD
  * port. A result of -1 means there isn't a MII capable PHY
  * connected to this port. On chips supporting multiple MII
@@ -86,46 +68,6 @@ extern cvmx_helper_link_info_t(*cvmx_override_board_link_get) (int ipd_port);
 extern int cvmx_helper_board_get_mii_address(int ipd_port);
 
 /**
- * This function as a board specific method of changing the PHY
- * speed, duplex, and autonegotiation. This programs the PHY and
- * not Octeon. This can be used to force Octeon's links to
- * specific settings.
- *
- * @phy_addr:  The address of the PHY to program
- * @link_flags:
- *		    Flags to control autonegotiation.  Bit 0 is autonegotiation
- *		    enable/disable to maintain backware compatibility.
- * @link_info: Link speed to program. If the speed is zero and autonegotiation
- *		    is enabled, all possible negotiation speeds are advertised.
- *
- * Returns Zero on success, negative on failure
- */
-int cvmx_helper_board_link_set_phy(int phy_addr,
-				   cvmx_helper_board_set_phy_link_flags_types_t
-				   link_flags,
-				   cvmx_helper_link_info_t link_info);
-
-/**
- * This function is the board specific method of determining an
- * ethernet ports link speed. Most Octeon boards have Marvell PHYs
- * and are handled by the fall through case. This function must be
- * updated for boards that don't have the normal Marvell PHYs.
- *
- * This function must be modifed for every new Octeon board.
- * Internally it uses switch statements based on the cvmx_sysinfo
- * data to determine board types and revisions. It relys on the
- * fact that every Octeon board receives a unique board type
- * enumeration from the bootloader.
- *
- * @ipd_port: IPD input port associated with the port we want to get link
- *		   status for.
- *
- * Returns The ports link status. If the link isn't fully resolved, this must
- *	   return zero.
- */
-extern cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port);
-
-/**
  * This function is called by cvmx_helper_interface_probe() after it
  * determines the number of ports Octeon can support on a specific
  * interface. This function is the per board location to override
@@ -149,18 +91,6 @@ extern cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port);
 extern int __cvmx_helper_board_interface_probe(int interface,
 					       int supported_ports);
 
-/**
- * Enable packet input/output from the hardware. This function is
- * called after by cvmx_helper_packet_hardware_enable() to
- * perform board specific initialization. For most boards
- * nothing is needed.
- *
- * @interface: Interface to enable
- *
- * Returns Zero on success, negative on failure
- */
-extern int __cvmx_helper_board_hardware_enable(int interface);
-
 enum cvmx_helper_board_usb_clock_types __cvmx_helper_board_usb_get_clock_type(void);
 
 #endif /* __CVMX_HELPER_BOARD_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-helper.h b/arch/mips/include/asm/octeon/cvmx-helper.h
index 5a3090d..e912659 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper.h
@@ -35,8 +35,6 @@
 #define __CVMX_HELPER_H__
 
 #include <asm/octeon/cvmx-config.h>
-#include <asm/octeon/cvmx-fpa.h>
-#include <asm/octeon/cvmx-wqe.h>
 
 typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
@@ -51,74 +49,7 @@ typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
 } cvmx_helper_interface_mode_t;
 
-typedef union {
-	uint64_t u64;
-	struct {
-		uint64_t reserved_20_63:44;
-		uint64_t link_up:1;	    /**< Is the physical link up? */
-		uint64_t full_duplex:1;	    /**< 1 if the link is full duplex */
-		uint64_t speed:18;	    /**< Speed of the link in Mbps */
-	} s;
-} cvmx_helper_link_info_t;
-
 #include <asm/octeon/cvmx-helper-errata.h>
-#include <asm/octeon/cvmx-helper-loop.h>
-#include <asm/octeon/cvmx-helper-npi.h>
-#include <asm/octeon/cvmx-helper-rgmii.h>
-#include <asm/octeon/cvmx-helper-sgmii.h>
-#include <asm/octeon/cvmx-helper-spi.h>
-#include <asm/octeon/cvmx-helper-util.h>
-#include <asm/octeon/cvmx-helper-xaui.h>
-
-/**
- * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
- * priorities[16]) is a function pointer. It is meant to allow
- * customization of the PKO queue priorities based on the port
- * number. Users should set this pointer to a function before
- * calling any cvmx-helper operations.
- */
-extern void (*cvmx_override_pko_queue_priority) (int pko_port,
-						 uint64_t priorities[16]);
-
-/**
- * cvmx_override_ipd_port_setup(int ipd_port) is a function
- * pointer. It is meant to allow customization of the IPD port
- * setup before packet input/output comes online. It is called
- * after cvmx-helper does the default IPD configuration, but
- * before IPD is enabled. Users should set this pointer to a
- * function before calling any cvmx-helper operations.
- */
-extern void (*cvmx_override_ipd_port_setup) (int ipd_port);
-
-/**
- * This function enables the IPD and also enables the packet interfaces.
- * The packet interfaces (RGMII and SPI) must be enabled after the
- * IPD.	 This should be called by the user program after any additional
- * IPD configuration changes are made if CVMX_HELPER_ENABLE_IPD
- * is not set in the executive-config.h file.
- *
- * Returns 0 on success
- *	   -1 on failure
- */
-extern int cvmx_helper_ipd_and_packet_input_enable(void);
-
-/**
- * Initialize the PIP, IPD, and PKO hardware to support
- * simple priority based queues for the ethernet ports. Each
- * port is configured with a number of priority queues based
- * on CVMX_PKO_QUEUES_PER_PORT_* where each queue is lower
- * priority than the previous.
- *
- * Returns Zero on success, non-zero on failure
- */
-extern int cvmx_helper_initialize_packet_io_global(void);
-
-/**
- * Does core local initialization for packet io
- *
- * Returns Zero on success, non-zero on failure
- */
-extern int cvmx_helper_initialize_packet_io_local(void);
 
 /**
  * Returns the number of ports on the given interface.
@@ -156,44 +87,6 @@ extern cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
 								   interface);
 
 /**
- * Auto configure an IPD/PKO port link state and speed. This
- * function basically does the equivalent of:
- * cvmx_helper_link_set(ipd_port, cvmx_helper_link_get(ipd_port));
- *
- * @ipd_port: IPD/PKO port to auto configure
- *
- * Returns Link state after configure
- */
-extern cvmx_helper_link_info_t cvmx_helper_link_autoconf(int ipd_port);
-
-/**
- * Return the link state of an IPD/PKO port as returned by
- * auto negotiation. The result of this function may not match
- * Octeon's link config if auto negotiation has changed since
- * the last call to cvmx_helper_link_set().
- *
- * @ipd_port: IPD/PKO port to query
- *
- * Returns Link state
- */
-extern cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port);
-
-/**
- * Configure an IPD/PKO port for the specified link state. This
- * function does not influence auto negotiation at the PHY level.
- * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
- *
- * @ipd_port:  IPD/PKO port to configure
- * @link_info: The new link state
- *
- * Returns Zero on success, negative on failure
- */
-extern int cvmx_helper_link_set(int ipd_port,
-				cvmx_helper_link_info_t link_info);
-
-/**
  * This function probes an interface to determine the actual
  * number of hardware ports connected to it. It doesn't setup the
  * ports or enable them. The main goal here is to set the global
@@ -204,23 +97,6 @@ extern int cvmx_helper_link_set(int ipd_port,
  *
  * Returns Zero on success, negative on failure
  */
-extern int cvmx_helper_interface_probe(int interface);
 extern int cvmx_helper_interface_enumerate(int interface);
 
-/**
- * Configure a port for internal and/or external loopback. Internal loopback
- * causes packets sent by the port to be received by Octeon. External loopback
- * causes packets received from the wire to sent out again.
- *
- * @ipd_port: IPD/PKO port to loopback.
- * @enable_internal:
- *		   Non zero if you want internal loopback
- * @enable_external:
- *		   Non zero if you want external loopback
- *
- * Returns Zero on success, negative on failure.
- */
-extern int cvmx_helper_configure_loopback(int ipd_port, int enable_internal,
-					  int enable_external);
-
 #endif /* __CVMX_HELPER_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-address.h b/drivers/staging/octeon/cvmx-address.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-address.h
rename to drivers/staging/octeon/cvmx-address.h
diff --git a/arch/mips/include/asm/octeon/cvmx-asxx-defs.h b/drivers/staging/octeon/cvmx-asxx-defs.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-asxx-defs.h
rename to drivers/staging/octeon/cvmx-asxx-defs.h
diff --git a/drivers/staging/octeon/cvmx-cmd-queue.c b/drivers/staging/octeon/cvmx-cmd-queue.c
index 132bccc..52bfdd2 100644
--- a/drivers/staging/octeon/cvmx-cmd-queue.c
+++ b/drivers/staging/octeon/cvmx-cmd-queue.c
@@ -29,18 +29,15 @@
  * Support functions for managing command queues used for
  * various hardware blocks.
  */
-
 #include <linux/kernel.h>
-
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-#include <asm/octeon/cvmx-fpa.h>
-#include <asm/octeon/cvmx-cmd-queue.h>
-
 #include <asm/octeon/cvmx-npei-defs.h>
 #include <asm/octeon/cvmx-pexp-defs.h>
-#include <asm/octeon/cvmx-pko-defs.h>
+
+#include "cvmx-fpa.h"
+#include "cvmx-pko-defs.h"
+#include "cvmx-cmd-queue.h"
 
 /**
  * This application uses this pointer to access the global queue
diff --git a/arch/mips/include/asm/octeon/cvmx-cmd-queue.h b/drivers/staging/octeon/cvmx-cmd-queue.h
similarity index 99%
rename from arch/mips/include/asm/octeon/cvmx-cmd-queue.h
rename to drivers/staging/octeon/cvmx-cmd-queue.h
index 8d05d90..427cc45 100644
--- a/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
+++ b/drivers/staging/octeon/cvmx-cmd-queue.h
@@ -74,11 +74,11 @@
 #ifndef __CVMX_CMD_QUEUE_H__
 #define __CVMX_CMD_QUEUE_H__
 
+#include <asm/compiler.h>
 #include <linux/prefetch.h>
 
-#include <asm/compiler.h>
+#include "cvmx-fpa.h"
 
-#include <asm/octeon/cvmx-fpa.h>
 /**
  * By default we disable the max depth support. Most programs
  * don't use it and it slows down the command queue processing
diff --git a/arch/mips/include/asm/octeon/cvmx-dbg-defs.h b/drivers/staging/octeon/cvmx-dbg-defs.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-dbg-defs.h
rename to drivers/staging/octeon/cvmx-dbg-defs.h
diff --git a/arch/mips/include/asm/octeon/cvmx-fau.h b/drivers/staging/octeon/cvmx-fau.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-fau.h
rename to drivers/staging/octeon/cvmx-fau.h
diff --git a/arch/mips/include/asm/octeon/cvmx-fpa-defs.h b/drivers/staging/octeon/cvmx-fpa-defs.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-fpa-defs.h
rename to drivers/staging/octeon/cvmx-fpa-defs.h
diff --git a/arch/mips/include/asm/octeon/cvmx-fpa.h b/drivers/staging/octeon/cvmx-fpa.h
similarity index 99%
rename from arch/mips/include/asm/octeon/cvmx-fpa.h
rename to drivers/staging/octeon/cvmx-fpa.h
index c00501d..8847e29 100644
--- a/arch/mips/include/asm/octeon/cvmx-fpa.h
+++ b/drivers/staging/octeon/cvmx-fpa.h
@@ -36,8 +36,8 @@
 #ifndef __CVMX_FPA_H__
 #define __CVMX_FPA_H__
 
-#include <asm/octeon/cvmx-address.h>
-#include <asm/octeon/cvmx-fpa-defs.h>
+#include "cvmx-address.h"
+#include "cvmx-fpa-defs.h"
 
 #define CVMX_FPA_NUM_POOLS	8
 #define CVMX_FPA_MIN_BLOCK_SIZE 128
diff --git a/drivers/staging/octeon/cvmx-helper-ethernet.c b/drivers/staging/octeon/cvmx-helper-ethernet.c
index ba90678..81c0657 100644
--- a/drivers/staging/octeon/cvmx-helper-ethernet.c
+++ b/drivers/staging/octeon/cvmx-helper-ethernet.c
@@ -9,17 +9,26 @@
  */
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-config.h>
-#include <asm/octeon/cvmx-fpa.h>
-#include <asm/octeon/cvmx-pip.h>
-#include <asm/octeon/cvmx-pko.h>
-#include <asm/octeon/cvmx-ipd.h>
 #include <asm/octeon/cvmx-spi.h>
+#include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-helper-board.h>
-#include <asm/octeon/cvmx-pip-defs.h>
 #include <asm/octeon/cvmx-smix-defs.h>
-#include <asm/octeon/cvmx-asxx-defs.h>
+#include <asm/octeon/cvmx-helper-board.h>
+
+#include "cvmx-fpa.h"
+#include "cvmx-pip.h"
+#include "cvmx-pko.h"
+#include "cvmx-ipd.h"
+#include "cvmx-pip-defs.h"
+#include "cvmx-asxx-defs.h"
+#include "cvmx-helper-npi.h"
+#include "cvmx-helper-spi.h"
+#include "cvmx-helper-loop.h"
+#include "cvmx-helper-util.h"
+#include "cvmx-helper-xaui.h"
+#include "cvmx-helper-rgmii.h"
+#include "cvmx-helper-sgmii.h"
+#include "cvmx-helper-ethernet.h"
 
 /**
  * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
diff --git a/drivers/staging/octeon/cvmx-helper-ethernet.h b/drivers/staging/octeon/cvmx-helper-ethernet.h
new file mode 100644
index 0000000..6fbfb213
--- /dev/null
+++ b/drivers/staging/octeon/cvmx-helper-ethernet.h
@@ -0,0 +1,219 @@
+/*
+ * This file is based on code from OCTEON SDK by Cavium Networks.
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ *
+ * Helper functions for common, but complicated tasks.
+ *
+ */
+
+#ifndef __CVMX_HELPER_ETHERNET_H__
+#define __CVMX_HELPER_ETHERNET_H__
+
+#include <asm/octeon/cvmx-config.h>
+
+typedef union {
+	uint64_t u64;
+	struct {
+		uint64_t reserved_20_63:44;
+		uint64_t link_up:1;	    /**< Is the physical link up? */
+		uint64_t full_duplex:1;	    /**< 1 if the link is full duplex */
+		uint64_t speed:18;	    /**< Speed of the link in Mbps */
+	} s;
+} cvmx_helper_link_info_t;
+
+/**
+ * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
+ * priorities[16]) is a function pointer. It is meant to allow
+ * customization of the PKO queue priorities based on the port
+ * number. Users should set this pointer to a function before
+ * calling any cvmx-helper operations.
+ */
+extern void (*cvmx_override_pko_queue_priority) (int pko_port,
+						 uint64_t priorities[16]);
+
+/**
+ * cvmx_override_ipd_port_setup(int ipd_port) is a function
+ * pointer. It is meant to allow customization of the IPD port
+ * setup before packet input/output comes online. It is called
+ * after cvmx-helper does the default IPD configuration, but
+ * before IPD is enabled. Users should set this pointer to a
+ * function before calling any cvmx-helper operations.
+ */
+extern void (*cvmx_override_ipd_port_setup) (int ipd_port);
+
+/**
+ * This function enables the IPD and also enables the packet interfaces.
+ * The packet interfaces (RGMII and SPI) must be enabled after the
+ * IPD.	 This should be called by the user program after any additional
+ * IPD configuration changes are made if CVMX_HELPER_ENABLE_IPD
+ * is not set in the executive-config.h file.
+ *
+ * Returns 0 on success
+ *	   -1 on failure
+ */
+extern int cvmx_helper_ipd_and_packet_input_enable(void);
+
+/**
+ * Initialize the PIP, IPD, and PKO hardware to support
+ * simple priority based queues for the ethernet ports. Each
+ * port is configured with a number of priority queues based
+ * on CVMX_PKO_QUEUES_PER_PORT_* where each queue is lower
+ * priority than the previous.
+ *
+ * Returns Zero on success, non-zero on failure
+ */
+extern int cvmx_helper_initialize_packet_io_global(void);
+
+/**
+ * Does core local initialization for packet io
+ *
+ * Returns Zero on success, non-zero on failure
+ */
+extern int cvmx_helper_initialize_packet_io_local(void);
+
+/**
+ * Auto configure an IPD/PKO port link state and speed. This
+ * function basically does the equivalent of:
+ * cvmx_helper_link_set(ipd_port, cvmx_helper_link_get(ipd_port));
+ *
+ * @ipd_port: IPD/PKO port to auto configure
+ *
+ * Returns Link state after configure
+ */
+extern cvmx_helper_link_info_t cvmx_helper_link_autoconf(int ipd_port);
+
+/**
+ * Return the link state of an IPD/PKO port as returned by
+ * auto negotiation. The result of this function may not match
+ * Octeon's link config if auto negotiation has changed since
+ * the last call to cvmx_helper_link_set().
+ *
+ * @ipd_port: IPD/PKO port to query
+ *
+ * Returns Link state
+ */
+extern cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port);
+
+/**
+ * Configure an IPD/PKO port for the specified link state. This
+ * function does not influence auto negotiation at the PHY level.
+ * The passed link state must always match the link state returned
+ * by cvmx_helper_link_get(). It is normally best to use
+ * cvmx_helper_link_autoconf() instead.
+ *
+ * @ipd_port:  IPD/PKO port to configure
+ * @link_info: The new link state
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int cvmx_helper_link_set(int ipd_port,
+				cvmx_helper_link_info_t link_info);
+
+/**
+ * This function probes an interface to determine the actual
+ * number of hardware ports connected to it. It doesn't setup the
+ * ports or enable them. The main goal here is to set the global
+ * interface_port_count[interface] correctly. Hardware setup of the
+ * ports will be performed later.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int cvmx_helper_interface_probe(int interface);
+
+/**
+ * Configure a port for internal and/or external loopback. Internal loopback
+ * causes packets sent by the port to be received by Octeon. External loopback
+ * causes packets received from the wire to sent out again.
+ *
+ * @ipd_port: IPD/PKO port to loopback.
+ * @enable_internal:
+ *		   Non zero if you want internal loopback
+ * @enable_external:
+ *		   Non zero if you want external loopback
+ *
+ * Returns Zero on success, negative on failure.
+ */
+extern int cvmx_helper_configure_loopback(int ipd_port, int enable_internal,
+					  int enable_external);
+
+typedef enum {
+	set_phy_link_flags_autoneg = 0x1,
+	set_phy_link_flags_flow_control_dont_touch = 0x0 << 1,
+	set_phy_link_flags_flow_control_enable = 0x1 << 1,
+	set_phy_link_flags_flow_control_disable = 0x2 << 1,
+	set_phy_link_flags_flow_control_mask = 0x3 << 1,	/* Mask for 2 bit wide flow control field */
+} cvmx_helper_board_set_phy_link_flags_types_t;
+
+/**
+ * cvmx_override_board_link_get(int ipd_port) is a function
+ * pointer. It is meant to allow customization of the process of
+ * talking to a PHY to determine link speed. It is called every
+ * time a PHY must be polled for link status. Users should set
+ * this pointer to a function before calling any cvmx-helper
+ * operations.
+ */
+extern cvmx_helper_link_info_t(*cvmx_override_board_link_get) (int ipd_port);
+
+/**
+ * This function as a board specific method of changing the PHY
+ * speed, duplex, and autonegotiation. This programs the PHY and
+ * not Octeon. This can be used to force Octeon's links to
+ * specific settings.
+ *
+ * @phy_addr:  The address of the PHY to program
+ * @link_flags:
+ *		    Flags to control autonegotiation.  Bit 0 is autonegotiation
+ *		    enable/disable to maintain backware compatibility.
+ * @link_info: Link speed to program. If the speed is zero and autonegotiation
+ *		    is enabled, all possible negotiation speeds are advertised.
+ *
+ * Returns Zero on success, negative on failure
+ */
+int cvmx_helper_board_link_set_phy(int phy_addr,
+				   cvmx_helper_board_set_phy_link_flags_types_t
+				   link_flags,
+				   cvmx_helper_link_info_t link_info);
+
+/**
+ * This function is the board specific method of determining an
+ * ethernet ports link speed. Most Octeon boards have Marvell PHYs
+ * and are handled by the fall through case. This function must be
+ * updated for boards that don't have the normal Marvell PHYs.
+ *
+ * This function must be modifed for every new Octeon board.
+ * Internally it uses switch statements based on the cvmx_sysinfo
+ * data to determine board types and revisions. It relys on the
+ * fact that every Octeon board receives a unique board type
+ * enumeration from the bootloader.
+ *
+ * @ipd_port: IPD input port associated with the port we want to get link
+ *		   status for.
+ *
+ * Returns The ports link status. If the link isn't fully resolved, this must
+ *	   return zero.
+ */
+extern cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port);
+
+/**
+ * Enable packet input/output from the hardware. This function is
+ * called after by cvmx_helper_packet_hardware_enable() to
+ * perform board specific initialization. For most boards
+ * nothing is needed.
+ *
+ * @interface: Interface to enable
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_board_hardware_enable(int interface);
+
+#endif /* __CVMX_HELPER_ETHERNET_H__ */
diff --git a/drivers/staging/octeon/cvmx-helper-loop.c b/drivers/staging/octeon/cvmx-helper-loop.c
index bfbd461..1f8c574 100644
--- a/drivers/staging/octeon/cvmx-helper-loop.c
+++ b/drivers/staging/octeon/cvmx-helper-loop.c
@@ -30,11 +30,11 @@
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-
 #include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-pip-defs.h>
+
+#include "cvmx-pip-defs.h"
+#include "cvmx-helper-util.h"
 
 /**
  * Probe a LOOP interface and determine the number of ports
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-loop.h b/drivers/staging/octeon/cvmx-helper-loop.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-helper-loop.h
rename to drivers/staging/octeon/cvmx-helper-loop.h
diff --git a/drivers/staging/octeon/cvmx-helper-npi.c b/drivers/staging/octeon/cvmx-helper-npi.c
index 9f7bcc4..80838fc 100644
--- a/drivers/staging/octeon/cvmx-helper-npi.c
+++ b/drivers/staging/octeon/cvmx-helper-npi.c
@@ -30,12 +30,12 @@
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-
 #include <asm/octeon/cvmx-helper.h>
 
-#include <asm/octeon/cvmx-pip-defs.h>
+#include "cvmx-pip-defs.h"
+#include "cvmx-helper-npi.h"
+#include "cvmx-helper-util.h"
 
 /**
  * Bringup and enable a NPI interface. After this call packet
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-npi.h b/drivers/staging/octeon/cvmx-helper-npi.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-helper-npi.h
rename to drivers/staging/octeon/cvmx-helper-npi.h
diff --git a/drivers/staging/octeon/cvmx-helper-rgmii.c b/drivers/staging/octeon/cvmx-helper-rgmii.c
index 730812c..d3d7320 100644
--- a/drivers/staging/octeon/cvmx-helper-rgmii.c
+++ b/drivers/staging/octeon/cvmx-helper-rgmii.c
@@ -30,19 +30,18 @@
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-
-
-#include <asm/octeon/cvmx-mdio.h>
-#include <asm/octeon/cvmx-pko.h>
 #include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-helper-board.h>
-
 #include <asm/octeon/cvmx-npi-defs.h>
 #include <asm/octeon/cvmx-gmxx-defs.h>
-#include <asm/octeon/cvmx-asxx-defs.h>
-#include <asm/octeon/cvmx-dbg-defs.h>
+#include <asm/octeon/cvmx-helper-board.h>
+
+#include "cvmx-pko.h"
+#include "cvmx-mdio.h"
+#include "cvmx-dbg-defs.h"
+#include "cvmx-asxx-defs.h"
+#include "cvmx-helper-util.h"
+#include "cvmx-helper-rgmii.h"
 
 void __cvmx_interrupt_gmxx_enable(int interface);
 void __cvmx_interrupt_asxx_enable(int block);
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h b/drivers/staging/octeon/cvmx-helper-rgmii.h
similarity index 98%
rename from arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
rename to drivers/staging/octeon/cvmx-helper-rgmii.h
index 7dfe5f5..d7ee33b 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
+++ b/drivers/staging/octeon/cvmx-helper-rgmii.h
@@ -35,6 +35,8 @@
 #ifndef __CVMX_HELPER_RGMII_H__
 #define __CVMX_HELPER_RGMII_H__
 
+#include "cvmx-helper-ethernet.h"
+
 /**
  * Put an RGMII interface in loopback mode. Internal packets sent
  * out will be received back again on the same port. Externally
diff --git a/drivers/staging/octeon/cvmx-helper-sgmii.c b/drivers/staging/octeon/cvmx-helper-sgmii.c
index 03ae748..882dbff 100644
--- a/drivers/staging/octeon/cvmx-helper-sgmii.c
+++ b/drivers/staging/octeon/cvmx-helper-sgmii.c
@@ -29,17 +29,16 @@
  * Functions for SGMII initialization, configuration,
  * and monitoring.
  */
-
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-
-#include <asm/octeon/cvmx-mdio.h>
 #include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-gmxx-defs.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
-#include <asm/octeon/cvmx-gmxx-defs.h>
-#include <asm/octeon/cvmx-pcsx-defs.h>
+#include "cvmx-mdio.h"
+#include "cvmx-pcsx-defs.h"
+#include "cvmx-helper-util.h"
+#include "cvmx-helper-sgmii.h"
 
 void __cvmx_interrupt_gmxx_enable(int interface);
 void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h b/drivers/staging/octeon/cvmx-helper-sgmii.h
similarity index 98%
rename from arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
rename to drivers/staging/octeon/cvmx-helper-sgmii.h
index f4c9eb1..25bdcfa 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
+++ b/drivers/staging/octeon/cvmx-helper-sgmii.h
@@ -35,6 +35,8 @@
 #ifndef __CVMX_HELPER_SGMII_H__
 #define __CVMX_HELPER_SGMII_H__
 
+#include "cvmx-helper-ethernet.h"
+
 /**
  * Probe a SGMII interface and determine the number of ports
  * connected to it. The SGMII interface should still be down after
diff --git a/drivers/staging/octeon/cvmx-helper-spi.c b/drivers/staging/octeon/cvmx-helper-spi.c
index a2cf7f1..26c71b6 100644
--- a/drivers/staging/octeon/cvmx-helper-spi.c
+++ b/drivers/staging/octeon/cvmx-helper-spi.c
@@ -34,13 +34,14 @@ void __cvmx_interrupt_stxx_int_msk_enable(int index);
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
-
-#include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-spi.h>
+#include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-helper.h>
 
-#include <asm/octeon/cvmx-pip-defs.h>
-#include <asm/octeon/cvmx-pko-defs.h>
+#include "cvmx-pip-defs.h"
+#include "cvmx-pko-defs.h"
+#include "cvmx-helper-spi.h"
+#include "cvmx-helper-util.h"
 
 /*
  * CVMX_HELPER_SPI_TIMEOUT is used to determine how long the SPI
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-spi.h b/drivers/staging/octeon/cvmx-helper-spi.h
similarity index 98%
rename from arch/mips/include/asm/octeon/cvmx-helper-spi.h
rename to drivers/staging/octeon/cvmx-helper-spi.h
index 69bac03..5c51f21 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-spi.h
+++ b/drivers/staging/octeon/cvmx-helper-spi.h
@@ -32,6 +32,8 @@
 #ifndef __CVMX_HELPER_SPI_H__
 #define __CVMX_HELPER_SPI_H__
 
+#include "cvmx-helper-ethernet.h"
+
 /**
  * Probe a SPI interface and determine the number of ports
  * connected to it. The SPI interface should still be down after
diff --git a/drivers/staging/octeon/cvmx-helper-util.c b/drivers/staging/octeon/cvmx-helper-util.c
index 65d2bc9..3306ca0 100644
--- a/drivers/staging/octeon/cvmx-helper-util.c
+++ b/drivers/staging/octeon/cvmx-helper-util.c
@@ -29,22 +29,18 @@
  * Small helper utilities.
  */
 #include <linux/kernel.h>
-
 #include <asm/octeon/octeon.h>
-
-#include <asm/octeon/cvmx-config.h>
-
-#include <asm/octeon/cvmx-fpa.h>
-#include <asm/octeon/cvmx-pip.h>
-#include <asm/octeon/cvmx-pko.h>
-#include <asm/octeon/cvmx-ipd.h>
 #include <asm/octeon/cvmx-spi.h>
-
 #include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-helper-util.h>
-
+#include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-ipd-defs.h>
 
+#include "cvmx-fpa.h"
+#include "cvmx-ipd.h"
+#include "cvmx-pip.h"
+#include "cvmx-pko.h"
+#include "cvmx-helper-util.h"
+
 /**
  * Convert a interface mode into a human readable string
  *
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-util.h b/drivers/staging/octeon/cvmx-helper-util.h
similarity index 99%
rename from arch/mips/include/asm/octeon/cvmx-helper-util.h
rename to drivers/staging/octeon/cvmx-helper-util.h
index f446f21..3bbeee2 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-util.h
+++ b/drivers/staging/octeon/cvmx-helper-util.h
@@ -34,6 +34,9 @@
 #ifndef __CVMX_HELPER_UTIL_H__
 #define __CVMX_HELPER_UTIL_H__
 
+#include "cvmx-fpa.h"
+#include "cvmx-wqe.h"
+
 /**
  * Convert a interface mode into a human readable string
  *
diff --git a/drivers/staging/octeon/cvmx-helper-xaui.c b/drivers/staging/octeon/cvmx-helper-xaui.c
index 21b7b5a..4841d93 100644
--- a/drivers/staging/octeon/cvmx-helper-xaui.c
+++ b/drivers/staging/octeon/cvmx-helper-xaui.c
@@ -30,16 +30,15 @@
  * and monitoring.
  *
  */
-
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-
 #include <asm/octeon/cvmx-helper.h>
-
-#include <asm/octeon/cvmx-pko-defs.h>
 #include <asm/octeon/cvmx-gmxx-defs.h>
-#include <asm/octeon/cvmx-pcsxx-defs.h>
+
+#include "cvmx-pko-defs.h"
+#include "cvmx-pcsxx-defs.h"
+#include "cvmx-helper-util.h"
+#include "cvmx-helper-xaui.h"
 
 void __cvmx_interrupt_gmxx_enable(int interface);
 void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-xaui.h b/drivers/staging/octeon/cvmx-helper-xaui.h
similarity index 98%
rename from arch/mips/include/asm/octeon/cvmx-helper-xaui.h
rename to drivers/staging/octeon/cvmx-helper-xaui.h
index c392808..3d48a51 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
+++ b/drivers/staging/octeon/cvmx-helper-xaui.h
@@ -35,6 +35,8 @@
 #ifndef __CVMX_HELPER_XAUI_H__
 #define __CVMX_HELPER_XAUI_H__
 
+#include "cvmx-helper-ethernet.h"
+
 /**
  * Probe a XAUI interface and determine the number of ports
  * connected to it. The XAUI interface should still be down
diff --git a/drivers/staging/octeon/cvmx-interrupt-decodes.c b/drivers/staging/octeon/cvmx-interrupt-decodes.c
index e59d1b7..9733a2a 100644
--- a/drivers/staging/octeon/cvmx-interrupt-decodes.c
+++ b/drivers/staging/octeon/cvmx-interrupt-decodes.c
@@ -31,14 +31,13 @@
  * and decoding RSL_INT_BLOCKS interrupts.
  *
  */
-
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-gmxx-defs.h>
-#include <asm/octeon/cvmx-pcsx-defs.h>
-#include <asm/octeon/cvmx-pcsxx-defs.h>
-#include <asm/octeon/cvmx-spxx-defs.h>
-#include <asm/octeon/cvmx-stxx-defs.h>
+
+#include "cvmx-pcsx-defs.h"
+#include "cvmx-spxx-defs.h"
+#include "cvmx-stxx-defs.h"
+#include "cvmx-pcsxx-defs.h"
 
 #ifndef PRINT_ERROR
 #define PRINT_ERROR(format, ...)
diff --git a/drivers/staging/octeon/cvmx-interrupt-rsl.c b/drivers/staging/octeon/cvmx-interrupt-rsl.c
index fa327ec..84d5093 100644
--- a/drivers/staging/octeon/cvmx-interrupt-rsl.c
+++ b/drivers/staging/octeon/cvmx-interrupt-rsl.c
@@ -29,12 +29,11 @@
  * Utility functions to decode Octeon's RSL_INT_BLOCKS
  * interrupts into error messages.
  */
-
 #include <asm/octeon/octeon.h>
-
-#include <asm/octeon/cvmx-asxx-defs.h>
 #include <asm/octeon/cvmx-gmxx-defs.h>
 
+#include "cvmx-asxx-defs.h"
+
 #ifndef PRINT_ERROR
 #define PRINT_ERROR(format, ...)
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-ipd.h b/drivers/staging/octeon/cvmx-ipd.h
similarity index 99%
rename from arch/mips/include/asm/octeon/cvmx-ipd.h
rename to drivers/staging/octeon/cvmx-ipd.h
index e13490e..f9b8b39 100644
--- a/arch/mips/include/asm/octeon/cvmx-ipd.h
+++ b/drivers/staging/octeon/cvmx-ipd.h
@@ -33,9 +33,10 @@
 #ifndef __CVMX_IPD_H__
 #define __CVMX_IPD_H__
 
+#include <asm/octeon/cvmx-ipd-defs.h>
 #include <asm/octeon/octeon-feature.h>
 
-#include <asm/octeon/cvmx-ipd-defs.h>
+#include "cvmx-pip.h"
 
 enum cvmx_ipd_mode {
    CVMX_IPD_OPC_MODE_STT = 0LL,	  /* All blocks DRAM, not cached in L2 */
diff --git a/drivers/staging/octeon/cvmx-link.c b/drivers/staging/octeon/cvmx-link.c
index 626ec88..455f543 100644
--- a/drivers/staging/octeon/cvmx-link.c
+++ b/drivers/staging/octeon/cvmx-link.c
@@ -13,20 +13,17 @@
  * Helper functions to abstract board specific data about
  * network ports from the rest of the cvmx-helper files.
  */
-
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-bootinfo.h>
-
 #include <asm/octeon/cvmx-config.h>
-
-#include <asm/octeon/cvmx-mdio.h>
-
 #include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-helper-util.h>
+#include <asm/octeon/cvmx-bootinfo.h>
+#include <asm/octeon/cvmx-gmxx-defs.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
-#include <asm/octeon/cvmx-gmxx-defs.h>
-#include <asm/octeon/cvmx-asxx-defs.h>
+#include "cvmx-mdio.h"
+#include "cvmx-asxx-defs.h"
+#include "cvmx-helper-util.h"
+#include "cvmx-helper-ethernet.h"
 
 /**
  * cvmx_override_board_link_get(int ipd_port) is a function
diff --git a/arch/mips/include/asm/octeon/cvmx-mdio.h b/drivers/staging/octeon/cvmx-mdio.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-mdio.h
rename to drivers/staging/octeon/cvmx-mdio.h
diff --git a/arch/mips/include/asm/octeon/cvmx-pcsx-defs.h b/drivers/staging/octeon/cvmx-pcsx-defs.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-pcsx-defs.h
rename to drivers/staging/octeon/cvmx-pcsx-defs.h
diff --git a/arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h b/drivers/staging/octeon/cvmx-pcsxx-defs.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h
rename to drivers/staging/octeon/cvmx-pcsxx-defs.h
diff --git a/arch/mips/include/asm/octeon/cvmx-pip-defs.h b/drivers/staging/octeon/cvmx-pip-defs.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-pip-defs.h
rename to drivers/staging/octeon/cvmx-pip-defs.h
diff --git a/arch/mips/include/asm/octeon/cvmx-pip.h b/drivers/staging/octeon/cvmx-pip.h
similarity index 99%
rename from arch/mips/include/asm/octeon/cvmx-pip.h
rename to drivers/staging/octeon/cvmx-pip.h
index df69bfd..f302043 100644
--- a/arch/mips/include/asm/octeon/cvmx-pip.h
+++ b/drivers/staging/octeon/cvmx-pip.h
@@ -33,9 +33,9 @@
 #ifndef __CVMX_PIP_H__
 #define __CVMX_PIP_H__
 
-#include <asm/octeon/cvmx-wqe.h>
-#include <asm/octeon/cvmx-fpa.h>
-#include <asm/octeon/cvmx-pip-defs.h>
+#include "cvmx-wqe.h"
+#include "cvmx-fpa.h"
+#include "cvmx-pip-defs.h"
 
 #define CVMX_PIP_NUM_INPUT_PORTS		40
 #define CVMX_PIP_NUM_WATCHERS			4
diff --git a/arch/mips/include/asm/octeon/cvmx-pko-defs.h b/drivers/staging/octeon/cvmx-pko-defs.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-pko-defs.h
rename to drivers/staging/octeon/cvmx-pko-defs.h
diff --git a/drivers/staging/octeon/cvmx-pko.c b/drivers/staging/octeon/cvmx-pko.c
index ade16c6a..110acf9 100644
--- a/drivers/staging/octeon/cvmx-pko.c
+++ b/drivers/staging/octeon/cvmx-pko.c
@@ -28,13 +28,13 @@
 /*
  * Support library for the hardware Packet Output unit.
  */
-
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-#include <asm/octeon/cvmx-pko.h>
 #include <asm/octeon/cvmx-helper.h>
 
+#include "cvmx-pko.h"
+#include "cvmx-helper-util.h"
+
 /**
  * Internal state of packet output
  */
diff --git a/arch/mips/include/asm/octeon/cvmx-pko.h b/drivers/staging/octeon/cvmx-pko.h
similarity index 99%
rename from arch/mips/include/asm/octeon/cvmx-pko.h
rename to drivers/staging/octeon/cvmx-pko.h
index 3da59bb..67553a0 100644
--- a/arch/mips/include/asm/octeon/cvmx-pko.h
+++ b/drivers/staging/octeon/cvmx-pko.h
@@ -58,10 +58,10 @@
 #ifndef __CVMX_PKO_H__
 #define __CVMX_PKO_H__
 
-#include <asm/octeon/cvmx-fpa.h>
-#include <asm/octeon/cvmx-pow.h>
-#include <asm/octeon/cvmx-cmd-queue.h>
-#include <asm/octeon/cvmx-pko-defs.h>
+#include "cvmx-fpa.h"
+#include "cvmx-pow.h"
+#include "cvmx-pko-defs.h"
+#include "cvmx-cmd-queue.h"
 
 /* Adjust the command buffer size by 1 word so that in the case of using only
  * two word PKO commands no command words stradle buffers.  The useful values
diff --git a/arch/mips/include/asm/octeon/cvmx-pow.h b/drivers/staging/octeon/cvmx-pow.h
similarity index 99%
rename from arch/mips/include/asm/octeon/cvmx-pow.h
rename to drivers/staging/octeon/cvmx-pow.h
index d5565d7..bd7c145 100644
--- a/arch/mips/include/asm/octeon/cvmx-pow.h
+++ b/drivers/staging/octeon/cvmx-pow.h
@@ -53,8 +53,9 @@
 
 #include <asm/octeon/cvmx-pow-defs.h>
 
-#include <asm/octeon/cvmx-scratch.h>
-#include <asm/octeon/cvmx-wqe.h>
+#include "cvmx-fpa.h"
+#include "cvmx-wqe.h"
+#include "cvmx-scratch.h"
 
 /* Default to having all POW constancy checks turned on */
 #ifndef CVMX_ENABLE_POW_CHECKS
diff --git a/arch/mips/include/asm/octeon/cvmx-scratch.h b/drivers/staging/octeon/cvmx-scratch.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-scratch.h
rename to drivers/staging/octeon/cvmx-scratch.h
diff --git a/drivers/staging/octeon/cvmx-spi.c b/drivers/staging/octeon/cvmx-spi.c
index ef5198d..7bc4559 100644
--- a/drivers/staging/octeon/cvmx-spi.c
+++ b/drivers/staging/octeon/cvmx-spi.c
@@ -30,15 +30,13 @@
  * Support library for the SPI
  */
 #include <asm/octeon/octeon.h>
-
-#include <asm/octeon/cvmx-config.h>
-
-#include <asm/octeon/cvmx-pko.h>
 #include <asm/octeon/cvmx-spi.h>
+#include <asm/octeon/cvmx-config.h>
 
-#include <asm/octeon/cvmx-spxx-defs.h>
-#include <asm/octeon/cvmx-stxx-defs.h>
-#include <asm/octeon/cvmx-srxx-defs.h>
+#include "cvmx-pko.h"
+#include "cvmx-spxx-defs.h"
+#include "cvmx-srxx-defs.h"
+#include "cvmx-stxx-defs.h"
 
 #define INVOKE_CB(function_p, args...)		\
 	do {					\
diff --git a/arch/mips/include/asm/octeon/cvmx-spxx-defs.h b/drivers/staging/octeon/cvmx-spxx-defs.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-spxx-defs.h
rename to drivers/staging/octeon/cvmx-spxx-defs.h
diff --git a/arch/mips/include/asm/octeon/cvmx-srxx-defs.h b/drivers/staging/octeon/cvmx-srxx-defs.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-srxx-defs.h
rename to drivers/staging/octeon/cvmx-srxx-defs.h
diff --git a/arch/mips/include/asm/octeon/cvmx-stxx-defs.h b/drivers/staging/octeon/cvmx-stxx-defs.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-stxx-defs.h
rename to drivers/staging/octeon/cvmx-stxx-defs.h
diff --git a/arch/mips/include/asm/octeon/cvmx-wqe.h b/drivers/staging/octeon/cvmx-wqe.h
similarity index 100%
rename from arch/mips/include/asm/octeon/cvmx-wqe.h
rename to drivers/staging/octeon/cvmx-wqe.h
diff --git a/drivers/staging/octeon/ethernet-mem.c b/drivers/staging/octeon/ethernet-mem.c
index 5a5cdb3..29398f0 100644
--- a/drivers/staging/octeon/ethernet-mem.c
+++ b/drivers/staging/octeon/ethernet-mem.c
@@ -8,17 +8,15 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
-#include <linux/slab.h>
-
 #include <asm/octeon/octeon.h>
 
+#include "cvmx-fpa.h"
 #include "ethernet-mem.h"
 #include "ethernet-defines.h"
 
-#include <asm/octeon/cvmx-fpa.h>
-
 /**
  * cvm_oct_fill_hw_skbuff - fill the supplied hardware pool with skbuffs
  * @pool:     Pool to allocate an skbuff for
diff --git a/drivers/staging/octeon/ethernet-rgmii.c b/drivers/staging/octeon/ethernet-rgmii.c
index beb7aac..c37be93 100644
--- a/drivers/staging/octeon/ethernet-rgmii.c
+++ b/drivers/staging/octeon/ethernet-rgmii.c
@@ -8,26 +8,24 @@
  * published by the Free Software Foundation.
  */
 
+#include <net/dst.h>
+#include <linux/phy.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
-#include <linux/phy.h>
 #include <linux/ratelimit.h>
-#include <net/dst.h>
-
 #include <asm/octeon/octeon.h>
-
-#include "ethernet-defines.h"
-#include "octeon-ethernet.h"
-#include "ethernet-util.h"
-#include "ethernet-mdio.h"
-
 #include <asm/octeon/cvmx-helper.h>
-
 #include <asm/octeon/cvmx-ipd-defs.h>
 #include <asm/octeon/cvmx-npi-defs.h>
 #include <asm/octeon/cvmx-gmxx-defs.h>
 
+#include "ethernet-mdio.h"
+#include "ethernet-util.h"
+#include "octeon-ethernet.h"
+#include "cvmx-helper-util.h"
+#include "ethernet-defines.h"
+
 static DEFINE_SPINLOCK(global_register_lock);
 
 static int number_rgmii_ports;
diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 22853d3..7ea35e0 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -27,23 +27,21 @@
 #endif /* CONFIG_XFRM */
 
 #include <linux/atomic.h>
-
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-gmxx-defs.h>
 
-#include "ethernet-defines.h"
-#include "ethernet-mem.h"
+#include "cvmx-fau.h"
+#include "cvmx-pip.h"
+#include "cvmx-pow.h"
+#include "cvmx-wqe.h"
 #include "ethernet-rx.h"
-#include "octeon-ethernet.h"
+#include "cvmx-scratch.h"
+#include "ethernet-mem.h"
 #include "ethernet-util.h"
-
-#include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-wqe.h>
-#include <asm/octeon/cvmx-fau.h>
-#include <asm/octeon/cvmx-pow.h>
-#include <asm/octeon/cvmx-pip.h>
-#include <asm/octeon/cvmx-scratch.h>
-
-#include <asm/octeon/cvmx-gmxx-defs.h>
+#include "octeon-ethernet.h"
+#include "cvmx-helper-util.h"
+#include "ethernet-defines.h"
 
 static struct napi_struct cvm_oct_napi;
 
diff --git a/drivers/staging/octeon/ethernet-rx.h b/drivers/staging/octeon/ethernet-rx.h
index a5973fd..a92708c 100644
--- a/drivers/staging/octeon/ethernet-rx.h
+++ b/drivers/staging/octeon/ethernet-rx.h
@@ -8,7 +8,9 @@
  * published by the Free Software Foundation.
  */
 
-#include <asm/octeon/cvmx-fau.h>
+#include "cvmx-fau.h"
+#include "ethernet-mem.h"
+#include "ethernet-defines.h"
 
 void cvm_oct_poll_controller(struct net_device *dev);
 void cvm_oct_rx_initialize(void);
diff --git a/drivers/staging/octeon/ethernet-spi.c b/drivers/staging/octeon/ethernet-spi.c
index 2ae1944..1b25b54 100644
--- a/drivers/staging/octeon/ethernet-spi.c
+++ b/drivers/staging/octeon/ethernet-spi.c
@@ -8,22 +8,19 @@
  * published by the Free Software Foundation.
  */
 
+#include <net/dst.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
-#include <net/dst.h>
-
 #include <asm/octeon/octeon.h>
-
-#include "ethernet-defines.h"
-#include "octeon-ethernet.h"
-#include "ethernet-util.h"
-
 #include <asm/octeon/cvmx-spi.h>
-
 #include <asm/octeon/cvmx-npi-defs.h>
-#include <asm/octeon/cvmx-spxx-defs.h>
-#include <asm/octeon/cvmx-stxx-defs.h>
+
+#include "ethernet-util.h"
+#include "cvmx-spxx-defs.h"
+#include "cvmx-stxx-defs.h"
+#include "octeon-ethernet.h"
+#include "ethernet-defines.h"
 
 static int number_spi_ports;
 static int need_retrain[2] = { 0, 0 };
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index 7c1c1b0..67e6616 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -23,21 +23,18 @@
 #endif /* CONFIG_XFRM */
 
 #include <linux/atomic.h>
-
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-gmxx-defs.h>
 
-#include "ethernet-defines.h"
-#include "octeon-ethernet.h"
+#include "cvmx-fau.h"
+#include "cvmx-pip.h"
+#include "cvmx-pko.h"
+#include "cvmx-wqe.h"
 #include "ethernet-tx.h"
 #include "ethernet-util.h"
-
-#include <asm/octeon/cvmx-wqe.h>
-#include <asm/octeon/cvmx-fau.h>
-#include <asm/octeon/cvmx-pip.h>
-#include <asm/octeon/cvmx-pko.h>
-#include <asm/octeon/cvmx-helper.h>
-
-#include <asm/octeon/cvmx-gmxx-defs.h>
+#include "octeon-ethernet.h"
+#include "ethernet-defines.h"
 
 #define CVM_OCT_SKB_CB(skb)	((u64 *)((skb)->cb))
 
diff --git a/drivers/staging/octeon/ethernet-xaui.c b/drivers/staging/octeon/ethernet-xaui.c
index 4b47bcf..aea7378 100644
--- a/drivers/staging/octeon/ethernet-xaui.c
+++ b/drivers/staging/octeon/ethernet-xaui.c
@@ -8,22 +8,20 @@
  * published by the Free Software Foundation.
  */
 
+#include <net/dst.h>
 #include <linux/phy.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/ratelimit.h>
-#include <net/dst.h>
-
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-gmxx-defs.h>
 
-#include "ethernet-defines.h"
-#include "octeon-ethernet.h"
 #include "ethernet-util.h"
 #include "ethernet-mdio.h"
-
-#include <asm/octeon/cvmx-helper.h>
-
-#include <asm/octeon/cvmx-gmxx-defs.h>
+#include "octeon-ethernet.h"
+#include "ethernet-defines.h"
+#include "cvmx-helper-ethernet.h"
 
 int cvm_oct_xaui_open(struct net_device *dev)
 {
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index f9dba23..e73c99c 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -8,36 +8,34 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/platform_device.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
+#include <net/dst.h>
 #include <linux/phy.h>
 #include <linux/slab.h>
-#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_net.h>
-
-#include <net/dst.h>
-
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
 #include <asm/octeon/octeon.h>
+#include <linux/etherdevice.h>
+#include <linux/platform_device.h>
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-gmxx-defs.h>
+#include <asm/octeon/cvmx-smix-defs.h>
 
-#include "ethernet-defines.h"
-#include "octeon-ethernet.h"
-#include "ethernet-mem.h"
+#include "cvmx-fau.h"
+#include "cvmx-ipd.h"
+#include "cvmx-pip.h"
+#include "cvmx-pko.h"
 #include "ethernet-rx.h"
 #include "ethernet-tx.h"
+#include "ethernet-mem.h"
 #include "ethernet-mdio.h"
 #include "ethernet-util.h"
-
-#include <asm/octeon/cvmx-pip.h>
-#include <asm/octeon/cvmx-pko.h>
-#include <asm/octeon/cvmx-fau.h>
-#include <asm/octeon/cvmx-ipd.h>
-#include <asm/octeon/cvmx-helper.h>
-
-#include <asm/octeon/cvmx-gmxx-defs.h>
-#include <asm/octeon/cvmx-smix-defs.h>
+#include "octeon-ethernet.h"
+#include "ethernet-defines.h"
+#include "cvmx-helper-util.h"
+#include "cvmx-helper-ethernet.h"
 
 static int num_packet_buffers = 1024;
 module_param(num_packet_buffers, int, 0444);
diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
index e9d3e9a..7c000b4 100644
--- a/drivers/staging/octeon/octeon-ethernet.h
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -15,9 +15,10 @@
 #define OCTEON_ETHERNET_H
 
 #include <linux/of.h>
-
 #include <asm/octeon/cvmx-helper-board.h>
 
+#include "cvmx-helper-ethernet.h"
+
 /**
  * This is the definition of the Ethernet driver's private
  * driver state stored in netdev_priv(dev).
-- 
2.3.3
