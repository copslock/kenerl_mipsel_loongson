Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jul 2009 18:41:47 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:55225 "EHLO
	mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492482AbZGCQll (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Jul 2009 18:41:41 +0200
Received: by pzk3 with SMTP id 3so2307965pzk.22
        for <multiple recipients>; Fri, 03 Jul 2009 09:35:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=cVvvJOL79N88fLDAaOfTiJGKfc0J56b2N+T5gu1fUxM=;
        b=DwNvfO/jf79v19bLTgXQaEvsyzm4GduelJoXOxNWPgMiG6ZS2bsfrWqvUC9MCxKWRb
         PM4DlBp7ont/iWmUSs64rwpTsG5tSALIjGKbnNygbr21ie710CDzZ6SeI4Nd1bd+WG/H
         D7Uir25GwzIGW6DeKOpcGyPnu/Mtw974LR0g0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=oGFBG5K1OaZ3B0RrW3MPsKsHWBYbrvCaUdzIYThKiiidsN71efuGxc1Pw/0Lki2KMr
         hMTtbB3ZzKR5rfI0kIO93gTZRcrU2gc8u5NGKxx0uGf8RvziONHob1HdfhVOThdqRYqC
         FJgJkoDwYfrMFHKm3pErHIu8XJTFbgcFwpzrE=
Received: by 10.140.208.16 with SMTP id f16mr1188054rvg.263.1246638930966;
        Fri, 03 Jul 2009 09:35:30 -0700 (PDT)
Received: from localhost.localdomain (p11179-adsao01yokonib1-acca.kanagawa.ocn.ne.jp [61.199.5.179])
        by mx.google.com with ESMTPS id g22sm16879315rvb.25.2009.07.03.09.35.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Jul 2009 09:35:29 -0700 (PDT)
Date:	Sat, 4 Jul 2009 01:33:09 +0900
From:	Akinobu Mita <akinobu.mita@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] mips: drop mmap_sem in pagefault oom path
Message-ID: <20090703163307.GA25268@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <akinobu.mita@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akinobu.mita@gmail.com
Precedence: bulk
X-list: linux-mips

Fix the pagefault oom path which does not drop mm->mmap_sem.
This was introduced by commit c7c1e3846bac1e4b8a8941f6a194812e28b0a519
(This is not compile tested)

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 arch/mips/mm/fault.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 6751ce9..f956ecb 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -171,6 +171,7 @@ out_of_memory:
 	 * We ran out of memory, call the OOM killer, and return the userspace
 	 * (which will retry the fault, or kill us if we got oom-killed).
 	 */
+	up_read(&mm->mmap_sem);
 	pagefault_out_of_memory();
 	return;
 
-- 
1.6.0.6
