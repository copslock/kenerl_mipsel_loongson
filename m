Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 06:15:32 +0200 (CEST)
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:47611 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007331AbbEYEP1emBaI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 06:15:27 +0200
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-08v.sys.comcast.net with comcast
        id Y4FN1q0022Ka2Q5014FNcR; Mon, 25 May 2015 04:15:22 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-11v.sys.comcast.net with comcast
        id Y4FM1q00442s2jH014FM4H; Mon, 25 May 2015 04:15:22 +0000
Message-ID: <5562A1D9.2080400@gentoo.org>
Date:   Mon, 25 May 2015 00:15:21 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: MIPS: oprofile: Distinguish R14000 from R12000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432527322;
        bh=l9864fywMa5zLbtvxdL65MowX7o7/euupcQJ5jS5JSE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=Cbu+IUVf7KJMOHuOzojUu/qKzg2tuht870uaGv1WIrD4kp6A8D+sy01nPtRdY37Dw
         woaVUryfq/l6lGxgKFvBALUwTai2xsBWMLiaGIQFhNbEJsy9V+65Pu0axAvVxjz3CI
         7+NJIOb4qiuHMnTTGVC1NHfOC5z+k7hkpQkckrIcJLjSNDf39rRBeinpvywk2rL5e4
         wBnly/jgTMeRYLuwN2KUa7zmqF7f1TMNa2HfMw6F/9YAoURDoa3Jaex7E6Xo7+3oeV
         /7iwyvmf4W2B9HvJTqV5Oi4YR/3wJ0Uy7uACuhZmtL3z1hmje3wmuq7WDGaOmkXXAC
         PD5f+L7I+2ocg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Currently, arch/mips/oprofile/op_model_mipsxx.c treats an R14000 as an
R12000.  This patch distinguishes one from the other.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 op_model_mipsxx.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

linux-mips-oprofile-fix-r14k.patch
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 6a6e2cc..75f1967 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -408,10 +408,13 @@ static int __init mipsxx_init(void)
 		break;
 
 	case CPU_R12000:
-	case CPU_R14000:
 		op_model_mipsxx_ops.cpu_type = "mips/r12000";
 		break;
 
+	case CPU_R14000:
+		op_model_mipsxx_ops.cpu_type = "mips/r14000";
+		break;
+
 	case CPU_R16000:
 		op_model_mipsxx_ops.cpu_type = "mips/r16000";
 		break;
