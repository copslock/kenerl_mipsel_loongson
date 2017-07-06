Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2017 22:48:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6590 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993936AbdGFUsI0wB5X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2017 22:48:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7A43945B24889;
        Thu,  6 Jul 2017 21:47:57 +0100 (IST)
Received: from [10.20.78.101] (10.20.78.101) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 6 Jul 2017
 21:48:01 +0100
Date:   Thu, 6 Jul 2017 21:47:50 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Petar Jovanovic <Petar.Jovanovic@imgtec.com>
CC:     Petar Jovanovic <petar.jovanovic@rt-rk.com>,
        'David Daney' <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
 mips64r1
In-Reply-To: <56EA75BA695AE044ACFB41322F6D2BF4013D065C1B@BADAG02.ba.imgtec.org>
Message-ID: <alpine.DEB.2.00.1707062139020.3339@tp.orcam.me.uk>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com> <001b01d2ae25$d7554b80$85ffe280$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org> <002c01d2c80f$52e66060$f8b32120$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org> <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk> <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com> <alpine.DEB.2.00.1705221846340.2590@tp.orcam.me.uk>,<000a01d2e6a4$38a8fe70$a9fafb50$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D065C1B@BADAG02.ba.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.101]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59038
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

On Thu, 6 Jul 2017, Petar Jovanovic wrote:

> Ping.

 I think we came to the conclusion that the way to move forward is to 
implement Octeon-specific controls where generic R1/R2 ISA ones are now 
(ab)used to get the desired effect.  Only once this is in place your 
change can go in.

 So if you want that, then I suggest that you either implement the 
prerequsite clean-up yourself or find someone who will do this for you.  

 HTH,

  Maciej
