Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:47:58 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:58458 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825979Ab2KEWrjYIYLc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:39 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so3945696pad.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Dv8EV5yYhMCiCcpJPLS+K4+AAeM3+Z0IlXs5zyggANI=;
        b=QfaXRFazO9ZwynKoJ0WqEZ6XgKPNFSFKy4i6jGn56GQwLK99bB6JW2gSxy1zMJY9PX
         elrFswfvvXYpU0tlVEUgNNInRVDtdkGqPMgzsnXw49fZMRViqsXKeo9ntndwjb/3zGCV
         dxic56UKFyyUjT/HjNLca/6R9Te3HJ8Cr1J9So0GFkLiIBEyx8WGtDcV59Ibkph4xqbh
         j+EB9f3nSp0o49AtBV6HZD3ecZD3q/wQljmIFWF9fTT73Q020xwScSEMzGyYbGoa8q49
         dqtGFvIC1b/CqMxDi3N04/dlJQhvmTIxCnPYI80r6aoolsWMObFZyLAaRnCXZWoGYM9r
         sBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=Dv8EV5yYhMCiCcpJPLS+K4+AAeM3+Z0IlXs5zyggANI=;
        b=hfU8lDbB0ngVOCzsO5JjbTQh646WhD4PfbrZLwzow3DIgG+yfpGxT2k1GSUyfFzIuf
         KAL61EOSi+pvVaHf5/DGe0ac0rxXrIZQttOmb445X+BjsyxwB1Z7ZtVeUyFojYUzNMds
         vNkqPzYOXU1iK5Ch5R1IMqLxNVy4HfXvK10k7MLkLc/vdMaQa2r408b8VWIxLfu+LNSd
         8isEAlvLIpkDSEh2MiZxNzjKqZ57mAo4XzuLr5OHFfa7on+PU9Cl3xpkGBc6fYrkTN/O
         YLuc6Vqugsdv2qx3R9xrjhC58nqk9YSp23U5agmAR4uRUNIScML5TTpg4pTNe/x2Tp1+
         b4HQ==
Received: by 10.68.189.138 with SMTP id gi10mr34244353pbc.165.1352155652928;
        Mon, 05 Nov 2012 14:47:32 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:32 -0800 (PST)
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 01/16] mm: add anon_vma_lock to validate_mm()
Date:   Mon,  5 Nov 2012 14:46:58 -0800
Message-Id: <1352155633-8648-2-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQkUufZMWeNTEl5fZL4gq4NxG/94h4ikyiCXt3O0+fejPyOmCcAbgaL0iKwnOD4gnAla+Uha/bG61XMotNrZcne+XVQg0h/jR2uCMqgA8baOSUdIQEYb6Vzi0LBcPaBxgg5mkZeOmYNbeGBzxuICTU9P/Z7VPET1y2fLk0dwAQTzTHX4BFEUuHuMdZAlzpDlm8u/mYHSDsiU6qOB6TUp7ReWG+CZCA==
X-archive-position: 34871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: walken@google.com
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

Iterate vma->anon_vma_chain without anon_vma_lock may cause NULL ptr deref in
anon_vma_interval_tree_verify(), because the node in the chain might have been
removed.

[ 1523.657950] BUG: unable to handle kernel paging request at fffffffffffffff0
[ 1523.660022] IP: [<ffffffff8122c29c>] anon_vma_interval_tree_verify+0xc/0xa0
[ 1523.660022] PGD 4e28067 PUD 4e29067 PMD 0
[ 1523.675725] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
[ 1523.750066] CPU 0
[ 1523.750066] Pid: 9050, comm: trinity-child64 Tainted: G        W    3.7.0-rc2-next-20121025-sasha-00001-g673f98e-dirty #77
[ 1523.750066] RIP: 0010:[<ffffffff8122c29c>]  [<ffffffff8122c29c>] anon_vma_interval_tree_verify+0xc/0xa0
[ 1523.750066] RSP: 0018:ffff880045f81d48  EFLAGS: 00010296
[ 1523.750066] RAX: 0000000000000000 RBX: fffffffffffffff0 RCX: 0000000000000000
[ 1523.750066] RDX: 0000000000000000 RSI: 0000000000000001 RDI: fffffffffffffff0
[ 1523.750066] RBP: ffff880045f81d58 R08: 0000000000000000 R09: 0000000000000f14
[ 1523.750066] R10: 0000000000000f12 R11: 0000000000000000 R12: ffff8800096c8d70
[ 1523.750066] R13: ffff8800096c8d00 R14: 0000000000000000 R15: ffff8800095b45e0
[ 1523.750066] FS:  00007f7a923f3700(0000) GS:ffff880013600000(0000) knlGS:0000000000000000
[ 1523.750066] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1523.750066] CR2: fffffffffffffff0 CR3: 000000000969d000 CR4: 00000000000406f0
[ 1523.750066] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1523.750066] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1523.750066] Process trinity-child64 (pid: 9050, threadinfo ffff880045f80000, task ffff880048eb0000)
[ 1523.750066] Stack:
[ 1523.750066]  ffff88000d7533f0 fffffffffffffff0 ffff880045f81da8 ffffffff812361d8
[ 1523.750066]  ffff880045f81d98 ffff880048ee9000 ffff8800095b4580 ffff8800095b4580
[ 1523.750066]  ffff88001d1cdb00 ffff8800095b45f0 ffff880022a4d630 ffff8800095b45e0
[ 1523.750066] Call Trace:
[ 1523.750066]  [<ffffffff812361d8>] validate_mm+0x58/0x1e0
[ 1523.750066]  [<ffffffff81236aa5>] vma_adjust+0x635/0x6b0
[ 1523.750066]  [<ffffffff81236c81>] __split_vma.isra.22+0x161/0x220
[ 1523.750066]  [<ffffffff81237934>] split_vma+0x24/0x30
[ 1523.750066]  [<ffffffff8122ce6a>] sys_madvise+0x5da/0x7b0
[ 1523.750066]  [<ffffffff811cd14c>] ? rcu_eqs_exit+0x9c/0xb0
[ 1523.750066]  [<ffffffff811802cd>] ? trace_hardirqs_on+0xd/0x10
[ 1523.750066]  [<ffffffff83aee198>] tracesys+0xe1/0xe6
[ 1523.750066] Code: 4c 09 ff 48 39 ce 77 9e f3 c3 0f 1f 44 00 00 31 c0 c3 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 53
48 89 fb 48 83 ec 08 <48> 8b 17 48 8b 8a 90 00 00 00 48 39 4f 40 74 34 80 3d f7 1f 5c
[ 1523.750066] RIP  [<ffffffff8122c29c>] anon_vma_interval_tree_verify+0xc/0xa0
[ 1523.750066]  RSP <ffff880045f81d48>
[ 1523.750066] CR2: fffffffffffffff0
[ 1523.750066] ---[ end trace e35e5fa49072faf9 ]---

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Figured-out-by: Bob Liu <lliubbo@gmail.com>
Signed-off-by: Michel Lespinasse <walken@google.com>

---
 mm/mmap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2d942353d681..9a796c41e7d9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -334,8 +334,10 @@ void validate_mm(struct mm_struct *mm)
 	struct vm_area_struct *vma = mm->mmap;
 	while (vma) {
 		struct anon_vma_chain *avc;
+		vma_lock_anon_vma(vma);
 		list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 			anon_vma_interval_tree_verify(avc);
+		vma_unlock_anon_vma(vma);
 		vma = vma->vm_next;
 		i++;
 	}
-- 
1.7.7.3
