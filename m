Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2004 09:56:34 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:48136
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8224774AbUG0I4a>; Tue, 27 Jul 2004 09:56:30 +0100
Received: from comm1.baslerweb.com (proxy.baslerweb.com [172.16.13.2])
          by proxy.baslerweb.com (Post.Office MTA v3.5.3 release 223
          ID# 0-0U10L2S100V35) with ESMTP id com
          for <linux-mips@linux-mips.org>; Tue, 27 Jul 2004 10:55:57 +0200
Received: from [172.16.13.253] (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id PLG5NBQP; Tue, 27 Jul 2004 10:56:25 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: ABI question
Date: Tue, 27 Jul 2004 10:57:52 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271057.53237.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi,

for 2.6 kernels, arch/mips/Makefile contains the following lines:

ifdef CONFIG_MIPS64
gcc-abi			= 64
gas-abi			= 32
tool-prefix		= $(64bit-tool-prefix)
UTS_MACHINE		:= mips64
endif

Is it intentional that gcc-abi and gas-abi are different? This
results in '-Wa,-32' appearing on gcc's command line, causing
the asembler to complain:

Error: -mgp64 used with a 32-bit ABI

If I change gas-abi to 64, this error goes away.

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
