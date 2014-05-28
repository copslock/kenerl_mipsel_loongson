Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2014 22:32:00 +0200 (CEST)
Received: from mail-bn1lp0141.outbound.protection.outlook.com ([207.46.163.141]:30117
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854796AbaE1UaWL7Gje (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 May 2014 22:30:22 +0200
Received: from localhost.localdomain (31.213.222.82) by
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 20:30:18 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3 12/12] kvm tools: Return number of bytes written by term_putc
Date:   Wed, 28 May 2014 22:28:06 +0200
Message-ID: <1401308886-17394-12-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: DB3PR07CA008.eurprd07.prod.outlook.com (10.242.134.48) To
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(74662001)(76176999)(50986999)(83072002)(74502001)(21056001)(66066001)(99396002)(85852003)(64706001)(33646001)(50466002)(80022001)(47776003)(104166001)(89996001)(88136002)(20776003)(77156001)(50226001)(79102001)(4396001)(77982001)(92566001)(46102001)(92726001)(42186004)(76482001)(81342001)(62966002)(102836001)(81542001)(86362001)(93916002)(87286001)(19580395003)(36756003)(83322001)(48376002)(19580405001)(87976001)(31966008)(101416001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB397;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40302
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

No caller is currently using the return value but better return
number of bytes written instead of 0 in case of an error.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/term.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kvm/term.c b/tools/kvm/term.c
index b153eed..1b8131a 100644
--- a/tools/kvm/term.c
+++ b/tools/kvm/term.c
@@ -57,7 +57,7 @@ int term_putc(char *addr, int cnt, int term)
 	while (num_remaining) {
 		ret = write(term_fds[term][TERM_FD_OUT], addr, num_remaining);
 		if (ret < 0)
-			return 0;
+			return cnt - num_remaining;
 		num_remaining -= ret;
 		addr += ret;
 	}
-- 
1.7.9.5
