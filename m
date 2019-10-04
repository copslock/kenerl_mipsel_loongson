Return-Path: <SRS0=VyqI=X5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA6EC47404
	for <linux-mips@archiver.kernel.org>; Fri,  4 Oct 2019 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9700215EA
	for <linux-mips@archiver.kernel.org>; Fri,  4 Oct 2019 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570221623;
	bh=259Ve+LRjZTkhpGbKGsJl+bKOi+aprZi6e8rerQKBMo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=htA9lb28Dt8gjW5a3SLJHgSYcb9SXeypp/gqQspbkl2FsrRUjh1NavtEb+RUARm+B
	 MIaZfOXUsfr5Bn733Sv6ksT+IkVmoJlYMzEn+ammkGpZz0vGT4B8NTYqj01Mb6dsJc
	 gzObPqKtS0NhKbBexl9VXrAAWGkW4MOVvewI1GdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbfJDUkT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388342AbfJDUkO (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 4 Oct 2019 16:40:14 -0400
Subject: Re: [GIT PULL] MIPS fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570221613;
        bh=259Ve+LRjZTkhpGbKGsJl+bKOi+aprZi6e8rerQKBMo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pQuwav/aRRIb6HNNu4v8vgWHpjFlwQVJG2FgVIXjPtlQ/QNGLbUl+r1nqJlQLQyDY
         agFUEScp6fzcUoI2TUJE/le1BlKmAdGuwvIhQwpe4AauAkDuA7/5fL5STOepqY+a6p
         wm2jc3cQK9c9U9ufX9pAu4aA13Vov0J10H8oGtbo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191004200527.7ydsrszuqim6h645@pburton-laptop>
References: <20191004200527.7ydsrszuqim6h645@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191004200527.7ydsrszuqim6h645@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.4_1
X-PR-Tracked-Commit-Id: 6822c29ddbbdeafd8d1b79ebe6c51b83efd55ae1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ea655343ce4180fe9b2c7ec8cb8ef9884a47901
Message-Id: <157022161349.19958.17033670105540888276.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Oct 2019 20:40:13 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The pull request you sent on Fri, 4 Oct 2019 20:05:28 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.4_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ea655343ce4180fe9b2c7ec8cb8ef9884a47901

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
