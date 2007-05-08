Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 17:02:17 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:1755 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20021952AbXEHQCP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 May 2007 17:02:15 +0100
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [129.133.6.193])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l48FwvSj007902
	for <linux-mips@linux-mips.org>; Tue, 8 May 2007 11:58:57 -0400
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [127.0.0.1])
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11) with ESMTP id l48FwvSF005963
	for <linux-mips@linux-mips.org>; Tue, 8 May 2007 11:58:57 -0400
Received: (from apache@localhost)
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l48FwvxP005961;
	Tue, 8 May 2007 11:58:57 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 8 May 2007 11:58:57 -0400 (EDT)
Message-ID: <44952.129.133.92.31.1178639937.squirrel@webmail.wesleyan.edu>
In-Reply-To: <20070508163010.1d2dd724@the-village.bc.nu>
References: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
    <20070508122700.262caec4@the-village.bc.nu>
    <55699.129.133.92.31.1178637383.squirrel@webmail.wesleyan.edu>
    <20070508163010.1d2dd724@the-village.bc.nu>
Date:	Tue, 8 May 2007 11:58:57 -0400 (EDT)
Subject: Re: PCI video card on SGI O2
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
X-Originating-IP: 129.133.6.193
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

>> I agree the Voodoo 1 should work. The issue here is that I can compile
>> in
>> tdfx character support for the kernel and still have it boot, but can't
>> boot with tdfx framebuffer support on the O2 for some reason. With just
>> character support lspci IDs the card
>>
>> 00:03.0 PCI VGA compatible controller: ...
>
> That isn't a Voodoo 1 if it reports PCI VGA compatible controller. What
> PCI ident values does it show. Also the tdfx framebuffer is for the later
> chips not the Voodoo1 or Voodoo2 - they use sstfb.
>
> It looks like your card is something else - a Banshee or Rush perhaps ?
>
>
You're quite right. What I have is not a Voodoo 1, but a Banshee. The full
output of lspci does say:

00:03.0 PCI VGA compatible controller: 3Dfx Interactive, Inc. Voodoo
Banshee (rev 03)

Sorry, hadn't had that card in the O2 for awhile.
