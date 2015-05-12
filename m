Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 21:07:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11252 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013229AbbELTHWXVOca convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 21:07:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 186D1EDE0CA89;
        Tue, 12 May 2015 20:07:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 12 May 2015 20:06:17 +0100
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Tue, 12 May 2015 20:06:17 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: RE: IP28: "Inconsistent ISA" messages during kernel build
Thread-Topic: IP28: "Inconsistent ISA" messages during kernel build
Thread-Index: AQHQjIz4GFG4R8fuXkevVUNLZB5Wy514B4nAgAB4lQCAACQyAA==
Date:   Tue, 12 May 2015 19:06:17 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235321053F0C@LEMAIL01.le.imgtec.org>
References: <55516EF3.7010706@gentoo.org> <5551B894.9000204@imgtec.com>
 <6D39441BF12EF246A7ABCE6654B0235321052BB1@LEMAIL01.le.imgtec.org>
 <20150512165922.GA609@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150512165922.GA609@fuloong-minipc.musicnaut.iki.fi>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.122]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Aaro Koskinen <aaro.koskinen@iki.fi> writes:
> Hi,
> 
> On Tue, May 12, 2015 at 09:00:23AM +0000, Matthew Fortune wrote:
> > Markos Chandras <Markos.Chandras@imgtec.com> writes:
> > > I presume you are using binutils >= 2.25? I have seen this problem
> > > in my local build tests as well and I discussed this with Matthew
> (now on CC).
> > > It seems it's an 'innocent' warning added to binutils 2.25 but I am
> > > not sure if this is now fixed or not. Matthew might be able to
> > > provide more information.
> >
> > I don't really know what an IP28 kernel is. What is the -march for
> this?
> > There is an issue with -march=xlp as the XLP is marked as an XLR in
> > the e_flags which is a mips64 but the xlp is a mips64r2 which is
> > correctly annotated as such in the .MIPS.abiflags. I haven't quite
> > figured out what to do about this yet.
> 
> Not sure if related, but I'm getting tons of these warnings as well
> already when compiling toolchain alone (GCC 5.1, binutils 2.25, GLIBC
> 2.20) for arch=octeon+ and soft-float. This will make e.g. GCC testsuite
> useless as pretty much everything fails with excess errors.
> Currently for OCTEON toolchain I need to downgrade to binutils 2.24. :-(

I think this will be related but for a different underlying reason. I'm
afraid I didn't see the fact that we don't actually have link tests that
hit every architecture and the few I chose to add explicitly were
consistent. I've added a bug for binutils about this:

Bug 18401  - MIPS -march=xlp results in inconsistent ISA markers
https://sourceware.org/bugzilla/show_bug.cgi?id=18401

I'll try and take a look at a fix (and link test coverage for all archs).

Thanks,
Matthew
