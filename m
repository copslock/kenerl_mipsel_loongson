Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 21:21:13 +0000 (GMT)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:33157
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8224988AbVBGVU4>;
	Mon, 7 Feb 2005 21:20:56 +0000
Received: from [192.168.0.35] ([192.168.0.35] unverified) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 7 Feb 2005 13:20:52 -0800
Message-ID: <4207DBB1.9000506@avtrex.com>
Date:	Mon, 07 Feb 2005 13:20:49 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	andreev <andreev@niisi.msk.ru>, linux-mips@linux-mips.org
Subject: Re: Strace doesn't work on linux-2.4.28 and later
References: <41FF876B.3070407@niisi.msk.ru> <4207C142.6070804@avtrex.com> <4207C3E0.7070405@avtrex.com> <20050207210825.GA6703@linux-mips.org>
In-Reply-To: <20050207210825.GA6703@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2005 21:20:52.0562 (UTC) FILETIME=[E71D9320:01C50D5A]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Index: arch/mips/kernel/scall_o32.S
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/kernel/Attic/scall_o32.S,v
> retrieving revision 1.18.2.14
> diff -u -r1.18.2.14 scall_o32.S
> --- arch/mips/kernel/scall_o32.S	25 Nov 2004 09:43:59 -0000	1.18.2.14
> +++ arch/mips/kernel/scall_o32.S	7 Feb 2005 21:12:53 -0000
> @@ -121,15 +121,14 @@
>  
>  trace_a_syscall:
>  	SAVE_STATIC
> -	sw	t2, PT_SCRATCH0(sp)
> +	move	s0, sp
          ^^^^^^^^^^^^^
I think this should be "move s0, t2" as in scall_64.S et al.

David Daney.
