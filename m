Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 13:57:10 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56074 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492648AbZLBM5F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 13:57:05 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB2Cuueq020018;
        Wed, 2 Dec 2009 12:56:57 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB2CuqDL020016;
        Wed, 2 Dec 2009 12:56:52 GMT
Date:   Wed, 2 Dec 2009 12:56:52 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dave Airlie <airlied@linux.ie>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] DRM: Fix build error in include/drm/ttm/ttm_memory.h
Message-ID: <20091202125651.GA19748@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

include/drm/ttm/ttm_memory.h uses struct page * without having included
the required headers or a forward declaration resulting in the following
build error for mtx1_defconfig on Linus' master branch, possibly others:

  CC [M]  drivers/gpu/drm/ttm/ttm_memory.o
In file included from /home/ralf/src/linux/linux-mips/drivers/gpu/drm/ttm/ttm_memory.c:28:
/home/ralf/src/linux/linux-mips/include/drm/ttm/ttm_memory.h:154: warning: ‘struct page’ declared inside parameter list
/home/ralf/src/linux/linux-mips/include/drm/ttm/ttm_memory.h:154: warning: its scope is only this definition or declaration, which is probably not what you want
/home/ralf/src/linux/linux-mips/include/drm/ttm/ttm_memory.h:156: warning: ‘struct page’ declared inside parameter list
/home/ralf/src/linux/linux-mips/drivers/gpu/drm/ttm/ttm_memory.c:537: error: conflicting types for ‘ttm_mem_global_alloc_page’
/home/ralf/src/linux/linux-mips/include/drm/ttm/ttm_memory.h:152: note: previous declaration of ‘ttm_mem_global_alloc_page’ was here
/home/ralf/src/linux/linux-mips/drivers/gpu/drm/ttm/ttm_memory.c:560: error: conflicting types for ‘ttm_mem_global_free_page’
/home/ralf/src/linux/linux-mips/include/drm/ttm/ttm_memory.h:155: note: previous declaration of ‘ttm_mem_global_free_page’ was here
make[6]: *** [drivers/gpu/drm/ttm/ttm_memory.o] Error 1
make[5]: *** [drivers/gpu/drm/ttm] Error 2
make[4]: *** [drivers/gpu/drm] Error 2
make[3]: *** [drivers/gpu] Error 2
make[2]: *** [drivers] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

Fixed by adding a forward declaration.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 include/drm/ttm/ttm_memory.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/drm/ttm/ttm_memory.h b/include/drm/ttm/ttm_memory.h
index 6983a7c..95355ee 100644
--- a/include/drm/ttm/ttm_memory.h
+++ b/include/drm/ttm/ttm_memory.h
@@ -143,6 +143,8 @@ static inline void ttm_mem_unregister_shrink(struct ttm_mem_global *glob,
 	spin_unlock(&glob->lock);
 }
 
+struct page;
+
 extern int ttm_mem_global_init(struct ttm_mem_global *glob);
 extern void ttm_mem_global_release(struct ttm_mem_global *glob);
 extern int ttm_mem_global_alloc(struct ttm_mem_global *glob, uint64_t memory,
