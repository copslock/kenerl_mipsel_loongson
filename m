Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 18:13:02 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:35781 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903445Ab2FTQM5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2012 18:12:57 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5KGCrh1005847;
        Wed, 20 Jun 2012 17:12:53 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5KGCnYa005796;
        Wed, 20 Jun 2012 17:12:49 +0100
Date:   Wed, 20 Jun 2012 17:12:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
Message-ID: <20120620161249.GB29196@linux-mips.org>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
 <20120620152759.2caceb8c.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120620152759.2caceb8c.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33742
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Jun 20, 2012 at 03:27:59PM +0900, Yoichi Yuasa wrote:

> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.

Thanks, fix applied.

  Ralf
