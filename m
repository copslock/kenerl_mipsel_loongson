Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2003 19:25:38 +0000 (GMT)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:3448
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225309AbTJaTZg>; Fri, 31 Oct 2003 19:25:36 +0000
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id OAA28225
	for <linux-mips@linux-mips.org>; Fri, 31 Oct 2003 14:25:18 -0500 (EST)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id OAA22918
	for <linux-mips@linux-mips.org>; Fri, 31 Oct 2003 14:25:16 -0500 (EST)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Fri, 31 Oct 2003 14:25:16 -0500 (EST)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: latest build - xconfig
Message-ID: <Pine.GSO.4.44.0310311420480.22698-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

It seems like xconfig is broken on the code currently in cvs.
./tkparse < ../arch/mips/config.in >> kconfig.tk
arch/mips/config-shared.in: 894: can't handle
dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1

Hope this helps somebody.

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
