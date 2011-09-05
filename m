Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2011 12:24:00 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:47425 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491784Ab1IEKXy convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Sep 2011 12:23:54 +0200
Received: by fxd20 with SMTP id 20so4218300fxd.36
        for <linux-mips@linux-mips.org>; Mon, 05 Sep 2011 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=lTrtfBuVIBz7ZqZdU+z2gRggaaXca1k4sC9927p/Hac=;
        b=C0p/a6MycIok5dMXSU3ddpJTtHN86j4++uT/cT3ZVY/CCG1N5atZyLZHZblW4Bl/0z
         685yiubF+Xu9xp7DPHOSjJndLeWQ3ZL1fnm10g/c7YylUClR30bOmBBaA3bHneeMD8Ql
         oMCABK4onO2fRbqP6zzJoIYgv1kZe4/DfJ6Bg=
MIME-Version: 1.0
Received: by 10.223.33.19 with SMTP id f19mr4453334fad.122.1315218228797; Mon,
 05 Sep 2011 03:23:48 -0700 (PDT)
Received: by 10.223.83.203 with HTTP; Mon, 5 Sep 2011 03:23:48 -0700 (PDT)
Date:   Mon, 5 Sep 2011 15:53:48 +0530
Message-ID: <CAFsuBjW4XZy6x4gDL+0cw92jUbuEodF4vzCcCijQDize97wkNQ@mail.gmail.com>
Subject: MIPS: Octeon: mailbox_interrupt is not registered as per cpu
From:   SAURABH MALPANI <saurabh140585@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: saurabh140585@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2369

Hi,

<Re sending this because last time I am afraid I didn't hit the
correct mail filters.>

Query:

mailbox_interrupt is not registered with IRQF_PERCPU but it is
supposed to be percpu interrupt. Is that on purpose or a miss? I am
porting some code from x86 to octeon which requires special handling
for per cpu interrupts.

 void octeon_prepare_cpus(unsigned int max_cpus)
{
         cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffffffff);
         if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt, IRQF_DISABLED,
                         "mailbox0", mailbox_interrupt)) {
                 panic("Cannot request_irq(OCTEON_IRQ_MBOX0)\n");
         }
         if (request_irq(OCTEON_IRQ_MBOX1, mailbox_interrupt, IRQF_DISABLED,
                         "mailbox1", mailbox_interrupt)) {
                 panic("Cannot request_irq(OCTEON_IRQ_MBOX1)\n");
         }
}

--
Saurabh
