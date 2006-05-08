Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 May 2006 19:35:50 +0100 (BST)
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:57048 "EHLO
	mail8.fw-sd.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133499AbWEHSfk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 May 2006 19:35:40 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id k48IZWc2028327;
	Mon, 8 May 2006 18:35:32 GMT
Received: from [43.134.85.135] ([43.134.85.135])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k48IZWsh005225;
	Mon, 8 May 2006 18:35:32 GMT
Message-ID: <445F8F73.6030808@am.sony.com>
Date:	Mon, 08 May 2006 11:35:31 -0700
From:	Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Tom Rini <trini@kernel.crashing.org>,
	Thiemo Seufer <ths@networkno.de>,
	"Bird, Tim" <Tim.Bird@am.sony.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from envir
 onment var
References: <20060504230647.GA3465@linux-mips.org>
In-Reply-To: <20060504230647.GA3465@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <tim.bird@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tim.bird@am.sony.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, May 04, 2006 at 02:04:49PM -0700, Tom Rini wrote:
> 
>> Let me ask a stupid question.  With all of the ways to otherwise do a
>> cross compile, why a config option on MIPS?  ARM*/SH*, which are at
>> least as likely to not be native-compiled, don't do that.  Just
>> something I've always wondered, really.
> 
> Having such information in an environment variable is imho terribly
> inelegant, having to pass it on the command line for each make
> invocation
> is terrible abuse for the fingertips so I went for this option which
> makes
> the makefile pick the right prefix.

And a great solution it would be, if it actually picked the
right prefix.  :-)  I understand that having the cross-compiler prefix
specified outside the build system has drawbacks.  When I first got
into embedded Linux (many years ago), I was struck by the inelegance
of this also.  However, hardcoding the prefixes in the Makefile is, IMHO,
not such a great idea either.

It really doesn't bother me if the "standard" prefixes are encoded in
a Makefile, but it would be nice to be able to select a non-standard
prefix the same way as for other Linux architectures.

I understand I can do that by turning off the "I'm cross-compiling"
option, but that seems counterintuitive given the current wording
of that option (not-withstanding the not-yet-mainlined help text).

My patch allows to keep the current behaviour, but also supports
use of the environment variable. I don't see any downside to it,
unless you are actively trying to discourage the use of the
environment variable.  In my own experience, use of the environment
variable, while inelegant for manual use, has certain benefits
for automated use.

Regards,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
