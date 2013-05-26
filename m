Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 May 2013 10:07:05 +0200 (CEST)
Received: from intranet.asianux.com ([58.214.24.6]:41550 "EHLO
        intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817030Ab3EZIHDNy3H3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 May 2013 10:07:03 +0200
Received: by intranet.asianux.com (Postfix, from userid 103)
        id 862C818402C6; Sun, 26 May 2013 16:06:56 +0800 (CST)
Received: from [10.1.0.143] (unknown [219.143.36.82])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by intranet.asianux.com (Postfix) with ESMTP id 308151840257;
        Sun, 26 May 2013 16:06:56 +0800 (CST)
Message-ID: <51A1C26E.5000609@asianux.com>
Date:   Sun, 26 May 2013 16:06:06 +0800
From:   Chen Gang <gang.chen@asianux.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     ralf@linux-mips.org, blogic@openwrt.org, david.daney@cavium.com
CC:     linux-mips@linux-mips.org, Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] arch: mips: kernel: using strlcpy() instead of strncpy()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <gang.chen@asianux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gang.chen@asianux.com
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


For NUL terminated string, need always be sure of ended by zero.

Or the next pr_info() will cause issue.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/mips/kernel/prom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 5712bb5..7e95404 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -30,7 +30,7 @@ __init void mips_set_machine_name(const char *name)
 	if (name == NULL)
 		return;
 
-	strncpy(mips_machine_name, name, sizeof(mips_machine_name));
+	strlcpy(mips_machine_name, name, sizeof(mips_machine_name));
 	pr_info("MIPS: machine is %s\n", mips_get_machine_name());
 }
 
-- 
1.7.7.6
