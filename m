Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2013 16:50:00 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:10871 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815921Ab3LQPtyph7Ya (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Dec 2013 16:49:54 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rBHFnpZt011805
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 17 Dec 2013 10:49:52 -0500
Received: from deneb.redhat.com (ovpn-113-103.phx2.redhat.com [10.3.113.103])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id rBHFn9As022379;
        Tue, 17 Dec 2013 10:49:51 -0500
From:   Mark Salter <msalter@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>, linux-mips@linux-mips.org
Subject: [PATCH v2 04/10] mips: select ARCH_MIGHT_HAVE_PC_SERIO
Date:   Tue, 17 Dec 2013 10:48:47 -0500
Message-Id: <1387295333-24684-5-git-send-email-msalter@redhat.com>
In-Reply-To: <1387295333-24684-1-git-send-email-msalter@redhat.com>
References: <1387295333-24684-1-git-send-email-msalter@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <msalter@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msalter@redhat.com
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

Architectures which might use an i8042 for serial IO to keyboard,
mouse, etc should select ARCH_MIGHT_HAVE_PC_SERIO.

Signed-off-by: Mark Salter <msalter@redhat.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 650de39..99db162 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2,6 +2,7 @@ config MIPS
 	bool
 	default y
 	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
-- 
1.8.3.1
