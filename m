Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2014 14:37:39 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:36668 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007687AbaLANhd5Voii convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Dec 2014 14:37:33 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id DFA051538A; Mon,  1 Dec 2014 13:37:27 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     peter fuerst <post@pfrst.de>, linux-mips@linux-mips.org
Subject: Re: fast_iob() vs PHYS_OFFSET
References: <yw1xsih2evgn.fsf@unicorn.mansr.com>
        <Pine.LNX.4.64.1411300255520.2113@Opal.Peter>
        <yw1xoaroev7i.fsf@unicorn.mansr.com>
        <20141201104132.GA1973@alpha.franken.de>
Date:   Mon, 01 Dec 2014 13:37:27 +0000
In-Reply-To: <20141201104132.GA1973@alpha.franken.de> (Thomas Bogendoerfer's
        message of "Mon, 1 Dec 2014 11:41:33 +0100")
Message-ID: <yw1xfvczebjc.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Thomas Bogendoerfer <tsbogend@alpha.franken.de> writes:

> On Sun, Nov 30, 2014 at 12:20:17PM +0000, Måns Rullgård wrote:
>> My concern is over systems like AR7.  It defines PHYS_OFFSET to
>> 0x14000000 and UNCAC_BASE, correspondingly, to 0xb4000000.  According to
>> the linux-mips wiki, there is some on-chip RAM at physical address 0,
>> which explains why the __fast_iob() macro works there.
>
> there is really on-chip RAM for AR7 at address 0. The AR7 CPU core
> is only MIPS32r1, so it doesn't have the exception vector base register
> and needs ram at physical address 0 for exception handlers (which all
> older cores do). I can't check right now, but even IP28 should have
> some memory mirrored there. The problem on IP28 is that accessing
> memory uncached requires reprogramming the memory controller (which
> then doesn't fit the concept of fast_iob()).

Well, that explains why it works on AR7.  It still doesn't tell me the
correct way to handle a 74k-based chip (MIPS32r2) with RAM starting at
physical address 0x04000000.

-- 
Måns Rullgård
mans@mansr.com
