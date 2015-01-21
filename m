Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 12:32:14 +0100 (CET)
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:50198 "EHLO
        resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011344AbbAULcLSXDpD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 12:32:11 +0100
Received: from resomta-ch2-09v.sys.comcast.net ([69.252.207.105])
        by resqmta-ch2-12v.sys.comcast.net with comcast
        id ibXg1p0042GyhjZ01bY4LD; Wed, 21 Jan 2015 11:32:04 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-ch2-09v.sys.comcast.net with comcast
        id ibY41p0020uk1nt01bY4FL; Wed, 21 Jan 2015 11:32:04 +0000
Message-ID: <54BF8E2B.3010904@gentoo.org>
Date:   Wed, 21 Jan 2015 06:31:55 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH v2] MIPS: Display CPU byteorder in /proc/cpuinfo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421839924;
        bh=ocTqdot6cB8eQWzJTXdmf3QShRH9fb+gg/i2ka1uZac=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=WB5Ha65LDLNkeSNfr90ceRCDl9g9B/m+tNnUYBNw1kuT2G2pzR6OBdJnjpiQzYf4Y
         +7mlD2emO+lREH7/G3R8SvvUrbTegyxBUrR5qaOReDTzvcIQHX7K2jd7fwVYR3fFA/
         JzVdMKAExAtXwe8yZ/9vf4uRKc3Nqu0CEEIy+hc8GbIoPBPmry0816/ekeMh2gKVHm
         b+Kzxa+/WQ250u0BIfJ6VqH9PZzHlggPrFRygF8esb9GYS1i8/RUD0nd4rsoFDOHN0
         ZpZWVpuc1VyVLqgDVsybIYPDJZktoLOnQdxTYaDMdbqqgCMuyvUxa0Wa9a7xVpKXrh
         f2Q0ngAI2sLcg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45400
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
 arch/mips/kernel/proc.c |    4 ++++
 1 file changed, 4 insertions(+)

This version of the patches replaces the #ifdefs with proper conditionals.

linux-mips-proc-cpuinfo-byteorder.patch
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 097fc8d..22ef4c9 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -65,6 +65,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
 		      cpu_data[n].udelay_val / (500000/HZ),
 		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
+	if (config_enabled(CONFIG_CPU_BIG_ENDIAN))
+		seq_printf(m, "byteorder\t\t: big endian\n");
+	else
+		seq_printf(m, "byteorder\t\t: little endian\n");
 	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
 	seq_printf(m, "microsecond timers\t: %s\n",
 		      cpu_has_counter ? "yes" : "no");
