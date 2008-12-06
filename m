Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Dec 2008 02:17:55 +0000 (GMT)
Received: from exch1.onstor.com ([66.201.51.80]:19151 "EHLO exch1.onstor.com")
	by ftp.linux-mips.org with ESMTP id S24155337AbYLFCRs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Dec 2008 02:17:48 +0000
Received: from ripper.onstor.net (10.0.0.42) by exch1.onstor.net (10.0.0.225)
 with Microsoft SMTP Server (TLS) id 8.1.311.2; Fri, 5 Dec 2008 18:17:38 -0800
Date:	Fri, 5 Dec 2008 18:17:37 -0800
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	"linux-mips@" <linux-mips.org linux-mips@linux-mips.org>
Subject: question regarding system memory whatever
Message-ID: <20081205181737.2fc890bc@ripper.onstor.net>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 2K3Xl1OQTInXD6xxuA8z3Q==
X-EMS-STAMP: Jnny417swVC6SVbRCEQf2A==
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

I recently changed plat_mem_setup() or equivalent in my platform code
to not mark the first 32M of memory as BOOT_MEM_ROM_DATA and instead
have the first BOOT_MEM_RAM memory region start at 0.  Here is the two
lines of output from mem_init() for the two different versions:

Memory: 433408k/475136k available (2202k kernel code, 41556k reserved, 690k data, 112k init, 0k highmem)

Memory: 433408k/507904k available (2202k kernel code, 74324k reserved, 689k data, 112k init, 0k highmem)

As you can see, the 32M got added to "reserved" memory (?) and only
added to the right hand number of the "available".  OK, so what does
that mean?  I promised our monkey userspace programmers that they
would have another 32M of memory to slosh around in, but before I
release this change on them I'd like to know what these numbers are
telling me.

This is on 2.6.22 from l.m.o on a Sibyte 1125 in 64bit LE.
CONFIG_FLATMEM=y which was the fashion at the time.

Cheers,

a
