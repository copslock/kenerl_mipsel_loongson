Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 18:52:39 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50973 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013726AbcCNRwGlyJ9i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Mar 2016 18:52:06 +0100
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5918D0F;
        Mon, 14 Mar 2016 17:52:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Michal Marek <mmarek@suse.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mips@linux-mips.org,
        linux-kbuild@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 50/50] ld-version: Fix awk regex compile failure
Date:   Mon, 14 Mar 2016 10:51:08 -0700
Message-Id: <20160314175020.516966872@linuxfoundation.org>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <20160314175013.403628835@linuxfoundation.org>
References: <20160314175013.403628835@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 4b7b1ef2c2f83d702272555e8adb839a50ba0f8e upstream.

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
Patchwork: https://patchwork.linux-mips.org/patch/12838/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/ld-version.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
