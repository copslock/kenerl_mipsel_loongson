Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 01:33:36 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57368 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009221AbaLTAdR2xHos (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 01:33:17 +0100
Received: by mail-ie0-f169.google.com with SMTP id y20so1712178ier.14;
        Fri, 19 Dec 2014 16:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/jJBxST447Aphw7wTZIVwmgoXmr5I5OEswDb6idBGLg=;
        b=wpW6NNmYBRgNCbSlKTgwbRnkIU1/7rEktF+AE4LLIvuWsMke7/Fy8s7A43RYahdIMF
         nnHJg0aWsZB4v6N1bSVCfXPW4NsA1A80qDFrkMY8cvUv37qEA6XfcgaVeY0SJjYad0dT
         eYlPGEtAkOUp9iVQo435JcPa4dWdu1+Te/CQXBqDJ/TxtT26tFBmabDt3xRMRklEaFPv
         iXCCRd+5qj+LSIn3xNKoY2yM0Bbx5KVCjzOgeuZKaVLaEXl2WqlBAbgOvuZKQy89bfP1
         AmMgciw2Uf+u2aFZNya30GhWUfOxC3bHGQ3AWWVUz+dyTXW9hN8XGQlbGKkBp70SP8LG
         2ewg==
X-Received: by 10.107.166.149 with SMTP id p143mr10571710ioe.16.1419035591382;
        Fri, 19 Dec 2014 16:33:11 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id n4sm1610744igr.15.2014.12.19.16.33.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 16:33:10 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sBK0X9IR021708;
        Fri, 19 Dec 2014 16:33:09 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sBK0X8AD021705;
        Fri, 19 Dec 2014 16:33:08 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] Revert broken C0_Pagegrain[PG_IEC] support.
Date:   Fri, 19 Dec 2014 16:33:03 -0800
Message-Id: <1419035585-21671-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The two patches reverted here break eXecute-Inhibit (XI) memory
protection support.  Before the patches we get SIGSEGV when attempting
to execute in non-executable memory, after the patches we loop forever
in handle_tlbl.

It is probably possible to make C0_Pagegrain[PG_IEC] work, but I think
the most prudent thing is to revert these patches, and then only reapply
something that works after it has been well tested.

David Daney (2):
  Revert "MIPS: Use dedicated exception handler if CPU supports RI/XI
    exceptions"
  Revert "MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions"

 arch/mips/include/asm/mipsregs.h | 1 -
 arch/mips/kernel/cpu-probe.c     | 9 ---------
 arch/mips/kernel/traps.c         | 7 -------
 arch/mips/mm/tlbex.c             | 4 ++--
 4 files changed, 2 insertions(+), 19 deletions(-)

-- 
1.7.11.7
