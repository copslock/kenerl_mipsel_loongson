Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2016 15:26:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34340 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992009AbcJJN0od97vD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Oct 2016 15:26:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u9ADQhTn008317;
        Mon, 10 Oct 2016 15:26:43 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u9ADQhDB008316;
        Mon, 10 Oct 2016 15:26:43 +0200
Date:   Mon, 10 Oct 2016 15:26:43 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] MIPS: Enable hardened usercopy
Message-ID: <20161010132642.GA8229@linux-mips.org>
References: <20161008214714.5375-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161008214714.5375-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55377
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

On Sat, Oct 08, 2016 at 10:47:14PM +0100, Paul Burton wrote:

> Enable CONFIG_HARDENED_USERCOPY checks for MIPS, calling check_object
> size in all of copy_{to,from}_user(), __copy_{to,from}_user() &
> __copy_{to,from}_user_inatomic().

Patch looks good but I was wondering how about further usermode
accessors such as csum_partial_copy_from_user, csum_and_copy_from_user,
csum_and_copy_to_user, csum_partial_copy_nocheck?

  Ralf
