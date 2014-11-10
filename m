Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 07:46:36 +0100 (CET)
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:42176 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013156AbaKJGqes0hHY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 07:46:34 +0100
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-07v.sys.comcast.net with comcast
        id DimR1p0042EPM3101imUPC; Mon, 10 Nov 2014 06:46:28 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-ch2-07v.sys.comcast.net with comcast
        id DimT1p0020gJalY01imTPo; Mon, 10 Nov 2014 06:46:28 +0000
Message-ID: <54605F42.1040403@gentoo.org>
Date:   Mon, 10 Nov 2014 01:46:26 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: R10000: Mark CPU_SUPPORTS_HUGEPAGES as broken
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415601988;
        bh=B/68KhmIGlekSxuNY/r26OsF1ChW1/5ad/vj1tjhcQI=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=i6MicDGzjKh1hadhD/fMKF4a9cTXxzlUYVfaOiVHZU+20hIKS/wBKULsiqyx0RgPM
         +fbVohZy+3Qr0MNhv/RqfnmeO2HBbVxPc1Me+Dg0tjFVTdg6POumYhCK5R61DbNjuH
         t58leR5zMOxaqDjrqy/UCUIENHTuwVaqyrjnOJnrs+O9+h3G74UeUn4WG4H/NT5/S/
         hUvHizw81RbPwQ8ZxFDJOnOqiMQ58VPS9o1ID4OOv0DGBNCoPWzbcpwJqp4ZW23lJj
         iitBz/lh/txUopuad1XmA4h9dJgqW/nC6YVkdUDMkCtqzK29PS0EXJH3WVOGQWZmYo
         TgxWWnR1gajpA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

Enabling CONFIG_TRANSPARENT_HUGEPAGE on an R10000-family processor on at least
SGI IP27 and IP30 machines creates problems, including random SIGSEGV and
SIGBUS signals to processes that attempt to use huge pages.  Until someone with
deeper TLB knowledge on R10K can attempt to solve this problem, marking
CPU_SUPPORTS_HUGEPAGES as BROKEN seems like a sensible thing to do.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5c3992c..7432be6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1418,7 +1418,7 @@ config CPU_R10000
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
-	select CPU_SUPPORTS_HUGEPAGES
+	select CPU_SUPPORTS_HUGEPAGES if BROKEN
 	help
 	  MIPS Technologies R10000-series processors.
 
