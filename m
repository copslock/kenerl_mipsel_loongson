Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 May 2015 21:28:08 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:44813 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026410AbbEBT1i7YtAo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 May 2015 21:27:38 +0200
Received: from localhost (unknown [87.213.45.130])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5E95DB4C;
        Sat,  2 May 2015 19:27:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.19 036/177] MIPS: Malta: Detect and fix bad memsize values
Date:   Sat,  2 May 2015 21:00:58 +0200
Message-Id: <20150502190121.243851746@linuxfoundation.org>
X-Mailer: git-send-email 2.3.7
In-Reply-To: <20150502190119.666291882@linuxfoundation.org>
References: <20150502190119.666291882@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47211
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

3.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit f7f8aea4b97c4d48e42f02cb37026bee445f239f upstream.

memsize denotes the amount of RAM we can access from kseg{0,1} and
that should be up to 256M. In case the bootloader reports a value
higher than that (perhaps reporting all the available RAM) it's best
if we fix it ourselves and just warn the user about that. This is
usually a problem with the bootloader and/or its environment.

[ralf@linux-mips.org: Remove useless parens as suggested bei Sergei.
Reformat long pr_warn statement to fit into 80 column limit.]

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9362/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mti-malta/malta-memory.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -53,6 +53,12 @@ fw_memblock_t * __init fw_getmdesc(int e
 		pr_warn("memsize not set in YAMON, set to default (32Mb)\n");
 		physical_memsize = 0x02000000;
 	} else {
+		if (memsize > (256 << 20)) { /* memsize should be capped to 256M */
+			pr_warn("Unsupported memsize value (0x%lx) detected! "
+				"Using 0x10000000 (256M) instead\n",
+				memsize);
+			memsize = 256 << 20;
+		}
 		/* If ememsize is set, then set physical_memsize to that */
 		physical_memsize = ememsize ? : memsize;
 	}
