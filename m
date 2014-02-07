Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2014 14:07:44 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41821 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827305AbaBGNHkvLfKL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Feb 2014 14:07:40 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s17D7cde017808;
        Fri, 7 Feb 2014 14:07:38 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s17D7b0q017807;
        Fri, 7 Feb 2014 14:07:37 +0100
Date:   Fri, 7 Feb 2014 14:07:37 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add 1074K CPU support explicitly.
Message-ID: <20140207130737.GG19285@linux-mips.org>
References: <1389992630-64139-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1389992630-64139-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39229
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

On Fri, Jan 17, 2014 at 03:03:50PM -0600, Steven J. Hill wrote:

> The 1074K is a multiprocessing coherent processing system (CPS) based
> on modified 74K cores. This patch makes the 1074K an actual unique
> CPU type, instead of a 74K derivative, which it is not.
> 
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Reviewed-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

I've also come to the conclusion that this seems to be the right
thing.  I'm still undecided on the urgency, 3.14 or later?  For now I'm
going to drop this into the 3.15 queue.

Thanks,

  Ralf
