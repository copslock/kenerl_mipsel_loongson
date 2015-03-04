Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 22:15:55 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:50078 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008055AbbCDVPx7Ogzt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Mar 2015 22:15:53 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t24LAuTE020849;
        Wed, 4 Mar 2015 13:10:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Ismael Ripoll <iripoll@upv.es>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Borislav Petkov <bp@suse.de>,
        =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 0/10] split ET_DYN ASLR from mmap ASLR
Date:   Wed,  4 Mar 2015 13:10:44 -0800
Message-Id: <1425503454-7531-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.9.1
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46158
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

v4:
- added Ack on powerpc (mpe)
- fixed mmap_base argument convention to be the same on all archs
- corrected paste-o in mips variable names (buildbot)
- clarified ET_DYN vs mmap ASLR regions in 9/10 (mpe)
v3:
- split change on a per-arch basis for easier review
- moved PF_RANDOMIZE check out of per-arch code (ingo)
v2:
- verbosified the commit logs, especially 4/5 (akpm)
