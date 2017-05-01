Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 May 2017 23:36:49 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993988AbdEAVgSB0U2G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 May 2017 23:36:18 +0200
Received: from localhost (unknown [107.14.56.132])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 29C69C2D;
        Mon,  1 May 2017 21:36:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rabin Vincent <rabinv@axis.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 50/62] MIPS: cevt-r4k: Fix out-of-bounds array access
Date:   Mon,  1 May 2017 14:35:03 -0700
Message-Id: <20170501212732.712278640@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170501212730.774855694@linuxfoundation.org>
References: <20170501212730.774855694@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 9d7f29cdb4ca53506115cf1d7a02ce6013894df0 upstream.

calculate_min_delta() may incorrectly access a 4th element of buf2[]
which only has 3 elements. This may trigger undefined behaviour and has
been reported to cause strange crashes in start_kernel() sometime after
timer initialization when built with GCC 5.3, possibly due to
register/stack corruption:

sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 10737418237ns
CPU 0 Unable to handle kernel paging request at virtual address ffffb0aa, epc == 8067daa8, ra == 8067da84
Oops[#1]:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.18 #51
task: 8065e3e0 task.stack: 80644000
$ 0   : 00000000 00000001 00000000 00000000
$ 4   : 8065b4d0 00000000 805d0000 00000010
$ 8   : 00000010 80321400 fffff000 812de408
$12   : 00000000 00000000 00000000 ffffffff
$16   : 00000002 ffffffff 80660000 806a666c
$20   : 806c0000 00000000 00000000 00000000
$24   : 00000000 00000010
$28   : 80644000 80645ed0 00000000 8067da84
Hi    : 00000000
Lo    : 00000000
epc   : 8067daa8 start_kernel+0x33c/0x500
ra    : 8067da84 start_kernel+0x318/0x500
Status: 11000402 KERNEL EXL
Cause : 4080040c (ExcCode 03)
BadVA : ffffb0aa
PrId  : 0501992c (MIPS 1004Kc)
Modules linked in:
Process swapper/0 (pid: 0, threadinfo=80644000, task=8065e3e0, tls=00000000)
Call Trace:
[<8067daa8>] start_kernel+0x33c/0x500
Code: 24050240  0c0131f9  24849c64 <a200b0a8> 41606020  000000c0  0c1a45e6 00000000  0c1a5f44

UBSAN also detects the same issue:

================================================================
UBSAN: Undefined behaviour in arch/mips/kernel/cevt-r4k.c:85:41
load of address 80647e4c with insufficient space
for an object of type 'unsigned int'
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.18 #47
Call Trace:
[<80028f70>] show_stack+0x88/0xa4
[<80312654>] dump_stack+0x84/0xc0
[<8034163c>] ubsan_epilogue+0x14/0x50
[<803417d8>] __ubsan_handle_type_mismatch+0x160/0x168
[<8002dab0>] r4k_clockevent_init+0x544/0x764
[<80684d34>] time_init+0x18/0x90
[<8067fa5c>] start_kernel+0x2f0/0x500
=================================================================

buf2[] is intentionally only 3 elements so that the last element is the
median once 5 samples have been inserted, so explicitly prevent the
possibility of comparing against the 4th element rather than extending
the array.

Fixes: 1fa405552e33f2 ("MIPS: cevt-r4k: Dynamically calculate min_delta_ns")
Reported-by: Rabin Vincent <rabinv@axis.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Tested-by: Rabin Vincent <rabinv@axis.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15892/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/cevt-r4k.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -80,7 +80,7 @@ static unsigned int calculate_min_delta(
 		}
 
 		/* Sorted insert of 75th percentile into buf2 */
-		for (k = 0; k < i; ++k) {
+		for (k = 0; k < i && k < ARRAY_SIZE(buf2); ++k) {
 			if (buf1[ARRAY_SIZE(buf1) - 1] < buf2[k]) {
 				l = min_t(unsigned int,
 					  i, ARRAY_SIZE(buf2) - 1);
