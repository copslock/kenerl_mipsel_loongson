Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Aug 2011 03:39:06 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:2762 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1493831Ab1H0BjD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 27 Aug 2011 03:39:03 +0200
X-TM-IMSS-Message-ID: <6eecd1b600018288@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 6eecd1b600018288 ; Fri, 26 Aug 2011 18:37:03 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: How to chip->startup() with IRQs disabled
Date:   Fri, 26 Aug 2011 18:39:17 -0700
Message-ID: <74B0AE1BA53C37449DE49BB274F9A2DBC4D052@orion8.netlogicmicro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to chip->startup() with IRQs disabled
Thread-Index: AcxkWiI2j/+0JnnlT7KeKap/xgfTRQ==
From:   "Om Narasimhan" <onarasimhan@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>
X-archive-position: 31002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: onarasimhan@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20445

Hi,
I am working on a chip with multiple cores. I have defined 
static struct irq_chip new_plat_chip = {
...
	.startup = n_irq_startup,
	.mask = n_irq_shutdown,
...
};

In n_irq_startup(), I have to make sure that all cores have set RVEC bit and corresponding EIMR bit. So, I try using on_each_cpu() (because EIMR can be set only by running code on that particular cpu) to run a function to set EIMR.

n_irq_startup() is called as chip->startup() from __setup_irq() (from request_threaded_irq, in turn from request_irq() ) with a spin lock held (desc->lock, in kernel/irq/manage.c).  This causes a stack dump from on_each_cpu(). Since it is wrong to call on_each_cpu with interrupts disabled, I want to change this piece of code.

I am wondering how other SMP mips system implement this. Any comments or pointers will be helpful.

I am not in the mailing list, please CC me in replies.

Om.
