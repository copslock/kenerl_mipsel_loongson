Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 13:37:44 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:32774 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993095AbdGGLhiAcdxF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Jul 2017 13:37:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 2847E1A20D0;
        Fri,  7 Jul 2017 13:37:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkn153 (rtrkn153.domain.local [192.168.236.145])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 129711A1FF5;
        Fri,  7 Jul 2017 13:37:32 +0200 (CEST)
From:   "Petar Jovanovic" <petar.jovanovic@rt-rk.com>
To:     "'Maciej W. Rozycki'" <macro@imgtec.com>,
        "'Petar Jovanovic'" <Petar.Jovanovic@imgtec.com>
Cc:     "'David Daney'" <ddaney@caviumnetworks.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <david.daney@cavium.com>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com> <001b01d2ae25$d7554b80$85ffe280$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org> <002c01d2c80f$52e66060$f8b32120$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org> <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk> <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com> <alpine.DEB.2.00.1705221846340.2590@tp.orcam.me.uk>,<000a01d2e6a4$38a8fe70$a9fafb50$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D065C1B@BADAG02.ba.imgtec.org> <alpine.DEB.2.00.1707062139020.3339@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1707062139020.3339@tp.orcam.me.uk>
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and mips64r1
Date:   Fri, 7 Jul 2017 13:37:31 +0200
Message-ID: <000b01d2f715$6bb602f0$432208d0$@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFk0u1L5Xxe++MwOaWf1NpDgdbVAQD+Q8JBAi8P7/cBht+ufgJrlzj2AtLLO/IBy5iamAEgIZO+AjLK5lYBw/HWDgHB3Adxoo/NW+A=
Content-Language: en-us
Return-Path: <petar.jovanovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: petar.jovanovic@rt-rk.com
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

-----Original Message-----
From: Maciej W. Rozycki
> I think we came to the conclusion that the way to move forward is to 
> implement Octeon-specific controls where generic R1/R2 ISA ones are now 
> (ab)used to get the desired effect.  Only once this is in place your 
> change can go in.

As I said earlier in the thread, "in the current ToT, I have not seen
where this change would affect apart from show_cpuinfo()"[1]. So, if
someone implements Octeon-specific controls, where this should be used?
I am not aware of the places where Octeon (ab)uses it in the current
kernel code. David says he "cannot recall exactly what the issues
were" [2].

Petar

[1] https://www.linux-mips.org/archives/linux-mips/2017-05/msg00103.html
[2] https://www.linux-mips.org/archives/linux-mips/2017-03/msg00149.html
