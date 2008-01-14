Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 14:03:55 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.152]:19619 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20029897AbYANODp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 14:03:45 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2147769fga.32
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 06:03:45 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=kU0HQQPjz1BuoLmAq0Q5nwb+/VaGy9lSfbm4DpK0tOw=;
        b=icme14+VvL5RDV5fYnQYE5fhbQsnPxPkz+E9lAvJ+3QeTUS6GwzK+ycMD3BIXeB0CTKM+KbDr7HdY7ns4Cp7j2PL4OVTY44xDg+v9lLcNXAzFWiVWse7TVR5L0eWnXZhi5P2n/4ftSbN82GmISY9wg74B8riAwluTYX+uQxKMQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pMoamnhdZek2+uDPyRSMF5MNTBoal8LKVpmxWd9M0bm4ezpvlIGIICl5zNxJbv2CHvhvIb3t/kLIFyZq3HF2O9AFf//iHc/M5KFW4Lp2WVE3BbQJKM3X4U/DvM7kotknY43rmJDfg4lullcjOu9D/TVcgkZM3DoVR+8wZiU+FfU=
Received: by 10.86.28.5 with SMTP id b5mr6231259fgb.79.1200319425493;
        Mon, 14 Jan 2008 06:03:45 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.31.112])
        by mx.google.com with ESMTPS id l12sm5118672fgb.9.2008.01.14.06.03.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 06:03:44 -0800 (PST)
Message-ID: <478B6BBD.90005@gmail.com>
Date:	Mon, 14 Jan 2008 17:03:41 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory for QEMU
References: <20080114.212253.126142719.anemo@mba.ocn.ne.jp>	<20080114133701.GA16555@linux-mips.org> <20080114.225318.63132741.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080114.225318.63132741.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 14 Jan 2008 13:37:01 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
>> I was actually planning to remove the Qemu platform for 2.6.25.  The
>> Malta emulation has become so good that there is no more point in having
>> the underfeatured synthetic platform that CONFIG_QEMU is.
>>
>> Objections?
> 
> The Qemu platform is one of officially supported platforms by Debian.
> If Debian did not support the Malta yet, I hope qemu alive.

Would you like me to try following the instructions given at

http://www.aurel32.net/info/debian_mips_qemu.php

with QEMU emulating a Malta board? I haven't tried this yet, but I
feel that the possibility exists that this would work out of the box.

Dmitri

> 
> ---
> Atsushi Nemoto
> 
> 
