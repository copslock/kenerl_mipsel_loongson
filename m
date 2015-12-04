Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 12:40:13 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34116 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013159AbbLDLkMFpwvx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2015 12:40:12 +0100
Received: by pacwq6 with SMTP id wq6so8660142pac.1;
        Fri, 04 Dec 2015 03:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=H6V2li49aUcZCpI5xuHiqcAZ2HEmRb4KRSTu2gBjwZI=;
        b=G9irWZ3CNJuTOpG7QqQHNCCXfS16YWSoLfpqJaXKo4G5fV6vzKvkfrfzj4/X9U+uly
         iKxUH1EUfq4tv4Wv1TOYipCyvRYUoNrNLk+u3raxtq4SnSBg2UJgCRbP4meNR8DyX9Kx
         OuNhbYr7EMlxNK+WuuN64Z5oCcv4QsUKGOzMMJvWYQUllR7+0ufUW9Qu+YEW9w1fpveg
         rRDZojS9uknQm3e1bfbFaQcCtNVHfUvabFgmO/nVrkYkvcu70HV7Jih/SdmxlEOGVRGT
         hsRycmI/iVJkCvM3qmchdvnqatuOp5aI86z5+PnYi46MErPWfWIp4Hhx27FbiQp3rqMy
         AzcA==
X-Received: by 10.66.153.198 with SMTP id vi6mr20801310pab.37.1449229205819;
        Fri, 04 Dec 2015 03:40:05 -0800 (PST)
Received: from yggdrasil (111-243-147-169.dynamic.hinet.net. [111.243.147.169])
        by smtp.gmail.com with ESMTPSA id w8sm16657822pfi.41.2015.12.04.03.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2015 03:40:04 -0800 (PST)
Date:   Fri, 4 Dec 2015 19:40:00 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>, ralf@linux-mips.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH] MIPS: CM: Fix compilation error when !MIPS_CM
Message-ID: <20151204193713-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

Fix mips_cm_lock_other compilation error when MIPS_CM is not selected.
This was introduced in commit 23d5de8efb9a (MIPS: CM: Introduce core-other
locking functions)

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 6516e9d..0dabede 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -501,7 +501,7 @@ extern void mips_cm_unlock_other(void);
 
 #else /* !CONFIG_MIPS_CM */
 
-static inline void mips_cm_lock_other(unsigned int core) { }
+static inline void mips_cm_lock_other(unsigned int core, unsigned int vp) { }
 static inline void mips_cm_unlock_other(void) { }
 
 #endif /* !CONFIG_MIPS_CM */
