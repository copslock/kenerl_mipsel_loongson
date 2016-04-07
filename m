Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 07:58:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40220 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025569AbcDGF6PbPhdS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Apr 2016 07:58:15 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u375wE7e028631;
        Thu, 7 Apr 2016 07:58:14 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u375wDli028630;
        Thu, 7 Apr 2016 07:58:13 +0200
Date:   Thu, 7 Apr 2016 07:58:13 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: 4.1: XPA breaks Alchemy
Message-ID: <20160407055813.GD26267@linux-mips.org>
References: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
 <20160407000658.GA11065@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160407000658.GA11065@NP-P-BURTON>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52917
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

On Thu, Apr 07, 2016 at 01:06:58AM +0100, Paul Burton wrote:

> 
> I don't suppose you'd be able to try this kernel branch?
> 
>     https://git.linux-mips.org/cgit/paul/linux.git/log/?h=v4.6-tlb
> 
>     git://git.linux-mips.org/pub/scm/paul/linux.git -b v4.6-tlb
> 
> I'm working on fixing up a number of issues with commit c5b367835cfc
> ("MIPS: Add support for XPA.") but unfortunately don't have access to
> any Alchemy systems to test it myself.

The unique architecural feature of Alchemy is that it has devices such as
the PCI bus outside the low 4GB of physical address space.  So I'd
suspect something is wrong there.

Everybody is running Sibyte 64 bit; I wonder if highmem with Sibyte is
also affected.

  Ralf
