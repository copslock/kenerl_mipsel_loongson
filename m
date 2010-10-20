Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2010 07:07:04 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:35141 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490983Ab0JTFHB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Oct 2010 07:07:01 +0200
Received: by ywp6 with SMTP id 6so1924472ywp.36
        for <multiple recipients>; Tue, 19 Oct 2010 22:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+qvcZczAG3sC+A/nd89KPOi7X4QYIx60fSmqmM8FUc0=;
        b=IsdoDLvcOpxnyQIMENrIqbEEs3aixBq6qLEm6wF3tlGgpxSmUj2xyF5jYgHHM94GuI
         1dHd+ZiX5KcVsaiGjOJ+08RM3jHabwsD59hhtsLuYI4s2gTkvt1usrdOcSXBYcEryvGQ
         KVt5KQW46FSCzKaKwEOZrh7YgU1H5F7fDj3SY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=R2M8rW8++VHnHaZWvKQCJ304Z8jISBRD5BbxdVw9rlMWXQYk/yOQjUacgLuu9pD81W
         3RHbTJ4gWLgjMvtcH6P0OIuGzhpherLuU5qYrru/qa4Bux4VVkDOmwhfg1cnztNVly8T
         PQtu2clkdHYwXIA3mO4QsUVZpQeFpjBNM8avI=
Received: by 10.150.95.13 with SMTP id s13mr504398ybb.146.1287551214500;
        Tue, 19 Oct 2010 22:06:54 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id v12sm886191ybk.11.2010.10.19.22.06.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 22:06:53 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kevink@paralogos.com
Cc:     eyal@mips.com, dengcheng.zhu@gmail.com
Subject: [PATCH 0/2] MIPS: enable APRP (APSP) and add features
Date:   Wed, 20 Oct 2010 13:10:29 +0800
Message-Id: <1287551431-15737-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

The APRP model makes it possible that one or more CPUs run the Linux
kernel whereas a dedicated CPU runs special real-time or signal processing
program.

This patchset adds the following to the current APRP support:
1. Several bug fixes;
2. Running floating point heavy jobs on the RP side;
3. Waking up RP side read by interrupt;
4. CPS multicore APRP support.

A mp3 player program was ported to run in the APRP (APSP exactly) model.
Considerable performance benefits were observed on the player program.
Since I encountered a sound card support issue on the current linux-mips
kernel, I rebased this patchset onto mti-2.6.29.4-1. And for the current
kernel, I used a simple test program to validate this work.

Deng-Cheng Zhu (2):
  MIPS: fix/enrich 34K APRP (APSP) functionalities
  MIPS: enable CPS multicore APRP (APSP)

 arch/mips/Kconfig                                  |    8 +
 .../include/asm/mach-malta/cpu-feature-overrides.h |    3 +
 arch/mips/include/asm/rtlx.h                       |    3 +
 arch/mips/kernel/kspd.c                            |   26 ++-
 arch/mips/kernel/rtlx.c                            |  153 +++++++++++++--
 arch/mips/kernel/vpe.c                             |  217 +++++++++++++++++++-
 arch/mips/mti-malta/malta-int.c                    |   26 +++-
 7 files changed, 409 insertions(+), 27 deletions(-)
