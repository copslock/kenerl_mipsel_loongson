Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 04:48:24 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:55965 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491783AbZJUCsR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 04:48:17 +0200
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta02.mail.rr.com with ESMTP
          id <20091021024807393.FHXM6809@hrndva-omta02.mail.rr.com>;
          Wed, 21 Oct 2009 02:48:07 +0000
Subject: Re: ftrace for MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	wuzhangjin@gmail.com
Cc:	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <1256092395.5482.32.camel@falcon>
References: <1255995599.17795.15.camel@falcon>
	 <1255997319.18347.576.camel@gandalf.stny.rr.com>
	 <1256052667.8149.56.camel@falcon>
	 <1256055714.18347.1608.camel@gandalf.stny.rr.com>
	 <1256092395.5482.32.camel@falcon>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Tue, 20 Oct 2009 22:48:06 -0400
Message-Id: <1256093286.18347.2245.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Wed, 2009-10-21 at 10:33 +0800, Wu Zhangjin wrote:
> Hi, all
> 
> Just made it(function graph tracer for MIPS) work :-)
> 
> The problem is that: the stack offset should be from 0 to PT_SIZE(304),
> but I mask it with 0xff(256), which is totally wrong.
> 
> Here is an example, the stack address of ra(return address) should be
> (s8 + ffbf0128 & 0xfff).
> 
> ffffffff801dad10 <do_sync_read>:
> ffffffff801dad10:       67bdfed0        daddiu  sp,sp,-304
> ffffffff801dad14:       ffbe0120        sd      s8,288(sp)
> ffffffff801dad18:       03a0f02d        move    s8,sp
> ffffffff801dad1c:       ffbf0128        sd      ra,296(sp)
> ffffffff801dad20:       ffb30118        sd      s3,280(sp)
> ffffffff801dad24:       ffb20110        sd      s2,272(sp)
> ffffffff801dad28:       ffb10108        sd      s1,264(sp)
> ffffffff801dad2c:       ffb00100        sd      s0,256(sp)
> ffffffff801dad30:       03e0082d        move    at,ra
> ffffffff801dad34:       0c042ab0        jal     ffffffff8010aac0
> <_mcount>
> ffffffff801dad38:       00020021        nop
> 
> Thanks! will send the patches out later.

Great to hear that it works! When I get my cross compiling working I'll
test out your patches.

I'll also probably update them to use the asm() over the probe and
tracing_disable(). That method is very inefficient.

Good work!

-- Steve
