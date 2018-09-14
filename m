Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 14:18:41 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994565AbeINMOKepsJF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 14:14:10 +0200
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EC54Jn080076
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 08:14:10 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mgb0c4xag-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 08:14:09 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 13:14:07 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 13:13:56 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8ECDtNn58785798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 12:13:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C20D852050;
        Fri, 14 Sep 2018 15:13:42 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.116])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id A432752052;
        Fri, 14 Sep 2018 15:13:37 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 14 Sep 2018 15:13:49 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 30/30] docs/boot-time-mm: remove bootmem documentation
Date:   Fri, 14 Sep 2018 15:10:45 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091412-0008-0000-0000-000002715AA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091412-0009-0000-0000-000021D9A084
Message-Id: <1536927045-23536-31-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140129
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rppt@linux.vnet.ibm.com
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

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/core-api/boot-time-mm.rst | 71 +++++----------------------------
 1 file changed, 10 insertions(+), 61 deletions(-)

diff --git a/Documentation/core-api/boot-time-mm.rst b/Documentation/core-api/boot-time-mm.rst
index 03cb164..e5ec9f1 100644
--- a/Documentation/core-api/boot-time-mm.rst
+++ b/Documentation/core-api/boot-time-mm.rst
@@ -5,54 +5,23 @@ Boot time memory management
 Early system initialization cannot use "normal" memory management
 simply because it is not set up yet. But there is still need to
 allocate memory for various data structures, for instance for the
-physical page allocator. To address this, a specialized allocator
-called the :ref:`Boot Memory Allocator <bootmem>`, or bootmem, was
-introduced. Several years later PowerPC developers added a "Logical
-Memory Blocks" allocator, which was later adopted by other
-architectures and renamed to :ref:`memblock <memblock>`. There is also
-a compatibility layer called `nobootmem` that translates bootmem
-allocation interfaces to memblock calls.
+physical page allocator.
 
-The selection of the early allocator is done using
-``CONFIG_NO_BOOTMEM`` and ``CONFIG_HAVE_MEMBLOCK`` kernel
-configuration options. These options are enabled or disabled
-statically by the architectures' Kconfig files.
-
-* Architectures that rely only on bootmem select
-  ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=n``.
-* The users of memblock with the nobootmem compatibility layer set
-  ``CONFIG_NO_BOOTMEM=y && CONFIG_HAVE_MEMBLOCK=y``.
-* And for those that use both memblock and bootmem the configuration
-  includes ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=y``.
-
-Whichever allocator is used, it is the responsibility of the
-architecture specific initialization to set it up in
-:c:func:`setup_arch` and tear it down in :c:func:`mem_init` functions.
+A specialized allocator called ``memblock`` performs the
+boot time memory management. The architecture specific initialization
+must set it up in :c:func:`setup_arch` and tear it down in
+:c:func:`mem_init` functions.
 
 Once the early memory management is available it offers a variety of
 functions and macros for memory allocations. The allocation request
 may be directed to the first (and probably the only) node or to a
 particular node in a NUMA system. There are API variants that panic
-when an allocation fails and those that don't. And more recent and
-advanced memblock even allows controlling its own behaviour.
-
-.. _bootmem:
-
-Bootmem
-=======
-
-(mostly stolen from Mel Gorman's "Understanding the Linux Virtual
-Memory Manager" `book`_)
-
-.. _book: https://www.kernel.org/doc/gorman/
-
-.. kernel-doc:: mm/bootmem.c
-   :doc: bootmem overview
+when an allocation fails and those that don't.
 
-.. _memblock:
+Memblock also offers a variety of APIs that control its own behaviour.
 
-Memblock
-========
+Memblock Overview
+=================
 
 .. kernel-doc:: mm/memblock.c
    :doc: memblock overview
@@ -61,26 +30,6 @@ Memblock
 Functions and structures
 ========================
 
-Common API
-----------
-
-The functions that are described in this section are available
-regardless of what early memory manager is enabled.
-
-.. kernel-doc:: mm/nobootmem.c
-
-Bootmem specific API
---------------------
-
-These interfaces available only with bootmem, i.e when ``CONFIG_NO_BOOTMEM=n``
-
-.. kernel-doc:: include/linux/bootmem.h
-.. kernel-doc:: mm/bootmem.c
-   :nodocs:
-
-Memblock specific API
----------------------
-
 Here is the description of memblock data structures, functions and
 macros. Some of them are actually internal, but since they are
 documented it would be silly to omit them. Besides, reading the
@@ -89,4 +38,4 @@ really happens under the hood.
 
 .. kernel-doc:: include/linux/memblock.h
 .. kernel-doc:: mm/memblock.c
-   :nodocs:
+   :functions:
-- 
2.7.4
