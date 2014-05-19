Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2014 18:55:21 +0200 (CEST)
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:32149
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854782AbaESQzAtX6J1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 May 2014 18:55:00 +0200
Received: from alberich.caveonetworks.com (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Mon, 19 May 2014 16:54:41 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 03/12] kvm tools: Move definition of TERM_MAX_DEVS to header
Date:   Mon, 19 May 2014 18:53:22 +0200
Message-ID: <1400518411-9759-4-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM2PR06CA006.eurprd06.prod.outlook.com (10.255.61.23) To
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 021670B4D2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(81542001)(33646001)(92566001)(46102001)(21056001)(81156002)(87976001)(87286001)(4396001)(53416003)(62966002)(99396002)(50986999)(36756003)(77156001)(76482001)(93916002)(92726001)(88136002)(86362001)(81342001)(42186004)(79102001)(50466002)(20776003)(69596002)(47776003)(102836001)(31966008)(80022001)(74502001)(83322001)(77982001)(19580405001)(76176999)(19580395003)(50226001)(85852003)(83072002)(66066001)(64706001)(48376002)(89996001)(101416001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40144
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
