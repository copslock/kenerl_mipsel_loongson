Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 18:15:21 +0000 (GMT)
Received: from mail-bw0-f13.google.com ([209.85.218.13]:36016 "EHLO
	mail-bw0-f13.google.com") by ftp.linux-mips.org with ESMTP
	id S21103632AbZAMSPT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2009 18:15:19 +0000
Received: by bwz6 with SMTP id 6so451725bwz.0
        for <linux-mips@linux-mips.org>; Tue, 13 Jan 2009 10:15:13 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rh5iKykZkzkGf+gn8VustrI+zNR4eBFUFTiFIKFUvgw=;
        b=SBUh1dn3zCrDr7Yg+ayQAFM1z5N7bYUA/1e4XFAqPCQJuUIN55arbC4DEFDnpFsAI3
         05rrEI76RpouRTxvTdeEvgqZA5kkaNB/uZcAEpFfvQkYz4z8ZNArF1ZYVACE/JenyAIq
         ucGE4qxqwOAoVuaH64sF4kX9jCAJLslGPcXXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M+TUkasBx1T0HJKu1eS+ey4vs7YgCC5vf9/YkJczR1axjcp5YoXOcfvCG2F+58FYrD
         ZRBr912srQWfzu4G2MLH84pciglF8/dkwQdwSTI5Z6dkULilY2IDZXBq6acfqbCrN0x3
         4z5t/fRLsETkJzUNQrZdFtm/gI9jOaWzWYX0E=
MIME-Version: 1.0
Received: by 10.181.235.6 with SMTP id m6mr11470022bkr.131.1231870512750; Tue, 
	13 Jan 2009 10:15:12 -0800 (PST)
In-Reply-To: <200901131830.32900.florian@openwrt.org>
References: <1231859270.25974.32.camel@EPBYMINW0568>
	 <200901131830.32900.florian@openwrt.org>
Date:	Tue, 13 Jan 2009 20:15:12 +0200
Message-ID: <fce2a370901131015m46c64a02i48fef2636f0168fe@mail.gmail.com>
Subject: Re: [pnx833x_port]: device name prefix - ttyS or ttySA?
From:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 13, 2009 at 7:30 PM, Florian Fainelli <florian@openwrt.org> wrote:
> Hi,
>
> Le Tuesday 13 January 2009 16:07:50 Ihar Hrachyshka, vous avez écrit :
>> In 'drivers/serial/pnx833x_port.c' we define the prefix for UART serial
>> device as "ttyS". Anyway, we use major:minor numbers for SA1100 serial
>> driver (that are 204:5). Why don't we use "ttySA" prefix then? That's
>> what different embedded build systems expect for populating /dev (f.e.
>> buildroot).
>
> In my experience, everything that is not ttyS is a bit confusing either when
> creating the devices in the roots, or when using the serial console in the
> kernel command line. So I will vote for ttyS.

The problem is that use-case with generic 8250 and board specific
serial drivers both enabled is not a fantasy. So we need to
differentiate between them.

>
> My 2 cents.
> --
> Best regards, Florian Fainelli
> Email : florian@openwrt.org
> http://openwrt.org
> -------------------------------
>
