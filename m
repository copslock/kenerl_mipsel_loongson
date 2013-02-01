Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Feb 2013 23:44:15 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:64794 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823006Ab3BAWoOqhwMb convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Feb 2013 23:44:14 +0100
Received: by mail-ob0-f169.google.com with SMTP id ta14so4666835obb.14
        for <linux-mips@linux-mips.org>; Fri, 01 Feb 2013 14:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=dCNw1WBN6CHA2gU8BCYoksczFuUaBU25m2G/GICzwQI=;
        b=fbpV/BpJT8J4UYdUWZxNPA5/325nBk+oO9/R1/ii/qI/z3rsz0GdXJG1Uxgq1QQZOX
         ELwOOt+zRXAkfM3f+8RIeBttKpXg1S9pDP1ccsRwUo1Tbps8Zud4r9bKt04BUU00OkDd
         HNzNFp6IQ9ANtJmsUYALScGL0xp780DUyrvAhgRErhNPERiJzMvUYs6i+CiZjX48QZse
         4pujIfEX4vG8+VDcv4IJ5IJkFiuIzgWa1GC6uyoHcrRFfRBKI1+NgtKbYZ08pm8dUZEU
         aT+o+ErYLyZVu+POQ0aB5lhPg2WIuGTnP6rchJFhLGqflCAKbCj8bPshMBfDxU4/xIsA
         NLlg==
MIME-Version: 1.0
X-Received: by 10.60.32.33 with SMTP id f1mr11457037oei.122.1359758648348;
 Fri, 01 Feb 2013 14:44:08 -0800 (PST)
Received: by 10.76.109.197 with HTTP; Fri, 1 Feb 2013 14:44:08 -0800 (PST)
Date:   Fri, 1 Feb 2013 23:44:08 +0100
Message-ID: <CACna6rxU3LX+PBgyddMqGtM4=_zvzLZMehB1W1PwN36ZUwF3sA@mail.gmail.com>
Subject: CPU hang on cpu_wait in CPU_74K
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello again ;)

I'm hacking a BCM4706 based board which uses a 74K CPU. The problem is
that wait_cpu (see cpu-probe.c) hangs my machine (is happens as soon
as the first [um]sleep is called).

The hang is related to the cpu-probe.c and:
> cpu_wait = r4k_wait;
> if ((c->processor_id & 0xff) >= PRID_REV_ENCODE_332(2, 1, 0))
> 	cpu_wait = r4k_wait_irqoff;

If I remove that lines completely [um]sleep doesn't hang machine
anymore. I'm not sure if removing that code is a proper solution. I'm
not sure what is the
> c->processor_id & 0xff
on my machine, but I've tried forcing both:
> cpu_wait = r4k_wait;
and
> cpu_wait = r4k_wait_irqoff;
and both are causing hangs.

If I recall correctly, Hauke was checking Broadcom's code and they're
using the same solution: removing that lines completely.

Do you have any idea how this could be solved?

-- 
Rafał
