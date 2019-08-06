Return-Path: <SRS0=xXK6=WC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A235C31E40
	for <linux-mips@archiver.kernel.org>; Tue,  6 Aug 2019 21:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD052173C
	for <linux-mips@archiver.kernel.org>; Tue,  6 Aug 2019 21:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565126115;
	bh=XQ/t2SiIzqQevAjIV1jZt+CRddJP9K0PErPscXN7u3M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=K6cfHBtJKjAohHYF/Xz4G3wwIy5G6QHLvws1FL2mftSqqSD/LOlxFGfBuB/OusHmL
	 V6xBmwD92gUBF1B2rlSJI58BAFCyrrVwTTYfhY8P6iR6h+JDCPZk4xcquwCYsWdHiG
	 CjvlaBynLB/neQO6As3IrOpuH+PVp7Qu+YdixIdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfHFVPM (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfHFVPL (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 6 Aug 2019 17:15:11 -0400
Subject: Re: [GIT PULL] MIPS fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565126110;
        bh=XQ/t2SiIzqQevAjIV1jZt+CRddJP9K0PErPscXN7u3M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wK0N1fr9SySm8lQhPoXLQk1GkbRYtqjatCorHOMHQndphrz5jlwWqDbFB+BWTHCzD
         NLcNyhMx9gyZ9KjR1e3bBEaTUci8ZXWtzrGNWdb/OvFE7jk3ueanNcrqPokothRGat
         I+NRa1PW+W2RaLnFtecpyQ5GLP7mxsmX1SIVM728=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190806192315.y2faix6zk5igs2ry@pburton-laptop>
References: <20190806192315.y2faix6zk5igs2ry@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190806192315.y2faix6zk5igs2ry@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.3_1
X-PR-Tracked-Commit-Id: 74034a09267c1f48d5ce7ae4c4a317fac7d43418
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76d7961ff4ee02cc70365600a52fb59ca544dc7c
Message-Id: <156512611045.6604.9076200938283634387.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Aug 2019 21:15:10 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The pull request you sent on Tue, 6 Aug 2019 19:23:16 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.3_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76d7961ff4ee02cc70365600a52fb59ca544dc7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
