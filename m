Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 14:15:54 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39093 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832655Ab3JHMPs1cQ4J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 14:15:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r98CFlqg028323;
        Tue, 8 Oct 2013 14:15:47 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r98CFkqC028322;
        Tue, 8 Oct 2013 14:15:46 +0200
Date:   Tue, 8 Oct 2013 14:15:46 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: Print correct PC in trace dump after NMI exception
Message-ID: <20131008121546.GI1615@linux-mips.org>
References: <1381232371-25017-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381232371-25017-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38264
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

On Tue, Oct 08, 2013 at 12:39:31PM +0100, Markos Chandras wrote:

> +	/*
> +	 * Clear ERL - restore segment mapping
> +	 * Clear BEV - required for page fault exception handler to work
> +	 */
> +	mfc0	k0, CP0_STATUS
> +	ori     k0, k0, ST0_EXL
> +	lui     k1, %hi(~ST0_BEV)
> +	ori     k1, k1, %lo(~ST0_ERL)

Why not:

	li	k1 ~(ST0_BEV | ST0_ERL)

If you were afraid gas might use $1 expanding this macro instruction - no,
it won't.  A belt & suspenders approach might be to drop in a ".set noat";
it would make the assembler throw an error if should ever see the need to
use $1.

  Ralf
