Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Oct 2010 18:47:36 +0200 (CEST)
Received: from swampdragon.chaosbits.net ([90.184.90.115]:27892 "EHLO
        swampdragon.chaosbits.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491095Ab0J3Qrd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Oct 2010 18:47:33 +0200
Received: by swampdragon.chaosbits.net (Postfix, from userid 1000)
        id 00BAB94040; Sat, 30 Oct 2010 18:37:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by swampdragon.chaosbits.net (Postfix) with ESMTP id F2EE49403F;
        Sat, 30 Oct 2010 18:37:16 +0200 (CEST)
Date:   Sat, 30 Oct 2010 18:37:16 +0200 (CEST)
From:   Jesper Juhl <jj@chaosbits.net>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Check vmalloc return value in vpe_open
Message-ID: <alpine.LNX.2.00.1010301823350.1572@swampdragon.chaosbits.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jj@chaosbits.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jj@chaosbits.net
Precedence: bulk
X-list: linux-mips

Hi,

I noticed that the return value of the 
vmalloc() call in arch/mips/kernel/vpe.c::vpe_open() is not checked, so we 
potentially store a null pointer in v->pbuffer. As far as I can tell this 
will be a problem. However, I don't know the mips code at all, so there 
may be something, somewhere where I did not look, that handles this in a 
safe manner but I couldn't find it.

To me it looks like we should do what the patch below implements and check 
for a null return and then return -ENOMEM in that case. Comments?

Please CC me on replies as I'm not subscribed to linux-mips.


Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 vpe.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 3eb3cde..22b79f6 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -1092,6 +1092,10 @@ static int vpe_open(struct inode *inode, struct file *filp)
 
 	/* this of-course trashes what was there before... */
 	v->pbuffer = vmalloc(P_SIZE);
+	if (!v->pbuffer) {
+		pr_warning("VPE loader: unable to allocate memory\n");
+		return -ENOMEM;
+	}
 	v->plen = P_SIZE;
 	v->load_addr = NULL;
 	v->len = 0;


-- 
Jesper Juhl <jj@chaosbits.net>             http://www.chaosbits.net/
Plain text mails only, please      http://www.expita.com/nomime.html
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
