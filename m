Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 May 2010 16:28:08 +0200 (CEST)
Received: from pfepa.post.tele.dk ([195.41.46.235]:42217 "EHLO
        pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492075Ab0E3O2E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 May 2010 16:28:04 +0200
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepa.post.tele.dk (Postfix) with ESMTP id 1A80FA50002;
        Sun, 30 May 2010 16:28:03 +0200 (CEST)
Date:   Sun, 30 May 2010 16:28:03 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 5/6] mips: refactor arch/mips/boot/compressed/Makefile
Message-ID: <20100530142803.GE22281@merkur.ravnborg.org>
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
X-archive-position: 26930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

