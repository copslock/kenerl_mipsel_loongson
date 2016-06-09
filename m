Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:02:26 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35458 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034247AbcFIVCZX6htE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:25 +0200
Received: by mail-pa0-f42.google.com with SMTP id hl6so16553998pac.2
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JUxJcNc8W276UI1yymiP2XnM+/dH5pu2Vi0GqiS5jec=;
        b=CjFE0KiRatuaH/12EJTsWTS0o1+l4jH5S4h4J8G3Dl5Nxq8C0UIcXf+2LjiexO1a8e
         5KhBDQ7dpJYN1njkwZ1Sos3K8BRIn71rL9uMtN4L+48OWgpxjV9J4v+zV4iuakHW3lhL
         wEnKFF2BNidJTFiWkaaZKoXVKQjsLRAI7pM7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JUxJcNc8W276UI1yymiP2XnM+/dH5pu2Vi0GqiS5jec=;
        b=RSOloVBzaVGgvbHL32PguA/GLoR36g6f3JNb1iHRBBs8DJufUUSLy63Jl6T+mgnIWW
         NfGrIvQNRUaTpCe5jN7LcoOZwlbz3QsZbop++NsPeH8RHrkdalaXYs30mkAMXIxypKGC
         m3Km8rFOmTHDgTpVOyBDpM5WT3Pip+P6BpfRkbMebXT7dyQijvd+cZpQ8dAEkTS2QTDH
         Vsbs267g/jsQnS352ZnG70OSTobRlWeOuTYAUoP2Q7BKvUk5DGiSHKp441QCT153op0u
         WTOy+l9QrrJj1tCR5WbqV8Xzys+Qaqq4eFNRqlPTSDxLcXhsfdvmzd7Dtf/FW/TbBTCX
         EYAA==
X-Gm-Message-State: ALyK8tLnnENNZzeSvhzp2Rh/lVHj7CVvn1RG8RS4K76MRdI0wiq1kcNoNZiYxBDRJQAVfmOm
X-Received: by 10.66.249.161 with SMTP id yv1mr14406381pac.39.1465506137628;
        Thu, 09 Jun 2016 14:02:17 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id m187sm12166897pfc.57.2016.06.09.14.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        user-mode-linux-devel@lists.sourceforge.net,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 00/14] run seccomp after ptrace
Date:   Thu,  9 Jun 2016 14:01:50 -0700
Message-Id: <1465506124-21866-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53964
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

There has been a long-standing (and documented) issue with seccomp
where ptrace can be used to change a syscall out from under seccomp.
This is a problem for containers and other wider seccomp filtered
environments where ptrace needs to remain available, as it allows
for an escape of the seccomp filter.

Since the ptrace attack surface is available for any allowed syscall,
moving seccomp after ptrace doesn't increase the actually available
attack surface. And this actually improves tracing since, for
example, tracers will be notified of syscall entry before seccomp
sends a SIGSYS, which makes debugging filters much easier.

The per-architecture changes do make one (hopefully small)
semantic change, which is that since ptrace comes first, it may
request a syscall be skipped. Running seccomp after this doesn't
make sense, so if ptrace wants to skip a syscall, it will bail
out early similarly to how seccomp was. This means that skipped
syscalls will not be fed through audit, though that likely means
we're actually avoiding noise this way.

This series first cleans up seccomp to remove the now unneeded
two-phase entry, fixes the SECCOMP_RET_TRACE hole (same as the
ptrace hole above), and then reorders seccomp after ptrace on
each architecture.

Thanks,

-Kees
