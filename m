Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 10:11:59 +0100 (BST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:20389 "EHLO
	t111.niisi.ras.ru") by ftp.linux-mips.org with ESMTP
	id S20021348AbXGQJL5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jul 2007 10:11:57 +0100
Received: from t111.niisi.ras.ru (localhost [127.0.0.1])
	by t111.niisi.ras.ru (8.13.4/8.13.4) with ESMTP id l6H9BfpD005485;
	Tue, 17 Jul 2007 13:11:41 +0400
Received: (from uucp@localhost)
	by t111.niisi.ras.ru (8.13.4/8.13.4/Submit) with UUCP id l6H9BfBc005482;
	Tue, 17 Jul 2007 13:11:41 +0400
Received: from [192.168.173.21] (aa248 [172.16.0.248])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id l6H9BrGh020799;
	Tue, 17 Jul 2007 13:11:53 +0400
Message-ID: <469C8600.7090208@niisi.msk.ru>
Date:	Tue, 17 Jul 2007 13:04:00 +0400
From:	Sergey Rogozhkin <rogozhkin@niisi.msk.ru>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	"Gleb O. Raiko" <raiko@niisi.msk.ru>, Kumba <kumba@gentoo.org>
Subject: Re: O2 RM7000 Issues
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org> <20070704192208.GA7873@linux-mips.org>
In-Reply-To: <20070704192208.GA7873@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <rogozhkin@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rogozhkin@niisi.msk.ru
Precedence: bulk
X-list: linux-mips


> Big loud bell began ringing.  The RM7000 fetches and decodes multiple
> instructions in one go.  And just like the E9000 cores it does
> throw an exception if it doesn't like one of the opcodes even if that
> doesn't actually get executed.  The kernel has a workaround for this
> PMC-Sierra peculiarity (I call it a bug) but it's only being activated
> for E9000 platforms.

Are you really sure RM7000 has this bug? Workaround mentioned above 
breaks gcc signal frame unwinding mechanism: it search for sigcontext 
struct at fixed offset from signal trampoline.

And one another known RM7000 bug, maybe not taken into account by linux: 
errata 38. r4k_wait is not suitable for RM7000 on some systems. I don't 
know if "O2" is affected.

Sergey Rogozhkin
