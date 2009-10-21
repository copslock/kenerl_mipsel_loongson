Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 19:23:51 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:35624 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493558AbZJURXp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 19:23:45 +0200
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta03.mail.rr.com with ESMTP
          id <20091021172335044.QHKD15360@hrndva-omta03.mail.rr.com>;
          Wed, 21 Oct 2009 17:23:35 +0000
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for
 MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <4ADF3FE0.5090104@caviumnetworks.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
	 <5dda13e8e3a9c9dba4bb7179183941bda502604f.1256135456.git.wuzhangjin@gmail.com>
	 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
	 <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
	 <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>
	 <1256141540.18347.3118.camel@gandalf.stny.rr.com>
	 <4ADF38D5.9060100@caviumnetworks.com>
	 <1256143568.18347.3169.camel@gandalf.stny.rr.com>
	 <4ADF3FE0.5090104@caviumnetworks.com>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Wed, 21 Oct 2009 13:23:33 -0400
Message-Id: <1256145813.18347.3210.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Wed, 2009-10-21 at 10:07 -0700, David Daney wrote:

> I have not used -pg, so I don't know for sure, I think all it does is 
> add the calls to _mcount.  Someone could investigate 
> -fno-omit-frame-pointer, with that you may be able to use:

Note, -pg assumes -fno-omit-frame-pointer, since -fomit-frame-pointer
and -pg are incompatible.

> 
>     move    s8,sp
> 
> To identify function prologs, but it would still be ad hoc, as modern 
> versions of GCC will reorder instructions in the prolog for better 
> scheduling.

I'll have to search the ABI documentation about calling _mcount in MIPS.
There are assumptions with _mcount that are made. It may very well be
safe to assume that the move s8,sp will always be there before an mcount
call.

-- Steve
