Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 17:56:26 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:56211 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993978AbdF1P4GYzrq8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 17:56:06 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id EFE661A47F4;
        Wed, 28 Jun 2017 17:56:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id D2B381A47F1;
        Wed, 28 Jun 2017 17:56:00 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Goran Ferenc <goran.ferenc@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 1/4] MIPS: VDSO: Fix conversions in do_monotonic()/do_monotonic_coarse()
Date:   Wed, 28 Jun 2017 17:55:28 +0200
Message-Id: <1498665337-28845-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498665337-28845-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498665337-28845-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Goran Ferenc <goran.ferenc@imgtec.com>

Fix incorrect calculation in do_monotonic() and do_monotonic_coarse()
function that in turn caused incorrect values returned by the vdso
version of system call clock_gettime() on mips64 if its system clock
ID parameter was CLOCK_MONOTONIC or CLOCK_MONOTONIC_COARSE.

Consider these variables and their types on mips32 and mips64:

tk->wall_to_monotonic.tv_sec  s64, s64   (kernel/vdso.c)
vdso_data.wall_to_mono_sec    u32, u32   (kernel/vdso.c)
to_mono_sec                   u32, u32   (vdso/gettimeofday.c)
ts->tv_sec                    s32, s64   (vdso/gettimeofday.c)

For mips64 case, u32 vdso_data.wall_to_mono_sec variable is updated
from the 64-bit signed variable tk->wall_to_monotonic.tv_sec
(kernel/vdso.c:76) which is a negative number holding the time passed
from 1970-01-01 to the time boot started. This 64-bit signed value is
currently around 47+ years, in seconds. For instance, let this value
be:

-1489757461

or

11111111111111111111111111111111 10100111001101000001101011101011

By updating 32-bit vdso_data.wall_to_mono_sec variable, we lose upper
32 bits (signed 1's).

to_mono_sec variable is a parameter of do_monotonic() and
do_monotonic_coarse() functions which holds vdso_data.wall_to_mono_sec
value. Its value needs to be added (or subtracted considering it holds
negative value from the tk->wall_to_monotonic.tv_sec) to the current
time passed from 1970-01-01 (ts->tv_sec), which is again something like
47+ years, but increased by the time passed from the boot to the
current time. ts->tv_sec is 32-bit long in case of 32-bit architecture
and 64-bit long in case of 64-bit architecture. Consider the update of
ts->tv_sec (vdso/gettimeofday.c:55 & 167):

ts->tv_sec += to_mono_sec;

mips32 case: This update will be performed correctly, since both
ts->tv_sec and to_mono_sec are 32-bit long and the sign in to_mono_sec
is preserved. Implicit conversion from u32 to s32 will be done
correctly.

mips64 case: This update will be wrong, since the implicit conversion
will not be done correctly. The reason is that the conversion will be
from u32 to s64. This is because to_mono_sec is 32-bit long for both
mips32 and mips64 cases and s64..33 bits of converted to_mono_sec
variable will be zeros.

So, in order to make MIPS64 implementation work properly for
MONOTONIC and MONOTONIC_COARSE clock ids on mips64, the size of
wall_to_mono_sec variable in mips_vdso_data union and respective
parameters in do_monotonic() and do_monotonic_coarse() functions
should be changed from u32 to u64. Because of consistency, this
size change from u32 and u64 is also done for wall_to_mono_nsec
variable and corresponding function parameters.

As far as similar situations for other architectures are concerned,
let's take a look at arm. Arm has two distinct vdso_data structures
for 32-bit & 64-bit cases, and arm's wall_to_mono_sec and
wall_to_mono_nsec are u32 for 32-bit and u64 for 64-bit cases.
On the other hand, MIPS has only one structure (mips_vdso_data),
hence the need for changing the size of above mentioned parameters.

Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/include/asm/vdso.h  | 4 ++--
 arch/mips/vdso/gettimeofday.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index 8f4ca5d..b7cd6cf 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -79,8 +79,8 @@ union mips_vdso_data {
 	struct {
 		u64 xtime_sec;
 		u64 xtime_nsec;
-		u32 wall_to_mono_sec;
-		u32 wall_to_mono_nsec;
+		u64 wall_to_mono_sec;
+		u64 wall_to_mono_nsec;
 		u32 seq_count;
 		u32 cs_shift;
 		u8 clock_mode;
diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index ce89c9e..fd7d433 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -39,8 +39,8 @@ static __always_inline int do_monotonic_coarse(struct timespec *ts,
 					       const union mips_vdso_data *data)
 {
 	u32 start_seq;
-	u32 to_mono_sec;
-	u32 to_mono_nsec;
+	u64 to_mono_sec;
+	u64 to_mono_nsec;
 
 	do {
 		start_seq = vdso_data_read_begin(data);
@@ -148,8 +148,8 @@ static __always_inline int do_monotonic(struct timespec *ts,
 {
 	u32 start_seq;
 	u64 ns;
-	u32 to_mono_sec;
-	u32 to_mono_nsec;
+	u64 to_mono_sec;
+	u64 to_mono_nsec;
 
 	do {
 		start_seq = vdso_data_read_begin(data);
-- 
2.7.4
