Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2014 13:48:32 +0200 (CEST)
Received: from mail-by2lp0236.outbound.protection.outlook.com ([207.46.163.236]:46732
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817535AbaFPLs1iquQa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jun 2014 13:48:27 +0200
Received: from alberich (2.171.207.32) by
 BLUPR07MB385.namprd07.prod.outlook.com (10.141.27.18) with Microsoft SMTP
 Server (TLS) id 15.0.954.9; Mon, 16 Jun 2014 11:48:19 +0000
Date:   Mon, 16 Jun 2014 13:47:29 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] kvm tools, mips: Adapt signature of kvm_cpu__emulate_io
Message-ID: <20140616114729.GB17831@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.171.207.32]
X-ClientProxiedBy: DB3PR05CA003.eurprd05.prod.outlook.com (10.242.134.33) To
 BLUPR07MB385.namprd07.prod.outlook.com (10.141.27.18)
X-Microsoft-Antispam: BL:0;ACTION:Default;RISK:Low;SCL:0;SPMLVL:NotSpam;PCL:0;RULEID:
X-Forefront-PRVS: 0244637DEA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(199002)(189002)(164054003)(15395725005)(31966008)(50466002)(66066001)(92726001)(74502001)(86362001)(20776003)(64706001)(47776003)(92566001)(80022001)(23676002)(19580405001)(105586001)(19580395003)(83506001)(85852003)(15202345003)(54356999)(101416001)(83072002)(79102001)(46102001)(15975445006)(74662001)(33716001)(21056001)(50986999)(77096002)(102836001)(4396001)(83322001)(81342001)(99396002)(33656002)(77982001)(76482001)(42186005)(87976001)(81542001)(85306003)(6606295002);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB385;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40526
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


Use struct kvm_cpu instead of struct kvm.
This change is req'd due to commit
8d770c4096cdf73e1b79e7395ef3a86aa2887077
(kvmtool: virtio: pass trapped vcpu to IO accessors).

Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/mips/include/kvm/kvm-cpu-arch.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Hi Pekka,

When submitting v3 patch set for mips support
(http://marc.info/?i=1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com)
that was based on v3.13-rc1-1436-g1fc83c5 of your tree.
Thus I missed commit 8d770c4096cdf73e1b79e7395ef3a86aa2887077
(kvmtool: virtio: pass trapped vcpu to IO accessors)

This patch provides the req'd change for above commit to fix
compilation for mips.

Please apply.


Thanks,

Andreas

diff --git a/tools/kvm/mips/include/kvm/kvm-cpu-arch.h b/tools/kvm/mips/include/kvm/kvm-cpu-arch.h
index fc286b1..3db7f2b 100644
--- a/tools/kvm/mips/include/kvm/kvm-cpu-arch.h
+++ b/tools/kvm/mips/include/kvm/kvm-cpu-arch.h
@@ -29,9 +29,9 @@ struct kvm_cpu {
  * As these are such simple wrappers, let's have them in the header so they'll
  * be cheaper to call:
  */
-static inline bool kvm_cpu__emulate_io(struct kvm *kvm, u16 port, void *data, int direction, int size, u32 count)
+static inline bool kvm_cpu__emulate_io(struct kvm_cpu *vcpu, u16 port, void *data, int direction, int size, u32 count)
 {
-	return kvm__emulate_io(kvm, port, data, direction, size, count);
+	return kvm__emulate_io(vcpu, port, data, direction, size, count);
 }
 
 static inline bool kvm_cpu__emulate_mmio(struct kvm_cpu *vcpu, u64 phys_addr, u8 *data, u32 len, u8 is_write)
-- 
1.7.9.5
