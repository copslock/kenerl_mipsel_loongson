Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 08:12:58 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.183]:18697 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021861AbXG3HM4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 08:12:56 +0100
Received: by wa-out-1112.google.com with SMTP id m16so1663818waf
        for <linux-mips@linux-mips.org>; Mon, 30 Jul 2007 00:12:54 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GOhtDbYC+78PI2L4XxmCn6fNUg2F9QmGJABI/yEyGAri9iE5VnR3VTng12Bb329ke/Hztfi1gES/PJznsu/1lvCUbW+wfEIOZty4gA6SXoaF6+4jrfVcoQYiWMCozrPzN5T3c/vv/u2kpnSvMWr7GRBsDY8RCKHF25LI5Kdmh6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HR7ks57uvfkbEx4RN8ItcEVI7mgmankiF6WhX14IWVEtpX7HLeb3we4W5Z5n2NWS/pe+eUM3Xp2cKLb98qE70pOJsF5agBOyb+PxjuqKIuNcgRsxeIJrHreC0GjvFELWfMyEI/Z973WsvndUD/EjiFye6hgTeXkv5dPwH7jROyo=
Received: by 10.114.169.2 with SMTP id r2mr5305502wae.1185779574812;
        Mon, 30 Jul 2007 00:12:54 -0700 (PDT)
Received: by 10.115.111.14 with HTTP; Mon, 30 Jul 2007 00:12:54 -0700 (PDT)
Message-ID: <5861a7880707300012o26a70235n6f8d72f513a33ff7@mail.gmail.com>
Date:	Mon, 30 Jul 2007 11:12:54 +0400
From:	"Dajie Tan" <jiankemeng@gmail.com>
To:	Ralf <ralf@linux-mips.org>
Subject: [PATCH] Fix rm9000 performance counter handler
Cc:	linux-mips@linux-mips.org
In-Reply-To: <5861a7880707300007s6269fd4ft16836a3f5dbf7028@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5861a7880707300007s6269fd4ft16836a3f5dbf7028@mail.gmail.com>
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

Sorry, forgot to add my sign. resend it.

Signed-off-by:  Dajie Tan <jiankemeng@gmail.com>
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
