Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2010 22:36:52 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:56218 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492964Ab0DUUgt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Apr 2010 22:36:49 +0200
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
        (easymta 1.00 BETA 1)
        id 1O4gfA-0002DC-0B; Wed, 21 Apr 2010 22:36:48 +0200
Date:   Wed, 21 Apr 2010 22:36:47 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH v2] mips/swarm: fixup screen_info struct
Message-ID: <20100421203647.GC7708@Chamillionaire.breakpoint.cc>
References: <20100421185547.GA7708@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20100421185547.GA7708@Chamillionaire.breakpoint.cc>
X-Key-Id: FE3F4706
X-Key-Fingerprint: FFDA BBBB 3563 1B27 75C9  925B 98D5 5C1C FE3F 4706
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sebastian@breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

|arch/mips/sibyte/swarm/setup.c:153:
| warning: large integer implicitly truncated to unsigned type

The field was changed in d9b26352 aka ("x86, setup: Store the boot
cursor state").
This patch changes the values back they way they were before this extra
field got introduced.

While here, the other two boards are also converted to C99 initializer.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/mips/jazz/setup.c            |   12 +++---------
 arch/mips/loongson/common/setup.c |   14 +++++---------
 arch/mips/sibyte/swarm/setup.c    |   19 ++++++++++---------
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/arch/mips/jazz/setup.c b/arch/mips/jazz/setup.c
index 7043f6b..c492563 100644
--- a/arch/mips/jazz/setup.c
+++ b/arch/mips/jazz/setup.c
@@ -76,15 +76,9 @@ void __init plat_mem_setup(void)
 
 #ifdef CONFIG_VT
 	screen_info = (struct screen_info) {
-		0, 0,		/* orig-x, orig-y */
-		0,		/* unused */
-		0,		/* orig_video_page */
-		0,		/* orig_video_mode */
-		160,		/* orig_video_cols */
-		0, 0, 0,	/* unused, ega_bx, unused */
-		64,		/* orig_video_lines */
-		0,		/* orig_video_isVGA */
-		16		/* orig_video_points */
+		.orig_video_cols = 160,
+		.orig_video_lines = 64,
+		.orig_video_points = 16,
 	};
 #endif
 
diff --git a/arch/mips/loongson/common/setup.c b/arch/mips/loongson/common/setup.c
index 4cd2aa9..c2e1410 100644
--- a/arch/mips/loongson/common/setup.c
+++ b/arch/mips/loongson/common/setup.c
@@ -41,15 +41,11 @@ void __init plat_mem_setup(void)
 	conswitchp = &vga_con;
 
 	screen_info = (struct screen_info) {
-		0, 25,		/* orig-x, orig-y */
-		    0,		/* unused */
-		    0,		/* orig-video-page */
-		    0,		/* orig-video-mode */
-		    80,		/* orig-video-cols */
-		    0, 0, 0,	/* ega_ax, ega_bx, ega_cx */
-		    25,		/* orig-video-lines */
-		    VIDEO_TYPE_VGAC,	/* orig-video-isVGA */
-		    16		/* orig-video-points */
+		.orig_y = 25,
+		.orig_video_cols = 80,
+		.orig_video_lines = 25,
+		.orig_video_isVGA = VIDEO_TYPE_VGAC,
+		.orig_video_points = 16,
 	};
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 5277aac..a3573f3 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -145,15 +145,16 @@ void __init plat_mem_setup(void)
 
 #ifdef CONFIG_VT
 	screen_info = (struct screen_info) {
-		0, 0,           /* orig-x, orig-y */
-		0,              /* unused */
-		52,             /* orig_video_page */
-		3,              /* orig_video_mode */
-		80,             /* orig_video_cols */
-		4626, 3, 9,     /* unused, ega_bx, unused */
-		25,             /* orig_video_lines */
-		0x22,           /* orig_video_isVGA */
-		16              /* orig_video_points */
+		.orig_video_page = 52,
+		.orig_video_mode = 3,
+		.orig_video_cols = 80,
+		.flags = 12,
+		.unused2 = 12,
+		.orig_video_ega_bx = 3,
+		.unused3 = 9,
+		.orig_video_lines = 25,
+		.orig_video_isVGA = 0x22,
+		.orig_video_points = 16,
        };
        /* XXXKW for CFE, get lines/cols from environment */
 #endif
-- 
1.6.6.1
