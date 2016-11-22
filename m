Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 22:05:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58144 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993096AbcKVVFaxkWKW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2016 22:05:30 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id D12CCCB2A982D;
        Tue, 22 Nov 2016 21:05:20 +0000 (GMT)
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775%25]) with mapi id
 14.03.0294.000; Tue, 22 Nov 2016 21:05:24 +0000
From:   Matt Redfearn <Matt.Redfearn@imgtec.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: [PATCH 2/5] MIPS: Fix vmlinux.64 target for CONFIG_RELOCATABLE
Thread-Topic: [PATCH 2/5] MIPS: Fix vmlinux.64 target for CONFIG_RELOCATABLE
Thread-Index: AQHSRPq7iM50kE8+a02DIiNtp8hbuqDlffz8
Date:   Tue, 22 Nov 2016 21:05:23 +0000
Message-ID: <9FCBB1D1936B2F4DB2DD02BA3957FB504CF9EBF8@HHMAIL01.hh.imgtec.org>
References: <6f8e21bd-ca22-5866-83dc-d70e4e10842b@cavium.com>
In-Reply-To: <6f8e21bd-ca22-5866-83dc-d70e4e10842b@cavium.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.11.182.224]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matt.Redfearn@imgtec.com
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

Hi Steven,

Please could you see if https://patchwork.linux-mips.org/patch/14554/ fixes this issue?

Thanks,
Matt
________________________________________
From: linux-mips-bounce@linux-mips.org [linux-mips-bounce@linux-mips.org] on behalf of Steven J. Hill [Steven.Hill@cavium.com]
Sent: 22 November 2016 19:44
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH 2/5] MIPS: Fix vmlinux.64 target for CONFIG_RELOCATABLE

The vmlinux.64 target was broken when building a relocatable
kernel. Fix calling of the correct tool.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1a6bac7..61568df 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -353,6 +353,11 @@ endif
 quiet_cmd_64 = OBJCOPY $@
        cmd_64 = $(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@
 vmlinux.64: vmlinux
+ifeq ($(CONFIG_RELOCATABLE)$(CONFIG_64BIT),yy)
+# Currently, objcopy fails to handle the relocations in the elf64
+# So the relocs tool must be run here to remove them first
+       $(call cmd,relocs)
+endif
        $(call cmd,64)

 all:   $(all-y)
--
1.9.1
