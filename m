Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 18:33:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54004 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006747AbaHYQdYag-SY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 18:33:24 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PGXNl2001458;
        Mon, 25 Aug 2014 18:33:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PGXNaf001457;
        Mon, 25 Aug 2014 18:33:23 +0200
Date:   Mon, 25 Aug 2014 18:33:23 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: bpf: Add new emit_long_instr macro
Message-ID: <20140825163323.GG25892@linux-mips.org>
References: <1406106009-6520-1-git-send-email-markos.chandras@imgtec.com>
 <20140818082831.GB32372@mchandras-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140818082831.GB32372@mchandras-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42230
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

On Mon, Aug 18, 2014 at 09:28:31AM +0100, Markos Chandras wrote:

> On Wed, Jul 23, 2014 at 10:00:09AM +0100, Markos Chandras wrote:
> > This macro uses the capitalized UASM_* macros to emit 32 or 64-bit
> > instructions depending on the kernel configurations. This allows
> > us to remove a few CONFIG_64BIT ifdefs from the code.
> > 
> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > ---
> >  arch/mips/net/bpf_jit.c | 51 ++++++++++++++++++-------------------------------
> >  1 file changed, 19 insertions(+), 32 deletions(-)
> > 
> Hi Ralf,
> 
> ping?

Ignored like a few other patches by various submitters because it was
not a fix and submitted after the -rc5 deadline.  Applied now.

  Ralf
