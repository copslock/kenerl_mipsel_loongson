Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 11:15:16 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:51047 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S29048597AbYISKPB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 11:15:01 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 5E6673ECA; Fri, 19 Sep 2008 03:14:56 -0700 (PDT)
Message-ID: <48D37B9D.8060500@ru.mvista.com>
Date:	Fri, 19 Sep 2008 14:14:53 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Dinar Temirbulatov <dtemirbulatov@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: mmap is broken for MIPS64 n32 and o32 abis
References: <a664af430809182331i41c9e344w83ecb2830ac24@mail.gmail.com>
In-Reply-To: <a664af430809182331i41c9e344w83ecb2830ac24@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Dinar Temirbulatov wrote:

> I noticed that mmap is not working properly under n32, o32 abis in
> MIPS64, for example if we want to map 0xb6000000 address to the
> userland under those abis we call  mmap and because the last argument
> in old_mmap is off_t and this type is 64-bits wide for MIPS64, we end
> up having for example 0xffffffffb6000000 address value. I am sure that
> this is not a glibc issue. Following patch adds 32-bit version of mmap
> and also it adds mmap64 support for n32 abi since mmap64 was
> implemented correctly for n32 too.
>                                           thanks, Dinar.
>   

  Your patch (BTW, how come it didn't get quoted? -- ah, it's 
text/x-patch) is using both tabs and spaces for indentation. Please use 
tabs only.
And either attach patches as text/plain or include them inline.

WBR, Sergei
