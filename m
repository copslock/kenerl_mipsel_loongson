Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2014 05:29:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50224 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817294AbaEED3db0lqm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 May 2014 05:29:33 +0200
Date:   Mon, 5 May 2014 04:29:32 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Remove SMTC Support
In-Reply-To: <53447CDF.3000902@paralogos.com>
Message-ID: <alpine.LFD.2.11.1405050417160.21408@eddie.linux-mips.org>
References: <1396954750-24762-1-git-send-email-markos.chandras@imgtec.com> <20140408144436.GT17197@linux-mips.org> <53447CDF.3000902@paralogos.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Kevin,

> > > This patchset removes the MIPS SMTC support.
> > While not really a fix I've applied this to my 3.15 fix branch.  At least
> > it will avoid us having to fix it up for 3.15 :-)
> >
> > That said, SMTC was a remarkable hack and ingenious proof of the MT
> > architecture.
> Sigh. I was rather proud of it.  If it's being excised (and I don't begrudge
> people the right to deprecate it), I guess it means I can unsubscribe from the
> mailing list, as supporting MT hacks was the main reason I hung around at all
> after leaving MIPS.

 The reason stated was: "It is not maintained anymore" -- perhaps you can 
step in as the maintainer instead?  We've got older code and code for 
older hardware still hanging around.

 FWIW I've found both the MT ASE itself and the way you made it used by 
Linux brilliant.  As did the few people I gave a more thorough overview of 
the design.  Thanks for your contribution to the MIPS architecture!

  Maciej
