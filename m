Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 07:37:14 +0200 (CEST)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36879 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006654AbaICFhNccaXe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2014 07:37:13 +0200
Received: by mail-wg0-f52.google.com with SMTP id m15so7797913wgh.11
        for <multiple recipients>; Tue, 02 Sep 2014 22:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Oba17ws312W/jkyTapsDfpGKEwe7A4IWjQBWb+3RRHk=;
        b=wrKpYOAVUJrBcCokuLvQkFiS+sNw8C51qwfbSESJabpu4enDn/5keoISRm45Hig7Tk
         5EFhBIba2kU0WplQi9q53cmwxvPeYkDmEdovmYNL4EU3kWHUfX/8e3y5qTfzoNoBt3Xt
         9Q7m1/j++w/vANy+UX7hO4xcKRtCcakMUmVcjRVRk9bzaH1M2tOzSET+IzNc/j/JRXwn
         daAaHu8N73MX91rk0s5fN5niM1QYYcVcAW1Ryb2E5tN9MfYTkBvaR36Kjy9/VBL+GpKl
         Mfc/z8EUsYE5SM5/D2XvbFBGexYTFXnUvt3Jujp3strn2z/a0VSYHTp2s398/SWNzXio
         q92w==
X-Received: by 10.194.174.4 with SMTP id bo4mr19634440wjc.84.1409722628273;
        Tue, 02 Sep 2014 22:37:08 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id fh5sm2269144wib.5.2014.09.02.22.37.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Sep 2014 22:37:07 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH][TRIVIAL] MIPS: Fix info about plat_setup in arch_mem_init comment
Date:   Wed,  3 Sep 2014 07:36:51 +0200
Message-Id: <1409722611-6466-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b3b8f0d..5b41c95 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -485,7 +485,7 @@ static void __init bootmem_init(void)
  * NOTE: historically plat_mem_setup did the entire platform initialization.
  *	 This was rather impractical because it meant plat_mem_setup had to
  * get away without any kind of memory allocator.  To keep old code from
- * breaking plat_setup was just renamed to plat_setup and a second platform
+ * breaking plat_setup was just renamed to plat_mem_setup and a second platform
  * initialization hook for anything else was introduced.
  */
 
-- 
1.8.4.5
