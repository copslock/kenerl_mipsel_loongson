Return-Path: <SRS0=mRU9=ZS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997D7C43215
	for <linux-mips@archiver.kernel.org>; Tue, 26 Nov 2019 02:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768D320835
	for <linux-mips@archiver.kernel.org>; Tue, 26 Nov 2019 02:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574734515;
	bh=SApbGo6e96+2wQYt1zE6K9i+7pXHLPxq5o0VdFgTegs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kciPh1njp6ug+WBEfjjKHg6KVFWv2gHxkj23T2oqGebwin5fBP3ueY0VrHDpnkWk3
	 9IHGF4M0jmiR/5pvR6YdwEQ12GPQokVVpnFIvvcTlqVslrUdPdT6xgtaLdwDq5xyqJ
	 B0b1preTw5YW71B+cOduu210Fr67yppf2dBb1wNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfKZCPO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Nov 2019 21:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbfKZCPN (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:13 -0500
Subject: Re: [GIT PULL] MIPS changes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734512;
        bh=SApbGo6e96+2wQYt1zE6K9i+7pXHLPxq5o0VdFgTegs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pOKW6osv7PjGUQfW0ZiMfOIF89F2km5TWtOQFs5XyuIMfLYrxV4phAoycNOTU2fxe
         N3x4+RflBNltTYp+HZtfRlBVDTtWc5UZfdZhcIEhGHS9Xt+Pacg6Uf5R8Cum6QuvqY
         ohpBzPW8nI7E8heZyVPO6G/04Oe7B7G5UcT4h/cg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125194535.nh6762uusyhz7jtn@pburton-laptop>
References: <20191125194535.nh6762uusyhz7jtn@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125194535.nh6762uusyhz7jtn@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.5
X-PR-Tracked-Commit-Id: a8d0f11ee50ddbd9f243c7a8b1a393a4f23ba093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2981dcf333b37e3753b5c1b5814418c4de1a8e34
Message-Id: <157473451258.11733.2305117261489169794.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:12 +0000
To:     Paul Burton <paulburton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 11:45:35 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2981dcf333b37e3753b5c1b5814418c4de1a8e34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
