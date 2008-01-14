Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 17:47:31 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.152]:23864 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20031567AbYANRrX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 17:47:23 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2207898fga.32
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 09:47:22 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=1OgS/vuSY8NpjXgAlXy5ptWekgKb96xHSgtPUXyGvlg=;
        b=qJd3W/DX4NudroHoo6nezKB2SMmcxV9ARWq4/uLxtcobUxjbesDIT5FLVQTUky8/16B29Usw8A0a+Kyp8XCR3RrdRh64Aey/hBrvwwXcUXVKtWCLyZ1r+GGN408aegEtuMiJapUFUppBUmTC+qDSmXB4jvdaBCCRrB22V0P943I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ISEEcSHgryd28UYD760e2IgWK12NnTph3BA0PDPESkFz8uZVxCkOfOwqL1slHPNEDi4SCKRDE/CwrslWo0nk3ZHJvn9xUvGEdx0OYms+NK8GS5bPgqzv8K02E5mByT7lnbSsfmKzaL1cMKHRenXFOPQeKI5seZ2IiZzEkl9qrQs=
Received: by 10.86.95.20 with SMTP id s20mr5361375fgb.67.1200332842803;
        Mon, 14 Jan 2008 09:47:22 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.31.85])
        by mx.google.com with ESMTPS id l19sm6719775fgb.3.2008.01.14.09.47.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 09:47:21 -0800 (PST)
Message-ID: <478BA01E.7050701@gmail.com>
Date:	Mon, 14 Jan 2008 20:47:10 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory for QEMU
References: <20080114.212253.126142719.anemo@mba.ocn.ne.jp> <20080114133701.GA16555@linux-mips.org> <478B6AA3.2070402@gmail.com> <20080114141424.GB22344@linux-mips.org> <478B9120.1020500@gmail.com> <20080114165759.GA2894@linux-mips.org>
In-Reply-To: <20080114165759.GA2894@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Jan 14, 2008 at 07:43:12PM +0300, Dmitri Vorobiev wrote:
> 
>>>>> I was actually planning to remove the Qemu platform for 2.6.25.  The
>>>>> Malta emulation has become so good that there is no more point in having
>>>>> the underfeatured synthetic platform that CONFIG_QEMU is.
>>>> I wholeheartedly agree with that. It is a godsend to me that I can use
>>>> identical configs to build the kernels for QEMU and for a physical Malta.
>>>> Emulation is more convenient to me because QEMU boots and runs faster
>>>> than the board I'm working with. Many thanks for that to QEMU developers.
>>>>
>>>> Off the topic, how about the plans to remove Atlas support?
>>> Maciej is promising to fix it up since a few years ;-)  Aside of that it's
>>> safe to say the Atlas is dead like a coffin nail.
>> Well, I could do the proper cleanup, if you give your sayso. As I wrote here
>> yesterday, I noticed that Malta code was screaming for being put into proper
>> shape. If MIPS maintainers are interested in applying such janitorial patches,
>> I could simultaneously wipe the Atlas support off.
>>
>> So?
> 
> Of course janitorial patches will be considered.

I'm rolling up the sleeves.

> 
> The Malta code used to scream even way louder.  I made an opportunistic
> attempt at fixing the one or other corner over time, whenever something
> was getting in my way for some reason.

I see. Actually, I am teaching system programming at the premises of the Moscow
State University and I am now working on a lab assignment where a Malta board
will be involved. In the classes, I insist that my students follow the coding
style rules to the letter, that's why I really want the Malta code to be 
worthy of imitation.  :)

> 
>   Ralf
> 
