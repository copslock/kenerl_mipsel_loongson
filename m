Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 20:52:33 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:25833 "HELO
	duck.specifix.com") by ftp.linux-mips.org with SMTP
	id S8133493AbWD1TwX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Apr 2006 20:52:23 +0100
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id E83E6FCBF; Fri, 28 Apr 2006 12:52:07 -0700 (PDT)
Subject: Re: problem with mips-linux gprof
From:	James E Wilson <wilson@specifix.com>
To:	dhunjukrishna@gmail.com
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <20060428063712.39756.qmail@web53501.mail.yahoo.com>
References: <20060428063712.39756.qmail@web53501.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1146253927.15759.16.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Fri, 28 Apr 2006 12:52:07 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Thu, 2006-04-27 at 23:37, Krishna wrote:
> But i get the following error message
> mips-unknown-linux-gnu-gprof: gmon.out file is missing call-graph data

Add a second function to your testcase.  You have to have at least two
functions in order to have a call graph.

If your testcase has only one function, main, then there will be no
useful call graph info, so the -pg library support won't bother to emit
one, and then gprof complains that it is missing.  This is correct, but
not very useful, and perhaps should be considered a bug.  I think gprof
should just default to emitting a flat profile in this case, without
giving an error, so I'd call this a binutils bug.

In the absence of call-graph info, you can use the gprof -p option to
get a flat profile.

The above assumes you don't have a profiled C library available.  If you
did, then you would have at least two profiled functions, main and
printf, and would have gotten some call graph info emitted.  If you
don't have a profiled C library available, you could try compiling one
yourself.  There is a glibc configure option --enable-profile for that. 
I've never tried this myself.  I'd expect this to be a non-trivial
exercise.  Besides the issue of compiling glibc, you also need to
install the profiled library, and arrange to link with it.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
