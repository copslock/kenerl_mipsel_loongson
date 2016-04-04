Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 10:32:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52212 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026024AbcDDIccUL41S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 10:32:32 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u348WUrX016134;
        Mon, 4 Apr 2016 10:32:30 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u348WRKO016133;
        Mon, 4 Apr 2016 10:32:27 +0200
Date:   Mon, 4 Apr 2016 10:32:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Qais Yousef <qsyousef@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix broken malta qemu
Message-ID: <20160404083226.GB15222@linux-mips.org>
References: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
 <20160401124852.GA5145@NP-P-BURTON>
 <56FFB8B7.8050607@gmail.com>
 <20160404064140.GA1368@NP-P-BURTON>
 <20160404080222.GA15222@linux-mips.org>
 <20160404080654.GA14758@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160404080654.GA14758@NP-P-BURTON>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52866
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

On Mon, Apr 04, 2016 at 09:06:54AM +0100, Paul Burton wrote:

> On Mon, Apr 04, 2016 at 10:02:23AM +0200, Ralf Baechle wrote:
> > FYI, Qais' initial fix is in the pull request I sent to Linus yesterday so
> > any fixes please relative to that patch.
> 
> Hi Ralf,
> 
> To late - I already submitted:
> 
>     https://patchwork.linux-mips.org/patch/13003/
> 
> I can rebase, but it'll be a revert of Qais' workaround followed by
> mine & squashed.

Yeah, rebase and something on top of that will be fine.

  Ralf
