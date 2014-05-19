Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2014 18:54:13 +0200 (CEST)
Received: from mail-bn1blp0184.outbound.protection.outlook.com ([207.46.163.184]:51769
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825887AbaESQyJqTO4W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 May 2014 18:54:09 +0200
Received: from alberich.caveonetworks.com (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Mon, 19 May 2014 16:54:00 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 00/12] kvm tools: Misc patches (mips support)
Date:   Mon, 19 May 2014 18:53:19 +0200
Message-ID: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM2PR06CA006.eurprd06.prod.outlook.com (10.255.61.23) To
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 021670B4D2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(164054003)(54534003)(81542001)(15202345003)(33646001)(92566001)(46102001)(21056001)(81156002)(87976001)(87286001)(4396001)(53416003)(15395725003)(62966002)(99396002)(50986999)(36756003)(77156001)(76482001)(93916002)(92726001)(88136002)(86362001)(81342001)(42186004)(79102001)(50466002)(20776003)(69596002)(47776003)(102836001)(31966008)(80022001)(74502001)(83322001)(77982001)(19580405001)(19580395003)(50226001)(85852003)(83072002)(66066001)(15975445006)(64706001)(48376002)(89996001)(101416001)(6606295002);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40141
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

Hi,

These patches contain changes that I am currently using on top of
git://github.com/penberg/linux-kvm.git (as of v3.13-rc1-1427-gd9147fb)
to run lkvm on MIPS.

The core is David's work for mips support and loading elf binaries.

I rebased his stuff, rearranged patches somewhat and split out general
(non-mips-specific) modifications.

I used it to test a paravirtualized guest on a host running KVM with
MIPS-VZ (on octeon3).

Changelog:
v2:
 - Removed superfluous includes in tools/kvm/Makefile (mips)
 - Fixed debug output format for register dump (mips) (when using
   32-bit lkvm with 64-bit guest)
 - Added comment for guest type (KVM_VM_TYPE) (mips)
 - Added check for upper bound of len in hypercall_write_cons (mips)
 - Modified patch sequence to avoid temporary introduction of
   load_bzimage (mips)
 - Added patch to return number of bytes written by term_putc
v1:
 - http://marc.info/?i=1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com

Please apply -- if there are no additional comments or objections.


Thanks,

Andreas
