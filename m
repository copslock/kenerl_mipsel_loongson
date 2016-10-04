Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2016 01:18:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42388 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992202AbcJDXSLC0SVW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Oct 2016 01:18:11 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u94NIA1N022041;
        Wed, 5 Oct 2016 01:18:10 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u94NI9Ho022040;
        Wed, 5 Oct 2016 01:18:09 +0200
Date:   Wed, 5 Oct 2016 01:18:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: tracing: move insn_has_delay_slot to a shared
 header
Message-ID: <20161004231809.GC14676@linux-mips.org>
References: <1475228026-25831-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475228026-25831-1-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Sep 30, 2016 at 11:33:45AM +0200, Marcin Nowakowski wrote:

> Currently both kprobes and uprobes code have definitions of the
> insn_has_delay_slot method. Move it to a separate header as an inline
> method that each probe-specific method can later use.
> No functional change intended, although the methods slightly varied in
> the constraints they set for the methods - the uprobes one was chosen as
> it is slightly more specific when filtering opcode fields.

Applied - but this is way to big for an inline function and will end up
getting expanded two times in uprobes.c for no good reason.  I think this
function should become go to something like arch/mips/kernel/branch.c -
or maybe a helper library like arch/mips/lib/bdelay.c.

  Ralf
