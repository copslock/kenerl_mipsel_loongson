Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2003 14:11:39 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:23719
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225442AbTJXNLe>; Fri, 24 Oct 2003 14:11:34 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA18352
	for <linux-mips@linux-mips.org>; Fri, 24 Oct 2003 09:11:27 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA17407
	for <linux-mips@linux-mips.org>; Fri, 24 Oct 2003 09:11:26 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Fri, 24 Oct 2003 09:11:26 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: configuring 2 ethernet ports
Message-ID: <Pine.GSO.4.44.0310240905590.17395-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I am trying to setup a pci wlan nic on a Malta board. I've compiled the
driver into the kernel and I have setup
/etc/sysconfig/network-scripts/ifcfg-eth1. After boot, when I look at
/proc/pci it looks like the system detected the card fine but ifconfig
only shows eth0 (the builtin port). How is the pci id linked to a
particular driver? What else do I need to do? I've scoured google but have
not come up with an answer. Thanks again,

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
