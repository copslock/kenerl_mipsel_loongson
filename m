Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 17:39:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20653 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013854AbaKQQiwj0oHH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 17:38:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D0BD8D9B39BE6;
        Mon, 17 Nov 2014 16:38:42 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 17 Nov
 2014 16:38:45 +0000
Received: from [192.168.159.30] (192.168.159.30) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 17 Nov
 2014 08:38:43 -0800
Message-ID: <546A248F.4040604@imgtec.com>
Date:   Mon, 17 Nov 2014 10:38:39 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 6/7] MIPS: Apply `.insn' to fixup labels throughout
References: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk> <alpine.DEB.1.10.1411152139430.2881@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.1.10.1411152139430.2881@tp.orcam.me.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.30]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 11/15/2014 04:09 PM, Maciej W. Rozycki wrote:
> Fix the issue with the ISA bit being lost in fixups that jump to
> labels placed just before a section switch.  Such a switch leads to
> the ISA bit being lost, because GAS concludes there is no code that
> follows and therefore the label refers to data.  Use the `.insn'
> pseudo-op to convince the tool this is not the case.
> 
> This lack of label annotation leads to microMIPS compilation errors 
> like:
> 
> mips-linux-gnu-ld: arch/mips/built-in.o: .fixup+0x3b8: Unsupported
> jump between ISA modes; consider recompiling with interlinking
> enabled. mips-linux-gnu-ld: final link failed: Bad value
> 
> Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com> --- Hi,
> 
> I see someone has just fixed this issue in one place, so I had to 
> regenerate the change I originally made against 3.17, but I really
> fail to see why not to fix it throughout at once.
> 
In our earlier branches I believe all of the '.insn' pseudo-ops were in
place. I remember removing a number of them during release testing since
they appeared to not make any difference. It appears that use of
different toolchains has shown that to be in error.

Steve


Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
