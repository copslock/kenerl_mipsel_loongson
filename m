Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 03:24:44 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006864AbbBXCYmGbyH3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 03:24:42 +0100
Date:   Tue, 24 Feb 2015 02:24:42 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
cc:     Kevin Cernekee <cernekee@chromium.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        IMG - MIPS Linux Kernel developers 
        <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with
 non-DMA I/O.
In-Reply-To: <54EBCC38.7000702@imgtec.com>
Message-ID: <alpine.LFD.2.11.1502240217360.17311@eddie.linux-mips.org>
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com> <54EBCC38.7000702@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45913
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

On Mon, 23 Feb 2015, Leonid Yegoshin wrote:

> The same is basically for transfer D$ --> I$ because in MIPS it is done via L2
> or memory.

 The original issue aside (I don't want to dive into it) this I believe is 
left to an implementer's discretion and there are MIPS implementations 
indeed that fill I$ directly from D$; IIRC Alchemy silicon and its 
descendants.

  Maciej
