Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2005 16:29:30 +0000 (GMT)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.61]:36534 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8225786AbVCCQ3N>; Thu, 3 Mar 2005 16:29:13 +0000
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 80085F4F148
	for <linux-mips@linux-mips.org>; Thu,  3 Mar 2005 16:29:03 +0000 (UTC)
Received: from [192.168.0.85] (unknown [83.104.11.251])
	by smtp-2.hotpop.com (Postfix) with ESMTP
	id C253CF4F0E4; Thu,  3 Mar 2005 16:29:01 +0000 (UTC)
Subject: Re: Newbie : Cross-compiling module for wrt54g
From:	JP <jaypee@hotpop.com>
To:	Christophe Jelger <Christophe.Jelger@unibas.ch>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <42272589.7000802@unibas.ch>
References: <42272589.7000802@unibas.ch>
Content-Type: text/plain
Date:	Thu, 03 Mar 2005 16:29:04 +0000
Message-Id: <1109867344.9625.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Return-Path: <jaypee@hotpop.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

Christophe

> The issues I have are : tools to use, kernel-header files versions 
> (wrt54g uses 2.4.20, means do I have to compile on a 2.4.20 machine ?), 
> debugging on wrt54g (can I use standard log-file ?).

You'll need the header files that linksys used which may or may not be
different to the 2.4.10 vanilla kernel headers

for the wrt54g you can get the right code for your FW rev here.
http://www.linksys.com/support/gpl.asp

Here's a page about tools
http://www.linux-mips.org/wiki/index.php/Toolchains

You might need an older toolchain to build 2.4 kernels.
Anyone have any success on build 2.4.x with gcc 3.x?

Don't take my word for it though I've been using a recentish gcc-3.4.1
built using uclibc's buildroot to build 
It was pretty easy to get working and install.

For our 2.4 kernels I used a montavista toolchain for the last few
years. mvista.com requires you register.

Happy hacking

-- 
JP <jaypee@hotpop.com>
