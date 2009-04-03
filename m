Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Apr 2009 15:12:43 +0100 (BST)
Received: from pyxis.i-cable.com ([203.83.115.105]:54483 "HELO
	pyxis.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20026586AbZDCOMe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Apr 2009 15:12:34 +0100
Received: (qmail 22743 invoked by uid 104); 3 Apr 2009 14:12:24 -0000
Received: from 203.83.114.122 by pyxis (envelope-from <robert.zhangle@gmail.com>, uid 101) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7733.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.227371 secs); 03 Apr 2009 14:12:24 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 3 Apr 2009 14:12:23 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n33ECDHu019091;
	Fri, 3 Apr 2009 22:12:13 +0800 (CST)
Date:	Fri, 3 Apr 2009 22:11:59 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	wu zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] ftrace porting of linux-2.6.29 for mips
Message-ID: <20090403141158.GA27751@adriano.hkcable.com.hk>
Mail-Followup-To: wu zhangjin <wuzhangjin@gmail.com>,
	linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <b00321320904021847w5ab3acb6nd1cd554c251ef8f6@mail.gmail.com> <20090403113315.GC6629@adriano.hkcable.com.hk> <b00321320904030503w8fe0165t2aded6727f35e24c@mail.gmail.com> <b00321320904030551p774d295lce3581c23d9d8c26@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b00321320904030551p774d295lce3581c23d9d8c26@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 20:51 Fri 03 Apr     , wu zhangjin wrote:
> okay, please check the attachment, thx!
> 
> including:
> 
> 1. add the HAVE_FUNCTION_TRACE_MCOUNT_TEST line in arch/mips/Kconfig
> 2. remove the useless registers save & restore operation in mcount.S
> 3. and add a "notrace" flag to tick_do_update_jiffies64 to avoid the
> nmi exception problem.

Have you tested the latest patch? Any working .config file?
I just tested it, seems can't boot.

I have pushed the patch, along with my fix, to my git tree, so that
the patch could be further polished. It is in linux-2.6.29-stable-ftrace branch.

http://repo.or.cz/w/linux-2.6/linux-loongson.git

BTW, it seems linux-mips@vger.kernel.org is not an alias of
linux-mips@linux-mips.org, since I haven't seen our previous emails appear in
linux-mips ML's archive. So I have added linux-mips@linux-mips.org to CC list.

When this patch is more ready to be included, we'd better include LKML in CC
list, too. Because there are more ftrace gurus which could give advices to this
patch.

Zhang, Le
http://zhangle.is-a-geek.org

> 
> $ diffstat patch-2.6.29-ftrace4mips-fix1
>  arch/mips/Kconfig              |    5
>  arch/mips/Makefile             |    2
>  arch/mips/include/asm/ftrace.h |   68 +++++++
>  arch/mips/kernel/Makefile      |   12 +
>  arch/mips/kernel/csrc-r4k.c    |    2
>  arch/mips/kernel/ftrace.c      |  382 +++++++++++++++++++++++++++++++++++++++++
>  arch/mips/kernel/mcount.S      |  224 ++++++++++++++++++++++++
>  arch/mips/kernel/mips_ksyms.c  |    5
>  arch/mips/kernel/vmlinux.lds   |  218 +++++++++++++++++++++++
>  arch/mips/kernel/vmlinux.lds.S |    1
>  include/linux/clocksource.h    |    4
>  kernel/sched_clock.c           |    2
>  kernel/time/tick-sched.c       |    2
>  kernel/trace/ring_buffer.c     |   22 ++
>  scripts/Makefile.build         |    1
>  scripts/recordmcount.pl        |   27 ++
>  16 files changed, 968 insertions(+), 9 deletions(-)
> 
> 
> -- 
> Studying engineer. Wu Zhangjin
> Lanzhou University      http://www.lzu.edu.cn
> Distributed & Embedded System Lab      http://dslab.lzu.edu.cn
> School of Information Science and Engeneering         http://xxxy.lzu.edu.cn
> wuzhangjin@gmail.com         http://falcon.oss.lzu.edu.cn
> Address:Tianshui South Road 222,Lanzhou,P.R.China    Zip Code:730000
> Tel:+86-931-8912025



> 
> $ diffstat patch-2.6.29-ftrace4mips-fix1
>  arch/mips/Kconfig              |    5
>  arch/mips/Makefile             |    2
>  arch/mips/include/asm/ftrace.h |   68 +++++++
>  arch/mips/kernel/Makefile      |   12 +
>  arch/mips/kernel/csrc-r4k.c    |    2
>  arch/mips/kernel/ftrace.c      |  382 +++++++++++++++++++++++++++++++++++++++++
>  arch/mips/kernel/mcount.S      |  224 ++++++++++++++++++++++++
>  arch/mips/kernel/mips_ksyms.c  |    5
>  arch/mips/kernel/vmlinux.lds   |  218 +++++++++++++++++++++++
>  arch/mips/kernel/vmlinux.lds.S |    1
>  include/linux/clocksource.h    |    4
>  kernel/sched_clock.c           |    2
>  kernel/time/tick-sched.c       |    2
>  kernel/trace/ring_buffer.c     |   22 ++
>  scripts/Makefile.build         |    1
>  scripts/recordmcount.pl        |   27 ++
>  16 files changed, 968 insertions(+), 9 deletions(-)
> 
> 
> -- 
> Studying engineer. Wu Zhangjin
> Lanzhou University      http://www.lzu.edu.cn
> Distributed & Embedded System Lab      http://dslab.lzu.edu.cn
> School of Information Science and Engeneering         http://xxxy.lzu.edu.cn
> wuzhangjin@gmail.com         http://falcon.oss.lzu.edu.cn
> Address:Tianshui South Road 222,Lanzhou,P.R.China    Zip Code:730000
> Tel:+86-931-8912025
