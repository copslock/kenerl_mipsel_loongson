Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 23:44:28 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:35202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006792AbcCGWo1C8q1a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Mar 2016 23:44:27 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (Postfix) with ESMTPS id 90BE98B137;
        Mon,  7 Mar 2016 22:44:18 +0000 (UTC)
Received: from treble.redhat.com (ovpn-113-72.phx2.redhat.com [10.3.113.72])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u27MiGoh014488;
        Mon, 7 Mar 2016 17:44:16 -0500
Date:   Mon, 7 Mar 2016 16:44:15 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] rtc: ds1685: actually spin forever in poweroff error path
Message-ID: <20160307224415.GA8500@treble.redhat.com>
References: <201603060005.PHCyifJr%fengguang.wu@intel.com>
 <25c2e99dc116c666a05e641082a2690c05c09a23.1457362965.git.jpoimboe@redhat.com>
 <56DDF30A.70505@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56DDF30A.70505@gentoo.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <jpoimboe@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jpoimboe@redhat.com
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

On Mon, Mar 07, 2016 at 04:30:50PM -0500, Joshua Kinard wrote:
> On 03/07/2016 10:03, Josh Poimboeuf wrote:
> > objtool reports the following warnings:
> > 
> >   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x0: duplicate frame pointer save
> >   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x3: duplicate frame pointer setup
> >   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x0: frame pointer state mismatch
> > 
> > The warning message needs to be improved, but what it really means in
> > this case is that ds1685_rtc_poweroff() has a possible code path where
> > it can actually fall through to the next function in the object code,
> > ds1685_rtc_work_queue().
> > 
> > The bug is caused by the use of the unreachable() macro in a place which
> > is actually reachable.  That causes gcc to assume that the printk()
> > immediately before the unreachable() macro never returns, when in fact
> > it does.  So gcc places the printk() at the very end of the function's
> > object code.  When the printk() returns, the next function starts
> > executing.
> > 
> > The surrounding comment and printk message state that the code should
> > spin forever, which explains the unreachable() statement.  However the
> > actual spin code is missing.
> 
> So this power down trick is used by both SGI O2 (IP32) and SGI Octane (IP30)
> systems via this RTC chip, and I've noticed lately that the Octane has stopped
> powering off via this function (it just sits and spins forever).  The O2 powers
> off as expected.  When I initially wrote this driver from the original version
> I found on LKML in '09, I hadn't gotten the Octane code back into a working
> shape, and once that happened, I only tested the non-SMP case (fixed Octane SMP
> in 4.1).  I suspect on the Octane, the use of SMP may be what is interfering
> somehow, and this bug may partially explain it.  This patch doesn't fix
> poweroff for me, but it's something to start from when I can get some time to
> chase it down.
> 
> That said, I initially left the 'while (1);' clause out because at one point
> during development, gcc yelled at me for using that at the end of the function,
> so I looked at some other drivers and saw the use of 'unreachable();' and used
> it instead.  Wasn't aware both of them are needed together in this instance.  I
> thought 'unreachable()' evaluated out to a 'while (1)' at the end.  Seems to
> actually be some kind of internal gcc trick.
> 
> How exactly did the kbuild bot trigger the above warnings?  I've only built and
> tested this driver on a MIPS platform and haven't seen that particular warning
> before.

Hi Joshua,

The warning was emitted by a brand new tool named objtool which does
some static object code analysis. It's currently only in linux-next, not
yet in Linus's tree.  To get the warning, you'd need to build the
linux-next tree for x86_64 with CONFIG_STACK_VALIDATION enabled.

Here's the kbuild bot warning:

  https://lkml.kernel.org/r/201603060005.PHCyifJr%fengguang.wu@intel.com


-- 
Josh
