Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 15:09:39 +0200 (CEST)
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:34701 "EHLO
        e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832655Ab3ISNJcw4OGY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Sep 2013 15:09:32 +0200
Received: from /spool/local
        by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <maddy@linux.vnet.ibm.com>;
        Thu, 19 Sep 2013 18:39:22 +0530
Received: from d28dlp01.in.ibm.com (9.184.220.126)
        by e28smtp01.in.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 19 Sep 2013 18:39:20 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
        by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7D113E0053;
        Thu, 19 Sep 2013 18:40:17 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
        by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r8JDBQpM40960188;
        Thu, 19 Sep 2013 18:41:29 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
        by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r8JD9DGf022071;
        Thu, 19 Sep 2013 18:39:13 +0530
Received: from SrihariMadhavan.in.ibm.com (sriharimadhavan.in.ibm.com [9.121.0.193] (may be forged))
        by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id r8JD9CDf022036;
        Thu, 19 Sep 2013 18:39:13 +0530
From:   Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To:     ralf@linux-mips.org
Cc:     steven.hill@imgtec.com, mmarek@suse.cz, swarren@nvidia.com,
        linux-mips@linux-mips.org, linux-kbuild@vger.kernel.org,
        james.hogan@imgtec.com,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] MIPS: fix invalid symbolic link file
Date:   Thu, 19 Sep 2013 18:39:08 +0530
Message-Id: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.7.10.4
X-TM-AS-MML: No
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13091913-4790-0000-0000-00000A67CB42
Return-Path: <maddy@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maddy@linux.vnet.ibm.com
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

   Commit 3b29aa5ba204c created a symlink file in include/dt-bindings.
   Even though commit diff is fine, symlink is invalid.
   ls -lb shows a newline character at the end of the filename.

lrwxrwxrwx 1 maddy maddy 35 Sep 19 18:11 dt-bindings ->
../../../../../include/dt-bindings\n

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/mips/boot/dts/include/dt-bindings |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/include/dt-bindings b/arch/mips/boot/dts/include/dt-bindings
index 68ae388..08c00e4 120000
--- a/arch/mips/boot/dts/include/dt-bindings
+++ b/arch/mips/boot/dts/include/dt-bindings
@@ -1 +1 @@
-../../../../../include/dt-bindings
+../../../../../include/dt-bindings
\ No newline at end of file
-- 
1.7.10.4
