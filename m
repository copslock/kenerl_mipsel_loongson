Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 22:23:17 +0200 (CEST)
Received: from mail-pb0-f53.google.com ([209.85.160.53]:49464 "EHLO
        mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6853554AbaFKUXPHvSRk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2014 22:23:15 +0200
Received: by mail-pb0-f53.google.com with SMTP id md12so181769pbc.12
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 13:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=64zXlf5tpyPIs4Latyi+PJXG8+7Io0h1kKAGSFVrjwE=;
        b=Al5aTDe4ULFhAdBZpz2+w8MJEryNmQfUE8rsKsEHRCFzVzgSsG0tCEHuPW5IF/2JxQ
         bXMcBna1mf8dBUYBXu8zQ90m8UAjdCaopvNfwgv0MBSo+b4jGYCGduM0f5kJ+JkiI2kl
         /GR6cx/UJnEvYaN1Di4Wz1Ep4NiojWOLOOG4m5XHm10LmWUuZdqI6DczEVUlIQWwwsFC
         fqqJ/UcGVLXq4bTVpvycgTt8gVwrRG+GvoDkD+Km/K31v5bR0SB/FRco2KZaSo/CQjZH
         ay6c7wfK9aDLysqbS1g6DVvJKRg9bV5bbS58+8un9SQ8dvXJCaq9ChsBRn3w+yqPWvTd
         VfPQ==
X-Gm-Message-State: ALoCoQmlVJIOYDmpOr7KcoX1jr4PWHdHK/7zDA33ElJtGR1uZER8VRlWPte0qIM4c+LGHLLWY9Id
X-Received: by 10.68.134.101 with SMTP id pj5mr7795727pbb.62.1402518188446;
        Wed, 11 Jun 2014 13:23:08 -0700 (PDT)
Received: from localhost (50-76-60-73-ip-static.hfc.comcastbusiness.net. [50.76.60.73])
        by mx.google.com with ESMTPSA id wp3sm76507584pbc.67.2014.06.11.13.23.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jun 2014 13:23:07 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [RFC 0/5] Two-phase seccomp and an x86_64 fast path
Date:   Wed, 11 Jun 2014 13:22:57 -0700
Message-Id: <cover.1402517933.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On my VM, getpid takes about 70ns.  Before this patchset, adding a
single-instruction always-accept seccomp filter added about 134ns of
overhead to getpid.  With this patchset, the overhead is down to about
13ns.

I'd really appreciate careful review from all relevant arch
maintainers for patch 1.

This is an RFC for now.  I'll submit a non-RFC version after the merge
window ends.

Andy Lutomirski (5):
  seccomp,x86,arm,mips,s390: Remove nr parameter from secure_computing
  x86_64,entry: Treat regs->ax the same in fastpath and slowpath
    syscalls
  seccomp: Refactor the filter callback and the API
  seccomp: Allow arch code to provide seccomp_data
  x86,seccomp: Add a seccomp fastpath

 arch/arm/kernel/ptrace.c       |   7 +-
 arch/mips/kernel/ptrace.c      |   2 +-
 arch/s390/kernel/ptrace.c      |   2 +-
 arch/x86/include/asm/calling.h |   6 +-
 arch/x86/kernel/entry_64.S     |  52 ++++++++-
 arch/x86/kernel/ptrace.c       |   2 +-
 arch/x86/kernel/vsyscall_64.c  |   2 +-
 include/linux/seccomp.h        |  25 +++--
 kernel/seccomp.c               | 244 +++++++++++++++++++++++++++--------------
 9 files changed, 241 insertions(+), 101 deletions(-)

-- 
1.9.3
