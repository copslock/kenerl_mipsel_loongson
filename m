Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 20:09:57 +0200 (CEST)
Received: from smtp.outflux.net ([198.145.64.163]:57628 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861334AbaGQSIxWKiiv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Jul 2014 20:08:53 +0200
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s6HI8hRC032225;
        Thu, 17 Jul 2014 11:08:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Drysdale <drysdale@google.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>, linux-api@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-arch@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v12 11/11] seccomp: add thread sync ability
Date:   Thu, 17 Jul 2014 11:08:27 -0700
Message-Id: <1405620518-18495-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.7.9.5
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41287
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

Twelfth time's the charm! :)

This adds the ability for threads to request seccomp filter
synchronization across their thread group (at filter attach time).
For example, for Chrome to make sure graphic driver threads are fully
confined after seccomp filters have been attached.

To support this, locking on seccomp changes via thread-group-shared
sighand lock is introduced, along with refactoring of no_new_privs. Races
with thread creation are handled via delayed duplication of the seccomp
task struct field and cred_guard_mutex.

This includes a new syscall (instead of adding a new prctl option),
as suggested by Andy Lutomirski and Michael Kerrisk.

Thanks!

-Kees

v12:
 - fixed bug where initial filter wouldn't allow TSYNC flag (drysdale)
 - optimized thread loops (drysdale)
v11:
 - updated writer locking commit log for clarity (luto)
 - clarified writer lock thread flag setting comment (luto)
 - inverted SECCOMP_FILTER_FLAG_MASK (luto)
 - renamed is_acestor parameter (luto)
 - added BUG_ON to catch currently impossible integer overflow (luto)
v10:
 - dropped pending-kill checks (oleg)
 - tweaked memory barriers (oleg)
v9:
 - rearranged/split patches to make things more reviewable
 - added use of cred_guard_mutex to solve exec race (oleg, luto)
 - added barriers for TIF_SECCOMP vs seccomp.mode race (oleg, luto)
 - fixed missed copying of nnp state after v8 refactor (oleg)
v8:
 - drop use of tasklist_lock, appears redundant against sighand (oleg)
 - reduced use of smp_load_acquire to logical minimum (oleg)
 - change nnp to a task struct held atomic flags field (oleg, luto)
 - drop needless irqflags changes in fork.c for holding sighand lock (oleg)
 - cleaned up use of thread for-each loop (oleg)
 - rearranged patch order to keep syscall changes adjacent
 - added example code to manpage (mtk)
v7:
 - rebase on Linus's tree (merged with network bpf changes)
 - wrote manpage text documenting API (follows this series)
v6:
 - switch from seccomp-specific lock to thread-group lock to gain atomicity
 - implement seccomp syscall across all architectures with seccomp filter
 - clean up sparse warnings around locking
v5:
 - move includes around (drysdale)
 - drop set_nnp return value (luto)
 - use smp_load_acquire/store_release (luto)
 - merge nnp changes to seccomp always, fewer ifdef (luto)
v4:
 - cleaned up locking further, as noticed by David Drysdale
v3:
 - added SECCOMP_EXT_ACT_FILTER for new filter install options
v2:
 - reworked to avoid clone races
