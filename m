Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 21:10:31 +0200 (CEST)
Received: from www17.your-server.de ([213.133.104.17]:32782 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817546Ab3ISTK3Lx7We (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Sep 2013 21:10:29 +0200
Received: from [146.60.53.248] (helo=[192.168.2.108])
        by www17.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.74)
        (envelope-from <thomas@m3y3r.de>)
        id 1VMjcL-0004y6-V2; Thu, 19 Sep 2013 21:10:22 +0200
Subject: [PATCH 1/10] MIPS: BCM47XX: Cocci spatch "noderef"
From:   thomas@m3y3r.de Thu Sep 19 17:31:10 2013
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-ID: <1379604755851-1504037195-1-diffsplit-thomas@m3y3r.de>
References: <1379604755850-858421494-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1379604755850-858421494-0-diffsplit-thomas@m3y3r.de>
Date:   Thu, 19 Sep 2013 20:38:21 +0200
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.97.6/17870/Tue Sep 17 17:11:27 2013)
Return-Path: <thomas@m3y3r.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@m3y3r.de Thu Sep 19 17:31:10 2013
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

sizeof when applied to a pointer typed expression gives the size of the
pointer.
Found by coccinelle spatch "misc/noderef.cocci"

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -162,7 +162,7 @@ static void nvram_read_alpha2(const char
 		pr_warn("alpha2 is too long %s\n", buf);
 		return;
 	}
-	memcpy(val, buf, sizeof(val));
+	memcpy(val, buf, sizeof(*val));
 }
 
 static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
