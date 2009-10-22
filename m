Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 19:59:36 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:44560 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493329AbZJVR73 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 19:59:29 +0200
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta03.mail.rr.com with ESMTP
          id <20091022175922804.MUFD15360@hrndva-omta03.mail.rr.com>;
          Thu, 22 Oct 2009 17:59:23 +0000
Subject: Re: [PATCH -v4 4/9] tracing: add static function tracer support
 for MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	wuzhangjin@gmail.com
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <1256233679.23653.7.camel@falcon>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <1256138686.18347.3039.camel@gandalf.stny.rr.com>
	 <1256233679.23653.7.camel@falcon>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Thu, 22 Oct 2009 13:59:21 -0400
Message-Id: <1256234361.20866.796.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Fri, 2009-10-23 at 01:47 +0800, Wu Zhangjin wrote:
> On Wed, 2009-10-21 at 11:24 -0400, Steven Rostedt wrote:

> > Is t0 and t1 safe for mcount to use? Remember, mcount does not follow
> > the dynamics of C function ABI.
> 
> So, perhaps we can use the saved registers(a0,a1...) instead.

I don't know. I was just asking.

-- Steve
