Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 15:22:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33677 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008032AbaLLOWgN0dDf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Dec 2014 15:22:36 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBCEMX1V013948;
        Fri, 12 Dec 2014 15:22:33 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBCEMX1K013947;
        Fri, 12 Dec 2014 15:22:33 +0100
Date:   Fri, 12 Dec 2014 15:22:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: MIPS in 3.19
Message-ID: <20141212142232.GA11185@linux-mips.org>
References: <20141211132746.GF31723@linux-mips.org>
 <CAJiQ=7C=WTzOKJ4CPGH3zB4hTr=RkF1ywn9bHs2DXpPRmwpCKg@mail.gmail.com>
 <20141211212240.GA6477@linux-mips.org>
 <548A4ACC.9050106@gmail.com>
 <548AB1B8.7040503@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548AB1B8.7040503@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44629
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

On Fri, Dec 12, 2014 at 09:13:28AM +0000, Markos Chandras wrote:

> I am a little confused as well. Sometimes the pull requests appear on
> LMO, some other times they don't. Would it be possible to CC LMO every
> time a pull request is sent to Linus so we have time to review it (more
> pair of eyes is not a bad thing) and comment on it if needed?

I only recently started cc'ing the list so forgive if I sometimes forget.
In this particular case however not cc'ing was intionsional because I
sent out the list of patches minutes after the pull request in the email
that started this thread.

While it is possible to look at what's pending for Linus in upstream-sfr
at any time, not a whole lot of people seem to do that and maybe I should
make it a habit to post a list of what's pending by -rc5 or -rc6 by which
time there is still time for some last minute changes.

That said, already a few releases ago I started to enforce the rc5
deadline for accepting major submission - with a few smaller exceptions,
based on the assessed risk.  But this time the volume of patches forced
me to be more radical or I'd probably still be shifting patches around!

Now, Linus has pulled.  Let's sort the mess than move on to 3.20 ...

  Ralf
