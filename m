Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 13:01:21 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:14354 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225307AbTCaMBU>;
	Mon, 31 Mar 2003 13:01:20 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP
	id 8DAA4B597; Mon, 31 Mar 2003 14:01:17 +0200 (CEST)
Message-ID: <3E882FB8.BBFDACE2@ekner.info>
Date: Mon, 31 Mar 2003 14:08:24 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Au1500 hardware cache coherency
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

Hi Pete,

I am attempting to use the HW coherency feature of the AU1500 to avoid SW flushes and increase the performance.
In the config-shared.in file, I can see that the CONFIG_NONCOHERENT_IO define is always set for the AMD
eval boards, which results in SW cache flushes when dma_cache_xxx functions are called. If HW coherency is
working, this define should not be set.

However, in your drivers, you only call the dma_cache functions from au1000/common/usbdev.c, but not from e.g. the ethernet
driver or the audio driver. Is this intentional? It seems that the ethernet & audio driver already relies on HW
coherency to function correctly (and it also sets the MAC enable bits accordingly, to force all ETH DMA
accesses to be coherent), so why not USB also?

When turning off NONCOHERENT_IO, there are some bugs (not in AU1000 code) which prevents the code from
compiling, but I have fixed these. And the kernel boots, but during some large disk-copy tests, I get occasional
data errors which I'm looking in to.

So before spending more time on debugging this, and creating patches for using HW coherency, I wanted to hear
your input - maybe there are known problems in the Au1500 coherency implementation?

/Hartvig
