Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 01:29:39 +0200 (CEST)
Received: from mail-pf0-x22a.google.com ([IPv6:2607:f8b0:400e:c00::22a]:56596
        "EHLO mail-pf0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992366AbdJDX2DsRh9m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 01:28:03 +0200
Received: by mail-pf0-x22a.google.com with SMTP id g65so7028326pfe.13
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 16:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T1A0smS+giVr4H193oRGpcCnJFnbMRiS1XOI5INkhzk=;
        b=CnoljvBMeXtYQdwwHFLvAdeeGReOGD+J7NJeRNqV/uNMpUdIbocYpIg+Kz58zH2az8
         PlalbMkU3R+n2xfzkWeie7TJpLxNClxY3MnTFLWXkQFbgfx8Ikz1lf4JkF5Vkq9/PESC
         ZiLwvzZp3ovEpHh54xk21ekxMKW+66x/QQxSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T1A0smS+giVr4H193oRGpcCnJFnbMRiS1XOI5INkhzk=;
        b=b1UrBuXp+jqefj5x/ASkhNH6T1Dr2d6rzHedAXb4WCH0uqdqnAFJFcLZgrjlMTbhQ1
         bvg5H9ajlqJWrnDWC9t3DbZ5iEPj0e63rsDcgfP9t5aCQZsvzy1dPeHNqQfKkTTbH0GV
         1ok5AUVClvN3vlfG/YNVWNYkM0+OxyuzuT9B05bb1bD9hqwVYM2pGJISq8tvGdcpNsLy
         08st9ud2UYsRYgDylu3tboz2zTQSyjzx2nOM9f8aV7M3mN9EcxeCRkkp+JWQ3MyTXxdy
         BSj/9nSEp/5yp3TR+ciozqDOi3J+2dKRDrD6qLBfd5er9YDoz9fUC8nM71+H0ZH3s3/J
         TxLQ==
X-Gm-Message-State: AHPjjUgCzvsqXn+HESfroIaxcSJbCJ3miOCOgEnD2z6g2BNeZYgFAqre
        WjJu4jE6Kd7yb4iJcad3ZGTkpw==
X-Google-Smtp-Source: AOwi7QD3W6M8W77jBDMhMn5wFQseT5JbhkbkTG7pb7PtUsPefcAmLY8ZJk00tm8a4r5jnoTIPKfw6A==
X-Received: by 10.159.255.10 with SMTP id bi10mr21491165plb.433.1507159677326;
        Wed, 04 Oct 2017 16:27:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h1sm24315148pgp.37.2017.10.04.16.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 16:27:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Harish Patil <harish.patil@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Mark Gross <mark.gross@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] timer: Start conversion to timer_setup()
Date:   Wed,  4 Oct 2017 16:26:54 -0700
Message-Id: <1507159627-127660-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

Hi,

This is the first of many timer infrastructure cleanups to simplify the
timer API[1]. All of these patches are expected to land via the timer
tree, so Acks (or corrections) appreciated.

These patches refactor various users of timer API that are NOT just using
init_timer() or setup_timer() (which is the vast majority of users,
and are being converted separately). These changes are focused on the
lesser-used init_timer_*(), TIMER_*INITIALIZER(), and DEFINE_TIMER()
methods of preparing a timer.

Thanks!

-Kees

[1] https://git.kernel.org/linus/686fef928bba6be13cabe639f154af7d72b63120
