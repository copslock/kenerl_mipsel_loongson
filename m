Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 14:08:12 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:54381 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012281AbaJ3NILUJfmH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 14:08:11 +0100
Received: by mail-pa0-f43.google.com with SMTP id eu11so5449168pac.30
        for <multiple recipients>; Thu, 30 Oct 2014 06:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ux9guzWxQs/Z4opqf93BDoOVxXHmgvNbsSYY5EoKwJA=;
        b=SvXx/SegKsVGe6eo547onaXRp2NULSPEveumn9uf0aAD0+iy5GWgGz5/t3xTy+qcpc
         +6ESP+yJyJzg9KnntBLgP4HsoYoT7XrSQwPqbqYVlsiFtaD98wfAFr+U/CB7/j0yAh4b
         7XVksdmDwNZUJr1s7wszoPrFBJBlDf9gTBg3eF48pFuLgX2WRwRQH9nrComgh7XWYvzj
         XOEhvxUWHB9GPqUDINWdQcRMuY2UM/zvE4X2Ni8j0IebSTwTiz2xYBOejgbh2d6kS/vD
         9X9kJskwXiIZ/h+SCb8BJneFzESX8WcTDdppgBdvDk62Pf5d7vTHoikR6abiwV/FkB5w
         FZHQ==
X-Received: by 10.70.42.175 with SMTP id p15mr17279681pdl.53.1414674484659;
        Thu, 30 Oct 2014 06:08:04 -0700 (PDT)
Received: from localhost.localdomain (p76ecb424.tokynt01.ap.so-net.ne.jp. [118.236.180.36])
        by mx.google.com with ESMTPSA id gy10sm4284525pbd.67.2014.10.30.06.08.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Oct 2014 06:08:03 -0700 (PDT)
From:   Isamu Mogi <isamu@leafytree.jp>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        isamu@leafytree.jp
Subject: [PATCH v2 0/3] MIPS: R3000: Fix debug output for Virtual page number
Date:   Thu, 30 Oct 2014 22:07:35 +0900
Message-Id: <1414674458-7583-1-git-send-email-isamu@leafytree.jp>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1410278429-8541-1-git-send-email-isamu@leafytree.jp>
References: <1410278429-8541-1-git-send-email-isamu@leafytree.jp>
Return-Path: <wiz.saturday@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: isamu@leafytree.jp
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

This patch set fixes the bit mask for MIPS R3000's virtual page number in
debug output. Also replace magic numbers with macros to decrease the
likelihood of issues like this.

Changes in v2:
- Replace magic numbers with macros
- Remove redundant parentheses

Isamu Mogi (3):
  MIPS: R3000: Fix debug output for Virtual page number
  MIPS: R3000: Replace magic numbers with macros
  MIPS: R3000: Remove redundant parentheses

 arch/mips/lib/r3k_dump_tlb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
1.9.1
