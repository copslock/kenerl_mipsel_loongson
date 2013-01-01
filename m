Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jan 2013 10:23:56 +0100 (CET)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:63250 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815858Ab3AAJXyY5mP5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jan 2013 10:23:54 +0100
Received: by mail-wg0-f49.google.com with SMTP id 15so5898130wgd.28
        for <multiple recipients>; Tue, 01 Jan 2013 01:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=KResWqwBYFV8OI+rN34d2Zyu16NSfjuhNhpYdMfilOc=;
        b=Z5VorQUmyend4B2yYshIFaJrtuVikHkVyi/7PTE+v1jxPdpz547uIQx/tr1AUAYFZQ
         Bm0+uoYlB1cX9l5HKWzIroRrs20Bq6sCigF48wUY27kAZC7CvINUHIAt5MYYjGSaOnTd
         0OhB8C04hUDr8tPYpiWIhyCFV0YnKalGMpbB53cO61WPrYaUbeNuUs7odJ59d8DziF6m
         YxLu/Yt52e/Nzypp06RPEZDLpnTWORKLcxMSTAwG4wM3esa47k+Gi9pAEzNZpqPhgmAd
         X5HfGe76vf1Hsn8ZGW6B3Jum2s+Al6+t2mIyERnyBG9cWhtQ2XPHexWjikoEjx5ySoap
         +EQg==
X-Received: by 10.194.235.6 with SMTP id ui6mr68052077wjc.12.1357032228807;
        Tue, 01 Jan 2013 01:23:48 -0800 (PST)
Received: from pixies.home.jungo.com (212-150-239-254.bb.netvision.net.il. [212.150.239.254])
        by mx.google.com with ESMTPS id bd6sm48237324wib.10.2013.01.01.01.23.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2013 01:23:47 -0800 (PST)
Date:   Tue, 1 Jan 2013 11:23:40 +0200
From:   Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Regarding commit a16dad7 [MIPS: Fix potencial corruption]
Message-ID: <20130101112340.0a0e8c08@pixies.home.jungo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 35352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shmulik.ladkani@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

Commit a16dad77 (MIPS: Fix potencial corruption) seems as a revert
of a8ca8b64 (MIPS: Avoid destructive invalidation on partial cachelines).

Snip of a16dad77:

@@ -643,9 +640,6 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 			 * hit ops with insufficient alignment.  Solved by
 			 * aligning the address to cache line size.
 			 */
-			cache_op(Hit_Writeback_Inv_SD, addr & almask);
-			cache_op(Hit_Writeback_Inv_SD,
-				 (addr + size - 1) & almask);


However,

(1)
The comment above the removed 'cache_op' instructions, which was
originally added as part of a8ca8b64, was not reverted, and now looks
out-of-context.

Any reason to keep the comment? If not, I'll submit a patch removing it.

(2)
Following a8ca8b64, another commit was submitted, adding similar
'cache_op' instructions to 'mips_sc_inv' - namely 96983ffe
(MIPS: MIPSxx SC: Avoid destructive invalidation on partial L2 cachelines).

Its purpose was to extend a8ca8b64, aligning behavior of 'mips_sc_inv'
to be similar to 'r4k_dma_cache_inv'.

Since the explicit 'cache_op' instrcutions are now removed from
'r4k_dma_cache_inv' (as of a16dad77), it probably makes sense to remove
them from 'mips_sc_inv' as well.

Any reason to keep these 'cache_op's? If not, I'll submit a patch.

Regards,
Shmulik
