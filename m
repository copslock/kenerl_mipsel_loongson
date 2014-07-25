Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2014 21:44:23 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:51701 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842577AbaGYToSH719s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2014 21:44:18 +0200
Received: by mail-la0-f54.google.com with SMTP id el20so3460332lab.27
        for <linux-mips@linux-mips.org>; Fri, 25 Jul 2014 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7NasbA2Ui75u75YX7S6N26b3q7Cm/XkVM2yG4j+XPFc=;
        b=OaWQP52vz6VvYUk3YFyavQPhunZTQXbd2ZZrhEVs6y9Gl0ycgIuomdVYV15OwawFqN
         3mEhn7Et1M+d+Ifs3z4sfPs1qZjVoa3jh+WzqJXdHcSA4w+F5x3XwETbvQ1+w5eu/K25
         ZG2pB4wPoCHf/IWWy9hn58DtjPDUUI0gvFQf/UgCc7jMJn9j+j6qlGfhiAIzWn0J6AbI
         qOsi1rJJOqMxcz/OhpXZPZzLba3NwQnPOAbipwJUIQ8d0pjnPnWi0/GW2kyCs4Ic4C2S
         IfLBpc56Q6/QITXOP4Yd6m+PF0jNxNbuPcoowcMX0BPP8wbNyCw/qJkTPrY25ikcJ4Yt
         FDEQ==
X-Received: by 10.112.24.167 with SMTP id v7mr17361657lbf.19.1406317452540;
        Fri, 25 Jul 2014 12:44:12 -0700 (PDT)
Received: from octofox.metropolis ([5.18.160.1])
        by mx.google.com with ESMTPSA id oy1sm17315261lbb.4.2014.07.25.12.44.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jul 2014 12:44:11 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Steven Hill <Steven.Hill@imgtec.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 0/2] mm/highmem: make kmap cache coloring aware
Date:   Fri, 25 Jul 2014 23:43:45 +0400
Message-Id: <1406317427-10215-1-git-send-email-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 1.8.1.4
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

Hi,

this series adds mapping color control to the generic kmap code, allowing
architectures with aliasing VIPT cache to use high memory. There's also
use example of this new interface by xtensa.

Max Filippov (2):
  mm/highmem: make kmap cache coloring aware
  xtensa: support aliasing cache in kmap

 arch/xtensa/include/asm/highmem.h | 40 +++++++++++++++++-
 arch/xtensa/mm/highmem.c          | 18 ++++++++
 mm/highmem.c                      | 89 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 134 insertions(+), 13 deletions(-)

-- 
1.8.1.4
