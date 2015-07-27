Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 20:17:57 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:53956 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011332AbbG0SR4NWIHz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 20:17:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=iho/16RjVdLFQOBVoPa4gH2Zag16zAr6AKuXG3bKiAc=;
        b=Lw3J5VD5chkN0SGScBW0WPluRQ9q+KtfmJ3ZJCOeL4kHqcoswJ3W1rV4nRXXarf9kGQTVfW+K7r/9x884PbwDjLlGNea3xQQE7C/9gIa2INH2zzAFmP6hN8ebNGXs4dGzQGeAbmdv90wYiXZtLPgOPRl5GZq/pMLUgAtPKKDglU=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54809 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZJmyD-002iyV-7h; Mon, 27 Jul 2015 18:17:49 +0000
Date:   Mon, 27 Jul 2015 11:17:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-next@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Crash in -next due to 'MIPS: Move FP usage checks into
 protected_{save, restore}_fp_context'
Message-ID: <20150727181747.GA20077@roeck-us.net>
References: <20150715160918.GA27653@roeck-us.net>
 <20150727150652.GA1756@roeck-us.net>
 <20150727172142.GE7289@NP-P-BURTON>
 <20150727174622.GA10708@roeck-us.net>
 <20150727180442.GG7289@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150727180442.GG7289@NP-P-BURTON>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Mon, Jul 27, 2015 at 11:04:42AM -0700, Paul Burton wrote:
> On Mon, Jul 27, 2015 at 10:46:22AM -0700, Guenter Roeck wrote:
> > On Mon, Jul 27, 2015 at 10:21:42AM -0700, Paul Burton wrote:
> > > On Mon, Jul 27, 2015 at 08:06:52AM -0700, Guenter Roeck wrote:
> > > > On Wed, Jul 15, 2015 at 09:09:18AM -0700, Guenter Roeck wrote:
> > > > > Hi,
> > > > > 
> > > > > my qemu test for mipsel crashes with next-20150715 as follows.
> > > > > 
> > > > ping ... problem is still seen as of next-20150727.
> > > 
> > > Hi Guenter,
> > > 
> > > Apologies for the delay. Could you share your affected kernel
> > > configuration & which userland you're running?
> > > 
> > > I've just tested with a malta_defconfig kernel & a buildroot based
> > > initramfs without problems, and things are also fine on my physical
> > > MIPSr6 setups. If you have any directions with which I can reproduce
> > > this problem that would be great.
> > > 
> > This is with qemu in little endian mode. Big endian works fine.
> 
> Yup, I was using little endian in both cases. malta_defconfig is little
> endian - sadly use of the el suffix is pretty inconsistent...
> 
Interesting.

> > The configuration, the script to build and run the kernel, 
> > and the root file system used are are available at
> > https://github.com/groeck/linux-build-test, in directory
> > rootfs/mipsel/. The log for the latest build failure is in
> > http://server.roeck-us.net:8010/builders/qemu-mipsel-next/builds/194/steps/qemubuildcommand/logs/stdio.
> 
> Thanks for the pointers, I'm able to reproduce it using your config and
> initramfs, and I'll dig into what's going on here.
> 
Let me know what you find. Maybe something is wrong with my configuration
or initramfs, but it is odd that I didn't see the problem earlier.

Unfortunately I don't recall where I got the configuration from.
Guess I should keep notes :-(.

Thanks,
Guenter
