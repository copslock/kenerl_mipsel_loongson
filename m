Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 14:58:23 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:54109
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225366AbTJVN6V>; Wed, 22 Oct 2003 14:58:21 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA19177
	for <linux-mips@linux-mips.org>; Wed, 22 Oct 2003 09:58:14 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA15144
	for <linux-mips@linux-mips.org>; Wed, 22 Oct 2003 09:58:13 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Wed, 22 Oct 2003 09:58:13 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: root login
Message-ID: <Pine.GSO.4.44.0310220952170.15096-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I apologize for the many recent questions but I have another trivia
question for all of you. :-)
I have installed the RH7.3 miniport to a harddrive connected to a MIPS
Malta board. The kernel the comes with the port (2.4.18) works fine. I
then took the cvs code (2.4.22) for mips and built it for malta. The first
few builds worked ok (which means I could logon as root). Then I changed
something in the build process so that now the kernels which I build won't
allow me to logon as root. I've changed /etc/passwd to eliminate the root
pw. Does anyone know how a kernel can affect the login like this?
Thanks,

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
