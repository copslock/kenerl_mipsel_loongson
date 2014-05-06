Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2014 17:53:00 +0200 (CEST)
Received: from mail-by2lp0235.outbound.protection.outlook.com ([207.46.163.235]:14371
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6837583AbaEFPw3wwfR5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 May 2014 17:52:29 +0200
Received: from CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) by
 CO1PR07MB940.namprd07.prod.outlook.com (10.141.73.25) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:21 +0000
Received: from alberich.caveonetworks.com (2.171.87.122) by
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:20 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 03/11] kvm tools: Move definition of TERM_MAX_DEVS to header
Date:   Tue, 6 May 2014 17:51:23 +0200
Message-ID: <1399391491-5021-4-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.171.87.122]
X-ClientProxiedBy: DBXPR07CA010.eurprd07.prod.outlook.com (10.255.191.168)
 To CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19)
X-Forefront-PRVS: 0203C93D51
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(77982001)(83072002)(85852003)(89996001)(92566001)(31966008)(77156001)(99396002)(20776003)(47776003)(83322001)(19580405001)(74662001)(74502001)(19580395003)(92726001)(80022001)(33646001)(53416003)(66066001)(2009001)(4396001)(36756003)(88136002)(81542001)(101416001)(50226001)(42186004)(93916002)(86362001)(81342001)(46102001)(79102001)(62966002)(50466002)(76482001)(87976001)(87286001)(50986999)(48376002)(76176999);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR07MB396;H:alberich.caveonetworks.com;FPR:F26675E1.2F9435A2.FBE72B4B.80E88A0B.20136;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

In order to use it in other C files (in addition to term.c).

Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/include/kvm/term.h |    2 ++
 tools/kvm/term.c             |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/kvm/include/kvm/term.h b/tools/kvm/include/kvm/term.h
index 5f63457..dc9882e 100644
--- a/tools/kvm/include/kvm/term.h
+++ b/tools/kvm/include/kvm/term.h
@@ -10,6 +10,8 @@
 #define CONSOLE_VIRTIO	2
 #define CONSOLE_HV	3
 
+#define TERM_MAX_DEVS	4
+
 int term_putc_iov(struct iovec *iov, int iovcnt, int term);
 int term_getc_iov(struct kvm *kvm, struct iovec *iov, int iovcnt, int term);
 int term_putc(char *addr, int cnt, int term);
diff --git a/tools/kvm/term.c b/tools/kvm/term.c
index 214f5e2..3de410b 100644
--- a/tools/kvm/term.c
+++ b/tools/kvm/term.c
@@ -16,7 +16,6 @@
 
 #define TERM_FD_IN      0
 #define TERM_FD_OUT     1
-#define TERM_MAX_DEVS	4
 
 static struct termios	orig_term;
 
-- 
1.7.9.5
