Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:30:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20638 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008923AbbK3Q24Xzp0e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:28:56 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id C0883F496E251;
        Mon, 30 Nov 2015 16:28:47 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 16:28:50 +0000
Received: from localhost (10.100.200.236) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 16:28:49 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, Tejun Heo <tj@kernel.org>,
        "Joe Perches" <joe@perches.com>, Jiri Slaby <jslaby@suse.com>,
        "Mauro Carvalho Chehab" <mchehab@osg.samsung.com>,
        <linux-kernel@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mark Rutland" <mark.rutland@arm.com>
Subject: [PATCH 27/28] dt-bindings: mips: img,boston: Document img,boston binding
Date:   Mon, 30 Nov 2015 16:21:52 +0000
Message-ID: <1448900513-20856-28-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.236]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Add documentation for the simple img,boston devicetree binding & the
boot protocol used to pass the devicetree to the kernel.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 Documentation/devicetree/bindings/mips/img/boston.txt | 15 +++++++++++++++
 MAINTAINERS                                           |  5 +++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/img/boston.txt

diff --git a/Documentation/devicetree/bindings/mips/img/boston.txt b/Documentation/devicetree/bindings/mips/img/boston.txt
new file mode 100644
index 0000000..27b2806
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/img/boston.txt
@@ -0,0 +1,15 @@
+Imagination Technologies Boston Development Board
+=================================================
+
+Required properties:
+--------------------
+ - compatible: Must be "img,boston".
+
+Boot protocol:
+--------------
+In accordance with the MIPS UHI specification[1], the bootloader must pass the
+following arguments to the kernel:
+ - $a0: -2.
+ - $a1: KSEG0 address of the flattened device-tree blob.
+
+[1] http://prplfoundation.org/wiki/MIPS_documentation
diff --git a/MAINTAINERS b/MAINTAINERS
index 2e156b2..a9cd996 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5435,6 +5435,11 @@ L:	linux-security-module@vger.kernel.org
 S:	Supported
 F:	security/integrity/ima/
 
+IMGTEC BOSTON PLATFORM SUPPORT
+M:	Paul Burton <paul.burton@imgtec.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mips/img/boston.txt
+
 IMGTEC IR DECODER DRIVER
 M:	James Hogan <james.hogan@imgtec.com>
 S:	Maintained
-- 
2.6.2
