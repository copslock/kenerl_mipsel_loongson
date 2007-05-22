Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 14:35:25 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:50829 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20022882AbXEVNfU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 May 2007 14:35:20 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l4MDW4no028568
	for <linux-mips@linux-mips.org>; Tue, 22 May 2007 09:32:04 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l4MDW4a4015465;
	Tue, 22 May 2007 09:32:04 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 22 May 2007 06:32:04 -0700 (PDT)
Message-ID: <36324.129.133.92.31.1179840724.squirrel@webmail.wesleyan.edu>
In-Reply-To: <20070522122808.GD32557@linux-mips.org>
References: <1178743456.15447.41.camel@scarafaggio>
    <20070516151939.GH19816@deprecation.cyrius.com>
    <20070516160313.GA3409@bongo.bofh.it>
    <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>
    <20070517151636.GJ3586@deprecation.cyrius.com>
    <20070521154726.GE5943@linux-mips.org>
    <20070522110956.GB29118@linux-mips.org>
    <1179834093.7896.23.camel@scarafaggio>
    <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu>
    <20070522122808.GD32557@linux-mips.org>
Date:	Tue, 22 May 2007 06:32:04 -0700 (PDT)
Subject: Re: SGI O2 meth: missing sysfs device symlink
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.192
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

> On Tue, May 22, 2007 at 08:01:53AM -0400, sknauert@wesleyan.edu wrote:
>
>> I've noticed that besides kernel complied from the Debian 2.6.18, I
>> can't
>> get any other kernel (vanilla from kernel.org or the separate linux-MIPS
>> repository) to boot on my O2.
>>
>> If you need beta testers, I can try, but it will take a day or so
>> (compiling on the O2 is slow).
>
> Sounds almost like you're building an excessibly large kernel
> configuration.
> A realistic kernel config will crosscompile within a few minutes on a
> modest machine such as a 3GHz / 1GB P4-class PC.
>

I could never get cross-compiling to work, so I've been doing all my
compiling directly on the R5K 300 Mhz CPU in my O2. If there is an easy
way to get this to work, I'd be very thankful for some pointers. Might my
trying to compile on the actual machine be why I can't seem to use any
source other than Debian's 2.6.18?

> But to lessen the pains of your aching CPU, here's a binary tarball:
>
> ftp://ftp.linux-mips.org/pub/linux/mips/people/ralf/sgi-ip32/linux-2.6.22-rc2-gc6b5a619-dirty.tar.bz2
>

Thanks. I installed the kernel and arcboot was able to load it, but
nothing showed up on the screen. Does this have framebuffer support? In
was also unable to ssh in. Does this kernel have the necessary support for
that? It didn't fault at boot (like most of my nonbootable kernel do) and
I did hear the standard startup hard drive activity, so things may be
working. I was also able to get a response from the power button to
correctly reboot. Sadly I lack the necessary null modem cable for a serial
console (if this was the only interface you configured). If you can crank
out a new one with framebuffer support just as quickly, I'll gladly give
it a whirl.

>> Finally, I've been working on the PCI Legacy IO issue (progress is sadly
>> slow - don't have a fully compiling patchset yet), would this patch be
>> relevant since its also an O2 sysfs issue?
>
> The two issues are entirely unrelated.
>
>   Ralf
>

Nice to know.
