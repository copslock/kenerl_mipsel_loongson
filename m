Return-Path: <SRS0=erdp=SM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A82C10F0E
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 02:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4246C21741
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554863408;
	bh=GaXQjknMz+qy5uDsU8knzeQ8Oqx3Tq2MI4Zoar43RTs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=L9VYL/oQqZNLLCXsrCWyqVho470Liya0LFO0+89iA+hIz5/JLbGf6MgjkvQk+xChY
	 UY37T9NWU02PX8vRJY9n5bwAXW1pD1NfFUOml2nJKl5UaxDLZnr+noKPpt1z6xk1Ok
	 OjAyeeaf2nLTdY5vtqDqXSWDjgW8GgMa4slm337E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfDJCaH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfDJCaH (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 9 Apr 2019 22:30:07 -0400
Subject: Re: [GIT PULL] MIPS fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554863406;
        bh=GaXQjknMz+qy5uDsU8knzeQ8Oqx3Tq2MI4Zoar43RTs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q7dECZHAvp0lpVuwnabguoYKIDKNBycs1WfJq2TUD/7WV2pRd7w9JcaTd/bdBTcy2
         A6HdCiQUSJLTZUQdzYhJwEE61i5k/o6ESym3lhpWWhdwCF2wZrdCEGg1n1w8vYZCpa
         vl7XDlOuwYgCRMvOmDi38h2M1vfZxIGkkDVQEQ4k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190409232635.qvqzhqtixbjxal4j@pburton-laptop>
References: <20190409232635.qvqzhqtixbjxal4j@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190409232635.qvqzhqtixbjxal4j@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.1_2
X-PR-Tracked-Commit-Id: 6e3572e83dc3563e3b7e742bcb225b42a60cdaeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ee7fb36f988539f52f83ce6048d696bd540066f
Message-Id: <155486340681.26187.13562560966056233170.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Apr 2019 02:30:06 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The pull request you sent on Tue, 9 Apr 2019 23:26:36 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.1_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ee7fb36f988539f52f83ce6048d696bd540066f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
