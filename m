Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 20:41:11 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:34847 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491187Ab1CRTlI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 20:41:08 +0100
Received: by wyb28 with SMTP id 28so4335903wyb.36
        for <multiple recipients>; Fri, 18 Mar 2011 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=t+EZQ33GnU0mzuiO2W6Fak62ci1GZvb1nEqpNjyR4C8=;
        b=BsefUBUA7uCzUFxH56D7gAfHtRBlicXZFP6WDLFaEkGkQRomcyHDB88OKORvtrWKk3
         Jb/NcinvAhnThdAphtKS3gbKF0EZ2QcBhNJETOFAGYRR6KjJtnYelPcwF6tqtzrFdYXI
         QXAoneRSe6iCcDi3LqrJEKbL/r0KrDfXI+VAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=qzRN+L6pOvtAjNWgqYZfWCboWoKn+Qbly2pxZq9fNZ2lpjQLWAGMj/cF3r6zSIy7ba
         zYzs9EcTlDm92LELYYb/WYCQ8nCSMJHo4HW/HelsPx56uGzkGU83J3g+lWhhM4f0FaR1
         5eDNJSM+FNUe8niVViDh+aWPFackzG+YvQivs=
Received: by 10.227.207.21 with SMTP id fw21mr1573121wbb.138.1300477258063;
        Fri, 18 Mar 2011 12:40:58 -0700 (PDT)
Received: from prasad-kvm (pineapple.rdg.ac.uk [134.225.206.123])
        by mx.google.com with ESMTPS id u9sm1514591wbg.51.2011.03.18.12.40.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 12:40:56 -0700 (PDT)
Date:   Fri, 18 Mar 2011 19:41:35 +0000
From:   Prasad Joshi <prasadjoshi124@gmail.com>
To:     akpm@linux-foundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        prasadjoshi124@gmail.com, mitra@kqinfotech.com
Cc:     chris@zankel.net, x86@kernel.org, jdike@addtoit.com, tj@kernel.org,
        cmetcalf@tilera.com, linux-sh@vger.kernel.org,
        liqin.chen@sunplusct.com, lennox.wu@gmail.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        linux390@de.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, kyle@mcmartin.ca, deller@gmx.de,
        jejb@parisc-linux.org, linux-parisc@vger.kernel.org,
        dhowells@redhat.com, yasutake.koichi@jp.panasonic.com,
        linux-am33-list@redhat.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, monstr@monstr.eu,
        microblaze-uclinux@itee.uq.edu.au, geert@linux-m68k.org,
        zippel@linux-m68k.org, sammy@sammy.net,
        linux-m68k@lists.linux-m68k.org, takata@linux-m32r.org,
        linux-m32r@ml.linux-m32r.org, tony.luck@intel.com,
        fenghua.yu@intel.com, linux-ia64@vger.kernel.org, starvik@axis.com,
        jesper.nilsson@axis.com, linux-cris-kernel@axis.com,
        hans-christian.egtvedt@atmel.com, linux@arm.linux.org.uk,
        rth@twiddle.net, linux-alpha@vger.kernel.org
Subject: [RFC][PATCH v3 00/22] __vmalloc: Propagating GFP allocation flag
 inside __vmalloc()
Message-ID: <20110318194135.GA4746@prasad-kvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <prasadjoshi124@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasadjoshi124@gmail.com
Precedence: bulk
X-list: linux-mips

A filesystem might run into a problem while calling __vmalloc(GFP_NOFS)
inside a lock.

It is expected than __vmalloc when called with GFP_NOFS should not
callback the filesystem code even incase of the increased memory
pressure. But the problem is that even if we pass this flag, __vmalloc
itself allocates memory with GFP_KERNEL.

Using GFP_KERNEL allocations may go into the memory reclaim path and try
to free memory by calling file system evict_inode function. Which might
lead into deadlock.

For further details
http://marc.info/?l=linux-mm&m=128942194520631&w=4
https://bugzilla.kernel.org/show_bug.cgi?id=30702

The patch passes the gfp allocation flag all the way down to those
allocating functions.

 arch/arm/include/asm/pgalloc.h           |   11 +++++-
 arch/avr32/include/asm/pgalloc.h         |    8 ++++-
 arch/cris/include/asm/pgalloc.h          |   10 ++++-
 arch/frv/include/asm/pgalloc.h           |    3 ++
 arch/frv/include/asm/pgtable.h           |    1 +
 arch/frv/mm/pgalloc.c                    |    9 ++++-
 arch/ia64/include/asm/pgalloc.h          |   24 +++++++++++--
 arch/m32r/include/asm/pgalloc.h          |   11 ++++--
 arch/m68k/include/asm/motorola_pgalloc.h |   20 +++++++++--
 arch/m68k/include/asm/sun3_pgalloc.h     |   14 ++++++--
 arch/m68k/mm/memory.c                    |    9 ++++-
 arch/microblaze/include/asm/pgalloc.h    |    3 ++
 arch/microblaze/mm/pgtable.c             |   13 +++++--
 arch/mips/include/asm/pgalloc.h          |   22 ++++++++----
 arch/mn10300/include/asm/pgalloc.h       |    2 +
 arch/mn10300/mm/pgtable.c                |   10 ++++-
 arch/parisc/include/asm/pgalloc.h        |   21 ++++++++---
 arch/powerpc/include/asm/pgalloc-32.h    |    2 +
 arch/powerpc/include/asm/pgalloc-64.h    |   27 +++++++++++---
 arch/powerpc/mm/pgtable_32.c             |   10 ++++-
 arch/s390/include/asm/pgalloc.h          |   30 +++++++++++++---
 arch/s390/mm/pgtable.c                   |   22 +++++++++---
 arch/score/include/asm/pgalloc.h         |   13 ++++---
 arch/sh/include/asm/pgalloc.h            |    8 ++++-
 arch/sh/mm/pgtable.c                     |    8 ++++-
 arch/sparc/include/asm/pgalloc_32.h      |    5 +++
 arch/sparc/include/asm/pgalloc_64.h      |   17 ++++++++-
 arch/tile/include/asm/pgalloc.h          |   13 ++++++-
 arch/tile/mm/pgtable.c                   |   10 ++++-
 arch/um/include/asm/pgalloc.h            |    1 +
 arch/um/kernel/mem.c                     |   21 ++++++++---
 arch/x86/include/asm/pgalloc.h           |   17 ++++++++-
 arch/x86/mm/pgtable.c                    |    8 ++++-
 arch/xtensa/include/asm/pgalloc.h        |    9 ++++-
 arch/xtensa/mm/pgtable.c                 |   11 +++++-
 include/asm-generic/4level-fixup.h       |    8 +++-
 include/asm-generic/pgtable-nopmd.h      |    3 +-
 include/asm-generic/pgtable-nopud.h      |    1 +
 include/linux/mm.h                       |   40 ++++++++++++++++-----
 mm/memory.c                              |   14 ++++---
 mm/vmalloc.c                             |   57 ++++++++++++++++++++----------
 41 files changed, 427 insertions(+), 119 deletions(-)
