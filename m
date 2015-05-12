Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 18:59:27 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:45705 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013148AbbELQ7Zwa6YO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 18:59:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id AE25256F409;
        Tue, 12 May 2015 19:59:27 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id odwkKsw2y7ZW; Tue, 12 May 2015 19:59:22 +0300 (EEST)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id B53165BC008;
        Tue, 12 May 2015 19:59:22 +0300 (EEST)
Date:   Tue, 12 May 2015 19:59:22 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP28: "Inconsistent ISA" messages during kernel build
Message-ID: <20150512165922.GA609@fuloong-minipc.musicnaut.iki.fi>
References: <55516EF3.7010706@gentoo.org>
 <5551B894.9000204@imgtec.com>
 <6D39441BF12EF246A7ABCE6654B0235321052BB1@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235321052BB1@LEMAIL01.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Tue, May 12, 2015 at 09:00:23AM +0000, Matthew Fortune wrote:
> Markos Chandras <Markos.Chandras@imgtec.com> writes:
> > I presume you are using binutils >= 2.25? I have seen this problem in my
> > local build tests as well and I discussed this with Matthew (now on CC).
> > It seems it's an 'innocent' warning added to binutils 2.25 but I am not
> > sure if this is now fixed or not. Matthew might be able to provide more
> > information.
> 
> I don't really know what an IP28 kernel is. What is the -march for this?
> There is an issue with -march=xlp as the XLP is marked as an XLR in the
> e_flags which is a mips64 but the xlp is a mips64r2 which is correctly
> annotated as such in the .MIPS.abiflags. I haven't quite figured out what
> to do about this yet.

Not sure if related, but I'm getting tons of these warnings as well
already when compiling toolchain alone (GCC 5.1, binutils 2.25,
GLIBC 2.20) for arch=octeon+ and soft-float. This will make e.g. GCC
testsuite useless as pretty much everything fails with excess errors.
Currently for OCTEON toolchain I need to downgrade to binutils 2.24. :-(

A.
