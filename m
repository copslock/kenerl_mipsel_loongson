Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2014 17:10:58 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50537 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014212AbaKUQK5ExA3K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Nov 2014 17:10:57 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sALGAuie005701;
        Fri, 21 Nov 2014 17:10:56 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sALGAtDg005700;
        Fri, 21 Nov 2014 17:10:55 +0100
Date:   Fri, 21 Nov 2014 17:10:55 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     John Crispin <john@phrozen.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: git caching(?) issues with http(s)
Message-ID: <20141121161055.GA5153@linux-mips.org>
References: <CAOiHx=nG0Td=9_A521NVjoixitTFxVnkvTCatubuFMKuHR+PEQ@mail.gmail.com>
 <20141121134141.GF30205@linux-mips.org>
 <CAOiHx=nJbFvUR4mBCTGdjDFkEX1onRK8P8_c3dwGwDxoox5mow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=nJbFvUR4mBCTGdjDFkEX1onRK8P8_c3dwGwDxoox5mow@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44344
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

On Fri, Nov 21, 2014 at 03:03:08PM +0100, Jonas Gorski wrote:

> >> I noticed that git over http(s) seems to get stale data (just done a
> >> few minutes ago):
> >>
> >> ~$ git clone http://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git
> >> Cloning into 'upstream-sfr'...
> >> ~$ cd upstream-sfr/
> >> ~/upstream-sfr$ git log -1
> >> commit 475d5928b79bb78326a645863d46ff95c5e25e5a
> >> Merge: c6b7b9f 1062080
> >> Author: Ralf Baechle <ralf@linux-mips.org>
> >> Date:   Sat Aug 2 00:07:03 2014 +0200
> >>
> >>     Merge branch '3.16-fixes' into mips-for-linux-next
> >
> > Odd - but I have an idea what might be wrong.
> >
> > Are you seeing this only with the upstream-sfr tree?
> 
> Hadn't checked anything else, but looks like it also affects other trees:
> 
> ~# git clone http://git.linux-mips.org/pub/scm/ralf/upstream-linus.git
> Cloning into 'upstream-linus'...
> ~$ cd upstream-linus/
> ~/upstream-linus$ git log -1
> commit 475d5928b79bb78326a645863d46ff95c5e25e5a
> Merge: c6b7b9f 1062080
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Sat Aug 2 00:07:03 2014 +0200
> 
>     Merge branch '3.16-fixes' into mips-for-linux-next
> 
> 
> (strangely the same commit)

The issue is a stale info/refs on the server.  This file normally gets
updated when the hook hooks/post-update is ran which in turn calls
git-update-server-info but that just didn't happen.

Can you retry?

Btw, why are you using http transport anyway?  The git protocol should
be more efficient.

  Ralf
