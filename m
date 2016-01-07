Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 18:55:31 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:55220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014611AbcAGRz2zZN0e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Jan 2016 18:55:28 +0100
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (Postfix) with ESMTPS id 23E6EA2023;
        Thu,  7 Jan 2016 17:55:27 +0000 (UTC)
Received: from redhat.com (vpn1-6-132.ams2.redhat.com [10.36.6.132])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u07HtOZ3026136;
        Thu, 7 Jan 2016 12:55:25 -0500
Date:   Thu, 7 Jan 2016 19:55:24 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] ld-version: fix it on Fedora
Message-ID: <1452189189-31188-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

On Fedora 23, ld --version outputs:
GNU ld version 2.25-15.fc23

But ld-version.sh fails to parse this, so e.g.  mips build fails to
enable VDSO, printing a warning that binutils >= 2.24 is required.

To fix, teach ld-version to parse this format.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Which tree should this be merged through? Mine? MIPS?

 scripts/ld-version.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
index 198580d..25d23c8 100755
--- a/scripts/ld-version.sh
+++ b/scripts/ld-version.sh
@@ -2,6 +2,8 @@
 # extract linker version number from stdin and turn into single number
 	{
 	gsub(".*)", "");
+	gsub(".*version ", "");
+	gsub("-.*", "");
 	split($1,a, ".");
 	print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
 	exit
-- 
MST
