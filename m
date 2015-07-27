Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 20:04:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61017 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011286AbbG0SEvUu9oz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 20:04:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E907B403B733E;
        Mon, 27 Jul 2015 19:04:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Jul 2015 19:04:45 +0100
Received: from localhost (10.100.200.213) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 27 Jul
 2015 19:04:44 +0100
Date:   Mon, 27 Jul 2015 11:04:42 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-next@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: Crash in -next due to 'MIPS: Move FP usage checks into
 protected_{save, restore}_fp_context'
Message-ID: <20150727180442.GG7289@NP-P-BURTON>
References: <20150715160918.GA27653@roeck-us.net>
 <20150727150652.GA1756@roeck-us.net>
 <20150727172142.GE7289@NP-P-BURTON>
 <20150727174622.GA10708@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150727174622.GA10708@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.213]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Mon, Jul 27, 2015 at 10:46:22AM -0700, Guenter Roeck wrote:
> On Mon, Jul 27, 2015 at 10:21:42AM -0700, Paul Burton wrote:
> > On Mon, Jul 27, 2015 at 08:06:52AM -0700, Guenter Roeck wrote:
> > > On Wed, Jul 15, 2015 at 09:09:18AM -0700, Guenter Roeck wrote:
> > > > Hi,
> > > > 
> > > > my qemu test for mipsel crashes with next-20150715 as follows.
> > > > 
> > > ping ... problem is still seen as of next-20150727.
> > 
> > Hi Guenter,
> > 
> > Apologies for the delay. Could you share your affected kernel
> > configuration & which userland you're running?
> > 
> > I've just tested with a malta_defconfig kernel & a buildroot based
> > initramfs without problems, and things are also fine on my physical
> > MIPSr6 setups. If you have any directions with which I can reproduce
> > this problem that would be great.
> > 
> This is with qemu in little endian mode. Big endian works fine.

Yup, I was using little endian in both cases. malta_defconfig is little
endian - sadly use of the el suffix is pretty inconsistent...

> The configuration, the script to build and run the kernel, 
> and the root file system used are are available at
> https://github.com/groeck/linux-build-test, in directory
> rootfs/mipsel/. The log for the latest build failure is in
> http://server.roeck-us.net:8010/builders/qemu-mipsel-next/builds/194/steps/qemubuildcommand/logs/stdio.

Thanks for the pointers, I'm able to reproduce it using your config and
initramfs, and I'll dig into what's going on here.

Paul
