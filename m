Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 19:57:48 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:30926 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20023690AbXIYS5p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 19:57:45 +0100
Received: from webmail.wesleyan.edu (pony2.wesleyan.edu [129.133.6.193])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l8PIujri031696;
	Tue, 25 Sep 2007 14:56:45 -0400
Received: from 69.183.163.198
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 25 Sep 2007 14:56:46 -0400 (EDT)
Message-ID: <55879.69.183.163.198.1190746606.squirrel@webmail.wesleyan.edu>
In-Reply-To: <20070925184317.GB15556@deprecation.cyrius.com>
References: <20070925181353.GA15412@deprecation.cyrius.com>
    <57307.69.183.163.198.1190745167.squirrel@webmail.wesleyan.edu>
    <20070925184317.GB15556@deprecation.cyrius.com>
Date:	Tue, 25 Sep 2007 14:56:46 -0400 (EDT)
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
From:	sknauert@wesleyan.edu
To:	"Martin Michlmayr" <tbm@cyrius.com>
Cc:	sknauert@wesleyan.edu, linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.10a
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
X-archive-position: 16676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

> * sknauert@wesleyan.edu <sknauert@wesleyan.edu> [2007-09-25 11:32]:
>> > One, make sure you're doing "make vmlinux.32", and two,
>> CONFIG_BUILD_ELF64
>
> I should say that I'm indeed using "make vmlinux.32".  Anyway, I see
> no reason why this would break, especially given that it used to work.
> And if it really isn't supported anymore, make it impossible to chose
> CONFIG_BUILD_ELF64 on IP32.
> --
> Martin Michlmayr
> http://www.cyrius.com/
>
>
Sorry, you're misinterpreting what I said. The indented text was the
advice given to me by Kumba (I highlighted the part of the linked thread)
of why a 64-bit kernel won't work. Or at least I think that's what he was
saying. Since you asked when 64-bit on IP32 was killed, and what patches
did it, I thought this information might help.
