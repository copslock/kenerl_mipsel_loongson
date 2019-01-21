Return-Path: <SRS0=dr9w=P5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BC7C282E9
	for <linux-mips@archiver.kernel.org>; Mon, 21 Jan 2019 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01242084A
	for <linux-mips@archiver.kernel.org>; Mon, 21 Jan 2019 08:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfAUIGt (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:06:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729595AbfAUIG3 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Mon, 21 Jan 2019 03:06:29 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0L83n8d064401
        for <linux-mips@vger.kernel.org>; Mon, 21 Jan 2019 03:06:28 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q57kw6aj3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@vger.kernel.org>; Mon, 21 Jan 2019 03:06:28 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 21 Jan 2019 08:06:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 08:06:14 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0L86DUX57606264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 08:06:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 095F35204E;
        Mon, 21 Jan 2019 08:06:13 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.125])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2FD2852059;
        Mon, 21 Jan 2019 08:06:08 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 21 Jan 2019 10:06:07 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 20/21] memblock: memblock_alloc_try_nid: don't panic
Date:   Mon, 21 Jan 2019 10:04:07 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012108-4275-0000-0000-00000301EA20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012108-4276-0000-0000-0000381015ED
Message-Id: <1548057848-15136-21-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210066
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

As all the memblock_alloc*() users are now checking the return value and
panic() in case of error, the panic() call can be removed from the core
memblock allocator, namely memblock_alloc_try_nid().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memblock.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 03b3929..7164275 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1526,7 +1526,7 @@ void * __init memblock_alloc_try_nid_nopanic(
 }
 
 /**
- * memblock_alloc_try_nid - allocate boot memory block with panicking
+ * memblock_alloc_try_nid - allocate boot memory block
  * @size: size of memory block to be allocated in bytes
  * @align: alignment of the region and block's size
  * @min_addr: the lower bound of the memory region from where the allocation
@@ -1536,9 +1536,8 @@ void * __init memblock_alloc_try_nid_nopanic(
  *	      allocate only from memory limited by memblock.current_limit value
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
- * Public panicking version of memblock_alloc_try_nid_nopanic()
- * which provides debug information (including caller info), if enabled,
- * and panics if the request can not be satisfied.
+ * Public function, provides additional debug information (including caller
+ * info), if enabled. This function zeroes the allocated memory.
  *
  * Return:
  * Virtual address of allocated memory block on success, NULL on failure.
@@ -1555,14 +1554,10 @@ void * __init memblock_alloc_try_nid(
 		     &max_addr, (void *)_RET_IP_);
 	ptr = memblock_alloc_internal(size, align,
 					   min_addr, max_addr, nid);
-	if (ptr) {
+	if (ptr)
 		memset(ptr, 0, size);
-		return ptr;
-	}
 
-	panic("%s: Failed to allocate %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa\n",
-	      __func__, (u64)size, (u64)align, nid, &min_addr, &max_addr);
-	return NULL;
+	return ptr;
 }
 
 /**
-- 
2.7.4

