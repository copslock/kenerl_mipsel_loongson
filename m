Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 03:12:05 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:47304 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008054AbbCDCLqMkP-U (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Mar 2015 03:11:46 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t242ASae002264;
        Tue, 3 Mar 2015 18:10:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Ismael Ripoll <iripoll@upv.es>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Dan McGee <dpmcgee@gmail.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Behan Webster <behanw@converseincode.com>,
        =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/10] split ET_DYN ASLR from mmap ASLR
Date:   Tue,  3 Mar 2015 18:10:15 -0800
Message-Id: <1425435025-30284-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.9.1
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46114
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

To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
ASLR from mmap ASLR, as already done on s390. The architectures
that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
and x86), have their various forms of arch_mmap_rnd() made available
via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
arch_randomize_brk() is collapsed as well.

This is an alternative to the solutions in:
https://lkml.org/lkml/2015/2/23/442

I've been able to test x86 and arm, and the buildbot (so far) seems
happy with building the rest.

Thanks!

-Kees

[1] http://cybersecurity.upv.es/attacks/offset2lib/offset2lib.html

v3:
- split change on a per-arch basis for easier review
- moved PF_RANDOMIZE check out of per-arch code (ingo)
v2:
- verbosified the commit logs, especially 4/5 (akpm)
