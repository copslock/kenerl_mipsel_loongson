Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 May 2010 17:39:46 +0200 (CEST)
Received: from pfepb.post.tele.dk ([195.41.46.236]:40168 "EHLO
        pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492085Ab0E3Pjl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 May 2010 17:39:41 +0200
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepb.post.tele.dk (Postfix) with ESMTP id 39301F8404B;
        Sun, 30 May 2010 17:39:39 +0200 (CEST)
Date:   Sun, 30 May 2010 17:39:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH 0/6] mips: diverse Makefile updates
Message-ID: <20100530153939.GA22352@merkur.ravnborg.org>
References: <20100530141939.GA22153@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100530141939.GA22153@merkur.ravnborg.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

> 
> Note: I tried to test a little with bigsur_defconfig
> but get_user() is buggy. Or at least my gcc thinks that
> first argument may be used uninitialized.
> I think mips needs to fix the 64 bit variant of get_user().
> I took a quick look but ran away.

My gcc:
mips-linux-gcc (GCC) 4.1.2
Copyright (C) 2006 Free Software Foundation, Inc.

I downloaded it from:
ftp://ftp.linux-mips.org/pub/linux/mips/people/macro/RPMS/i386/

	Sam
