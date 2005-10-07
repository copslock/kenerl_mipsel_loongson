Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 09:39:06 +0100 (BST)
Received: from alg145.algor.co.uk ([62.254.210.145]:63244 "EHLO
	dmz.algor.co.uk") by ftp.linux-mips.org with ESMTP id S8133560AbVJGIiu
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 09:38:50 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1ENni8-00012U-00; Fri, 07 Oct 2005 09:36:12 +0100
Received: from wapping.algor.co.uk ([172.20.192.98])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1ENnkE-0000oc-00; Fri, 07 Oct 2005 09:38:22 +0100
Message-ID: <43463403.8080407@mips.com>
Date:	Fri, 07 Oct 2005 09:38:27 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	colin <colin@realtek.com.tw>
CC:	linux-mips@linux-mips.org
Subject: Re: gcc of SDE6 cannot compile C++ applications
References: <002701c5cb08$c9682630$106215ac@realtek.com.tw>
In-Reply-To: <002701c5cb08$c9682630$106215ac@realtek.com.tw>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-3.766,
	required 4, AWL, BAYES_00, XENO_CONTENT)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



colin wrote:

>Hi there,
>I upgrade my SDE from 5 to 6.
>Before upgrading, we can compile C++ applications. After doing that, C++
>cannot be compiled by the gcc of SDE6.
>The warning message is like this:
>    mipsel-linux-gcc: main.cpp: C++ compiler not installed on this system
>
>I found that MIPS offers C++ compiler running on MIPS.
>Does MIPS want us to compile C++ on MIPS, not on X86?
>  
>

I recommend that you contact sde@mips.com with questions about SDE. The
linux-mips community probably isn't very interested in these issues ;-(

As to your question: the SDE cross-compiler is intended only for
cross-compiling kernels, and not applications, so we don't currently
build the C++ compiler for x86 (until Linus does a rewrite in C++, I
suppose). So yes, the current expectation is that you would compile
applications, including C++, on a MIPS platform.

Nigel
