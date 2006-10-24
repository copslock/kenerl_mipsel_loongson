Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 16:34:16 +0100 (BST)
Received: from alpha.total-knowledge.com ([205.217.158.170]:53692 "EHLO
	total-knowledge.com") by ftp.linux-mips.org with ESMTP
	id S20039704AbWJXPeL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Oct 2006 16:34:11 +0100
Received: (qmail 32255 invoked from network); 24 Oct 2006 08:34:00 -0700
Received: from unknown (HELO ?192.168.0.236?) (ilya@209.157.142.202)
  by alpha.total-knowledge.com with ESMTPA; 24 Oct 2006 08:34:00 -0700
Message-ID: <453E3264.6000405@total-knowledge.com>
Date:	Tue, 24 Oct 2006 08:33:56 -0700
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Karl-Johan Karlsson <creideiki+linux-mips@ferretporn.se>,
	linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
References: <200610212159.04965.creideiki+linux-mips@ferretporn.se> <20061022232316.GA19127@linux-mips.org> <20061023001947.GA10853@linux-mips.org> <200610232330.23498.creideiki+linux-mips@ferretporn.se> <20061023224318.GA1732@linux-mips.org> <53979.136.163.203.3.1161698036.squirrel@www.ferretporn.se> <20061024140614.GB27800@linux-mips.org>
In-Reply-To: <20061024140614.GB27800@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips



Ralf Baechle wrote:
> On Tue, Oct 24, 2006 at 03:53:56PM +0200, Karl-Johan Karlsson wrote:
>   
>> Now that I actually look at Gentoo's patchset, I see there's a large patch
>> (misc-2.6.17-ioc3-metadriver-r26.patch) touching serial and ethernet
>> drivers for the IOC3. Perhaps the snapshot actually did boot, but just
>> couldn't talk to me without that patch? The patch doesn't apply to the
>> current git, though, so I think I'll leave that to someone who knows what
>> they're doing.
>>     
>
> That metadriver thing is primarily necessary for the sake of Octanes.
>   
Actually I wasn't able to get my O2K to boot without it, last time
I tried.
>   Ralf
>   

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
