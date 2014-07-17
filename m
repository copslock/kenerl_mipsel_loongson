Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 15:27:56 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:36217 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861326AbaGQN1wjYTOy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 15:27:52 +0200
Received: by mail-la0-f54.google.com with SMTP id el20so1749499lab.13
        for <multiple recipients>; Thu, 17 Jul 2014 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tJD1kYEZCkBSIvwYeAqBbH3TDPSSD5S0XtL578GjnKc=;
        b=Pmt6F9S7A6Atf8blO7NfRxJT67iDW088GIEhSW5TmC5awdUWroA4sHtgjhVH2i6LHW
         dy/z5MkcucR1ZBiaWe/b2Q5dCx28x+mrBW/xovHzOa3OUPNtMYHQaVo65qq+MAsPROq2
         Z/w6s5LJKDI+UfrZcQLXuWSQeLgpqlPSO+SZIwqV5Xau/Z4QhSTByDh3fgKBaQXef9el
         x8ZIB0NmZ1q6ebYR2+imkzWsqsK+qtMvgEXk7SQWj08dZZVj1/+qMBUTM+F11QYq7r62
         WP3CbIV39oeZ+qFSQTkFWJm/699bnVcOOTF22pgN6ZWQa53foKtoCdf1MzE5WJd/j/N1
         pEWA==
X-Received: by 10.152.5.105 with SMTP id r9mr32592627lar.37.1405603666998;
        Thu, 17 Jul 2014 06:27:46 -0700 (PDT)
Received: from localhost.localdomain (alfa-g11.tenet.odessa.ua. [195.138.73.151])
        by mx.google.com with ESMTPSA id x6sm1614246lae.12.2014.07.17.06.27.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 06:27:45 -0700 (PDT)
From:   Andrey Utkin <andrey.krieger.utkin@gmail.com>
To:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mips@linux-mips.org
Cc:     dborkman@redhat.com, markos.chandras@imgtec.com,
        ralf@linux-mips.org, Andrey Utkin <andrey.krieger.utkin@gmail.com>
Subject: [PATCH 2/3] arch/mips/net/bpf_jit.c: fix failure check
Date:   Thu, 17 Jul 2014 16:27:35 +0300
Message-Id: <1405603655-12571-1-git-send-email-andrey.krieger.utkin@gmail.com>
X-Mailer: git-send-email 1.8.5.5
Return-Path: <andrey.krieger.utkin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrey.krieger.utkin@gmail.com
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

static int pkt_type_offset(void) returned -1 in case of failure, and
actual (positive) offset value in case of success. In the only instance
of its usage, the result was saved to local "unsigned int off" variable,
   which is used in a lot of places in the same (large) function, so
   changing its type could cause many warnings.
There was no signed int variable which could be just used for this case.
There are two possibilities to resolve that: to declare temporary signed
int variable to get the return value from pkt_type_offset(), or to
separate return status from returned offset value. The latter approach
was chosen, however, I am not sure which would be practically optimal.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=80371
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Andrey Utkin <andrey.krieger.utkin@gmail.com>
---
 arch/mips/net/bpf_jit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index b87390a..47f65d5 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -770,7 +770,7 @@ static u64 jit_get_skb_w(struct sk_buff *skb, unsigned offset)
 #else
 #define PKT_TYPE_MAX	7
 #endif
-static int pkt_type_offset(void)
+static int pkt_type_offset(unsigned int *off_arg)
 {
 	struct sk_buff skb_probe = {
 		.pkt_type = ~0,
@@ -779,8 +779,10 @@ static int pkt_type_offset(void)
 	unsigned int off;
 
 	for (off = 0; off < sizeof(struct sk_buff); off++) {
-		if (ct[off] == PKT_TYPE_MAX)
-			return off;
+		if (ct[off] == PKT_TYPE_MAX) {
+			*off_arg = off;
+			return 0;
+		}
 	}
 	pr_err_once("Please fix pkt_type_offset(), as pkt_type couldn't be found\n");
 	return -1;
@@ -1332,9 +1334,7 @@ jmp_cmp:
 		case BPF_ANC | SKF_AD_PKTTYPE:
 			ctx->flags |= SEEN_SKB;
 
-			off = pkt_type_offset();
-
-			if (off < 0)
+			if (pkt_type_offset(&off))
 				return -1;
 			emit_load_byte(r_tmp, r_skb, off, ctx);
 			/* Keep only the last 3 bits */
-- 
1.8.5.5
