Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 01:06:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47429 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008072AbaIMXGDX0Etf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 01:06:03 +0200
Date:   Sun, 14 Sep 2014 00:06:03 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ed Swierk <eswierk@skyportsystems.com>,
        linux-mips@linux-mips.org, ddaney.cavm@gmail.com
Subject: Re: [PATCH v2 5/6] mips: use per-mm page to execute FP branch delay
 slots
In-Reply-To: <20140704113007.GA804@pburton-laptop>
Message-ID: <alpine.LFD.2.11.1409132359450.11957@eddie.linux-mips.org>
References: <CAO_EM_k0Qp_VPEd2Q+WTJWsvE8cmyAuC780SwGfDxhTt_GzMeg@mail.gmail.com> <20140704080641.GY804@pburton-laptop> <20140704085246.GH13532@linux-mips.org> <20140704090601.GZ804@pburton-laptop> <20140704093809.GI13532@linux-mips.org>
 <20140704113007.GA804@pburton-laptop>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42541
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

On Fri, 4 Jul 2014, Paul Burton wrote:

> > > I'm in 2 minds about this - it sounds crazy but perhaps it's the most
> > > sane option available :)
> > 
> > Sanity is overrated anyway ;-)
> 
> I had originally left this patch at the point I started considering
> implementing emulation for the whole ISA in the kernel, figuring I was
> going insane & should probably do something else for a while. Perhaps I
> shouldn't worry so much ;)

 One question: does this emulation handle PC-relative instructions placed 
in a branch delay slot correctly?  This only applies to microMIPS ADDIUPC 
at the moment I believe, but still that has to work correctly whether on 
FP hardware or emulated.

  Maciej
