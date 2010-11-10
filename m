Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Nov 2010 14:48:48 +0100 (CET)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:37991 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491176Ab0KJNsp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Nov 2010 14:48:45 +0100
Received: by pvg7 with SMTP id 7so109394pvg.36
        for <multiple recipients>; Wed, 10 Nov 2010 05:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=bnt5TvfQOHxa0HWfo/uAGtTvLyFjh+MVqX6p0s1X3GM=;
        b=kIMK3o9Zmuk73KN8F0U68n54Blp9gdZ5/rUcL3ktlqLxApivxj8bbLD8EWY0LecLLX
         kE9bmlHtM5K7Kw5ijiIPy8SFHeYGTSQUtGGUiDPfOgLOB04qcFTZurForD4oChxTfgjq
         8YLzxLCtHGh/EFmQAdE4Z2OkRUltSrZtS6r2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=R+SMkiZvdQEoRP5kuN+dpgvFaQy/QLJANkP89N07IVHgMmPaPwYeeSeVLTybL3dO0S
         unweTcNiR2JP88Rl6cjYxxAE8A9/4uan4ND0DOa+0iAK/xlWZGMTXoP/8gsknkIFdnEn
         Nol9gtSO7X/LQa7HQEU7eJsG0eIm46K3Efkzw=
Received: by 10.143.44.1 with SMTP id w1mr6658769wfj.447.1289396918101;
        Wed, 10 Nov 2010 05:48:38 -0800 (PST)
Received: from metis (220-138-164-213.dynamic.hinet.net [220.138.164.213])
        by mx.google.com with ESMTPS id v19sm878017wfh.0.2010.11.10.05.48.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 05:48:35 -0800 (PST)
Date:   Wed, 10 Nov 2010 21:48:15 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH v2] MIPS: Separate two consecutive loads in memset.S
Message-ID: <20101110134815.GA28312@metis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
Precedence: bulk
X-list: linux-mips

partial_fixup is used in noreorder block.

Separating two consecutive loads can save one cycle on processors with
GPR intrelock and can fix load-use on processors that need a load delay slot.

Also do so for fwd_fixup.

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/lib/memset.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 77dc3b2..606c8a9 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -161,16 +161,16 @@ FEXPORT(__bzero)
 
 .Lfwd_fixup:
 	PTR_L		t0, TI_TASK($28)
-	LONG_L		t0, THREAD_BUADDR(t0)
 	andi		a2, 0x3f
+	LONG_L		t0, THREAD_BUADDR(t0)
 	LONG_ADDU	a2, t1
 	jr		ra
 	 LONG_SUBU	a2, t0
 
 .Lpartial_fixup:
 	PTR_L		t0, TI_TASK($28)
-	LONG_L		t0, THREAD_BUADDR(t0)
 	andi		a2, LONGMASK
+	LONG_L		t0, THREAD_BUADDR(t0)
 	LONG_ADDU	a2, t1
 	jr		ra
 	 LONG_SUBU	a2, t0
-- 
1.7.1
