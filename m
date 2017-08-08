Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 14:24:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4037 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993411AbdHHMXDcealG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 14:23:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 100CD5490EAC4;
        Tue,  8 Aug 2017 13:22:54 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 8 Aug 2017 13:22:57 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 3/6] MIPS: microMIPS: Fix decoding of addiusp instruction
Date:   Tue, 8 Aug 2017 13:22:32 +0100
Message-ID: <1502194955-18018-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502194955-18018-1-git-send-email-matt.redfearn@imgtec.com>
References: <1502194955-18018-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Commit 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
added handling of microMIPS instructions to manipulate the stack
pointer. Unfortunately the decoding of the addiusp instruction was
incorrect, and performed a left shift by 2 bits to the raw immediate,
rather than decoding the immediate and then performing the shift, as
documented in the ISA.

This led to incomplete stack traces, due to incorrect frame sizes being
calculated. For example the instruction:
801faee0 <do_sys_poll>:
801faee0:       4e25            addiu   sp,sp,-952

As decoded by objdump, would be interpreted by the existing code as
having manipulated the stack pointer by +1096.

Fix this by changing the order of decoding the immediate and applying
the left shift. Also change to accessing the instuction through the
union to avoid the endianness problem of accesing halfword[0], which
will fail on big endian systems.

Cope with the special behaviour of immediates 0x0, 0x1, 0x1fe and 0x1ff
by XORing with 0x100 again if mod(immediate) < 4. This logic was tested
with the following test code:

int main(int argc, char **argv)
{
	unsigned int enc;
	int imm;

	for (enc = 0; enc < 512; ++enc) {
		int tmp = enc << 2;
		imm = -(signed short)(tmp | ((tmp & 0x100) ? 0xfe00 : 0));
		unsigned short tmp = enc;
		tmp = (tmp ^ 0x100) - 0x100;
		if ((unsigned short)(tmp + 2) < 4)
			tmp ^= 0x100;
		imm = -(signed short)(tmp << 2);
		printf("%#x\t%d\t->\t(%#x\t%d)\t%#x\t%d\n",
		       enc, enc,
		       (short)tmp, (short)tmp,
		       imm, imm);
	}
	return EXIT_SUCCESS;
}

Which generates the table:

input encoding	->	tmp (matching manual)	frame size
-----------------------------------------------------------------------
0	0	->	(0x100		256)	0xfffffc00	-1024
0x1	1	->	(0x101		257)	0xfffffbfc	-1028
0x2	2	->	(0x2		2)	0xfffffff8	-8
0x3	3	->	(0x3		3)	0xfffffff4	-12
...
0xfe	254	->	(0xfe		254)	0xfffffc08	-1016
0xff	255	->	(0xff		255)	0xfffffc04	-1020
0x100	256	->	(0xffffff00	-256)	0x400		1024
0x101	257	->	(0xffffff01	-255)	0x3fc		1020
...
0x1fc	508	->	(0xfffffffc	-4)	0x10		16
0x1fd	509	->	(0xfffffffd	-3)	0xc		12
0x1fe	510	->	(0xfffffefe	-258)	0x408		1032
0x1ff	511	->	(0xfffffeff	-257)	0x404		1028

Thanks to James Hogan for the test code & verifying the logic.

Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Suggested-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

Changes in v3:
- Deal with special behaviour of addiusp immediates 0x0,0x1,0x1fe & 0x1ff

Changes in v2:
- Replace conditional with xor and subtract

 arch/mips/kernel/process.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 9d38faf01055..288a79bd0e72 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -386,10 +386,14 @@ static int get_frame_info(struct mips_frame_info *info)
 				{
 					unsigned short tmp;
 
-					if (ip->halfword[0] & mm_addiusp_func)
+					if (ip->mm16_r3_format.simmediate & mm_addiusp_func)
 					{
-						tmp = (((ip->halfword[0] >> 1) & 0x1ff) << 2);
-						info->frame_size = -(signed short)(tmp | ((tmp & 0x100) ? 0xfe00 : 0));
+						tmp = ip->mm_b0_format.simmediate >> 1;
+						tmp = ((tmp & 0x1ff) ^ 0x100) - 0x100;
+						/* 0x0,0x1,0x1fe,0x1ff are special */
+						if ((tmp + 2) < 4)
+							tmp ^= 0x100;
+						info->frame_size = -(signed short)(tmp << 2);
 					} else {
 						tmp = (ip->halfword[0] >> 1);
 						info->frame_size = -(signed short)(tmp & 0xf);
-- 
2.7.4
