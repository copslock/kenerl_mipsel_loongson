Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2008 13:07:38 +0100 (BST)
Received: from p549F5CCF.dip.t-dialin.net ([84.159.92.207]:63632 "EHLO
	p549F5CCF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20022163AbYFBMHg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Jun 2008 13:07:36 +0100
Received: from skerikoff.satca.net ([81.90.243.194]:61401 "EHLO smtp.satca.net")
	by lappi.linux-mips.net with ESMTP id S525904AbYFBLwC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 2 Jun 2008 13:52:02 +0200
Received: from localhost (unknown [127.0.0.1])
	by smtp.satca.net (Postfix) with ESMTP id F0F92E418E7;
	Mon,  2 Jun 2008 10:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at satca.net
Received: from smtp.satca.net ([127.0.0.1])
	by localhost (skerikoff.satca.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uyv-Ac8CyG26; Mon,  2 Jun 2008 12:28:49 +0200 (CEST)
Received: from [192.168.51.201] (unknown [192.168.51.201])
	by smtp.satca.net (Postfix) with ESMTP id 4BBB3E41089;
	Mon,  2 Jun 2008 10:28:49 +0000 (UTC)
Message-ID: <4843DEFD.9020303@satca.net>
Date:	Mon, 02 Jun 2008 13:52:29 +0200
From:	Marian Jancar <m.jancar@satca.net>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 5/7] gcov: add gcov profiling infrastructure
References: <48313DE6.30802@de.ibm.com> <20080523001136.59ec8b34.akpm@linux-foundation.org> <20080523084506.GB719@linux-mips.org>
In-Reply-To: <20080523084506.GB719@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <m.jancar@satca.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.jancar@satca.net
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
>> {standard input}: Assembler messages:
>> {standard input}:2716: Error: Branch out of range
>> {standard input}:2819: Error: Branch out of range
>> {standard input}:2884: Error: Branch out of range
>> {standard input}:3032: Error: Branch out of range
>> {standard input}:3097: Error: Branch out of range
>> {standard input}:3151: Error: Branch out of range
>> {standard input}:3216: Error: Branch out of range
>> make[1]: *** [drivers/telephony/ixj.o] Error 1
>> make: *** [drivers/telephony/ixj.o] Error 2
> 
> A known problem which I had decieded to ignore until it begins to actually
> bite.  It's triggered by something like this
> 
>                 __asm__ __volatile__(
>                 "       .set    mips3                                   \n"
>                 "1:     ll      %0, %1          # atomic_add            \n"
>                 "       addu    %0, %2                                  \n"
>                 "       sc      %0, %1                                  \n"
>                 "       beqz    %0, 2f                                  \n"
>                 "       .subsection 2                                   \n"
>                 "2:     b       1b                                      \n"
>                 "       .previous                                       \n"
>                 "       .set    mips0                                   \n"
>                 : "=&r" (temp), "=m" (v->counter)
>                 : "Ir" (i), "m" (v->counter));
> 
> when compiled into a large compilation unit.

Please unignore :) It bites when compiling madwifi (without profiling or
anything such).

Marian
