Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 04:11:44 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:45782 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224772AbUCPELn>;
	Tue, 16 Mar 2004 04:11:43 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id NAA12952;
	Tue, 16 Mar 2004 13:11:33 +0900 (JST)
Received: 4UMDO01 id i2G4BXb00533; Tue, 16 Mar 2004 13:11:33 +0900 (JST)
Received: 4UMRO01 id i2G4BOS04456; Tue, 16 Mar 2004 13:11:32 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Tue, 16 Mar 2004 13:11:25 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: sjhill@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-Id: <20040316131125.017d9c4a.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20040315205101Z8225248-9616+3861@linux-mips.org>
References: <20040315205101Z8225248-9616+3861@linux-mips.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Steven,

You need to add the following change further.
Please apply this patch to v2.4.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/pci.c linux/arch/mips/pci/pci.c
--- linux-orig/arch/mips/pci/pci.c	2003-06-28 11:26:25.000000000 +0900
+++ linux/arch/mips/pci/pci.c	2004-03-16 12:42:37.000000000 +0900
@@ -129,7 +129,7 @@
 	return pcibios_enable_resources(dev, mask);
 }
 
-#ifdef CONFIG_NEW_PCI
+#ifdef CONFIG_PCI_NEW
 /*
  * Named PCI new and about to die before it's old :-)
  *



On Mon, 15 Mar 2004 20:50:56 +0000
sjhill@linux-mips.org wrote:

> 
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	sjhill@ftp.linux-mips.org	04/03/15 20:50:56
> 
> Modified files:
> 	arch/mips      : Tag: linux_2_4 config-shared.in defconfig 
> 	                 defconfig-atlas defconfig-bosporus 
> 	                 defconfig-capcella defconfig-cobalt 
> 	                 defconfig-csb250 defconfig-db1000 
> 	                 defconfig-db1100 defconfig-db1500 
> 	                 defconfig-db1550 defconfig-ddb5476 
> 	                 defconfig-ddb5477 defconfig-decstation 
> 	                 defconfig-e55 defconfig-eagle defconfig-ev64120 
> 	                 defconfig-ev96100 defconfig-hp-lj 
> 	                 defconfig-hydrogen3 defconfig-ip22 
> 	                 defconfig-it8172 defconfig-ivr 
> 	                 defconfig-jmr3927 defconfig-lasat 
> 	                 defconfig-malta defconfig-mirage 
> 	                 defconfig-mpc30x defconfig-mtx-1 defconfig-nino 
> 	                 defconfig-ocelot defconfig-osprey 
> 	                 defconfig-pb1000 defconfig-pb1100 
> 	                 defconfig-pb1500 defconfig-pb1550 
> 	                 defconfig-rbtx4927 defconfig-rm200 
> 	                 defconfig-sb1250-swarm defconfig-sead 
> 	                 defconfig-tb0226 defconfig-tb0229 
> 	                 defconfig-ti1500 defconfig-workpad 
> 	                 defconfig-xxs1500 defconfig-yosemite 
> 	arch/mips64    : Tag: linux_2_4 defconfig-atlas 
> 	                 defconfig-decstation defconfig-ip22 
> 	                 defconfig-ip27 defconfig-jaguar defconfig-malta 
> 	                 defconfig-ocelotc defconfig-sb1250-swarm 
> 	                 defconfig-sead 
> 	drivers/net    : Tag: linux_2_4 Config.in 
> 
> Log message:
> 	Remove ~100 lines from the main 'config-shared.in' file to simplify the
> 	PCI configuration option. Update all config files to reflect the change
> 	as well as the stuff for kernel command line and Pb1550 *sigh*. Also
> 	fixed network config directives for 'make xconfig' breakages.
> 
> 
