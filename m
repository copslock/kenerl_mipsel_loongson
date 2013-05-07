Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 12:05:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36877 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823015Ab3EGKE5kqHx8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 May 2013 12:04:57 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r47A4sfj017815;
        Tue, 7 May 2013 12:04:54 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r47A4lUS017814;
        Tue, 7 May 2013 12:04:47 +0200
Date:   Tue, 7 May 2013 12:04:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org
Subject: Re: Build errors caused by modalias generation patch
Message-ID: <20130507100447.GA15044@linux-mips.org>
References: <20130506160253.GA27181@linux-mips.org>
 <87mws8m3eu.fsf@hase.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mws8m3eu.fsf@hase.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36336
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

On Mon, May 06, 2013 at 07:19:53PM +0200, Andreas Schwab wrote:

> Please try the patch in
> <http://marc.info/?l=linux-kbuild&m=136767800809256&w=2>.

No change in observed behaviour.  I did all my builds in empty object
directories so I don't see why this patch would make any difference.

  Ralf
