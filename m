Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 08:48:48 +0100 (BST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:36816 "EHLO
	t111.niisi.ras.ru") by ftp.linux-mips.org with ESMTP
	id S8133556AbVJGHsP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 08:48:15 +0100
Received: from t111.niisi.ras.ru (localhost [127.0.0.1])
	by t111.niisi.ras.ru (8.13.4/8.12.11) with ESMTP id j977m5Ti008827;
	Fri, 7 Oct 2005 11:48:08 +0400
Received: (from uucp@localhost)
	by t111.niisi.ras.ru (8.13.4/8.13.4/Submit) with UUCP id j977m5Hn008824;
	Fri, 7 Oct 2005 11:48:05 +0400
Received: from [192.168.173.2] (t34 [193.232.173.34])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id j977je3t031962;
	Fri, 7 Oct 2005 11:45:40 +0400
Message-ID: <4346272B.4010100@niisi.msk.ru>
Date:	Fri, 07 Oct 2005 11:43:39 +0400
From:	"Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	linux-mips@linux-mips.org
Subject: Re: Bug in the syscall tracing code
References: <43455D2D.1010901@niisi.msk.ru> <20051006205308.GB31717@hattusa.textio>
In-Reply-To: <20051006205308.GB31717@hattusa.textio>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> - Use the k1 slot instead of s0 to save the function pointer.

Unfortunately, k0, k1 cannot be used. We shall withstand 
do_syscall_trace. It implies going to the user mode and back.

Regards,
Gleb.
