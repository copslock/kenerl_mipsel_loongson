Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 13:05:41 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:54405 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20022567AbXEVMFg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 May 2007 13:05:36 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l4MC1siM020808;
	Tue, 22 May 2007 08:01:54 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l4MC1rc7008321;
	Tue, 22 May 2007 08:01:53 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 22 May 2007 08:01:53 -0400 (EDT)
Message-ID: <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu>
In-Reply-To: <1179834093.7896.23.camel@scarafaggio>
References: <1178743456.15447.41.camel@scarafaggio>
    <20070516151939.GH19816@deprecation.cyrius.com>
    <20070516160313.GA3409@bongo.bofh.it>
    <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>
    <20070517151636.GJ3586@deprecation.cyrius.com>
    <20070521154726.GE5943@linux-mips.org>
    <20070522110956.GB29118@linux-mips.org>
    <1179834093.7896.23.camel@scarafaggio>
Date:	Tue, 22 May 2007 08:01:53 -0400 (EDT)
Subject: Re: SGI O2 meth: missing sysfs device symlink
From:	sknauert@wesleyan.edu
To:	"Giuseppe Sacco" <giuseppe@eppesuigoccas.homedns.org>
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
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
X-archive-position: 15124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

I've noticed that besides kernel complied from the Debian 2.6.18, I can't
get any other kernel (vanilla from kernel.org or the separate linux-MIPS
repository) to boot on my O2.

If you need beta testers, I can try, but it will take a day or so
(compiling on the O2 is slow).

Finally, I've been working on the PCI Legacy IO issue (progress is sadly
slow - don't have a fully compiling patchset yet), would this patch be
relevant since its also an O2 sysfs issue?

> Il giorno mar, 22/05/2007 alle 12.09 +0100, Ralf Baechle ha scritto:
>> On Mon, May 21, 2007 at 04:47:26PM +0100, Ralf Baechle wrote:
>>
>> Below patch is meant to cure the problem.  It's against HEAD but should
>> apply to somewhat older problems as well.
>>
>> I appreciate testing asap so I can try to still push this upstream
>> for 2.6.22.
> [...]
>
> I may test it against 2.6.18, the standard debian kernel for stable; but
> I will be on the console only in two days :-(
>
> Bye,
> Giuseppe
>
>
>
>
