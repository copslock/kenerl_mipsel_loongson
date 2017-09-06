Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 23:37:25 +0200 (CEST)
Received: from mail-pf0-x232.google.com ([IPv6:2607:f8b0:400e:c00::232]:35289
        "EHLO mail-pf0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993156AbdIFVhPCMwPJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2017 23:37:15 +0200
Received: by mail-pf0-x232.google.com with SMTP id g13so14711598pfm.2
        for <linux-mips@linux-mips.org>; Wed, 06 Sep 2017 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2ZKSQaCkJm0jjODw1AaZbXW/aP7sJjHQu6bX5eBcMHA=;
        b=feJXkk58ptVCKa9QhERy7ItqTx4uL+zouKdhSk5RA2gVorXvyJNtIy3j6FGuaWmlkQ
         p6mvHy3MGkutMw3dW/Ob9tK1HK2m+WukR+9+0K14fKIVgW1JV0DGw8zL+Azdnu3p0Akb
         PRkr83OwSOKAszwEbs0PEvFxzR5MuluBIuJfIu9PU9h1BJ1TYW7p/UOhvlb0Qv1kndkT
         BNoLgtSbubTISsHPzCCyjdpgDD1WaIlOW0Vo16HIIioXOdzKuST3qlI8daBv1uXujpa7
         X+8awEIDDjtpZFXLih75crQSG61dq3XoPxmMGUP9NrMGtSQI/1YqbWjyE7TaklS/IWJ3
         y8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2ZKSQaCkJm0jjODw1AaZbXW/aP7sJjHQu6bX5eBcMHA=;
        b=WJ1nYvkcRKo8o5qHkdz/mL7ZSdHRfLvx88O07tVgvZ464wySED8oPBtutt9XrHm+fO
         7fqOuO+Sb/o3ss2OTlaCvPmOzyizZsx2zMm3u8W9PHK7jLgQMm/wWjrxjSbu0lM+eZvf
         I58YWJAS5+KIuzuc3c7U4G2v8XUxvVwu/Ig4bT6My/2XeFd1KY2XERmyAnVFYTgSZjz9
         AInplTSxQ6sPjzClVS1W6nmIPYYp5ZYJOZxFX1zjGlwtq8qQJLWs4uIQ4vXd+GkWmvUv
         yMzDzp1UdIaa46jRq/3OEIFp/7KcErMZ/MfGK8I7agjlYoIhH4ljLSusmqlJxzqHTwN1
         0Tqg==
X-Gm-Message-State: AHPjjUh44/K+hLRYrZNZ5qHUDh7VIDi1WrCILsKDKDWCh5BfncGIVyO3
        bwO5Pbf5GXfO3cY28SPXKcuWxfjZtFVLXGqfN0s=
X-Google-Smtp-Source: ADKCNb60sBzi5CSRS/N1B/RRdbPKuNH5H5oViJ77QkVXTihqRNm8KZ/Xu/wKpYMftmBj0HnyYfC0qv//3i4SVQugrp8=
X-Received: by 10.84.130.42 with SMTP id 39mr567287plc.239.1504733828321; Wed,
 06 Sep 2017 14:37:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.132 with HTTP; Wed, 6 Sep 2017 14:37:07 -0700 (PDT)
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Wed, 6 Sep 2017 14:37:07 -0700
Message-ID: <CAJx26kXc=AXjOeZdwhUCExFSuRRQ9VT-uoNijov9yFEy-BFcNA@mail.gmail.com>
Subject: [RFC] Hanging when parking smp threads
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinpopo6@gmail.com
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

Hello,

I've been trying to trace down a hang issue for ages now, can't seem
to get to the root of the problem. I'm wondering if anyone else has
seen anything similar or has any suggestions.

I am testing on a bmips chip on kernel version 4.1.20. I don't see the
problem on ARM, so I have a suspicion there might be an issue with the
smp mips specific code, but I cannot put my finger on it.

The hang occurs when stress testing suspend and resume. Everyone once
in a while it hangs when going into suspend and I see the following.

1. CPU 0 brings down other CPUs for suspend and attempts to parks smp
threads. It waits for each thread to be parked before moving on.
kernel/power/suspend.c: disable_nonboot_cpus()
kernel/cpu.c: _cpu_down() then smpboot_park_threads()

2. CPU X(nonboot cpu) parks all smpboot threads except the last one.
Then it hangs here.
Under further inspection I see the following...
The thread that needs to be parked is never scheduled instead it is
waiting in the wake_list within the cpu runqueue(The cpu that should
be parking the thread).
The CPU (with its wait_list populated) is staying in the idle task
loop. It never schedules the next task in the wait_list.

I've tried pulling in potential fixes from upstream, but everything i
tried so far has failed to fix the hang.

I am running out of ideas on how to debug this. So any pointers on how
to get deeper into the issue would be much appreciated. Thanks!

Justin
.
