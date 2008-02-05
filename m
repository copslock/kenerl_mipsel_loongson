Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Feb 2008 15:23:24 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:18650 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20028989AbYBEPXW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Feb 2008 15:23:22 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m15FN6TW019277;
	Tue, 5 Feb 2008 16:23:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m15FN4mM019276;
	Tue, 5 Feb 2008 16:23:04 +0100
Date:	Tue, 5 Feb 2008 16:23:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Florian Lohoff <flo@rfc822.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080205152304.GA18157@linux-mips.org>
References: <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org> <20080203062711.GA28394@paradigm.rfc822.org> <47A80C0A.4040106@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47A80C0A.4040106@gentoo.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 05, 2008 at 02:11:06AM -0500, Kumba wrote:

>>>> Thomas Bogendoerfer wrote:
>>>>> no suprise here. As Ralf already noted cache barrier is a restricted
>>>>> instruction, it will always cause a illegal instruction when used
>>>>> in user space. Nevertheless it looks like all IP28 are affected
>>>>> by the simple exploit. Flo built glibc 2.7 with LLSC war workaround
>>>>> and this avoids triggering the hang.
>>>> Ah, didn't know the 'cache' instructions was kernel-mode only.  Explains 
>>>> why it survived then :)
>>>>
>>>> How does one enable the LLSC war workaround in glibc?
>>> By modifying the code ;-)
>>
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=462112
>>
>> Flo
>
> Interesting.  Is there a reason the kernel uses an #ifdef to choose between 
> 'bezq' and 'bezql' that's not needed in glibc itself?  Or does glibc itself 
> lack a mechanism to detect CPU types to single out this specific change?
>
> And any idea if uClibc will need similar mods?

The kernel has rather detailed knowledge about which workarounds are
required for what platform and is optimized based on this knowledge.

Userspace is different.  The basic promise is that userspace will run on
any platform above certain minimum specs.  That is something like MIPS II
code is expected to run find on MIPS III or MIPS32 r1 or MIPS64 r2
hardware for example.  This promise includes even workarounds as far as
practicable and occasionally requires doing things that are somewhat
suboptimal for performance or coding style.  But it keeps things
deterministic for users.

  Ralf
