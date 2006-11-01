Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 19:11:31 +0000 (GMT)
Received: from outmx014.isp.belgacom.be ([195.238.4.69]:56043 "EHLO
	outmx014.isp.belgacom.be") by ftp.linux-mips.org with ESMTP
	id S20037530AbWKATL0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Nov 2006 19:11:26 +0000
Received: from outmx014.isp.belgacom.be (localhost [127.0.0.1])
        by outmx014.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id kA1JBE8H023381;
	Wed, 1 Nov 2006 20:11:15 +0100
        (envelope-from <wim@iguana.be>)
Received: from infomag.iguana.be (25.55-136-217.adsl-dyn.isp.belgacom.be [217.136.55.25])
        by outmx014.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id kA1JBBKT023341;
	Wed, 1 Nov 2006 20:11:11 +0100
        (envelope-from <wim@iguana.be>)
Received: from infomag.iguana.be (localhost.localdomain [127.0.0.1])
	by infomag.iguana.be (8.13.7/8.12.11) with ESMTP id kA1JBD4A008231;
	Wed, 1 Nov 2006 20:11:13 +0100
Received: (from wim@localhost)
	by infomag.iguana.be (8.13.7/8.13.7/Submit) id kA1JBCpA008230;
	Wed, 1 Nov 2006 20:11:12 +0100
Date:	Wed, 1 Nov 2006 20:11:12 +0100
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thomas Koeller <thomas@koeller.dyndns.org>,
	Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
	"Randy. Dunlap" <rdunlap@xenotime.net>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20061101191112.GB7056@infomag.infomag.iguana.be>
References: <20061101184633.GA7056@infomag.infomag.iguana.be> <20061101185036.GD4736@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101185036.GD4736@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Ralf,

> > Thomas: I moved start and stop code into seperate functions. I also
> > deleted the #include <rm9k_wdt.h> because the file doesn't exist.
> 
> You just didn't see it, include/asm-mips/mach-excite/rm9k_wdt.h.

Thanks, didn't see it indeed :-). I'll include that again.
Any other remarks still?

Greetings,
Wim.
