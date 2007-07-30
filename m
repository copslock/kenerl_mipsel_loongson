Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 08:07:46 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.182]:16855 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021629AbXG3HHo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 08:07:44 +0100
Received: by wa-out-1112.google.com with SMTP id m16so1662519waf
        for <linux-mips@linux-mips.org>; Mon, 30 Jul 2007 00:07:42 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fohjyq1VikuAWIEjlMEPd8Lu46EisrlGT08Pe3yNH0/OzfsiEJzIiTWj9HziOPOtzA0IZISP5Or1x3VPHCLdkqAaSu0sgnad115/kqkJWnplfFgWfYhJ8wsD7pq7xsb2OLAsNBlYLdmKs/Ki54nt/fBBPmkZ2isPwhaBzm6+giM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mM+QMlQIFHbi7WJmrTzB8C8MM/CFvoCt6fdhyyVk3fs4siTiuT9UAWnMd8DJZGC7G76XhCHbYrEYs98v9lwBN/ev25XDaUDmgnIdSMzTgY9K4fRCM1wztOZqhRpDX/bpqtChfy8FCZhjYwWE1nV0KK5zVJBSegHY4cR/Ip3TKpk=
Received: by 10.114.14.1 with SMTP id 1mr5312500wan.1185779262145;
        Mon, 30 Jul 2007 00:07:42 -0700 (PDT)
Received: by 10.115.111.14 with HTTP; Mon, 30 Jul 2007 00:07:42 -0700 (PDT)
Message-ID: <5861a7880707300007s6269fd4ft16836a3f5dbf7028@mail.gmail.com>
Date:	Mon, 30 Jul 2007 11:07:42 +0400
From:	"Dajie Tan" <jiankemeng@gmail.com>
To:	Ralf <ralf@linux-mips.org>
Subject: [PATCH] Fix rm9000 performance counter handler
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

The new type of irq handler remove a parameter (struct pt_regs *),but
someone forgot to supply it.

Signed-off-by:
---

diff --git a/arch/mips/oprofile/op_model_rm9000.c
b/arch/mips/oprofile/op_model_rm9000.c
index 7dc9bf6..98b5257 100644
--- a/arch/mips/oprofile/op_model_rm9000.c
+++ b/arch/mips/oprofile/op_model_rm9000.c
@@ -85,6 +85,7 @@ static irqreturn_t rm9000_perfcount_handler(int irq,
void * dev_id)
        unsigned int control = read_c0_perfcontrol();
        uint32_t counter1, counter2;
        uint64_t counters;
+       struct pt_regs *regs = get_irq_regs();

        /*
         * RM9000 combines two 32-bit performance counters into a single
