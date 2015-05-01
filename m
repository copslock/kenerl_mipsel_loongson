Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:40:28 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:34934 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026380AbbEATh4V-6gi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:37:56 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 47B305A6D73;
        Fri,  1 May 2015 22:37:45 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id mMQusksFc3Eu; Fri,  1 May 2015 22:37:40 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id B7F8B5BC00D;
        Fri,  1 May 2015 22:37:48 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 10/11] MIPS: OCTEON: ethernet: delete unneeded symbol exports
Date:   Fri,  1 May 2015 22:37:12 +0300
Message-Id: <1430509033-12113-11-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47196
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

Delete unneeded symbol exports.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon/cvmx-cmd-queue.c       | 1 -
 drivers/staging/octeon/cvmx-helper-ethernet.c | 5 -----
 drivers/staging/octeon/cvmx-helper-util.c     | 4 ----
 drivers/staging/octeon/cvmx-pko.c             | 2 --
 drivers/staging/octeon/cvmx-spi.c             | 1 -
 5 files changed, 13 deletions(-)

diff --git a/drivers/staging/octeon/cvmx-cmd-queue.c b/drivers/staging/octeon/cvmx-cmd-queue.c
index 8241fc6..132bccc 100644
--- a/drivers/staging/octeon/cvmx-cmd-queue.c
+++ b/drivers/staging/octeon/cvmx-cmd-queue.c
@@ -47,7 +47,6 @@
  * state. It points to a bootmem named block.
  */
 __cvmx_cmd_queue_all_state_t *__cvmx_cmd_queue_state_ptr;
-EXPORT_SYMBOL_GPL(__cvmx_cmd_queue_state_ptr);
 
 /**
  * Initialize the Global queue state pointer.
diff --git a/drivers/staging/octeon/cvmx-helper-ethernet.c b/drivers/staging/octeon/cvmx-helper-ethernet.c
index 390f8f80..ba90678 100644
--- a/drivers/staging/octeon/cvmx-helper-ethernet.c
+++ b/drivers/staging/octeon/cvmx-helper-ethernet.c
@@ -614,7 +614,6 @@ int cvmx_helper_ipd_and_packet_input_enable(void)
 		__cvmx_helper_errata_fix_ipd_ptr_alignment();
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cvmx_helper_ipd_and_packet_input_enable);
 
 /**
  * Initialize the PIP, IPD, and PKO hardware to support
@@ -693,7 +692,6 @@ int cvmx_helper_initialize_packet_io_global(void)
 #endif
 	return result;
 }
-EXPORT_SYMBOL_GPL(cvmx_helper_initialize_packet_io_global);
 
 /**
  * Does core local initialization for packet io
@@ -738,7 +736,6 @@ cvmx_helper_link_info_t cvmx_helper_link_autoconf(int ipd_port)
 	 */
 	return port_link_info[ipd_port];
 }
-EXPORT_SYMBOL_GPL(cvmx_helper_link_autoconf);
 
 /**
  * Return the link state of an IPD/PKO port as returned by
@@ -797,7 +794,6 @@ cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port)
 	}
 	return result;
 }
-EXPORT_SYMBOL_GPL(cvmx_helper_link_get);
 
 /**
  * Configure an IPD/PKO port for the specified link state. This
@@ -853,7 +849,6 @@ int cvmx_helper_link_set(int ipd_port, cvmx_helper_link_info_t link_info)
 		port_link_info[ipd_port].u64 = link_info.u64;
 	return result;
 }
-EXPORT_SYMBOL_GPL(cvmx_helper_link_set);
 
 /**
  * Configure a port for internal and/or external loopback. Internal loopback
diff --git a/drivers/staging/octeon/cvmx-helper-util.c b/drivers/staging/octeon/cvmx-helper-util.c
index 453d7f6..65d2bc9 100644
--- a/drivers/staging/octeon/cvmx-helper-util.c
+++ b/drivers/staging/octeon/cvmx-helper-util.c
@@ -251,7 +251,6 @@ int cvmx_helper_setup_red(int pass_thresh, int drop_thresh)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cvmx_helper_setup_red);
 
 /**
  * Setup the common GMX settings that determine the number of
@@ -385,7 +384,6 @@ int cvmx_helper_get_ipd_port(int interface, int port)
 	}
 	return -1;
 }
-EXPORT_SYMBOL_GPL(cvmx_helper_get_ipd_port);
 
 /**
  * Returns the interface number for an IPD/PKO port number.
@@ -410,7 +408,6 @@ int cvmx_helper_get_interface_num(int ipd_port)
 
 	return -1;
 }
-EXPORT_SYMBOL_GPL(cvmx_helper_get_interface_num);
 
 /**
  * Returns the interface index number for an IPD/PKO port
@@ -434,4 +431,3 @@ int cvmx_helper_get_interface_index_num(int ipd_port)
 
 	return -1;
 }
-EXPORT_SYMBOL_GPL(cvmx_helper_get_interface_index_num);
diff --git a/drivers/staging/octeon/cvmx-pko.c b/drivers/staging/octeon/cvmx-pko.c
index 008b881..ade16c6a 100644
--- a/drivers/staging/octeon/cvmx-pko.c
+++ b/drivers/staging/octeon/cvmx-pko.c
@@ -140,7 +140,6 @@ void cvmx_pko_disable(void)
 	pko_reg_flags.s.ena_pko = 0;
 	cvmx_write_csr(CVMX_PKO_REG_FLAGS, pko_reg_flags.u64);
 }
-EXPORT_SYMBOL_GPL(cvmx_pko_disable);
 
 /**
  * Reset the packet output.
@@ -182,7 +181,6 @@ void cvmx_pko_shutdown(void)
 	}
 	__cvmx_pko_reset();
 }
-EXPORT_SYMBOL_GPL(cvmx_pko_shutdown);
 
 /**
  * Configure a output port and the associated queues for use.
diff --git a/drivers/staging/octeon/cvmx-spi.c b/drivers/staging/octeon/cvmx-spi.c
index 459e3b1..ef5198d 100644
--- a/drivers/staging/octeon/cvmx-spi.c
+++ b/drivers/staging/octeon/cvmx-spi.c
@@ -177,7 +177,6 @@ int cvmx_spi_restart_interface(int interface, cvmx_spi_mode_t mode, int timeout)
 
 	return res;
 }
-EXPORT_SYMBOL_GPL(cvmx_spi_restart_interface);
 
 /**
  * Callback to perform SPI4 reset
-- 
2.3.3
