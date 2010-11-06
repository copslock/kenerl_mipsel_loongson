Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Nov 2010 21:05:11 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:41412 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491206Ab0KFUFI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Nov 2010 21:05:08 +0100
Received: by iwn8 with SMTP id 8so4254052iwn.36
        for <linux-mips@linux-mips.org>; Sat, 06 Nov 2010 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=3e/9V/ltUqga1xOxn0cDOFryhGHv8Mfq0Rq+ISuwut4=;
        b=BKtAEF2GX19wceuP+iDpVEQsdGLZCO4WDe/CSnOD5xm51oL850DAJmammriBu/9w/J
         BQYmPVau5PVs/Yb0eMXUChSlTV5ZTV56ZmQu6QtD6ClRePWHZ3sWPqxeglrj/hUGi/KH
         PTELTWolcpcex+Q/D0e46hSh+kxoPHwa68BqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=JaCpdc2UV2ig1dBvzMD3vSxaKW6kwi3fnIDw/s/UWN5IwdjdZouIh7dayGtRp45C83
         naPO/GFGPzuLePtkHGzKZ8QWIExTvvJEWBUDG/vFjG5OkcpSSBgzGDRJoyhI+ZmrrQ4Q
         cVaCwdtGxaxx80N43RJuARZPQcRuhJzI7iPPI=
MIME-Version: 1.0
Received: by 10.231.16.204 with SMTP id p12mr2719364iba.194.1289073904887;
 Sat, 06 Nov 2010 13:05:04 -0700 (PDT)
Received: by 10.231.192.138 with HTTP; Sat, 6 Nov 2010 13:05:04 -0700 (PDT)
Date:   Sat, 6 Nov 2010 22:05:04 +0200
Message-ID: <AANLkTimo=SEZ7R1=erEVhL9VWsqcBpKGjeEeKfqG1eaZ@mail.gmail.com>
Subject: build error in current Linus' git tree
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

The latest Linus tree (151f52f0) yields the following build error for
ip22_defconfig:

  LD      .tmp_vmlinux1
drivers/built-in.o: In function `dma_setup':
sgiwd93.c:(.text+0x38d9c): undefined reference to `dma_cache_sync'
sgiwd93.c:(.text+0x38d9c): relocation truncated to fit: R_MIPS_26
against `dma_cache_sync'
drivers/built-in.o: In function `sgiseeq_start_xmit':
sgiseeq.c:(.text+0x4acfc): undefined reference to `dma_cache_sync'
sgiseeq.c:(.text+0x4acfc): relocation truncated to fit: R_MIPS_26
against `dma_cache_sync'
sgiseeq.c:(.text+0x4ad6c): undefined reference to `dma_cache_sync'
sgiseeq.c:(.text+0x4ad6c): relocation truncated to fit: R_MIPS_26
against `dma_cache_sync'
sgiseeq.c:(.text+0x4ada4): undefined reference to `dma_cache_sync'
sgiseeq.c:(.text+0x4ada4): relocation truncated to fit: R_MIPS_26
against `dma_cache_sync'
sgiseeq.c:(.text+0x4adcc): undefined reference to `dma_cache_sync'
sgiseeq.c:(.text+0x4adcc): relocation truncated to fit: R_MIPS_26
against `dma_cache_sync'
drivers/built-in.o:sgiseeq.c:(.text+0x4aeb4): more undefined
references to `dma_cache_sync' follow
drivers/built-in.o: In function `sgiseeq_start_xmit':
sgiseeq.c:(.text+0x4aeb4): relocation truncated to fit: R_MIPS_26
against `dma_cache_sync'
sgiseeq.c:(.text+0x4aef0): relocation truncated to fit: R_MIPS_26
against `dma_cache_sync'
drivers/built-in.o: In function `sgiseeq_interrupt':
sgiseeq.c:(.text+0x4afec): relocation truncated to fit: R_MIPS_26
against `dma_cache_sync'
sgiseeq.c:(.text+0x4b1a0): relocation truncated to fit: R_MIPS_26
against `dma_cache_sync'
sgiseeq.c:(.text+0x4b1c4): relocation truncated to fit: R_MIPS_26
against `dma_cache_sync'
sgiseeq.c:(.text+0x4b1f8): additional relocation overflows omitted
from the output
make: *** [.tmp_vmlinux1] Error 1

Dmitri
