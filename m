Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2007 06:14:41 +0000 (GMT)
Received: from cwb.pacific.net.hk ([202.14.67.92]:62862 "EHLO
	cwb.pacific.net.hk") by ftp.linux-mips.org with ESMTP
	id S20043178AbXAEGOg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Jan 2007 06:14:36 +0000
Received: from shockwave.dccext.org (ip155.bb203.pacific.net.hk [202.64.203.155])
        by cwb.pacific.net.hk with ESMTP
        id l056EQZ8015314; Fri, 5 Jan 2007 14:14:26 +0800
Received: (from root@localhost)
	by shockwave.dccext.org (8.11.4/8.11.4) id l056EDQ14986;
	Fri, 5 Jan 2007 14:14:13 +0800 (HKT)
Date:	Fri, 5 Jan 2007 13:56:46 +0800
From:	Davy Chan <chandave-linux-mips@wiasia.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] pnx8550: Fix broken write_config_byte() function in arch/mips/pci/ops-pnx8550.c
Message-ID: <20070105135646.D14007@wiasia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <chandave-linux-mips@wiasia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chandave-linux-mips@wiasia.com
Precedence: bulk
X-list: linux-mips


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(Looks like not many people write single bytes to the PCI configuration
 registers on a PNX8550-based system.)

There's a serious typo in the function:
  arch/mips/pci/ops-pnx8550.c:write_config_byte()

The parameter passed to the function config_access() is PCI_CMD_CONFIG_READ
instead of PCI_CMD_CONFIG_WRITE. This renders any attempts to write
a single byte to the PCI configuration registers useless.

This problem does not exist for write_config_word() nor write_config_dword().

This problem has been there since kernel v2.6.17 and is still there
as of kernel v2.6.19.1.

Patch attached.

See ya...

d.c.


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ops-pnx8550.c.patch"

--- linux-2.6.17.13-orig/arch/mips/pci/ops-pnx8550.c	2006-09-10 01:17:04.000000000 +0800
+++ linux-2.6.17.13/arch/mips/pci/ops-pnx8550.c	2007-01-04 13:49:37.000000000 +0800
@@ -202,7 +202,7 @@
 		break;
 	}
 
-	err = config_access(PCI_CMD_CONFIG_READ, bus, devfn, where, ~(1 << (where & 3)), &data);
+	err = config_access(PCI_CMD_CONFIG_WRITE, bus, devfn, where, ~(1 << (where & 3)), &data);
 
 	return err;
 }

--RnlQjJ0d97Da+TV1--
