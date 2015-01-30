Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 18:13:53 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53622 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012309AbbA3RNvlxVk8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 18:13:51 +0100
Date:   Fri, 30 Jan 2015 17:13:51 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Makefile: Set correct ISA level for MIPS
 ASEs
In-Reply-To: <54CBB717.7000106@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501301712200.28301@eddie.linux-mips.org>
References: <1422629056-27715-1-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501301606470.28301@eddie.linux-mips.org> <54CBB0D4.1040506@imgtec.com> <alpine.LFD.2.11.1501301638050.28301@eddie.linux-mips.org> <54CBB717.7000106@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45588
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

On Fri, 30 Jan 2015, Markos Chandras wrote:

> >  Hmm doesn't `cc-option-yn' pull options accumulated in $(cflags-y) 
> > already for the check it makes?  If not, then it's rather less than useful 
> > for us and I can see two options here:
> 
> I think it does but IIRC at this point no -march=XXXX was set. Perhaps
> moving the ASEs checks after the CPU_* code in Makefile to fix this
> problem indirectly.

 That sounds like a pragmatic fix to me then!

  Maciej
