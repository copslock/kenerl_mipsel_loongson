Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:12:33 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34557 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010581AbbGFLMcFQfAe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:12:32 +0200
Received: by pabvl15 with SMTP id vl15so94136096pab.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yq8vbvCcNedfuP27btajbn4cMs3yKXxZ6vhgfzM9vjY=;
        b=E6gyIfLMf5MXshHne8YrsmOWt8qZygqrKuY5U+cbx4Ts7AROaIcdX3XuiaNaO9ZEh8
         ckuJwmezvfpcfel6l6lM/edt4wstmCzvfu4tLIch/bj5xow+g0ahgYJtDvcvrhjM4G0N
         TAYNZ4i1K77PivA3TAyg6WKNnd0edsfeFEd6oRgylHoE0j7JkX+sKAbg96pwbaDT9NvO
         +dyNIXfhjC6qa/4bwwl6n3iAGm3UrpG0VgTuOQ4FN3z64nwNIfa35WfB7z9Teoyx4kuT
         IAY8j9O2gypqdB6sM1VJgsyPTVh6GdsN3rj2XyIT95xRfGRLvz/zO1ES9ryRTZTl5hbQ
         pNzw==
X-Gm-Message-State: ALoCoQmzs/pyuAfKnOsYbWOSH3MY68wWFdmmYQ7drA8N8uzkJkb6JfZJMAflLjymyL//t4d0wA0k
X-Received: by 10.66.161.135 with SMTP id xs7mr106601831pab.154.1436181145826;
        Mon, 06 Jul 2015 04:12:25 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id bn5sm17865810pbc.82.2015.07.06.04.12.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:12:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Michael Opdenacker <michael.opdenacker@free-electrons.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH 00/14] MIPS: Migrate clockevent drivers to 'set-state'
Date:   Mon,  6 Jul 2015 16:41:51 +0530
Message-Id: <cover.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

Hi Guys,

This series migrates MIPS clockevent drivers (present in arch/mips/
directory), to the new set-state interface. This would enable these
drivers to use new states (like: ONESHOT_STOPPED, etc.) of a clockevent
device (if required), as the set-mode interface is marked obsolete now
and wouldn't be expanded to handle new states.

Rebased over: v4.2-rc1

Following patches:
  MIPS/alchemy/time: Migrate to new 'set-state' interface
  MIPS/jazz/timer: Migrate to new 'set-state' interface
  MIPS/cevt-r4k: Migrate to new 'set-state' interface
  MIPS/sgi-ip27/timer: Migrate to new 'set-state' interface
  MIPS/sni/time: Migrate to new 'set-state' interface

must be integrated to mainline kernel via clockevents tree, because of
dependency on:
  352370adb058 ("clockevents: Allow set-state callbacks to be optional")


Other patches don't have this dependency and can be pushed via platform
specific trees, if Maintainers want it that way.

This has been build/boot tested by two bots on various platforms for few
days now, not sure if we had a good coverage for MIPS though:

- kernelci, http://kernelci.org/
- 0-DAY kernel test infrastructure, kbuild test robot


Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Cc: Hongliang Tao <taohl@lemote.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Kelvin Cheung <keguang.zhang@gmail.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Qais Yousef <qais.yousef@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>

Viresh Kumar (14):
  MIPS/alchemy/time: Migrate to new 'set-state' interface
  MIPS/jazz/timer: Migrate to new 'set-state' interface
  MIPS/jz4740/time: Migrate to new 'set-state' interface
  MIPS/cevt-bcm1480: Migrate to new 'set-state' interface
  MIPS/cevt-ds1287: Migrate to new 'set-state' interface
  MIPS/cevt-gt641xx: Migrate to new 'set-state' interface
  MIPS/cevt-r4k: Migrate to new 'set-state' interface
  MIPS/cevt-sb1250: Migrate to new 'set-state' interface
  MIPS/cevt-txx9: Migrate to new 'set-state' interface
  MIPS/loongson64/timer: Migrate to new 'set-state' interface
  MIPS/loongsoon32/time: Migrate to new 'set-state' interface
  MIPS/ralink/rt3352: Migrate to new 'set-state' interface
  MIPS/sgi-ip27/timer: Migrate to new 'set-state' interface
  MIPS/sni/time: Migrate to new 'set-state' interface

 arch/mips/alchemy/common/time.c                   |   6 --
 arch/mips/include/asm/cevt-r4k.h                  |   1 -
 arch/mips/jazz/irq.c                              |   7 --
 arch/mips/jz4740/time.c                           |  46 +++++----
 arch/mips/kernel/cevt-bcm1480.c                   |  44 ++++----
 arch/mips/kernel/cevt-ds1287.c                    |  37 ++++---
 arch/mips/kernel/cevt-gt641xx.c                   |  57 +++++++----
 arch/mips/kernel/cevt-r4k.c                       |   7 --
 arch/mips/kernel/cevt-sb1250.c                    |  45 +++++----
 arch/mips/kernel/cevt-txx9.c                      |  81 +++++++++------
 arch/mips/loongson32/common/time.c                |  57 ++++++-----
 arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c |  46 ++++-----
 arch/mips/loongson64/loongson-3/hpet.c            | 116 +++++++++++++---------
 arch/mips/ralink/cevt-rt3352.c                    |  59 +++++------
 arch/mips/sgi-ip27/ip27-timer.c                   |   7 --
 arch/mips/sni/time.c                              |  49 ++++-----
 16 files changed, 359 insertions(+), 306 deletions(-)

-- 
2.4.0
