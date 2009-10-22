Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 20:00:42 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:43769 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493329AbZJVSAg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 20:00:36 +0200
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta01.mail.rr.com with ESMTP
          id <20091022180029919.EDFU26298@hrndva-omta01.mail.rr.com>;
          Thu, 22 Oct 2009 18:00:29 +0000
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for
 MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	wuzhangjin@gmail.com, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <4AE08559.40806@caviumnetworks.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
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
	 <1256145813.18347.3210.camel@gandalf.stny.rr.com>
	 <1256211516.3852.47.camel@falcon>  <4AE08173.7070500@caviumnetworks.com>
	 <1256227916.20866.784.camel@gandalf.stny.rr.com>
	 <4AE08559.40806@caviumnetworks.com>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Thu, 22 Oct 2009 14:00:28 -0400
Message-Id: <1256234428.20866.797.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Thu, 2009-10-22 at 09:16 -0700, David Daney wrote:
> Steven Rostedt wrote:

> > Functions that run off into another function?? I guess the compiler
> > could do that, but with -pg enable, I would think is broken.
> > 
> 
> Use of GCC-4.5's __builtin_unreachable() can lead to this, as well as 
> functions that call noreturn functions.

But still. Should that unreachable code have a "save ra to stack"? If
not, this method is still safe.

-- Steve
