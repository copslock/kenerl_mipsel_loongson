Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2003 22:23:04 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:48433
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225524AbTJUVXC>; Tue, 21 Oct 2003 22:23:02 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id RAA08931
	for <linux-mips@linux-mips.org>; Tue, 21 Oct 2003 17:22:50 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id RAA14456
	for <linux-mips@linux-mips.org>; Tue, 21 Oct 2003 17:22:49 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Tue, 21 Oct 2003 17:22:49 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: module dependency files
Message-ID: <Pine.GSO.4.44.0310211717110.14194-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I have now gotten the modules to build but there is one part of the
process that doesn't work. On my pc I want to build all of the files which
are to be installed on the mips board. I am trying to create the files
which can be copied onto (or into) the redhat 7.3 miniport. "make modules"
works fine. It seems like I need to run "make modules_install" but it
complains about the .o files being the wrong architecture. So the basic
question seems to be how can I run depmod on the pc for mips?
Thanks again.

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
