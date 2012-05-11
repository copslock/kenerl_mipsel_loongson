Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 May 2012 00:05:37 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36310 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903693Ab2EKWFd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 May 2012 00:05:33 +0200
Received: by pbbrq13 with SMTP id rq13so4326205pbb.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=csniluFhR4vS63A9nvPlUvOkMJm7TaoZ+HePol2yF9w=;
        b=cPs1IsVH87YxjgvKbCleZuS3+c0ux1U/jWaCIoOIPC5o+WkgYhhwbyaTRqKTAhBcrD
         p246V70DSiXqaHaBF4S1qibscavCrQPt8kT1H1oc3ZoQpCyMZW+EWOyXoiOmQbjDTJ2I
         Pl8GxWfdtUWV0zqPMwGhflHcnqtGj8eE+UAuYdcBB1kD+BkfBst5gzoPPKfyVNqUZs8u
         cj7PI3RRaYvzHd73MZ+nq5qPiPo1dXnEOTTUe/6sVflJG/8XcRkrDuDgVeyRPO0DGMF7
         7MECKMWgGJx1ns1ir63yB89JtJHPWhOymNh5Ol3AI5woHqrO8Edm+Hage7hv5t0iLdhV
         E8zg==
Received: by 10.68.221.105 with SMTP id qd9mr35650037pbc.1.1336773926977;
        Fri, 11 May 2012 15:05:26 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id rt4sm13965507pbc.3.2012.05.11.15.05.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 15:05:26 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4BM5PaW017901;
        Fri, 11 May 2012 15:05:25 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4BM5OY8017899;
        Fri, 11 May 2012 15:05:24 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/3] of/spi/eeprom: Configure at25 from device tree and autoload its driver.
Date:   Fri, 11 May 2012 15:05:20 -0700
Message-Id: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

As per the Subject, given a device tree fragment like this:

	spi@1070000001000 {
		compatible = "cavium,octeon-3010-spi";
		reg = <0x10700 0x00001000 0x0 0x100>;
		interrupts = <0 58>;
		#address-cells = <1>;
		#size-cells = <0>;

		eeprom@0 {
			compatible = "st,m95256", "atmel,at25";
			reg = <0>;
			spi-max-frequency = <5000000>;
			spi-cpha;
			spi-cpol;

			pagesize = <64>;
			size = <32768>;
			address-width = <16>;
		};
	};

The at25 module is autoloaded and configured from the device tree data.

1/3) Make of_modalias_node() work better for auto loading drivers.

2/3) Use MODALIAS prefixed with "spi:" for SPI drivers so modprobe can
     find the proper driver module.

3/3) Use standard eeprom device tree binding to configure at25,
     convert MODULE_ALIAS(), to equivalent MODULE_DEVICE_TABLE().

David Daney (3):
  of: Add prefix parameter to of_modalias_node().
  spi: Use consistent MODALIAS values.
  eeprom/of: Add device tree bindings to at25.

 drivers/misc/eeprom/at25.c   |   61 +++++++++++++++++++++++++++++++++++++++---
 drivers/of/base.c            |   22 +++++++++++----
 drivers/of/of_i2c.c          |    2 +-
 drivers/of/of_spi.c          |    2 +-
 drivers/spi/spi.c            |   39 +++++++++++++++++++++++---
 include/linux/of.h           |    3 +-
 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 sound/soc/fsl/p1022_ds.c     |    2 +-
 8 files changed, 113 insertions(+), 20 deletions(-)

-- 
1.7.2.3
