Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:28:46 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:37647 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133374AbWCTE0s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:26:48 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E587D64D3D; Mon, 20 Mar 2006 04:36:25 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 80BCD66ED5; Mon, 20 Mar 2006 04:36:10 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:36:10 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, akpm@osdl.org
Subject: [PATCH 4/6] [NET] Fix NET_SB1250_MAC Kconfig order to match Linus' tree
Message-ID: <20060320043610.GD20200@deprecation.cyrius.com>
References: <20060320043445.GA20171@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043445.GA20171@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

The Kconfig option NET_SB1250_MAC is listed in different places in
drivers/net/Kconfig in the Linus' and linux-mips trees.  Bring them
into sync.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- mips.git/drivers/net/Kconfig	2006-03-13 18:43:52.000000000 +0000
+++ linux-2.6/drivers/net/Kconfig	2006-03-13 18:55:59.000000000 +0000
@@ -460,6 +452,10 @@
 	  If you have an Alchemy Semi AU1X00 based system
 	  say Y.  Otherwise, say N.
 
+config NET_SB1250_MAC
+	tristate "SB1250 Ethernet support"
+	depends on NET_ETHERNET && SIBYTE_SB1xxx_SOC
+
 config SGI_IOC3_ETH
 	bool "SGI IOC3 Ethernet"
 	depends on NET_ETHERNET && PCI && SGI_IP27
@@ -2009,10 +1997,6 @@
 
 	  If in doubt, say N.
 
-config NET_SB1250_MAC
-	tristate "SB1250 Ethernet support"
-	depends on SIBYTE_SB1xxx_SOC
-
 config R8169_VLAN
 	bool "VLAN support"
 	depends on R8169 && VLAN_8021Q

-- 
Martin Michlmayr
http://www.cyrius.com/
