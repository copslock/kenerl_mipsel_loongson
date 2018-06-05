Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2018 19:07:37 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994741AbeFERHM356Gk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jun 2018 19:07:12 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE3132075B;
        Tue,  5 Jun 2018 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528218426;
        bh=No+0RICM8CvxuwvR68zmE9WXq688h8Zdk815Kcb+reQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnCkUuEM1ru9cl/prZ08S96sHx/O7r67UFf/PFEIxHfQRFzTwKFDTZcrA6vUi6B9S
         Bq05kjvuO4CNAWX4Fk6j/pUDjUausmioDwlLmyjyBmNlXg7NOnRURxheK5mobgWICr
         x6MQ0D1BQuBMa8IPMcIpzqUJABA0MzmyG78k/Obg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.9 50/61] MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests
Date:   Tue,  5 Jun 2018 19:02:11 +0200
Message-Id: <20180605170120.873339046@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=vjBF=IX=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64196
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit 28e4213dd331e944e7fca1954a946829162ed9d4 upstream.

Having PR_FP_MODE_FRE (i.e. Config5.FRE) set without PR_FP_MODE_FR (i.e.
Status.FR) is not supported as the lone purpose of Config5.FRE is to
emulate Status.FR=0 handling on FPU hardware that has Status.FR=1
hardwired[1][2].  Also we do not handle this case elsewhere, and assume
throughout our code that TIF_HYBRID_FPREGS and TIF_32BIT_FPREGS cannot
be set both at once for a task, leading to inconsistent behaviour if
this does happen.

Return unsuccessfully then from prctl(2) PR_SET_FP_MODE calls requesting
PR_FP_MODE_FRE to be set with PR_FP_MODE_FR clear.  This corresponds to
modes allowed by `mips_set_personality_fp'.

References:

[1] "MIPS Architecture For Programmers, Vol. III: MIPS32 / microMIPS32
    Privileged Resource Architecture", Imagination Technologies,
    Document Number: MD00090, Revision 6.02, July 10, 2015, Table 9.69
    "Config5 Register Field Descriptions", p. 262

[2] "MIPS Architecture For Programmers, Volume III: MIPS64 / microMIPS64
    Privileged Resource Architecture", Imagination Technologies,
    Document Number: MD00091, Revision 6.03, December 22, 2015, Table
    9.72 "Config5 Register Field Descriptions", p. 288

Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.0+
Patchwork: https://patchwork.linux-mips.org/patch/19327/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -699,6 +699,10 @@ int mips_set_process_fp_mode(struct task
 	if (value & ~known_bits)
 		return -EOPNOTSUPP;
 
+	/* Setting FRE without FR is not supported.  */
+	if ((value & (PR_FP_MODE_FR | PR_FP_MODE_FRE)) == PR_FP_MODE_FRE)
+		return -EOPNOTSUPP;
+
 	/* Avoid inadvertently triggering emulation */
 	if ((value & PR_FP_MODE_FR) && raw_cpu_has_fpu &&
 	    !(raw_current_cpu_data.fpu_id & MIPS_FPIR_F64))
