Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2005 20:28:52 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:8183 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225266AbVBAU2g>; Tue, 1 Feb 2005 20:28:36 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id j11KSZdh010813;
	Tue, 1 Feb 2005 12:28:35 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id j11KSZ1O010811;
	Tue, 1 Feb 2005 12:28:35 -0800
Date:	Tue, 1 Feb 2005 12:28:35 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix Kconfig for Broadcom SWARM
Message-ID: <20050201202835.GA10788@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

Attached patch adds necessary options for Broadcom SWARM. 

Thanks
Manish Lachwani

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_sibyte_compile_1.patch"

Index: linux/arch/mips/Kconfig
===================================================================
--- linux.orig/arch/mips/Kconfig
+++ linux/arch/mips/Kconfig
@@ -498,6 +498,8 @@
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SIBYTE_CFE
+	select SIBYTE_HAS_LDT
 
 config SIBYTE_SENTOSA
 	bool "Support for Sibyte BCM91250E-Sentosa"

--k+w/mQv8wyuph6w0--
