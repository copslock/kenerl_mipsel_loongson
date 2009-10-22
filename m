Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 23:31:20 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8437 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493004AbZJVVbO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 23:31:14 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae0cefe0000>; Thu, 22 Oct 2009 14:30:43 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 14:29:56 -0700
Received: from localhost ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 14:29:56 -0700
From:	Adam Nemet <anemet@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <19168.52948.22223.757259@ropi.home>
Date:	Thu, 22 Oct 2009 14:29:56 -0700
To:	rostedt@goodmis.org
Cc:	David Daney <ddaney@caviumnetworks.com>, wuzhangjin@gmail.com,
	Richard Sandiford <rdsandiford@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH -v4 4/9] tracing: add static function tracer support
 for MIPS
In-Reply-To: <1256244726.20866.802.camel@gandalf.stny.rr.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	<2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	<3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	<ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	<1256138686.18347.3039.camel@gandalf.stny.rr.com>
	<1256233679.23653.7.camel@falcon>
	<4AE0A5BE.8000601@caviumnetworks.com>
	<19168.49354.525249.654494@ropi.home>
	<1256244726.20866.802.camel@gandalf.stny.rr.com>
X-Mailer: VM 8.0.9 under Emacs 23.0.93.1 (x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 22 Oct 2009 21:29:56.0713 (UTC) FILETIME=[CD22ED90:01CA535E]
Return-Path: <Adam.Nemet@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemet@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Steven Rostedt writes:
> On Thu, 2009-10-22 at 13:30 -0700, Adam Nemet wrote:
> > Also note that for functions invoked via tail call you won't get an exit
> > event.  E.g. if bar is tail-called from foo:
> > 
> >   foo entered
> >   bar entered
> >   foo/bar exited
> > 
> > However, this is not MIPS-specific and you can always disable tail calls
> > with -fno-optimize-sibling-calls.
> 
> The question is, would bar have a _mcount call? So far, we have not had
> any issues with this on either x86 nor PPC.

Yes, bar will have an _mcount call.  The difference is that bar will return to
foo's caller directly rather than to foo first.

Adam
