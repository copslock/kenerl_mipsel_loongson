Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 06:54:41 +0000 (GMT)
Received: from zok.SGI.COM ([IPv6:::ffff:204.94.215.101]:48014 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225192AbTBRGyk>;
	Tue, 18 Feb 2003 06:54:40 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1I6sYKp018554
	for <@external-mail-relay.sgi.com:linux-mips@linux-mips.org>; Mon, 17 Feb 2003 22:54:35 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id RAA09355 for <linux-mips@linux-mips.org>; Tue, 18 Feb 2003 17:54:32 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1I6sSuP006378
	for <linux-mips@linux-mips.org>; Tue, 18 Feb 2003 17:54:29 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1I6sRK8006376
	for linux-mips@linux-mips.org; Tue, 18 Feb 2003 17:54:27 +1100
Date: Tue, 18 Feb 2003 17:54:27 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: weirdness in bootmem_init(), arch/mips64/kernel/setup.c
Message-ID: <20030218065427.GA915@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

This code isn't really relevant to what I'm working on (it isn't compiled
in to kernels for the ip27), but I just noticed it, and it looks broken:

        /* Find the highest page frame number we have available.  */
        max_pfn = 0;
        for (i = 0; i < boot_mem_map.nr_map; i++) {
                unsigned long start, end;

                if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
                        continue;

*****           start = PFN_UP(boot_mem_map.map[i].addr);
*****           end = PFN_DOWN(boot_mem_map.map[i].addr
                      + boot_mem_map.map[i].size);

*****           if (start >= end)
                        continue;
                if (end > max_pfn)
                        max_pfn = end;
        }


That test looks like it will always succeed... and it looks like the
author wanted it to be a sanity check.

Why all this business with PFN_UP and PFN_DOWN?  (They are bit
shifts... PFN_UP shifts left, PFN_DOWN shifts right)

Cheers,
Andrew
