Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 00:45:03 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36777 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011111AbbGNWpCOHvVD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 00:45:02 +0200
Received: by pdjr16 with SMTP id r16so12957766pdj.3;
        Tue, 14 Jul 2015 15:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BMnBCLiTVEoMUwO+1rNCIADmhlr5B275Gvcp/odzXQQ=;
        b=hd0+aOPu1xSWXL0uij5d42JYk5/ZGSrrSbEPANN4Zi8znRNpztQFEqDJpjbpUnoQtk
         2ip89EHGEPkmFRYTFFbU3pQ/TVVw1AHlwt9WXbkvhuf5T7qNdpjOj5jPeoGwK4f5JArH
         AbQL5yrAxQKEDJ9vKoROEQ6u8kW+yXBgUiGRWVBcqLt2Wakac6G3RlRS59E24HkaWpoc
         Z4yk+mWVvKWJAFC56T71NQgAtNOrQplc/5hKdlzd6mm3GejwqKsA5c465bhaYoNMtQbs
         4vQSYSgq4JFtNrrtWNSGw59Ly71OsjBpEG1DHC5OOQOW76s8qjv023ezPzdwg+YuQ6uc
         5X0g==
X-Received: by 10.68.224.10 with SMTP id qy10mr1723828pbc.23.1436913896210;
        Tue, 14 Jul 2015 15:44:56 -0700 (PDT)
Received: from chrisp-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by smtp.gmail.com with ESMTPSA id je4sm2450609pbb.17.2015.07.14.15.44.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jul 2015 15:44:55 -0700 (PDT)
From:   Chris Packham <judge.packham@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Chris Packham <judge.packham@gmail.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [RFC PATCH v1] mips: Use unsigned int when reading CP0 registers
Date:   Wed, 15 Jul 2015 10:44:30 +1200
Message-Id: <1436913870-17738-1-git-send-email-judge.packham@gmail.com>
X-Mailer: git-send-email 2.5.0.rc0
Return-Path: <judge.packham@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: judge.packham@gmail.com
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

Update __read_32bit_c0_register() and __read_32bit_c0_ctrl_register() to
use "unsigned int res;" instead of "int res;". There is little reason to
treat these register values as signed. They are either counters (which
by definition are unsigned) or are made up of various bit fields to be
interpreted as per the CPU datasheet.

Signed-off-by: Chris Packham <judge.packham@gmail.com>

---
This has come up via u-boot[1] which sync's asm/mipsregs.h with the
kernel. In u-boots case the value read from read_c0_count() is assigned
to an unsigned long [2] which triggers a sign extension and causes a
bug.

U-boot should probably be more explicit about the types used for the
timer_read_counter() API but that aside is there any reason to treat
these values as signed integers? A quick grep around the arch/mips makes
me thing that there may be some bugs lurking when read_c0_count() starts
to yield a negative value but I haven't really explored any of them.

I also notice that read_32bit_cp1_register has a similar issue. I
haven't touched it at this stage but it probably makes sense to do so
for consistency if the CP0 macros are changed. Looking at the users of
read_32bit_cp1_register() it's probably less of an issue.

Thanks,
Chris
--
[1] - http://lists.denx.de/pipermail/u-boot/2015-July/219086.html
[2] - http://git.denx.de/?p=u-boot.git;a=blob;f=arch/mips/cpu/time.c#l11

 arch/mips/include/asm/mipsregs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index c5b0956..54a942f 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -932,7 +932,7 @@ do {								\
  */
 
 #define __read_32bit_c0_register(source, sel)				\
-({ int __res;								\
+({ unsigned int __res;							\
 	if (sel == 0)							\
 		__asm__ __volatile__(					\
 			"mfc0\t%0, " #source "\n\t"			\
@@ -1014,7 +1014,7 @@ do {									\
  * On RM7000/RM9000 these are uses to access cop0 set 1 registers
  */
 #define __read_32bit_c0_ctrl_register(source)				\
-({ int __res;								\
+({ unsigned int __res;							\
 	__asm__ __volatile__(						\
 		"cfc0\t%0, " #source "\n\t"				\
 		: "=r" (__res));					\
-- 
2.5.0.rc0
