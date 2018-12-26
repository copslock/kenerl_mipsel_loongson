Return-Path: <SRS0=uWOb=PD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27237C43387
	for <linux-mips@archiver.kernel.org>; Wed, 26 Dec 2018 19:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E767A20C01
	for <linux-mips@archiver.kernel.org>; Wed, 26 Dec 2018 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545852049;
	bh=3GKib+kiZ6Kg9/s7Fjj6yR0DGl5iruVTcaEE2mE5gj8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T6rveFYXL2CtKGsN8nZj4TVmXZYOlsMOof479CGR94U+Mtw6X5Yg1N3+0i1pKlq+G
	 R8DarJ2VjOTXlr37OrERjYddSHCjQ27thKYa8gSxzy8SAg6pcLhYw/aC1JPpgeYTmk
	 Vos98xhQqAX9olUtoB3VOd8+xi/PAcMQSvcRtAjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeLZTUE (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbeLZTUE (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 26 Dec 2018 14:20:04 -0500
Subject: Re: [GIT PULL] Main MIPS pull for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545852003;
        bh=3GKib+kiZ6Kg9/s7Fjj6yR0DGl5iruVTcaEE2mE5gj8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iYEKAKtfxUQjPrwCKDpLy7Ry60jFiQR1tE7cg2yP9OHHCkKE49enpAy0l+MB0I2qF
         ZHf+o/o+ImGLQNQbbYeM/kwukZmTScg25ueerJKEN/mEmbE8FtxMOvaiAMoh8N74N/
         YtMSoquLeDxyY75fcKXDzcLA754ggLva08OiGGak=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181223162426.36uer6mzf2o3xkya@pburton-laptop>
References: <20181223162426.36uer6mzf2o3xkya@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181223162426.36uer6mzf2o3xkya@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_4.21
X-PR-Tracked-Commit-Id: adcc81f148d733b7e8e641300c5590a2cdc13bf3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89261c57021352045c4af24522c6854c9ee90139
Message-Id: <20181226192003.20075.32056.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 19:20:03 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The pull request you sent on Sun, 23 Dec 2018 16:24:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89261c57021352045c4af24522c6854c9ee90139

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
