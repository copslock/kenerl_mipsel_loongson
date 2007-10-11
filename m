Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 10:53:45 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.190]:17729 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021470AbXJKJxP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 10:53:15 +0100
Received: by mu-out-0910.google.com with SMTP id w1so569111mue
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2007 02:52:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=w2ThYS9RQI6HuRrAWw6Ha9mrJISrzZ5HulZc/31dcFY=;
        b=DS5HZHkSdnpevxA9rHz9BXyokilD1VX8YBmWGDt6UsNitDfTU6HZQaL/Ft4CtZNdyPBO/3bUMU7THkkX/Hf2B0u3f7Gn9Vg4qSYO3fkaK3uwTf+WhYs9YNZaxgyNPMo4l+mhUDaTRNXW3TSLm0yxrBxRzoXQPtJ66O6KaDaVIiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=OFlvwu1nX4QGZoXMd/D7D0l07RAw5YjOMWKuEaH0Gk9AGoQ8YUuogdFStAna7uIF6XKZr63j9tIx53piaK+NH26UTDq9IRxSUIjLvLBpkcpMCQG9uQDXXfXSTCROtP83+Jol+jQFA4m76ONE7jqwNW5IQl5SC2kVBQDhEy7DX1M=
Received: by 10.82.175.17 with SMTP id x17mr3456886bue.1192096377515;
        Thu, 11 Oct 2007 02:52:57 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id g1sm4040270muf.2007.10.11.02.52.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Oct 2007 02:52:55 -0700 (PDT)
Message-ID: <470DF25E.60009@gmail.com>
Date:	Thu, 11 Oct 2007 11:52:30 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [RFC] Add __initbss section
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

As discussed previously, it seems a good idea to create a new init
section .init.bss that store uninitialized data used only at boot
time. That way, we can avoid to embed these uninitialized data in the
Linux image since it's totaly useless.

As a good candidate for using this, is tlbex.c. This file allocates a
couple of big arrays that don't need to be part of the init data
section since they're not initialized and they're currently only used
at boot time.

So this patchset does this but the result looks weird: I tried to
apply this patch on top of the patchset:

---8<---

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a61246d..8271eab 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -743,11 +743,11 @@ il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
  * We deliberately chose a buffer size of 128, so we won't scribble
  * over anything important on overflow before we panic.
  */
-static __initdata u32 tlb_handler[128];
+static __initbss u32 tlb_handler[128];
 
 /* simply assume worst case size for labels and relocs */
-static __initdata struct label labels[128];
-static __initdata struct reloc relocs[128];
+static __initbss struct label labels[128];
+static __initbss struct reloc relocs[128];

--->8---

and the kernel image is bigger after the patch is applied !

$ ls -l vmlinux*
-rwxrwxr-x 1 fbuihuu fbuihuu 2503324 2007-10-11 11:41 vmlinux*
-rwxrwxr-x 1 fbuihuu fbuihuu 2503264 2007-10-11 11:41 vmlinux~old*

Could anybody explain me why ? The time is missing and I probably
couldn't investigate into this until this weekend. 

Also not that with the current patchset applied, there are now 2
segments that need to be loaded, hopefully it won't cause any issues
with any bootloaders out there that would assume that an image has
only one segment...

Other question: I noticed that the exit.data section is not
discarded. Could anybody give me the reason why ?

		Franck
