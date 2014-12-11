Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2014 22:22:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58629 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008550AbaLKVWmB0BJC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Dec 2014 22:22:42 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBBLMfFw009411;
        Thu, 11 Dec 2014 22:22:41 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBBLMe9j009410;
        Thu, 11 Dec 2014 22:22:40 +0100
Date:   Thu, 11 Dec 2014 22:22:40 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: MIPS in 3.19
Message-ID: <20141211212240.GA6477@linux-mips.org>
References: <20141211132746.GF31723@linux-mips.org>
 <CAJiQ=7C=WTzOKJ4CPGH3zB4hTr=RkF1ywn9bHs2DXpPRmwpCKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJiQ=7C=WTzOKJ4CPGH3zB4hTr=RkF1ywn9bHs2DXpPRmwpCKg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44621
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

On Thu, Dec 11, 2014 at 11:19:53AM -0800, Kevin Cernekee wrote:

> On Thu, Dec 11, 2014 at 5:27 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> >
> > Kevin Cernekee (15):
> >       Documentation: DT: Add entries for BCM3384 and its peripherals
> 
> >       MIPS: bcm3384: Initial commit of bcm3384 platform support
> >       MAINTAINERS: Add entry for BCM33xx cable chips
> 
> Hi Ralf,
> 
> Could we drop/revert these three patches for now, and then use the
> "BMIPS Generic target V4" patch series to support BCM3384?  The BMIPS
> Generic series incorporates a great deal of helpful feedback from Arnd
> and others, and it also runs on 5+ other chips.
> 
> It is OK if it isn't merged until 3.20+.  No rush.

Too late - the pull request to Linus is out.

  Ralf
