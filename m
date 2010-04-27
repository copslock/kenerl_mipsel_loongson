Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2010 14:14:36 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.155]:34620 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491092Ab0D0MOd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Apr 2010 14:14:33 +0200
Received: by fg-out-1718.google.com with SMTP id e12so1270920fga.6
        for <linux-mips@linux-mips.org>; Tue, 27 Apr 2010 05:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=jFSdP2eKxW2WctFyaOKBOQDDYlcJ/rdfHayiC4xnCL0=;
        b=TYeLiXJPapCkUE1t2gRxVlwcAFsxQrnWHZCkodNMwIOfHCcTqNyf5PPdbWSgFKrpPV
         6VT6U4FmtMl+rA9hMQRynUuKmMz5vV4Gk/5qUnNRiC4QD294DZ3ZreL/oYIXJiMQ+3GN
         zhhOg9jIQU9Atp+zD9PySkUiKCfvQHGKHa4t8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WH08/WiMIL5/DWb7jF3YeHaTKR+VKCqxUhxMtHXc8V+1UsHther/kJeBWptqMX92vn
         qAsDYfhK1MS9zmuD4plQS/gAuiFMX0t+vk+d3ns/S2DYvbIC3UsTQxsbAgTN38ekdh+w
         uaOyVsPqV+2Tok35sy083VaALIp9pk+Rp1UUs=
MIME-Version: 1.0
Received: by 10.86.124.35 with SMTP id w35mr4724010fgc.49.1272370472872; Tue, 
        27 Apr 2010 05:14:32 -0700 (PDT)
Received: by 10.223.106.12 with HTTP; Tue, 27 Apr 2010 05:14:32 -0700 (PDT)
Date:   Tue, 27 Apr 2010 14:14:32 +0200
Message-ID: <k2lf861ec6f1004270514k199cace5wafd6dd269ded8911@mail.gmail.com>
Subject: use bootmem in platform code on MIPS
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hello,

I'd like to use bootmem to reserve large chunks of RAM (at a particular physical
address; for Au1200 MAE, CIM and framebuffer, and later Au1300 OpenGL block)
but it seems that it can't be done:  Doing __alloc_bootmem() in
plat_mem_setup() is
too early, while an arch_initcall() is too late because by then the
slab allocator is
already up and handing out random addresses and/or refusing allocations larger
than a few MBytes.

Is there another callback I could use which would allow me to use bootmem (short
of abusing plat_smp_setup)?

Would a separate callback like this be an acceptable solution?

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -487,6 +487,10 @@ static void __init arch_mem_init(char **cmdline_p)
        }

        bootmem_init();
+
+       if (plat_bootmem_init)
+               plat_bootmem_init();
+
        sparse_init();
        paging_init();
 }

Thanks,
     Manuel Lauss
