Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:08:41 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36730 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbcLSCIAOs5QK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:00 +0100
Received: by mail-lf0-f67.google.com with SMTP id o20so6141330lfg.3;
        Sun, 18 Dec 2016 18:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GqY+x7+Rg+la2U5DE3HGjsQDbY4L1+TIwDas+e9x1Bo=;
        b=kAWvphY0diurcDYlwya8SzQcDMn8ZMi9L+FqMAyXmvK8R7GmhtD9SvC9WTDLt/iVvc
         YZssZdzlWgDVLISQCP4csCL/syzJRxqAmeJRpnRmcTyHWgVA5blf0ts7mAFQrGBZMOnw
         U2sa7nJmtT/C7/bHjrFGqZqR747yjD7WJtejASRQnh85Rp4GhJtq654M7/DoFQZUfkZ9
         p5NQ8rqtDXt2ypY4sFkoAN1yU7SHLyW9S3v7ZNm90o4nyuZOU2x+BfcWt8ALhVl09rPB
         0YPr4GsiF5hrx+DEmqRk15x/BfKX6HYB2oQRdeXmz7Qp4wHMu1TL9RAlQJXIpWFWroHg
         +XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GqY+x7+Rg+la2U5DE3HGjsQDbY4L1+TIwDas+e9x1Bo=;
        b=GMIqpQUtgP7ctBuhPkpFbyI/8r1TV0HscFgI4BJSB0QJETEq1BMbcOjAbom271pq13
         L7RE67FWOz6CE42Qt8BjL/Fl8gTLU1DPp8CepGOX6JcCt4As5HdFrABTIqSh6iyBuhZO
         BiEPYbmk/cw7k3TKITDf/hcXnsTQCFOc1sbJSsiXi070Ecn4XXFveP3fUxo0P+qH/OaW
         3Q/Qv/JqJq6KYX2bmBzIm6owGl2TA8sKSaXPHUfErX76hbimLJMR88EYItFJtn8f1/Uw
         Hciaub82/oLlMb/03tVsBPHCGHFmhrjmou0nJEaTvF37oPsz68fFSsdL5Ba87Ns4eooU
         6lXg==
X-Gm-Message-State: AIkVDXILvewSSYhEwZ6ZahPmR4DuYk32ehr3TOfRwKNmw6FTAgoAPxu48u7PiG4YltYuBw==
X-Received: by 10.46.7.26 with SMTP id 26mr6346022ljh.18.1482113273250;
        Sun, 18 Dec 2016 18:07:53 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:07:52 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 00/21] MIPS memblock: Remove bootmem code and switch to NO_BOOTMEM
Date:   Mon, 19 Dec 2016 05:07:25 +0300
Message-Id: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Most of the modern platforms supported by linux kernel have already
been cleaned up of old bootmem allocator by moving to nobootmem
interface wrapping up the memblock. This patchset is the first
attempt to do the similar improvement for MIPS for UMA systems
only.

Even though the porting was performed as much careful as possible
there still might be problem with support of some platforms,
especially Loonson3 or SGI IP27, which perform early memory manager
initialization by their self.

The patchset is split so individual patch being consistent in
functional and buildable ways. But the MIPS early memory manager
will work correctly only either with or without the whole set being
applied. For the same reason a reviewer should not pay much attention
to methods bootmem_init(), arch_mem_init(), paging_init() and
mem_init() until they are fully refactored.

The patchset is applied on top of kernel v4.9.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Serge Semin (21):
  MIPS memblock: Unpin dts memblock sanity check method
  MIPS memblock: Add dts mem and reserved-mem callbacks
  MIPS memblock: Alter traditional add_memory_region() method
  MIPS memblock: Alter user-defined memory parameter parser
  MIPS memblock: Alter initrd memory reservation method
  MIPS memblock: Alter kexec-crashkernel parameters parser
  MIPS memblock: Alter elfcorehdr parameters parser
  MIPS memblock: Move kernel parameters parser into individual method
  MIPS memblock: Move kernel memory reservation to individual method
  MIPS memblock: Discard bootmem allocator initialization
  MIPS memblock: Add memblock sanity check method
  MIPS memblock: Add memblock print outs in debug
  MIPS memblock: Add memblock allocator initialization
  MIPS memblock: Alter IO resources initialization method
  MIPS memblock: Alter weakened MAAR initialization method
  MIPS memblock: Alter paging initialization method
  MIPS memblock: Alter high memory freeing method
  MIPS memblock: Slightly improve buddy allocator init method
  MIPS memblock: Add print out method of kernel virtual memory layout
  MIPS memblock: Add free low memory test method call
  MIPS memblock: Deactivate old bootmem allocator

 arch/mips/Kconfig        |   2 +-
 arch/mips/kernel/prom.c  |  32 +-
 arch/mips/kernel/setup.c | 958 +++++++++++++++--------------
 arch/mips/mm/init.c      | 234 ++++---
 drivers/of/fdt.c         |  47 +-
 include/linux/of_fdt.h   |   1 +
 6 files changed, 739 insertions(+), 535 deletions(-)

-- 
2.6.6
