Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 20:33:55 +0200 (CEST)
Received: from nixon.xkey.com ([209.245.148.124]:22740 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S1122987AbSIQSdy>;
	Tue, 17 Sep 2002 20:33:54 +0200
Received: (qmail 6665 invoked from network); 17 Sep 2002 18:33:45 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 17 Sep 2002 18:33:45 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id g8HIVbx02025
	for linux-mips@linux-mips.org; Tue, 17 Sep 2002 11:31:37 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Tue, 17 Sep 2002 11:31:36 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: [RFC] FPU context switch
Message-ID: <20020917113136.A1890@wumpus.internal.keyresearch.com>
References: <20020917110423.E17321@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020917110423.E17321@mvista.com>; from jsun@mvista.com on Tue, Sep 17, 2002 at 11:04:23AM -0700
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Tue, Sep 17, 2002 at 11:04:23AM -0700, Jun Sun wrote:

> Currently I am leaning towards 2) or 3).  What is your opinion?

(1) and (2) are how other archs like Alpha and Itanium deal with
this. I think (3) is likely to be painful to debug and maintain and
won't win much. So I'd suggest (2).

g
