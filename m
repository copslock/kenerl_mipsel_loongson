Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2010 17:21:41 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:50164 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492241Ab0BZQVM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2010 17:21:12 +0100
Received: by bwz7 with SMTP id 7so214505bwz.24
        for <multiple recipients>; Fri, 26 Feb 2010 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=oDSySC9e9GhIRICoJbosRFf+jY0qNTedDUAgFwkslcc=;
        b=gWFHQGfHbx29L2/qm6xT+ukigvfDSWTfFylIz+K3usZQtLhOehjpuD4u5JM9ypRGy8
         33pW2BkfjLYxafEhvHIBNBIoe3pqN5QUp8sNgEFK3mGQnGD8mYwcY9stY3m/Eyhyhkwh
         GrruHg+B303+AOSUnv1OoZ8jN+hPLuc4sY4/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BRFzOd09mcJRN2e+LBThKjAP1EHNf+ctxhs2ET4NvokHSEcF8XkVXSb683pbG1xzCI
         F1e0XIah3XPn0kAUS4BUFwMHu92Z7SgTocEhTqMvfLxOfbxJ4BXDr95hkRpIalrCRtaZ
         svu9egt6+nz9A1uoQg4cy3o2TmURDmsuG4BJs=
Received: by 10.204.48.197 with SMTP id s5mr418305bkf.177.1267201264076;
        Fri, 26 Feb 2010 08:21:04 -0800 (PST)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 15sm147563bwz.8.2010.02.26.08.21.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 08:21:02 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/2] MIPS: Alchemy: various build fixes
Date:   Fri, 26 Feb 2010 17:22:00 +0100
Message-Id: <1267201322-28069-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The following two patches fix build issues found by Ralf.

I also have a massive third patch (300kb) which updates the
devboard defconfigs to get rid of other build failures (by
switching to the new pcmcia socket driver).  I'm pretty sure I'll
be eaten by the lmo mailer, so how should I proceed?

Manuel Lauss (2):
  MIPS: Alchemy: Repair db1500/bosporus builds
  MIPS: Alchemy: fix Au1100 ethernet build failure

 arch/mips/alchemy/common/platform.c              |   19 ++++----
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   52 ++++++++++++----------
 2 files changed, 38 insertions(+), 33 deletions(-)
