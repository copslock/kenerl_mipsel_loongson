Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 07:12:41 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:1382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832655Ab3JHFMjFH5Z5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 07:12:39 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r985Ca1S017599
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 8 Oct 2013 01:12:37 -0400
Received: from deneb.redhat.com ([10.3.113.12])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r985CA0L020195;
        Tue, 8 Oct 2013 01:12:36 -0400
From:   Mark Salter <msalter@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v2 07/14] mips: select ARCH_MAY_HAVE_PC_PARPORT
Date:   Tue,  8 Oct 2013 01:10:23 -0400
Message-Id: <1381209030-351-8-git-send-email-msalter@redhat.com>
In-Reply-To: <1381209030-351-1-git-send-email-msalter@redhat.com>
References: <1381209030-351-1-git-send-email-msalter@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <msalter@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38248
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

Architectures which support CONFIG_PARPORT_PC should select
ARCH_MAY_HAVE_PC_PARPORT.

Signed-off-by: Mark Salter <msalter@redhat.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f75ab4a..199fde67 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1,6 +1,7 @@
 config MIPS
 	bool
 	default y
+	select ARCH_MAY_HAVE_PC_PARPORT
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
-- 
1.8.3.1
