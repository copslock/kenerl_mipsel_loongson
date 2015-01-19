Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 10:02:44 +0100 (CET)
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:33061 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011002AbbASJCnAIvCQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 10:02:43 +0100
Received: from resomta-po-03v.sys.comcast.net ([96.114.154.227])
        by resqmta-po-11v.sys.comcast.net with comcast
        id hl2a1p0034ueUHc01l2aNP; Mon, 19 Jan 2015 09:02:34 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-po-03v.sys.comcast.net with comcast
        id hl2Z1p0010uk1nt01l2Zb0; Mon, 19 Jan 2015 09:02:34 +0000
Message-ID: <54BCC827.3020806@gentoo.org>
Date:   Mon, 19 Jan 2015 04:02:31 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421658154;
        bh=wFEGGqt6Aetxk3E/fK6ezKxNmgQR6UlEofrg9hBE2DY=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=M+EAFxWXwFa9haPklYE9Tq++VwBS0nzAlwzmGyJJhm47fIjORZr0jdHchohWLKb8k
         MVBeeW2Y8SvhoF0CV72AzBJq89YeCiy1bakjcbv+G9zHxqJmgnQAn4RF6sKutYDYM9
         +rPwp1f2CG0Z+/luLclCU66YdTlNET5aix5gNNobWYry2a3xQnp/nPPSY4FlOZdK7r
         4EC+zzSItAvIxNKgmHCKAR6yQkq3HbcRbqOu818NbdqtpIaSbRthgQXHPWSUNdNkz1
         HvKC6GR4JfJGgm9eS5aLaXm/7l1IGzjU8tX9Pj3+KGgWgL43Ta84ukaYh6B5C/flcP
         k0bMMA4KUEFAg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45295
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

This is a small patch to display the CPU byteorder that the kernel was compiled
with in /proc/cpuinfo.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/kernel/proc.c |    5 +++++
 1 file changed, 5 insertions(+)

This patch has been submitted several times prior over the years (I think), but
I don't recall what, if any, objections there were to it.

linux-mips-proc-cpuinfo-byteorder.patch
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 097fc8d..75e6a62 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -65,6 +65,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
 		      cpu_data[n].udelay_val / (500000/HZ),
 		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
+#ifdef __MIPSEB__
+	seq_printf(m, "byteorder\t\t: big endian\n");
+#else
+	seq_printf(m, "byteorder\t\t: little endian\n");
+#endif
 	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
 	seq_printf(m, "microsecond timers\t: %s\n",
 		      cpu_has_counter ? "yes" : "no");
