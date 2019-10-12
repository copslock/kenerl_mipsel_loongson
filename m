Return-Path: <SRS0=/R1U=YF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DA9C4360C
	for <linux-mips@archiver.kernel.org>; Sat, 12 Oct 2019 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18932089C
	for <linux-mips@archiver.kernel.org>; Sat, 12 Oct 2019 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570916421;
	bh=RzIx90IBbDuPyuMPrO3q5qTEqSZJZGhkVSO4b7V3dDQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0Aib+SqnLa4N0ziPN/9T9o4IeHgnnyx7SDLMRhySiiZTHdzCMBlt1T8hTnVsCtSYB
	 jW7ywi4jSxHRCrivuGQ1ullcTxpDizYNSNUCsJqeopCmS9e11lZEnl9Q8tUb29q+yZ
	 wRImMvP7eHhGl3L7LIIeKL76vECnie2sYwhW34Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfJLVkP (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 12 Oct 2019 17:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729655AbfJLVkH (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 12 Oct 2019 17:40:07 -0400
Subject: Re: [GIT PULL] MIPS fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570916406;
        bh=RzIx90IBbDuPyuMPrO3q5qTEqSZJZGhkVSO4b7V3dDQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uBiHDTqWw83We/TQnLuC4VBiK2ZjTQM1Fkw48yXpvUerZhoFQGxEab2te72alFOsV
         Y8AIaOqwWHoTpcS/Hf+FwxUDIBFN9TIHqzATr4EHfv48LMsXYenLgKU5fka9DbeUka
         8fBJ3HDgjC5sD39MP734frjHupXJB/RAnHwfKbMw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012190412.vaazxi325tjnab2d@pburton-laptop>
References: <20191012190412.vaazxi325tjnab2d@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012190412.vaazxi325tjnab2d@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.4_2
X-PR-Tracked-Commit-Id: 2f2b4fd674cadd8c6b40eb629e140a14db4068fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63f9bff56beb718ac0a2eb8398a98220b1e119dc
Message-Id: <157091640655.3377.15157832582232701820.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 21:40:06 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 19:04:14 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.4_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63f9bff56beb718ac0a2eb8398a98220b1e119dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
