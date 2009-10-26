Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 15:01:25 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:53421 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493041AbZJZOBS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 15:01:18 +0100
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta01.mail.rr.com with ESMTP
          id <20091026140108718.QVYP20264@hrndva-omta01.mail.rr.com>;
          Mon, 26 Oct 2009 14:01:08 +0000
Subject: Re: [PATCH -v5 02/11] MIPS: add mips_timecounter_read() to get
 high precision timestamp
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
	 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Mon, 26 Oct 2009 10:01:07 -0400
Message-Id: <1256565667.26028.257.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Sun, 2009-10-25 at 23:16 +0800, Wu Zhangjin wrote:
> This patch implement a mips_timecounter_read(), which can be used to get
> high precision timestamp without extra lock.
> 
> It is based on the clock counter register and the
> timecounter/cyclecounter abstraction layer of kernel.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/include/asm/time.h |   19 +++++++++++++++++++
>  arch/mips/kernel/csrc-r4k.c  |   41 +++++++++++++++++++++++++++++++++++++++++
>  arch/mips/kernel/time.c      |    2 ++

Some patches touch core tracing code, and some are arch specific. Now
the question is how do we go. I prefer that we go the path of the
tracing tree (easier for me to test). But every patch that touches MIPS
arch, needs an Acked-by from the MIPS maintainer. Which I see is Ralf
(on the Cc of this patch set.)

Thanks,

-- Steve
