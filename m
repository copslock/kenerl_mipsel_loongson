Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 18:34:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2647 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6862792AbaFQQctAG7b3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 18:32:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9FFF169282FA5;
        Tue, 17 Jun 2014 17:32:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 17 Jun 2014 17:32:41 +0100
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0174.001; Tue, 17 Jun 2014 17:32:41 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     "Joseph S. Myers" <joseph@codesourcery.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: RE: MIPS MSA sigcontext changes in 3.15
Thread-Topic: MIPS MSA sigcontext changes in 3.15
Thread-Index: AQHPij1bO0gLDabvHkqdHLfQrYWNBJt1YNYAgAAVWKA=
Date:   Tue, 17 Jun 2014 16:32:40 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320E03BD4@LEMAIL01.le.imgtec.org>
References: <Pine.LNX.4.64.1406171447030.23412@digraph.polyomino.org.uk>
 <Pine.LNX.4.64.1406171539240.23412@digraph.polyomino.org.uk>
In-Reply-To: <Pine.LNX.4.64.1406171539240.23412@digraph.polyomino.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40603
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

Joseph S. Myers <joseph@codesourcery.com> writes:
> On Tue, 17 Jun 2014, Joseph S. Myers wrote:
> 
> > signal mask at a particular offset in the ucontext.  As far as I can see,
> > extending sigcontext requires a new sigaction flag that could be used to
> > opt in, for a particular signal handler, to receiving the new-layout
> > ucontext (so new symbol versions of sigaction in glibc could then pass
> > that flag to the kernel, but existing binaries would continue to get
> > old-layout ucontext from the kernel), or else putting the new data at the
> 
> And a new flag would itself be problematic - signal handlers would need
> wrapping with userspace code to convert structure layout when new-version
> sigaction is used on an older kernel.  That suggests putting the new data
> at the end of ucontext is to be preferred (but in any case it would be
> best to revert the incompatible changes until something compatible with
> existing userspace can be produced).

An attempt was made to appropriately version the sigcontext structure to
allow readers to determine whether the MSA part of the context was present
or not but this only helps the sigcontext structure and not necessarily
the impact that has on the overall ucontext. On the face of it then it
does seem better to have the extra context at the end of ucontext as it
does indeed look broken for existing glibc versions.

A brief scan of how other architectures have handled extending ucontext
shows a wide variety of solutions although adding to the end of ucontext
seems to be the underlying theme.

Thanks for finding this.

Regards,
Matthew
