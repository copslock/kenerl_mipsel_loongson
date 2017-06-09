Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2017 21:53:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54168 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993947AbdFITxqFbWpn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Jun 2017 21:53:46 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v59JrTrL019346;
        Fri, 9 Jun 2017 21:53:30 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v59JrM1V019345;
        Fri, 9 Jun 2017 21:53:22 +0200
Date:   Fri, 9 Jun 2017 21:53:22 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     monstr@monstr.eu, liqin.linux@gmail.com, lennox.wu@gmail.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH 7/7] MIPS: Use generic libgcc intrinsics
Message-ID: <20170609195322.GA18307@linux-mips.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170606191023.24581-1-palmer@dabbelt.com>
 <20170606191023.24581-8-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606191023.24581-8-palmer@dabbelt.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58386
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

On Tue, Jun 06, 2017 at 12:10:23PM -0700, Palmer Dabbelt wrote:

> These routines in arch/mips/lib/ are functionally identical to those
> recently added to lib/ so remove them and select the generic ones.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Thanks, nice cleanup!

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
