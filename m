Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Nov 2013 23:12:02 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:54471 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6867263Ab3K0WL5t6Up0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Nov 2013 23:11:57 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 144F856F61E;
        Thu, 28 Nov 2013 00:11:57 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id dtxegRQ+b677; Thu, 28 Nov 2013 00:11:52 +0200 (EET)
Received: from blackmetal.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 1CCE35BC002;
        Thu, 28 Nov 2013 00:11:52 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: cavium-octeon: export symbols needed by octeon-ethernet
Date:   Thu, 28 Nov 2013 00:11:44 +0200
Message-Id: <1385590304-29540-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.4.3
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38592
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

Export symbols needed by the octeon-ethernet driver. The patch fixes a
build failure with CONFIG_OCTEON_ETHERNET=m.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c   | 1 +
 arch/mips/cavium-octeon/executive/cvmx-helper-util.c | 4 ++++
 arch/mips/cavium-octeon/executive/cvmx-helper.c      | 8 ++++++++
 arch/mips/cavium-octeon/executive/cvmx-pko.c         | 3 ++-
 arch/mips/cavium-octeon/executive/cvmx-spi.c         | 1 +
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
index 132bccc..8241fc6 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
@@ -47,6 +47,7 @@
  * state. It points to a bootmem named block.
  */
 __cvmx_cmd_queue_all_state_t *__cvmx_cmd_queue_state_ptr;
+EXPORT_SYMBOL_GPL(__cvmx_cmd_queue_state_ptr);
 
 /**
  * Initialize the Global queue state pointer.
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
index 65d2bc9..453d7f6 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
@@ -251,6 +251,7 @@ int cvmx_helper_setup_red(int pass_thresh, int drop_thresh)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_setup_red);
 
 /**
  * Setup the common GMX settings that determine the number of
@@ -384,6 +385,7 @@ int cvmx_helper_get_ipd_port(int interface, int port)
 	}
 	return -1;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_get_ipd_port);
 
 /**
  * Returns the interface number for an IPD/PKO port number.
@@ -408,6 +410,7 @@ int cvmx_helper_get_interface_num(int ipd_port)
 
 	return -1;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_get_interface_num);
 
 /**
  * Returns the interface index number for an IPD/PKO port
@@ -431,3 +434,4 @@ int cvmx_helper_get_interface_index_num(int ipd_port)
 
 	return -1;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_get_interface_index_num);
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index d63d20d..c96b3f2 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -88,6 +88,7 @@ int cvmx_helper_get_number_of_interfaces(void)
 	else
 		return 3;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_get_number_of_interfaces);
 
 /**
  * Return the number of ports on an interface. Depending on the
@@ -102,6 +103,7 @@ int cvmx_helper_ports_on_interface(int interface)
 {
 	return interface_port_count[interface];
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_ports_on_interface);
 
 /**
  * Get the operating mode of an interface. Depending on the Octeon
@@ -179,6 +181,7 @@ cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int interface)
 			return CVMX_HELPER_INTERFACE_MODE_RGMII;
 	}
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_interface_get_mode);
 
 /**
  * Configure the IPD/PIP tagging and QoS options for a specific
@@ -825,6 +828,7 @@ int cvmx_helper_ipd_and_packet_input_enable(void)
 		__cvmx_helper_errata_fix_ipd_ptr_alignment();
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_ipd_and_packet_input_enable);
 
 /**
  * Initialize the PIP, IPD, and PKO hardware to support
@@ -903,6 +907,7 @@ int cvmx_helper_initialize_packet_io_global(void)
 #endif
 	return result;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_initialize_packet_io_global);
 
 /**
  * Does core local initialization for packet io
@@ -947,6 +952,7 @@ cvmx_helper_link_info_t cvmx_helper_link_autoconf(int ipd_port)
 	 */
 	return port_link_info[ipd_port];
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_link_autoconf);
 
 /**
  * Return the link state of an IPD/PKO port as returned by
@@ -1005,6 +1011,7 @@ cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port)
 	}
 	return result;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_link_get);
 
 /**
  * Configure an IPD/PKO port for the specified link state. This
@@ -1060,6 +1067,7 @@ int cvmx_helper_link_set(int ipd_port, cvmx_helper_link_info_t link_info)
 		port_link_info[ipd_port].u64 = link_info.u64;
 	return result;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_link_set);
 
 /**
  * Configure a port for internal and/or external loopback. Internal loopback
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index f2c8775..008b881 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -140,7 +140,7 @@ void cvmx_pko_disable(void)
 	pko_reg_flags.s.ena_pko = 0;
 	cvmx_write_csr(CVMX_PKO_REG_FLAGS, pko_reg_flags.u64);
 }
-
+EXPORT_SYMBOL_GPL(cvmx_pko_disable);
 
 /**
  * Reset the packet output.
@@ -182,6 +182,7 @@ void cvmx_pko_shutdown(void)
 	}
 	__cvmx_pko_reset();
 }
+EXPORT_SYMBOL_GPL(cvmx_pko_shutdown);
 
 /**
  * Configure a output port and the associated queues for use.
diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index ef5198d..459e3b1 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -177,6 +177,7 @@ int cvmx_spi_restart_interface(int interface, cvmx_spi_mode_t mode, int timeout)
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(cvmx_spi_restart_interface);
 
 /**
  * Callback to perform SPI4 reset
-- 
1.8.4.3
