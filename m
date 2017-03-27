Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2017 00:39:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45498 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993868AbdC0Wj0z69CU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Mar 2017 00:39:26 +0200
Date:   Mon, 27 Mar 2017 23:39:26 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: Does the R10K family support the "wait" instruction?
In-Reply-To: <0c62c4a7-b44c-45f6-2428-5b9b9e6a6204@gentoo.org>
Message-ID: <alpine.LFD.2.20.1703272323220.6942@eddie.linux-mips.org>
References: <88c3cc1d-fd80-bb9a-d1ec-ed3c44dea71b@gentoo.org> <20170327130539.GA5734@linux-mips.org> <0c62c4a7-b44c-45f6-2428-5b9b9e6a6204@gentoo.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57455
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

On Mon, 27 Mar 2017, Joshua Kinard wrote:

> > If you have any documentation to indicate a MIPS II CPU to support WAIT,
> > I'm interested.  From all that I know the feature was introduced by the
> > R4600.
> 
> One of my Google searches, using the keywords "mips wait instruction", has been
> returning search results from a Harvard computer sciences course detailing the
> "instructional operating system OS/161", which uses an instructional CPU that
> borrows heavily from the R3000 (which they dub MIPS-161):
> 
> http://os161.eecs.harvard.edu/documentation/sys161-1.99.07/mips.html
> 
> In there, they state:
> "The WAIT instruction has been borrowed from MIPS-II. This operation puts the
> processor into a low-power state and suspends execution until some external
> event occurs, such as an interrupt. Since the exact behavior of WAIT is not
> clearly specified anywhere I could find, the MIPS-161 behavior is as follows"
> 
> So it could be that the instructor for that course simply got some wrong
> information, but good luck teaching Google that.  I figure once its spider
> crawls this e-mail in the archives, it'll further strengthen hits like the above.

 FWIW according to the MIPS IV ISA manual[1], which seems to be the most 
comprehensive legacy MIPS ISA instruction reference, COP0 encodings, and 
hence the WAIT instruction, have never been a part of any of the legacy 
MIPS ISAs, they have always been implementation-specific.

  Maciej

References:

[1] "MIPS IV Instruction Set", MIPS Technologies, Inc., Revision 3.2, By
    Charles Price, September, 1995, Section A 8.3.1 "Coprocessor 0 - 
    COP0", p. A-176
    <http://techpubs.sgi.com/library/manuals/2000/007-2597-001/pdf/007-2597-001.pdf>
