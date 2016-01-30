Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 06:18:35 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34657 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009116AbcA3FRlW6jUt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 06:17:41 +0100
Received: by mail-pf0-f196.google.com with SMTP id 65so4716200pfd.1;
        Fri, 29 Jan 2016 21:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pKgh2PltLH/AcyjKwomzaatXbrt4twSeM6p+Yn1NfDk=;
        b=bID8k5pAaP1fI9Krt6gfucLWiT56P+8YNMkc3c0KNC17v/u4Y1bvn8KYAGjGfTNmqg
         hZEvOZBaYHJ4VTh9dZdjFQYAfXGzIu4fhTxVr5puQSDdWoPUKWH3eZnuXqK7W4kGfcBe
         nYuFGf42TpcJUfYp/84ExjDZEND1Lb3if2Vc7xprtTzawB1RvoKSCuyEl0MR35OyHz4E
         /32rxdddeOdbEHPMv5mxkSKRAq4jQFTonhocMznYz7j6nU6GgHok+JtrbpfGPOgJcBtA
         79To+oGt8tVRf/1LSi2PIvM4AO67Vag90RBEmlJiSzLm1uFzvBvz0J9qHENX5CR92AMP
         kCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pKgh2PltLH/AcyjKwomzaatXbrt4twSeM6p+Yn1NfDk=;
        b=mFntj0OYwND2KGsJnZvBl2SEfmZi/4yo0rs6ls748dEIkuEALdQvrF8LsUdhhTnULl
         GtdevI688pXatpV2vjGSH6X2LtDtn6ggGwsFzmnwg6/qMb51P44Fl+LNe9hwCHIEVacg
         RDU9OgnOVpMGNusCNh6ShbdZ4EXBY7mr+bDEjBIOCLbKXvjpueSGhphOjNbvvwRSg5Ss
         MFORpE4tU8ZsZmsDHobbxGgTkCVuGp+9uRv3SC84LwaDgD+8zYfqNM/ZJc8T1xkuscd8
         tD03T4ZLVbL7jLKBlLC0KpSIptWry82upcIsP7ljOtzzElx4XXr1YMEll6tmDNutqSrw
         F03Q==
X-Gm-Message-State: AG10YOTl8NeskCqHQRDKGOMigl+4JIkwdruDv6ZD+rZPjb7pf7s4QVyQPTKJ9dIbFEETrw==
X-Received: by 10.98.79.9 with SMTP id d9mr15201933pfb.46.1454131055609;
        Fri, 29 Jan 2016 21:17:35 -0800 (PST)
Received: from localhost.localdomain (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id a21sm7498645pfj.40.2016.01.29.21.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 21:17:35 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org, jaedon.shin@gmail.com, jfraser@broadcom.com,
        pgynther@google.com, dragan.stancevic@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/6] BMIPS: BMIPS: local_r4k___flush_cache_all needs to blast S-cache
Date:   Fri, 29 Jan 2016 21:17:23 -0800
Message-Id: <1454131046-11124-4-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
References: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

local_r4k___flush_cache_all() is missing a special check for BMIPS5000
processors, we need to blast the S-cache, just like other MTI processors
since we have an inclusive cache. We also need an additional __sync() to
make sure this is completed.

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/mm/c-r4k.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 6bf6c6b..d4dfb21 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -447,6 +447,11 @@ static inline void local_r4k___flush_cache_all(void * args)
 		r4k_blast_scache();
 		break;
 
+	case CPU_BMIPS5000:
+		r4k_blast_scache();
+		__sync();
+		break;
+
 	default:
 		r4k_blast_dcache();
 		r4k_blast_icache();
-- 
1.7.1
