Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Sep 2017 01:13:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34543 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992618AbdI2XNHwnas6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Sep 2017 01:13:07 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 17102DD359C6E;
        Sat, 30 Sep 2017 00:12:56 +0100 (IST)
Received: from [10.20.78.110] (10.20.78.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.361.1; Sat, 30 Sep 2017
 00:12:59 +0100
Date:   Sat, 30 Sep 2017 00:12:46 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix input modify in __write_64bit_c0_split()
In-Reply-To: <20170929161653.GB32161@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1709292354290.12020@tp.orcam.me.uk>
References: <20170919131122.23926-1-james.hogan@imgtec.com> <alpine.DEB.2.00.1709282351210.12020@tp.orcam.me.uk> <20170929161653.GB32161@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.110]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60207
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

On Fri, 29 Sep 2017, James Hogan wrote:

> >  NB you could use DINS on MIPS64r2+ (and `__read_64bit_c0_split' could 
> > use one instruction less; patch posted separately).
> 
> Yes, that did occur to me, but it seemed simpler for this non-critical
> case to use the more compatible sequence (whereas for the equivalent VZ
> guest accessors, which imply R5+, I've used DINS in my not-yet-submitted
> patches).

 It would have to be a separate change anyway, however your observation 
about 32-bit EJTAG/Cache exception handlers clobbering the temporary 
64-bit value made in the other thread also applies here and we have R2 
code variants for other stuff already, so I think it would be a worthwhile 
improvement.

  Maciej
