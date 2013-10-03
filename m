Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 09:47:24 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36835 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822995Ab3JCHrSZYwlN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Oct 2013 09:47:18 +0200
Received: by mail-pd0-f182.google.com with SMTP id r10so2080620pdi.13
        for <linux-mips@linux-mips.org>; Thu, 03 Oct 2013 00:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=dBeknLgWqRfE9ss1c2Ny6AXKSJ/55qtYzmCNeY0xCfE=;
        b=RgU6TADonALYqm3yJmkqJe2uWvW8JexfflHdcQ45lhV4yrm/KtdTe5Q2y5uAY3bvhT
         iYpIvjAZQHUXWR6wgl11LdOE8Xps/rmgKBdrzQmTgJJXj98QThohSeNETkiAbmwY/YBr
         ZiqBxGB19uCQ1PhdPpRjikznbjLO46qmSocBD9ZDb8/jpARaVxno+0WQFfDASdZNJmTv
         wOrztoyiX4lA29eSTnYC89YJUTMLZWWIiGvJLHgN60EKU6jVYV0OR93O72htaMpqjUMD
         DEY3+/cTlonHfUaqWdMD/rRYMzEB1wgPZjXB+w/3sXXbK1kmUVM9vXdyLQCoKqqoMS0J
         OsNQ==
X-Received: by 10.68.244.130 with SMTP id xg2mr7090164pbc.13.1380786431167;
        Thu, 03 Oct 2013 00:47:11 -0700 (PDT)
Received: from localhost ([115.115.74.130])
        by mx.google.com with ESMTPSA id uw6sm6472077pbc.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 00:47:10 -0700 (PDT)
From:   Prem Mallappa <prem.mallappa@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>
Subject: MIPS: KDUMP: fix for crashkernel to load from non-sectioned memory.
Date:   Thu,  3 Oct 2013 13:16:54 +0530
Message-Id: <1380786415-24956-1-git-send-email-pmallappa@caviumnetworks.com>
X-Mailer: git-send-email 1.8.4
Return-Path: <prem.mallappa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prem.mallappa@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


This only happens with kernels having initramfs builtin.
W.R.T following memory map, first kernel ends up in creating per-cpu crash notes (ELF PT_NOTE) in the higher memory area.
When a initramfs image is used, most often the crash_note ends up in "pfn's" belonging to 0x2000.0000

When crashkernel tries to access the PT_NOTEs (crash_notes per cpu variable) via __pfn_to_section <= pfn_to_page <= kmap, we end up in crash, as the sections belong to pfn 0x20006c00 (mem_section[2][0]) for a crash kernel is not populated.

Creating new mappings using ioremap solves the problem, which is pretty much what the patch does.

Determined physical RAM map:
 memory: 0000000004eff000 @ 0000000000100000 (usable)
 memory: 000000000a000000 @ 0000000005000000 (usable)   <<<< Crashkernel reserved area
 memory: 0000000030000000 @ 0000000020000000 (usable)

------------
mem_section[0][0]:0x8000000004180003
mem_section[1][0]:0x0
mem_section[2][0]:0x8000000003e00003
mem_section[3][0]:0x8000000003e00003
mem_section[4][0]:0x8000000003e00003
mem_section[5][0]:0x0
mem_section[6][0]:0x0  << Repeats rest of 1024 times >>

get_crash_notes_per_cpu: crash_notes addr = 20006c00
<<32 entries>>
get_crash_notes_per_cpu: crash_notes addr = 2013cc00


Crash Kernel
============
Determined physical RAM map:
 memory: 000000000a000000 @ 0000000005000000 (usable)
 memory: 0000000020000000 @ 0000000050000000 (usable)

------
mem_section[0][0]:0x8000000008184003
mem_section[1][0]:0x0
mem_section[2][0]:0x0
mem_section[3][0]:0x0
mem_section[4][0]:0x0
mem_section[5][0]:0x8000000007384003
mem_section[6][0]:0x8000000007384003
mem_section[7][0]:0x0    << Repeats rest of 1024 times >>
