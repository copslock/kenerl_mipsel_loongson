Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 15:13:31 +0200 (CEST)
Received: from imap.thunk.org ([74.207.234.97]:44156 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992161AbcJXNNYTaIkY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 15:13:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=nS63t3PxzAbuk2GfUhTMZdwuQHIjjH1I3KmU7VcrZB0=;
        b=Y8BKF4CsyPnZCDFkNJgg3R2AmW5DIUOj/uMj+qUba5r9lnKcN6lSJ+S7V1gsFIlk0UsD9p+xNsujSuQUSkJ6PsCxqulKtj+syzy4duqbKxOteDVGoWXjun/wpbRiOmxHNIjEFImJy/J16VfSV5KyeujC3V9ctGd1WUk3/9YSwsM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.84_2)
        (envelope-from <tytso@thunk.org>)
        id 1byf3w-0004hf-Ua; Mon, 24 Oct 2016 13:13:12 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 66A42C005C7; Mon, 24 Oct 2016 09:13:11 -0400 (EDT)
Date:   Mon, 24 Oct 2016 09:13:11 -0400
From:   Theodore Ts'o <tytso@mit.edu>
To:     SF Markus Elfring <elfring@users.sourceforge.net>
Cc:     linux-mips@linux-mips.org,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf =?iso-8859-1?Q?B=E4chle?= <ralf@linux-mips.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/4] MIPS/kernel/r2-to-r6-emul: Use seq_puts() in
 mipsr2_stats_show()
Message-ID: <20161024131311.ttwr2bblphg6vd2b@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-mips@linux-mips.org,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf =?iso-8859-1?Q?B=E4chle?= <ralf@linux-mips.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
 <4126c272-cdf6-677a-fe98-74e8034078d8@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4126c272-cdf6-677a-fe98-74e8034078d8@users.sourceforge.net>
User-Agent: NeoMutt/20160916 (1.7.0)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Return-Path: <tytso@thunk.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tytso@mit.edu
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

On Mon, Oct 24, 2016 at 02:27:55PM +0200, SF Markus Elfring wrote:
> 
> A string which did not contain a data format specification should be put
> into a sequence.

This is not a correct description of what you are doing.  A better
description would be to say:

"Use seq_put[sc]() instead of seq_printf() since the string does not
contain a data format specifier".  You should fix this in all the
patches.  Please also note this is really pointless patch, since
reading from /proc isn't done in a tight loop, and even if it were,
the use of vsprintf is the tiniest part of the overhead.  It otherwise
reduces the text space or the number of lines of code....

					- Ted
