Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2010 18:44:59 +0100 (CET)
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:62725 "EHLO
        CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492026Ab0BFRow (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Feb 2010 18:44:52 +0100
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML109.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
         Sat, 6 Feb 2010 18:44:45 +0100
From:   Frans Pop <elendil@planet.nl>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] remove trailing spaces in messages
Date:   Sat, 6 Feb 2010 18:44:36 +0100
User-Agent: KMail/1.9.9
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@elte.hu>,
        Jeff Dike <jdike@addtoit.com>,
        Jiri Kosina <trivial@kernel.org>,
        Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-pm@lists.linux-foundation.org, linuxppc-dev@ozlabs.org,
        linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        microblaze-uclinux@itee.uq.edu.au,
        Mike Frysinger <vapier@gentoo.org>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        Russell King <linux@arm.linux.org.uk>,
        sparclinux@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        uclinux-dist-devel@blackfin.uclinux.org,
        user-mode-linux-devel@lists.sourceforge.net, x86@kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002061844.45212.elendil@planet.nl>
X-OriginalArrivalTime: 06 Feb 2010 17:44:45.0591 (UTC) FILETIME=[12149270:01CAA754]
Return-Path: <elendil@planet.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elendil@planet.nl
Precedence: bulk
X-list: linux-mips

This is a first series of patches to remove trailing spaces in messages. 
Patches cover arch-specific code plus one fix for PM and one in 
Documentation. Depending on how this series is received I'll continue
with other parts of the kernel.

Benefits are:
- general cleanup and consistency
- minor reduction in kernel size and user's log file size
- reduced annoyance for people writing logcheck rules

The patch for m68k has been rebased against linux-next; all other
patches apply against both mainline and -next (as of 5-2).

Shortstat:
 74 files changed, 135 insertions(+), 136 deletions(-)

Frans Pop (16):
      alpha: remove trailing spaces in messages
      arm: remove trailing spaces in messages
      ia64: remove trailing space in messages
      m68k: remove trailing space in messages
      microblaze: remove trailing space in messages
      mips: remove trailing space in messages
      parisc: remove trailing space in messages
      s390: remove trailing space in messages
      sparc: remove trailing space in messages
      x86: remove trailing space in messages
      blackfin: remove trailing space in messages
      cris/trivial: remove trailing space in message
      powerpc: remove trailing space in messages
      um: remove trailing space in messages
      PM: remove trailing space in message
      trivial: remove trailing space in spidev test program
