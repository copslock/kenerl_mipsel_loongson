Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 12:27:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59419 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6816285Ab3JNK1kHp1vx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 12:27:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r9EARb8i000741;
        Mon, 14 Oct 2013 12:27:37 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r9EARXcX000740;
        Mon, 14 Oct 2013 12:27:33 +0200
Date:   Mon, 14 Oct 2013 12:27:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: stack protector: Fix per-task canary switch
Message-ID: <20131014102733.GS3098@linux-mips.org>
References: <1381144466-19736-1-git-send-email-james.hogan@imgtec.com>
 <20131007124859.GF3098@linux-mips.org>
 <20131010231617.GI4301@kroah.com>
 <525BADFB.4070601@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <525BADFB.4070601@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38320
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

On Mon, Oct 14, 2013 at 09:40:27AM +0100, James Hogan wrote:

> On 11/10/13 00:16, Greg KH wrote:
> > On Mon, Oct 07, 2013 at 02:48:59PM +0200, Ralf Baechle wrote:
> >> On Mon, Oct 07, 2013 at 12:14:26PM +0100, James Hogan wrote:
> >>
> >>> Ralf: This is a regression in v3.11, so please consider for v3.12.
> >>
> >> Applied, will send to Linus with the next pull request.
> > 
> > Which would be in time for 3.12-final, right?
> 
> Yes, it's included in v3.12-rc5 as:
> 8b3c569a3999a8fd5a819f892525ab5520777c92
> 
> >> stable folks - please apply to 3.12-stable.
> > 
> > There is no 3.12-stable yet, as 3.12-final isn't out yet.
> > 
> > Confused,
> 
> I think Ralf meant v3.11-stable. It's only needed there as the
> regression was introduced in v3.11-rc1.

Yes, indeed.  Greg, sorry for the confusion.

Thanks,

  Ralf
