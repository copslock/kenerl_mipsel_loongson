Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 23:17:54 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:32785
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993997AbdCMWO5IXZWm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2017 23:14:57 +0100
Received: by mail-wr0-x244.google.com with SMTP id g10so21791783wrg.0;
        Mon, 13 Mar 2017 15:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hPnPMUmdxCmL2VZfHCk49qFtrqUABprIraT2deulDPM=;
        b=vMhH71+EwFar6S8dJ+TBpuvjUbQQwW6fbFDyV+pzcRgqvD1Ws5qyzgc/gkt1bXxCFR
         xwQs/OJcq0wdTe1rd8t3EdrpLO1qe9gpAbhxRCQkua4e7JEeAEI0x5VzrNb23N5hsvG/
         1BonYZJIwyzfdW18iUSjX18fp4ywHZ/PM80CfRWlscq9+I5cfFs9qGktzcxGT9fKT+PG
         Eh9JZMMAJ5CYRQcP31FCvSzCgyN57+Bm2xTURxGnUPlvxv4r+uVfOPF+J1WTc9IFgbrW
         zO6/baRwKCwmlJxRZOr2ArDNDm7xJdy4QUQ4+M0lURgYnBV7P6pJyuiIJXGbGnn8cJjW
         mr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hPnPMUmdxCmL2VZfHCk49qFtrqUABprIraT2deulDPM=;
        b=kg+5BFtrS55iWuwoectMIuWoPmk3SOa+ESvrt3wNwazFMcyvJ68RhtivXtY65/SHjV
         88MSv2gASzcsT12SwyHqBXbGgCdvG4rW0aL1mr96kv7rcV850IwyJs+sijDwYF+zPx07
         l1zXfQHYukRGg3HeCost/GTn0aJIrgpEshyq0WTk1fn6VhUzc4BW7kwNM9/pALoevPpK
         6dPj4zPl7uW846c0ApfYCZzN9jCFBqmEM3f8nh8wr4+r5VXdj0KQqv5ecaDRkJerCP4v
         1c3e7YdPVntTQyuWRcifdpDaBrrr3eauQzFotLxtVEJFvk8hU9CvXWi90HoJq0at3X2X
         EJeA==
X-Gm-Message-State: AMke39kPS5IX/LGOMk74gX7D1uT6DgWz+dLOylO/3U0EDF/toYlH5ZCWhpy0Os6tjHuWRA==
X-Received: by 10.223.163.195 with SMTP id m3mr29043535wrb.83.1489443291833;
        Mon, 13 Mar 2017 15:14:51 -0700 (PDT)
Received: from localhost (login1.zih.tu-dresden.de. [141.76.16.140])
        by smtp.googlemail.com with ESMTPSA id q4sm13025125wme.17.2017.03.13.15.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Mar 2017 15:14:51 -0700 (PDT)
From:   Till Smejkal <till.smejkal@googlemail.com>
X-Google-Original-From: Till Smejkal <till.smejkal@gmail.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-mm@kvack.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 08/13] kernel/fork: Define explicitly which mm_struct to duplicate during fork
Date:   Mon, 13 Mar 2017 15:14:10 -0700
Message-Id: <20170313221415.9375-9-till.smejkal@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170313221415.9375-1-till.smejkal@gmail.com>
References: <20170313221415.9375-1-till.smejkal@gmail.com>
Return-Path: <till.smejkal@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: till.smejkal@googlemail.com
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

The dup_mm-function used during 'do_fork' to duplicate the current task's
mm_struct for the newly forked task always implicitly uses current->mm for
this purpose. However, during copy_mm it was already decided which
mm_struct to copy/duplicate. So pass this mm_struct to dup_mm instead of
again deciding which mm_struct to use.

Signed-off-by: Till Smejkal <till.smejkal@gmail.com>
---
 kernel/fork.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9209f6d5d7c0..d3087d870855 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1158,9 +1158,10 @@ void mm_release(struct task_struct *tsk, struct mm_struct *mm)
  * Allocate a new mm structure and copy contents from the
  * mm structure of the passed in task structure.
  */
-static struct mm_struct *dup_mm(struct task_struct *tsk)
+static struct mm_struct *dup_mm(struct task_struct *tsk,
+				struct mm_struct *oldmm)
 {
-	struct mm_struct *mm, *oldmm = current->mm;
+	struct mm_struct *mm;
 	int err;
 
 	mm = allocate_mm();
@@ -1226,7 +1227,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	}
 
 	retval = -ENOMEM;
-	mm = dup_mm(tsk);
+	mm = dup_mm(tsk, oldmm);
 	if (!mm)
 		goto fail_nomem;
 
-- 
2.12.0
