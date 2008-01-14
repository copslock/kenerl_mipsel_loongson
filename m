Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 16:43:27 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.187]:53363 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20030992AbYANQnS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 16:43:18 +0000
Received: by fk-out-0910.google.com with SMTP id f40so1339037fka.0
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 08:43:17 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=2e99OBW1rxbsmbMIHmdBtU1ewWepXFi+pN+bMzbMa2M=;
        b=VUPL8XVunRvmMb9VownTtURwYi2hDuerPoCS7OwPpeD1HKWFYzJA4Aa4hbu3PVYNQ+1hO5zVA3kYSobhTLVJfv8ea49CTtwJjTaS6y/ogRNKwSIMH3pt5tnBse/qAmh5PIOXeRpdVZLUEGlH5f4LZnlF5Y9vkHc/pc1qJKWvEH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XZFsZ6uJXbmLqvp/LWE+VVAU7S0cVXzpDn0lp50vvcNR3Wz/60VQOwrfqSVVqpsIhN5o4HaUgibijz9XFwapUjFTKE/oNFQ6xBdb8rfHW/FU6qzgqvKujBnz0EBUbcjGGs5u/72I9sMIPIkxg1fLjBdtHNEYnJ5uoAbv00TlXpc=
Received: by 10.82.105.13 with SMTP id d13mr11266611buc.30.1200328996906;
        Mon, 14 Jan 2008 08:43:16 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.31.112])
        by mx.google.com with ESMTPS id j9sm21630153mue.6.2008.01.14.08.43.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 08:43:15 -0800 (PST)
Message-ID: <478B9120.1020500@gmail.com>
Date:	Mon, 14 Jan 2008 19:43:12 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory for QEMU
References: <20080114.212253.126142719.anemo@mba.ocn.ne.jp> <20080114133701.GA16555@linux-mips.org> <478B6AA3.2070402@gmail.com> <20080114141424.GB22344@linux-mips.org>
In-Reply-To: <20080114141424.GB22344@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Jan 14, 2008 at 04:58:59PM +0300, Dmitri Vorobiev wrote:
> 
>>> I was actually planning to remove the Qemu platform for 2.6.25.  The
>>> Malta emulation has become so good that there is no more point in having
>>> the underfeatured synthetic platform that CONFIG_QEMU is.
>> I wholeheartedly agree with that. It is a godsend to me that I can use
>> identical configs to build the kernels for QEMU and for a physical Malta.
>> Emulation is more convenient to me because QEMU boots and runs faster
>> than the board I'm working with. Many thanks for that to QEMU developers.
>>
>> Off the topic, how about the plans to remove Atlas support?
> 
> Maciej is promising to fix it up since a few years ;-)  Aside of that it's
> safe to say the Atlas is dead like a coffin nail.

Well, I could do the proper cleanup, if you give your sayso. As I wrote here
yesterday, I noticed that Malta code was screaming for being put into proper
shape. If MIPS maintainers are interested in applying such janitorial patches,
I could simultaneously wipe the Atlas support off.

So?

> 
> The main problem with the Atlas is the SAA9730 SOC which is broken in an
> infinite number of totally pervert ways, I'm told.  I know of no systems
> other than the Atlas using it.
> 
>   Ralf
> 
