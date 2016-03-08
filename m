Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2016 17:48:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40530 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007998AbcCHQsg4mkxr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Mar 2016 17:48:36 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 66698D48529E5;
        Tue,  8 Mar 2016 16:48:28 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 8 Mar 2016 16:48:30 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 8 Mar 2016 16:48:30 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, Michal Marek <mmarek@suse.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, <linux-mips@linux-mips.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH] ld-version: Fix awk regex compile failure
Date:   Tue, 8 Mar 2016 16:47:53 +0000
Message-ID: <1457455673-12219-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Michal Marek <mmarek@suse.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # 4.4.x-
---
I've only tested this with GNU Awk 4.0.2, which seems a bit more
lenient than whatever version of awk Geert's build machine is using.

I'd appreciated if somebody experiencing the error could give this patch
a spin to check it fixes it.
---
 scripts/ld-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
index d154f0877fd8..7bfe9fa1c8dc 100755
--- a/scripts/ld-version.sh
+++ b/scripts/ld-version.sh
@@ -1,7 +1,7 @@
 #!/usr/bin/awk -f
 # extract linker version number from stdin and turn into single number
 	{
-	gsub(".*)", "");
+	gsub(".*\\)", "");
 	gsub(".*version ", "");
 	gsub("-.*", "");
 	split($1,a, ".");
-- 
2.4.10
