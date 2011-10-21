Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2011 22:18:44 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:52970 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491756Ab1JUUSk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2011 22:18:40 +0200
Received: by bkbc12 with SMTP id c12so6598524bkb.36
        for <linux-mips@linux-mips.org>; Fri, 21 Oct 2011 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=yj4mdoqzvTgPjwux1zXhSCU8P9kNtSweHAiMJqGLl2Q=;
        b=FdirB1m0vX4zUt1P1r9O66bkkZ8Z6ki2QgdgVe13tRG5K328/9xxZSZBqgG2HzZbUb
         fUWvlgQP+uACLDiiamUIihkkTFltiQjdkongmu6UUXm4aF9DqcX07ZfrIxy0xy1rL76n
         nnBaUt1hlaOxx/O3+wBNln1INLW8nwj2da6uQ=
MIME-Version: 1.0
Received: by 10.205.113.17 with SMTP id eu17mr11496346bkc.76.1319228315091;
 Fri, 21 Oct 2011 13:18:35 -0700 (PDT)
Received: by 10.205.81.13 with HTTP; Fri, 21 Oct 2011 13:18:35 -0700 (PDT)
Date:   Sat, 22 Oct 2011 01:48:35 +0530
Message-ID: <CAMmEz3QV+kWvRK9KnUdmKFGqNA8XUspjc_cH7aYXfea5XYaRAg@mail.gmail.com>
Subject: cause IP zero on interrupt
From:   Noor <noor.mubeen@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noor.mubeen@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15976

what does it mean if cause register IP bits are zero after
interrupt exception  has already been invoked ?

-- 
Thanks
Noor
