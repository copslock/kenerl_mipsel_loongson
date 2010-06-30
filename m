Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2010 08:00:22 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:62259 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492085Ab0F3F7v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jun 2010 07:59:51 +0200
Received: by vws8 with SMTP id 8so674318vws.36
        for <linux-mips@linux-mips.org>; Tue, 29 Jun 2010 22:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=3d1596tp6MdENke0aF7f+kto+eRMoCDpc8q5ub6kf6k=;
        b=EgoiRxSRrP6tdnFE0x7parnnrCjv/WLImqSXSwxCPmbbdqtQhDVY3SSZ8iA620J9qH
         sD0N51tRBPFhZYu9tVQbU+yxwLMkoJtXPQLOqafrpLQX6k6TvHJy3xXqKorkFUwD/+Tt
         lqxhKhGnFZUMNozsCE+9h5FTWkY1JWizqRAKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=t4MkZCvbSZePuZzuulbyT1AWK5CoI/h3Zkt1fuiwoQ5qpRBg6VVZLLveZhiDZGavGJ
         3dR+vGtpf7kToMq1F7SNg/t7rwT22RMcvviLqBYLJIYY1MyRjdR5DSYYMBN2jlu3KxUi
         6Q0bR/xudmY0E+FVOPE+FosdgztoGme3DDf+Y=
MIME-Version: 1.0
Received: by 10.220.126.197 with SMTP id d5mr4471677vcs.169.1277877582344; 
        Tue, 29 Jun 2010 22:59:42 -0700 (PDT)
Received: by 10.220.46.147 with HTTP; Tue, 29 Jun 2010 22:59:42 -0700 (PDT)
Date:   Wed, 30 Jun 2010 14:59:42 +0900
Message-ID: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com>
Subject: How to detect STACKOVEFLOW on mips
From:   Adam Jiang <jiang.adam@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19941

Hello, list.

I'm having a problem with kernel mode stack on my box. It seems that
STACKOVERFLOW happened to Linux kernel. However, I can't prove it
because the lack of any detection in __do_IRQ() function just like on
the other architectures. If you know something about, please help me
on following two questions.
- Is there any possible to do this on MIPS?
- or, more simple question, how could I get the address $sp pointed by
asm() notation in C?

Any suggestion from you will be appreciated.

Best regards,
/Adam
