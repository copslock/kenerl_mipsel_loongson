Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 18:46:59 +0200 (CEST)
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36053 "EHLO
        mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010425AbbGNQqjCsE3n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 18:46:39 +0200
Received: by obnw1 with SMTP id w1so9696878obn.3
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=1EVEeF26dbH5d/0uxxTDE6Ve2N3Fr+9fVLUL+oRYraM=;
        b=AZ9mKIzr5rs7X0KrlO3e7ppfBLbqsSsjya7qlP/s/BDR570woZpsPjcOc0ZvcPvBiR
         uRChG2ficTsQ3y7gzHEkU/vrlO0jZSmtz+f2tl7ToVnOOVQz3NR/XsvlP14NTv3uchQX
         ePz0O3B9k7Pb6JV4/YDhKfqGCz5jIF7CODg04notFUMizg+JZpUP21wLMvSRbbr8mcRH
         5OkOmNxGxL9C7JqpdmCFdMl2LxIhLBOpuALvJu2F3RiODaE4MyKglOiAVFDiwJhD+Ggk
         Zb1KtLNmPR2EM2iDSwXKcgXAA4PTi5x5TC2gSSCu7PzgJwkBtUMiXjZGeV4rBPTE1WmI
         4XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=1EVEeF26dbH5d/0uxxTDE6Ve2N3Fr+9fVLUL+oRYraM=;
        b=Cn40mfdleroBcCIYtNHkrZw3XOnQem2sslOj1u5DU6GglXU79DPS3U3JIGPFlw2IbK
         QYhRAIqgbHsK2FmKF6worwxpcE3Ap8vm+2BqL+2uqthuC/s8R8NmIo/q0D4fsGIP5AhJ
         DIN2axARS1COJ1lDmf7krZt+gEpjBWTLrK86dNxztCVWBvtFgqVEnC7AGJt7fjcwTNI9
         gBzkY+JVt0ecJd1agix8ppp0GHh1egZPtI6Zw+EkzHiphsC/sB16XPJw6v6oj7bvS0vu
         SwkjSP9K5H7ZMoOz2ltXh+lJHduQpzlk+yrt3Rbwdr4XOS5C/qVi5zxbMDMTF/jKFLzW
         aMsg==
X-Gm-Message-State: ALoCoQlH0XEUoTDZzv73rJsmsnHYE+DJeA58eDWE5xyH25+8NIX1/CKSoyfVpHt+lqKE3qT4dLIb
X-Received: by 10.202.181.11 with SMTP id e11mr34497301oif.107.1436892393470;
        Tue, 14 Jul 2015 09:46:33 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id y131sm741436oig.28.2015.07.14.09.46.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 09:46:32 -0700 (PDT)
Subject: [PATCH v2 2/8] MIPS: Remove "weak" from platform_maar_init()
 declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2015 11:46:29 -0500
Message-ID: <20150714164629.1541.26450.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

Weak header file declarations are error-prone because they make every
definition weak, and the linker chooses one based on link order (see
10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
decl")).

platform_maar_init() is defined in:

  - arch/mips/mm/init.c (where it is marked "weak")
  - arch/mips/mti-malta/malta-memory.c (without annotation)

The "weak" attribute on the platform_maar_init() extern declaration applies
to the platform-specific definition in arch/mips/mti-malta/malta-memory.c,
so both definitions are weak, and which one we get depends on link order.

Remove the "weak" attribute from the declaration.  That makes the malta
definition strong, so it will always be preferred if it is present.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/include/asm/maar.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/maar.h b/arch/mips/include/asm/maar.h
index 6c62b0f..b02891f 100644
--- a/arch/mips/include/asm/maar.h
+++ b/arch/mips/include/asm/maar.h
@@ -26,7 +26,7 @@
  *
  * Return:	The number of MAAR pairs configured.
  */
-unsigned __weak platform_maar_init(unsigned num_pairs);
+unsigned platform_maar_init(unsigned num_pairs);
 
 /**
  * write_maar_pair() - write to a pair of MAARs
