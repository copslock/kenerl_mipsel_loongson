Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 15:15:23 +0000 (GMT)
Received: from relay4.aport.ru ([194.67.18.135]:51952 "HELO relay4.aport.ru")
	by ftp.linux-mips.org with SMTP id S8134400AbWASPPG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2006 15:15:06 +0000
Received: (qmail 20503 invoked from network); 19 Jan 2006 15:18:55 -0000
Received: from webmail.aport.ru ([194.67.18.2]) (envelope-sender <olegol@aport.ru>)
          by relay4.aport.ru
          for <geoman@gentoo.org>; 19 Jan 2006 15:18:55 -0000
Content-Type: text/plain; charset="koi8-r"
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Message-Id: <VJSxoX-x5jIgi-R@aport2000.ru>
X-Originating-Ip: [175.37.2.205, 217.147.104.223]
Subject: Re: Re: GTK/GLIB port for mipsel
From:	olegol@aport.ru
References: <43CFA8DC.9050904@gentoo.org>
X-Mailer: Aport Webmail 2.2
Date:	Thu, 19 Jan 2006 18:18:56 +0300
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <43CFA8DC.9050904@gentoo.org>
Return-Path: <olegol@aport.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: olegol@aport.ru
Precedence: bulk
X-list: linux-mips

>I suspect that glib is broken for cross-compile in this 
way.  It is 
>probably detecting that your host i686 install can use 
asm code for 
>atomic operations, and thus enables it, which of course 
kills your 
>build.  Natively, it looks like it does the RightThing
(TM):
>
>checking whether to use assembler code for atomic 
operations... none

Steve, you are absolutely correct!
I've just encountered the same thing.
I fixed the configure script and it now does not forces 
the atomic operations to be compiled in asm - it takes C 
implementation instead.

Thanks a lot!

With respect,
Oleg Kruzhkov
