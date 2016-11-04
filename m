Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 20:08:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57404 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993086AbcKDTIDxsd2o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 20:08:03 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2FFB12C91078C;
        Fri,  4 Nov 2016 19:07:54 +0000 (GMT)
Received: from [10.20.78.29] (10.20.78.29) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 4 Nov 2016
 19:07:56 +0000
Date:   Fri, 4 Nov 2016 19:07:47 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>
Subject: RE: [PATCH] MIPS: VDSO: Always select -msoft-float
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235380AB822B@HHMAIL01.hh.imgtec.org>
Message-ID: <alpine.DEB.2.00.1611041905370.13938@tp.orcam.me.uk>
References: <1477843551-21813-1-git-send-email-linux@roeck-us.net> <alpine.DEB.2.00.1611012208400.24498@tp.orcam.me.uk> <20161101233038.GA25472@roeck-us.net> <alpine.DEB.2.00.1611022043010.24498@tp.orcam.me.uk> <6D39441BF12EF246A7ABCE6654B0235380AB79B7@HHMAIL01.hh.imgtec.org>
 <20161104152603.GB12009@roeck-us.net> <alpine.DEB.2.00.1611041558460.13938@tp.orcam.me.uk> <6D39441BF12EF246A7ABCE6654B0235380AB822B@HHMAIL01.hh.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.29]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55677
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

On Fri, 4 Nov 2016, Matthew Fortune wrote:

> >  This code is executed in the user mode so while floating-point code may
> > not be needed there, not at least right now, there's actually nothing
> > which should stop us from from adding some should such a need arise.
> 
> Indeed. For now though the switch to -msoft-float is the simplest solution
> isn't it?

 As I previously noted I am leaning towards accepting this solution, but 
please let me do some further research before I answer your question.  
I'll reply to your original response when I am ready.

  Maciej
