Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 15:16:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40351 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832228Ab3APOQW7PiFq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jan 2013 15:16:22 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0GEGKNa021184;
        Wed, 16 Jan 2013 15:16:20 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0GEGI6f021183;
        Wed, 16 Jan 2013 15:16:18 +0100
Date:   Wed, 16 Jan 2013 15:16:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     "Hill, Steven" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "cernekee@gmail.com" <cernekee@gmail.com>,
        "kevink@paralogos.com" <kevink@paralogos.com>
Subject: Re: [PATCH] [RFC] Proposed changes to eliminate 'union
 mips_instruction' type.
Message-ID: <20130116141618.GC26569@linux-mips.org>
References: <1358230420-3575-1-git-send-email-sjhill@mips.com>
 <50F5B0D0.9010604@gmail.com>
 <31E06A9FC96CEC488B43B19E2957C1B801146C51CC@exchdb03.mips.com>
 <50F5DA93.2080706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50F5DA93.2080706@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Jan 15, 2013 at 02:39:15PM -0800, David Daney wrote:

So this should be fairly readable, far less code and in especially no
more variants for endianess except a single simple macro.

What do you think?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/inst.h | 227 +++++++++++++++++--------------------------
 1 file changed, 87 insertions(+), 140 deletions(-)

diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index ab84064..442e7a4 100644
--- a/arch/mips/include/asm/inst.h
+++ b/arch/mips/include/asm/inst.h
@@ -196,154 +196,100 @@ enum lx_func {
  * Damn ...  bitfields depend from byteorder :-(
  */
 #ifdef __MIPSEB__
-struct j_format {	/* Jump format */
-	unsigned int opcode : 6;
-	unsigned int target : 26;
-};
-
-struct i_format {	/* Immediate format (addi, lw, ...) */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int rt : 5;
-	signed int simmediate : 16;
-};
-
-struct u_format {	/* Unsigned immediate format (ori, xori, ...) */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int rt : 5;
-	unsigned int uimmediate : 16;
-};
-
-struct c_format {	/* Cache (>= R6000) format */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int c_op : 3;
-	unsigned int cache : 2;
-	unsigned int simmediate : 16;
-};
-
-struct r_format {	/* Register format */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int rt : 5;
-	unsigned int rd : 5;
-	unsigned int re : 5;
-	unsigned int func : 6;
-};
-
-struct p_format {	/* Performance counter format (R10000) */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int rt : 5;
-	unsigned int rd : 5;
-	unsigned int re : 5;
-	unsigned int func : 6;
-};
-
-struct f_format {	/* FPU register format */
-	unsigned int opcode : 6;
-	unsigned int : 1;
-	unsigned int fmt : 4;
-	unsigned int rt : 5;
-	unsigned int rd : 5;
-	unsigned int re : 5;
-	unsigned int func : 6;
-};
-
-struct ma_format {	/* FPU multiply and add format (MIPS IV) */
-	unsigned int opcode : 6;
-	unsigned int fr : 5;
-	unsigned int ft : 5;
-	unsigned int fs : 5;
-	unsigned int fd : 5;
-	unsigned int func : 4;
-	unsigned int fmt : 2;
-};
-
-struct b_format { /* BREAK and SYSCALL */
-	unsigned int opcode:6;
-	unsigned int code:20;
-	unsigned int func:6;
-};
+#define BITFIELD_FIELD(field, more)					\
+	field;								\
+	more
 
 #elif defined(__MIPSEL__)
 
-struct j_format {	/* Jump format */
-	unsigned int target : 26;
-	unsigned int opcode : 6;
-};
-
-struct i_format {	/* Immediate format */
-	signed int simmediate : 16;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
-};
-
-struct u_format {	/* Unsigned immediate format */
-	unsigned int uimmediate : 16;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
-};
-
-struct c_format {	/* Cache (>= R6000) format */
-	unsigned int simmediate : 16;
-	unsigned int cache : 2;
-	unsigned int c_op : 3;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
-};
-
-struct r_format {	/* Register format */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
-};
-
-struct p_format {	/* Performance counter format (R10000) */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
-};
-
-struct f_format {	/* FPU register format */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int fmt : 4;
-	unsigned int : 1;
-	unsigned int opcode : 6;
-};
-
-struct ma_format {	/* FPU multiply and add format (MIPS IV) */
-	unsigned int fmt : 2;
-	unsigned int func : 4;
-	unsigned int fd : 5;
-	unsigned int fs : 5;
-	unsigned int ft : 5;
-	unsigned int fr : 5;
-	unsigned int opcode : 6;
-};
-
-struct b_format { /* BREAK and SYSCALL */
-	unsigned int func:6;
-	unsigned int code:20;
-	unsigned int opcode:6;
-};
+#define BITFIELD_FIELD(field, more)					\
+	more								\
+	field;
 
 #else /* !defined (__MIPSEB__) && !defined (__MIPSEL__) */
 #error "MIPS but neither __MIPSEL__ nor __MIPSEB__?"
 #endif
 
+struct j_format {
+	BITFIELD_FIELD(unsigned int opcode : 6,	/* Jump format */
+	BITFIELD_FIELD(unsigned int target : 26,
+	))
+};
+
+struct i_format {			/* signed immediate format */
+	BITFIELD_FIELD(unsigned int opcode : 6,
+	BITFIELD_FIELD(unsigned int rs : 5,
+	BITFIELD_FIELD(unsigned int rt : 5,
+	BITFIELD_FIELD(signed int simmediate : 16,
+	))))
+};
+
+struct u_format {			/* unsigned immediate format */
+	BITFIELD_FIELD(unsigned int opcode : 6,
+	BITFIELD_FIELD(unsigned int rs : 5,
+	BITFIELD_FIELD(unsigned int rt : 5,
+	BITFIELD_FIELD(unsigned int uimmediate : 16,
+	))))
+};
+
+struct c_format {			/* Cache (>= R6000) format */
+	BITFIELD_FIELD(unsigned int opcode : 6,
+	BITFIELD_FIELD(unsigned int rs : 5,
+	BITFIELD_FIELD(unsigned int c_op : 3,
+	BITFIELD_FIELD(unsigned int cache : 2,
+	BITFIELD_FIELD(unsigned int simmediate : 16,
+	)))))
+};
+
+struct r_format {			/* Register format */
+	BITFIELD_FIELD(unsigned int opcode : 6,
+	BITFIELD_FIELD(unsigned int rs : 5,
+	BITFIELD_FIELD(unsigned int rt : 5,
+	BITFIELD_FIELD(unsigned int rd : 5,
+	BITFIELD_FIELD(unsigned int re : 5,
+	BITFIELD_FIELD(unsigned int func : 6,
+	))))))
+};
+
+struct p_format {		/* Performance counter format (R10000) */
+	BITFIELD_FIELD(unsigned int opcode : 6,
+	BITFIELD_FIELD(unsigned int rs : 5,
+	BITFIELD_FIELD(unsigned int rt : 5,
+	BITFIELD_FIELD(unsigned int rd : 5,
+	BITFIELD_FIELD(unsigned int re : 5,
+	BITFIELD_FIELD(unsigned int func : 6,
+	))))))
+};
+
+struct f_format { 			/* FPU register format */
+	BITFIELD_FIELD(unsigned int opcode : 6,
+	BITFIELD_FIELD(unsigned int : 1,
+	BITFIELD_FIELD(unsigned int fmt : 4,
+	BITFIELD_FIELD(unsigned int rt : 5,
+	BITFIELD_FIELD(unsigned int rd : 5,
+	BITFIELD_FIELD(unsigned int re : 5,
+	BITFIELD_FIELD(unsigned int func : 6,
+	)))))))
+};
+
+struct ma_format {		/* FPU multiply and add format (MIPS IV) */
+	BITFIELD_FIELD(unsigned int opcode : 6,
+	BITFIELD_FIELD(unsigned int fr : 5,
+	BITFIELD_FIELD(unsigned int ft : 5,
+	BITFIELD_FIELD(unsigned int fs : 5,
+	BITFIELD_FIELD(unsigned int fd : 5,
+	BITFIELD_FIELD(unsigned int func : 4,
+	BITFIELD_FIELD(unsigned int fmt : 2,
+	)))))))
+};
+
+struct b_format {			/* BREAK and SYSCALL */
+	BITFIELD_FIELD(unsigned int opcode : 6,
+	BITFIELD_FIELD(unsigned int code : 20,
+	BITFIELD_FIELD(unsigned int func : 6,
+	)))
+};
+
 union mips_instruction {
 	unsigned int word;
 	unsigned short halfword[2];
@@ -353,6 +299,7 @@ union mips_instruction {
 	struct u_format u_format;
 	struct c_format c_format;
 	struct r_format r_format;
+	struct p_format p_format;
 	struct f_format f_format;
 	struct ma_format ma_format;
 	struct b_format b_format;
