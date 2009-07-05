Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jul 2009 16:59:03 +0200 (CEST)
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:35189 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492015AbZGEO64 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 5 Jul 2009 16:58:56 +0200
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id 8F3CF63754;
	Sun,  5 Jul 2009 14:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJ1GNXIrQL9h; Sun,  5 Jul 2009 23:52:04 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
	id 2612763758; Sun,  5 Jul 2009 23:52:04 +0900 (JST)
Date:	Sun, 5 Jul 2009 23:52:03 +0900
From:	Paul Mundt <lethal@linux-sh.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Krzysztof Helt <krzysztof.h1@wp.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, ???? <yanh@lemote.com>,
	zhangfx <zhangfx@lemote.com>
Subject: Re: [BUG] drivers/video/sis: deadlock introduced by "fbdev: add mutex for fb_mmap locking"
Message-ID: <20090705145203.GA8326@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Krzysztof Helt <krzysztof.h1@wp.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, ???? <yanh@lemote.com>,
	zhangfx <zhangfx@lemote.com>
References: <1246785112.14240.34.camel@falcon> <alpine.LFD.2.01.0907050715490.3210@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907050715490.3210@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 05, 2009 at 07:19:33AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 5 Jul 2009, Wu Zhangjin wrote:
> > 
> > then it works! so, I guess there is a deadlock introduced by the above
> > commit.
> 
> Hmm. Perhaps more likely, the 'mm_lock' mutex hasn't even been initialized 
> yet.  We appear to have had that problem with matroxfb and sm501fb, and it 
> may be more common than that. See commit f50bf2b2.
> 
> That said, I do agree that the mm_lock seems to be causing more problems 
> than it actually fixes, and maybe we should revert it. Krzysztof?
> 
Looking at this a bit closer, just moving the mutex initialization in to
framebuffer_alloc() should basically fix most of these, at least it
certainly does for sm501fb and for this sis case as well. So, here's a
patch to do that.

As an aside note, matroxfb is the odd one out, as it doesn't use
framebuffer_alloc() directly for whatever reason. This actually raises an
additional issue, in that framebuffer_alloc() is already where other
mutexes are initialized, which will simply never happen on matroxfb
(suggesting that at least the FB_BACKLIGHT and matroxfb combination will
blow up, although perhaps that's not a valid combination).

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/video/fbmem.c   |    1 -
 drivers/video/fbsysfs.c |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 53ea056..27a5271 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1514,7 +1514,6 @@ register_framebuffer(struct fb_info *fb_info)
 			break;
 	fb_info->node = i;
 	mutex_init(&fb_info->lock);
-	mutex_init(&fb_info->mm_lock);
 
 	fb_info->dev = device_create(fb_class, fb_info->device,
 				     MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index d4a2c11..dd413ad 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -62,6 +62,8 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 	mutex_init(&info->bl_curve_mutex);
 #endif
 
+	mutex_init(&info->mm_lock);
+
 	return info;
 #undef PADDING
 #undef BYTES_PER_LONG
