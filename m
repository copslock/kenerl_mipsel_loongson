Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 15:18:19 +0000 (GMT)
Received: from rn-out-0910.google.com ([64.233.170.189]:54578 "EHLO
	rn-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20021521AbXK1PSJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Nov 2007 15:18:09 +0000
Received: by rn-out-0102.google.com with SMTP id e25so1048574rng
        for <linux-mips@linux-mips.org>; Wed, 28 Nov 2007 07:17:04 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=LI9boRHSkwvsjEuyhEMmC6SDbF5MmAMnUhFcWoeo3ik=;
        b=er5F0X+4NN1bsCQcjVpI7NDcwTgdLbzWEdwCHijjA0oS5uERH+1Z56B9+cARpNelwHtE7VUoHd4ER+xEAd3vYEVpd/T7ySnC1wWOGI82S5XEZi9/W6VU7LArnfkCY1u38LzPA7BQBhy8yHbiEp48d5zJQUIrvAxnnE9TFiTdwvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JBKeviMqF3+Min/I55pFFDv1ovxTJR0S6I4clL7QI1F7HWQXQHbW8n8U6u0Owll+SjmzrbqX3M93i8Uk84MdknGfSwONDeLrJGkbkBMAWdHBM7IH8+5KANPvlwbohC0+9tu1xryH6tkWZYa0pEDYvYfWuN+iIfZ12OLnDZ9oBw0=
Received: by 10.142.212.19 with SMTP id k19mr1413693wfg.1196263023345;
        Wed, 28 Nov 2007 07:17:03 -0800 (PST)
Received: by 10.142.214.9 with HTTP; Wed, 28 Nov 2007 07:17:03 -0800 (PST)
Message-ID: <73cd086a0711280717q6468b635wa75f3228350338f1@mail.gmail.com>
Date:	Wed, 28 Nov 2007 18:17:03 +0300
From:	"Pavel Kiryukhin" <vksavl@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] disable date alarm for malta rtc.
Cc:	vksavl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <vksavl@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vksavl@gmail.com
Precedence: bulk
X-list: linux-mips

RTC test that can be found in linux/Documentation/rtc.txt generally
hangs for malta boards.
Actually it waits for alarm interrupt that doesn't occure. Cause of
this -  Date alarm setting is not supported in rtc.c driver API. Some
chips (e.g. Intel82371 Southbridge RTC) supports this feature and uses
control register D for setting day of month. Just write "don't care"
(==0) value to this register.

Signed-off-by: Pavel Kiryukhin <vksavl@gmail.com>
---
diff --git a/arch/mips/mips-boards/generic/time.c
b/arch/mips/mips-boards/generic/time.c
index f02ce63..1c8043a 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -170,6 +170,10 @@ void __init plat_time_init(void)
         /* Set Data mode - binary. */
         CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_DM_BINARY, RTC_CONTROL);

+#ifdef CONFIG_MIPS_MALTA
+       /*we don't support Date Alarm*/
+       CMOS_WRITE(0, RTC_REG_D);
+#endif
        est_freq = estimate_cpu_frequency();

        printk("CPU frequency %d.%02d MHz\n", est_freq/1000000,
