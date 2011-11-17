Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 22:58:44 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:60728 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904062Ab1KQV5p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 22:57:45 +0100
Received: by ywp31 with SMTP id 31so2058695ywp.36
        for <multiple recipients>; Thu, 17 Nov 2011 13:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9SygXBUvPvjSrlXWSL0dCXpsSu487AgLdEB/jJnxd+E=;
        b=m1J3NBciPDTDzrf746S9cvpXVYaeP4LvOIvJ/11ML8kOls3ZYX7RjdI9XJ7Z7HUtNZ
         JSHyy86Fl7f8xbrWW0GFVyYwqCGBqMVb3c/nBaUn4vN9TMYXEQ6B86Ok6RG1diOAaBOf
         GQZ74cf69BQqu4yn3sQgCTBgbhtsqyAe48W+I=
Received: by 10.236.136.38 with SMTP id v26mr648975yhi.69.1321567057666;
        Thu, 17 Nov 2011 13:57:37 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id f14sm5332474ani.8.2011.11.17.13.57.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 13:57:36 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAHLvYwY013240;
        Thu, 17 Nov 2011 13:57:34 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAHLvWoJ013230;
        Thu, 17 Nov 2011 13:57:32 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH v2 0/2] Dummy HPAGE_* constants for !CONFIG_HUGETLB_PAGE
Date:   Thu, 17 Nov 2011 13:57:28 -0800
Message-Id: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14864

From: David Daney <david.daney@cavium.com>

After a, somewhat heated, discussion with David Rientjes, I think the
following approach will work.

The first patch adds HPAGE_SHIFT, needed by MIPS.

The second cleans up the exiting HPAGE_MASK and HPAGE_SIZE

David Daney (2):
  hugetlb: Provide a default HPAGE_SHIFT if !CONFIG_HUGETLB_PAGE
  hugetlb: Provide safer dummy values for HPAGE_MASK and HPAGE_SIZE

 include/linux/hugetlb.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Cc: David Rientjes <rientjes@google.com>
-- 
1.7.2.3
