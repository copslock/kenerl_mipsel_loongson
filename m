Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 03:21:15 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37838 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990596AbdKVCUZVtyhn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 03:20:25 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eHKeE-0004YB-Iv; Wed, 22 Nov 2017 02:20:22 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1eHKe8-0003By-Ds; Wed, 22 Nov 2017 02:20:16 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Marcin Nowakowski" <marcin.nowakowski@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Ingo Molnar" <mingo@kernel.org>
Date:   Wed, 22 Nov 2017 01:58:13 +0000
Message-ID: <lsq.1511315893.487863844@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 094/133] MIPS: microMIPS: Fix decoding of addiusp
 instruction
In-Reply-To: <lsq.1511315892.657723235@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.51-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit a0ae2b08331a9882150618e0c81ea837e4a37ace upstream.

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
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16955/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/process.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -413,10 +413,14 @@ static int get_frame_info(struct mips_fr
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
