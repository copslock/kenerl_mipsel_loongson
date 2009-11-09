Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 13:49:01 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:36635 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492621AbZKIMsy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 13:48:54 +0100
Received: from [127.0.0.1] (really [74.67.89.75])
          by hrndva-omta03.mail.rr.com with ESMTP
          id <20091109124845440.KTHA6318@hrndva-omta03.mail.rr.com>;
          Mon, 9 Nov 2009 12:48:45 +0000
Subject: Re: [PATCH -v6 08/13] tracing: add IRQENTRY_EXIT section for MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
To:	wuzhangjin@gmail.com
Cc:	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <1257737468.3451.9.camel@falcon.domain.org>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
	 <f746f813531a16bd650f9290787c66cbc0cdc34d.1256569489.git.wuzhangjin@gmail.com>
	 <20091109022640.GC13153@nowhere>
	 <1257737468.3451.9.camel@falcon.domain.org>
Content-Type: text/plain
Date:	Mon, 09 Nov 2009 07:46:37 -0500
Message-Id: <1257770797.2845.4.camel@frodo>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Mon, 2009-11-09 at 11:31 +0800, Wu Zhangjin wrote:
> Hi,

> BTW: 
> 
> Who should I resend this patchset to? you or Steven? If this patchset
> are okay, I will rebase it on the latest tracing/core branch of -tip and
> send the latest version out, and hope you can apply it, otherwise, I
> need to rebase it to the future mainline versions again and again ;) and
> at least, I have tested all of them and their combinations on YeeLoong
> netbook, they work well. of course, more testing report from the other
> MIPS developers are welcome ;)

Just Cc Frederic, Ingo and myself. We'll figure out who will pull it in.
I'll probably do it since I have the MIPS box to do the testing.

Note, I'm currently in NYC at a conference and will not be pulling in
anything till Wednesday when I get back.

Any changes to MIPS arch must have an Acked-by: the MIPS maintainer
(Ralf?) before anything can be pulled in.

Thanks!

-- Steve
