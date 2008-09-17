Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2008 20:55:08 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.157]:40430 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20143946AbYIPTzF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Sep 2008 20:55:05 +0100
Received: by fg-out-1718.google.com with SMTP id d23so1805323fga.32
        for <linux-mips@linux-mips.org>; Tue, 16 Sep 2008 12:55:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=HXa5qiF5NTfG8eu06kP72eZPmG9zDnqeRWrYl/Laf18=;
        b=SewIOaGWccgc5uNXAoP6TUBA+ZHAf8WbrAQ4bxYJaVVoiqbZaQ8d/0ohq5LcKRGP0m
         kSf1bm08r6D+OKXG0gRnWJudc7zLl5O1n7OqXZrVDeKe6la+HEHSYendfIe+skV74SOD
         QtCWmjGcQbC8JFwGgY1ZwwafaJ3+JLuD+io+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QIdo4Bj5Bd7r58WaoYejtO3lyFYTfwfZgjynudEmt3ck63p9Gz+B1SzBwzWNhCgah6
         xNN7DA4YUYxRamBzlh/pM7Vr4TlxrlTSW5twA+5J9XHz/tPfWXxCLWl1OeTp7KbMFul0
         ZW0cZKbCrzM7E3XwelilTL9Sxueafp8m2UwnQ=
Received: by 10.181.21.6 with SMTP id y6mr1096301bki.86.1221594903973;
        Tue, 16 Sep 2008 12:55:03 -0700 (PDT)
Received: from ?192.168.1.117? ( [213.46.133.62])
        by mx.google.com with ESMTPS id h6sm9015523nfh.21.2008.09.16.12.54.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 12:55:00 -0700 (PDT)
Message-ID: <48D06372.3050809@gmail.com>
Date:	Tue, 16 Sep 2008 21:54:58 -0400
From:	roel kluin <roel.kluin@gmail.com>
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MIPS] vr41xx: unsigned irq cannot be negative
References: <48CF02EE.8050406@gmail.com> <48CF8E05.6050000@ru.mvista.com>
In-Reply-To: <48CF8E05.6050000@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <roel.kluin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.

>> @@ -79,8 +80,9 @@ static void irq_dispatch(unsigned int irq)
>>              desc->chip->mask(source_irq);
>>              desc->chip->ack(source_irq);
>>          }
>> -        irq = cascade->get_irq(irq);
>> -        if (irq < 0)
>> +        ret = cascade->get_irq(irq);
>> +        irq = ret;
>> +        if (ret < 0)
>>              atomic_inc(&irq_err_count);
>>          else
>>              irq_dispatch(irq);
>>   
> 
>  How about this:
> 
>         ret = cascade->get_irq(irq);
>         if (ret < 0)
>             atomic_inc(&irq_err_count);
>         else
>             irq_dispatch(ret);
> 
> 
> WBR, Sergei

good suggestion, but shouldn't we then remove source_irq
as well?

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/mips/vr41xx/common/irq.c b/arch/mips/vr41xx/common/irq.c
index cba36a2..ab4e327 100644
--- a/arch/mips/vr41xx/common/irq.c
+++ b/arch/mips/vr41xx/common/irq.c
@@ -63,6 +63,7 @@ static void irq_dispatch(unsigned int irq)
 {
 	irq_cascade_t *cascade;
 	struct irq_desc *desc;
+	int ret;
 
 	if (irq >= NR_IRQS) {
 		atomic_inc(&irq_err_count);
@@ -71,21 +72,22 @@ static void irq_dispatch(unsigned int irq)
 
 	cascade = irq_cascade + irq;
 	if (cascade->get_irq != NULL) {
-		unsigned int source_irq = irq;
-		desc = irq_desc + source_irq;
+		desc = irq_desc + irq;
 		if (desc->chip->mask_ack)
-			desc->chip->mask_ack(source_irq);
+			desc->chip->mask_ack(irq);
 		else {
-			desc->chip->mask(source_irq);
-			desc->chip->ack(source_irq);
+			desc->chip->mask(irq);
+			desc->chip->ack(irq);
 		}
-		irq = cascade->get_irq(irq);
-		if (irq < 0)
+
+		ret = cascade->get_irq(irq);
+		if (ret < 0)
 			atomic_inc(&irq_err_count);
 		else
-			irq_dispatch(irq);
+			irq_dispatch(ret);
+
 		if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-			desc->chip->unmask(source_irq);
+			desc->chip->unmask(irq);
 	} else
 		do_IRQ(irq);
 }
