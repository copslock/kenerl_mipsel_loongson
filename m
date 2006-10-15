Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Oct 2006 22:47:33 +0100 (BST)
Received: from farad.aurel32.net ([82.232.2.251]:13760 "EHLO farad.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20039513AbWJOVrb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Oct 2006 22:47:31 +0100
Received: from bode.aurel32.net ([2001:618:400:fc13:211:9ff:feed:c498] helo=[IPv6:2001:618:400:fc13:211:9ff:feed:c498])
	by farad.aurel32.net with esmtps (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GZDpN-0007ee-DW; Sun, 15 Oct 2006 23:47:25 +0200
Message-ID: <4532AC6D.7060201@aurel32.net>
Date:	Sun, 15 Oct 2006 23:47:25 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: SYS_personality does not work correctly on mips(el)64
References: <452EB653.7070604@aurel32.net> <20061013095206.GA4027@networkno.de> <4532A415.1080801@aurel32.net> <20061015212746.GA25607@networkno.de>
In-Reply-To: <20061015212746.GA25607@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Thiemo Seufer a écrit :
> Aurelien Jarno wrote:
>> Thiemo Seufer a écrit :
>>> Aurelien Jarno wrote:
>>>> Hi all,
>>>>
>>>> On mips(el), when doing multiple call to the syscall SYS_personality in 
>>>> order to get the current personality (using 0xffffffff for the first 
>>>> argument), on a 64-bit kernel, the second and subsequent syscalls are 
>>>> failing. That works correctly with a 32-bit kernels and on other 
>>>> architectures.
>>> That's caused by mis-handling broken sign extensions, see also
>>> http://bugs.debian.org/380531.
>> I still got the exact same problem with this patch applied.
> 
> I works for me on a bcm91480b in big endian mode.

Oops, you are right, I booted the wrong kernel. Sorry!

-- 
   .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
  : :' :  Debian developer           | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
