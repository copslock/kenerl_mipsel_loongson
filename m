Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2014 22:10:33 +0200 (CEST)
Received: from mail-bl2lp0212.outbound.protection.outlook.com ([207.46.163.212]:33102
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854783AbaE1UKbcW0Jo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 May 2014 22:10:31 +0200
Received: from localhost.localdomain (31.213.222.82) by
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 20:10:03 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v3 01/12] kvm tools: Print message on failure of KVM_CREATE_VM
Date:   Wed, 28 May 2014 22:08:44 +0200
Message-ID: <1401307735-16195-2-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: AM3PR02CA004.eurprd02.prod.outlook.com (10.242.240.24) To
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(199002)(189002)(62966002)(81342001)(102836001)(86362001)(81542001)(92726001)(46102001)(92566001)(77982001)(76482001)(42186004)(31966008)(101416001)(87286001)(19580395003)(93916002)(87976001)(83322001)(36756003)(19580405001)(48376002)(21056001)(74502001)(74662001)(50986999)(83072002)(76176999)(88136002)(89996001)(20776003)(104166001)(80022001)(47776003)(50226001)(4396001)(79102001)(77156001)(99396002)(66066001)(64706001)(50466002)(33646001)(85852003);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB397;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40291
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

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/kvm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/kvm/kvm.c b/tools/kvm/kvm.c
index d7d2e84..7bd20d3 100644
--- a/tools/kvm/kvm.c
+++ b/tools/kvm/kvm.c
@@ -286,6 +286,7 @@ int kvm__init(struct kvm *kvm)
 
 	kvm->vm_fd = ioctl(kvm->sys_fd, KVM_CREATE_VM, 0);
 	if (kvm->vm_fd < 0) {
+		pr_err("KVM_CREATE_VM ioctl");
 		ret = kvm->vm_fd;
 		goto err_sys_fd;
 	}
-- 
1.7.9.5
