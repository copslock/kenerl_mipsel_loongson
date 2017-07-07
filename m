Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 17:04:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29510 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993944AbdGGPE25hI9b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 17:04:28 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTP id 79D28E766FD76;
        Fri,  7 Jul 2017 16:04:19 +0100 (IST)
Received: from [10.20.78.107] (10.20.78.107) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 7 Jul 2017
 16:04:22 +0100
Date:   Fri, 7 Jul 2017 16:04:11 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Petar Jovanovic <petar.jovanovic@rt-rk.com>
CC:     'Petar Jovanovic' <Petar.Jovanovic@imgtec.com>,
        'David Daney' <ddaney@caviumnetworks.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <david.daney@cavium.com>
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
 mips64r1
In-Reply-To: <000b01d2f715$6bb602f0$432208d0$@rt-rk.com>
Message-ID: <alpine.DEB.2.00.1707071538030.3339@tp.orcam.me.uk>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com> <001b01d2ae25$d7554b80$85ffe280$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org> <002c01d2c80f$52e66060$f8b32120$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org> <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk> <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com> <alpine.DEB.2.00.1705221846340.2590@tp.orcam.me.uk>,<000a01d2e6a4$38a8fe70$a9fafb50$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D065C1B@BADAG02.ba.imgtec.org> <alpine.DEB.2.00.1707062139020.3339@tp.orcam.me.uk> <000b01d2f715$6bb602f0$432208d0$@rt-rk.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Fri, 7 Jul 2017, Petar Jovanovic wrote:

> As I said earlier in the thread, "in the current ToT, I have not seen
> where this change would affect apart from show_cpuinfo()"[1]. So, if
> someone implements Octeon-specific controls, where this should be used?

 Right, `egrep -r 'cpu_has_(mips_r1|mips32r1|mips64r1|mips32r2)' arch/mips'
does not show anything else indeed.  Please make it unambiguous in the 
patch description then, i.e. that there is no functional change beyond
reporting in `show_cpuinfo'.

> I am not aware of the places where Octeon (ab)uses it in the current
> kernel code. David says he "cannot recall exactly what the issues
> were" [2].

 Thanks for the pointer as this message has not been recorded in 
patchwork due to its changed `Subject'.

 I disagree with David there.  The intended use for generic ISA level 
controls is the same between userland and the kernel.  That is say 
`cpu_has_mips_r2' can be used to conditionally turn on a piece of code 
that uses a MIPSr2 mandatory architectural feature, such as the ROTR 
instruction or the CP0.EBase register.

 Anything that is allowed to vary between implementations, be it the 
availability of a feature or a choice made between possible solutions 
for optimisation reasons, has to use a separate control, either the CPU 
identifier or a dedicated `cpu_<foo>' setting, like we do with cache 
controls for example.

  Maciej
