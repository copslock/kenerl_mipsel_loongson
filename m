Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 21:05:27 +0200 (CEST)
Received: from nixon.xkey.com ([209.245.148.124]:51671 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S1122987AbSIQTF0>;
	Tue, 17 Sep 2002 21:05:26 +0200
Received: (qmail 13178 invoked from network); 17 Sep 2002 19:05:19 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 17 Sep 2002 19:05:19 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id g8HJ3AM02250;
	Tue, 17 Sep 2002 12:03:10 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Tue, 17 Sep 2002 12:03:10 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [RFC] FPU context switch
Message-ID: <20020917120310.A2043@wumpus.internal.keyresearch.com>
References: <20020917110423.E17321@mvista.com> <1032288140.28433.165.camel@gs256.sp.cs.cmu.edu> <20020917114831.G17321@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020917114831.G17321@mvista.com>; from jsun@mvista.com on Tue, Sep 17, 2002 at 11:48:31AM -0700
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Tue, Sep 17, 2002 at 11:48:31AM -0700, Jun Sun wrote:

> I think this gives a big performance improvement because most processes
> don't use FPU during their runs but they all have used_math flag set!

Jun,

You really ought to prove that first. Many people spend a lot of time
optimizing things that aren't important. If it isn't important, than
the simplest scheme is the best choice.

greg
