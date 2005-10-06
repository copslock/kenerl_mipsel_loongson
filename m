Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 08:29:51 +0100 (BST)
Received: from mailout01.sul.t-online.com ([194.25.134.80]:3205 "EHLO
	mailout01.sul.t-online.com") by ftp.linux-mips.org with ESMTP
	id S8133532AbVJFH3g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 08:29:36 +0100
Received: from fwd31.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1ENQC7-0005M2-02; Thu, 06 Oct 2005 09:29:35 +0200
Received: from denx.de (SOkMwmZVre8yPsLo7eQDPyoPWdgo6abFTP+ER70FSaoInTW0cZK+46@[84.150.104.90]) by fwd31.sul.t-online.de
	with esmtp id 1ENQC2-0FuMQi0; Thu, 6 Oct 2005 09:29:30 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id D36DD42EED; Thu,  6 Oct 2005 09:29:29 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 068D3353D93;
	Thu,  6 Oct 2005 09:29:24 +0200 (MEST)
To:	Arravind babu <aravindforl@yahoo.co.in>
Cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: Basic question w.r.t bootloader 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Thu, 06 Oct 2005 07:53:32 BST."
             <20051006065332.6978.qmail@web8604.mail.in.yahoo.com> 
Date:	Thu, 06 Oct 2005 09:29:24 +0200
Message-Id: <20051006072924.068D3353D93@atlas.denx.de>
X-ID:	SOkMwmZVre8yPsLo7eQDPyoPWdgo6abFTP+ER70FSaoInTW0cZK+46@t-dialin.net
X-TOI-MSGID: 27b933b6-027c-49bd-aef5-d132cf33b1b1
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20051006065332.6978.qmail@web8604.mail.in.yahoo.com> you wrote:
> 
>        Generally how bootloader/bootflash code detects
> the size of RAM on the board? Is it hardcoded some
> where in the bootflash code or is it detected using
> memory chips ?

One method is to probe addresses (at N, 2*N, 4*N etc. starting with a
resonable value of N like 1 MB) until probing fails. See for  example
common/memsize.c in the U-Boot sources.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The IQ of the group is the lowest IQ of a member of the group divided
by the number of people in the group.
