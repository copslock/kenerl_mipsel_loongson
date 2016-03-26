Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Mar 2016 18:30:20 +0100 (CET)
Received: from aserp1040.oracle.com ([141.146.126.69]:48454 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025239AbcCZR3pnGhqu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Mar 2016 18:29:45 +0100
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u2QHTW6K030967
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 26 Mar 2016 17:29:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id u2QHTWg6011313
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 26 Mar 2016 17:29:32 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u2QHTT1A031348;
        Sat, 26 Mar 2016 17:29:31 GMT
Received: from localhost.localdomain (/73.159.178.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 26 Mar 2016 10:29:28 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Michal Marek <mmarek@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] ld-version: Fix awk regex compile failure
Date:   Sat, 26 Mar 2016 13:28:38 -0400
Message-Id: <1459013330-15318-34-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459013330-15318-1-git-send-email-sasha.levin@oracle.com>
References: <1459013330-15318-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 4b7b1ef2c2f83d702272555e8adb839a50ba0f8e ]

The ld-version.sh script fails on some versions of awk with the
following error, resulting in build failures for MIPS:

awk: scripts/ld-version.sh: line 4: regular expression compile failed (missing '(')

This is due to the regular expression ".*)", meant to strip off the
beginning of the ld version string up to the close bracket, however
brackets have a meaning in regular expressions, so lets escape it so
that awk doesn't expect a corresponding open bracket.

Fixes: ccbef1674a15 ("Kbuild, lto: add ld-version and ld-ifversion ...")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Tested-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Michal Marek <mmarek@suse.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # 4.4.x-
Patchwork: https://patchwork.linux-mips.org/patch/12838/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 scripts/ld-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
index 198580d..1659b40 100755
--- a/scripts/ld-version.sh
+++ b/scripts/ld-version.sh
@@ -1,7 +1,7 @@
 #!/usr/bin/awk -f
 # extract linker version number from stdin and turn into single number
 	{
-	gsub(".*)", "");
+	gsub(".*\\)", "");
 	split($1,a, ".");
 	print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
 	exit
-- 
2.5.0
