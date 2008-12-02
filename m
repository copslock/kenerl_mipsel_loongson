Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2008 15:56:34 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.157]:61801 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S24055064AbYLBP4c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Dec 2008 15:56:32 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2101492fga.32
        for <linux-mips@linux-mips.org>; Tue, 02 Dec 2008 07:56:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=x7POE9Va+p/c+LDgIx1VY6THX9xb9jlcNlNboDIL1gQ=;
        b=SAe96nPvsCBPugUTQHd7IkrkxUV/tq7Cg4KocX7PPYQO5QVmqyMGGiVdOCiFnsDNZM
         T2Ay/zRwxgwg2c4ER8d9wLpMuCwzNvt+nGeoNxCnO0a5/h+qC5nmMhRcs++mwSoVpWow
         v3/eywLBKD12Z+oFDPQyogqLvzHDL9MyvGZXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=c8u8WIe73XA8xYV5pZge6qHnvVD2uk6qZTIqlGLThvDD7m9WvcVWWX9KjfWdB24+An
         Orb18ggfVbmo/4rZHZoP95Fl023TAgHV2pzzEmfw15MpmFM+Gs8oXq0CCXQJlUhQJa4p
         905YIiIyKMMNhOyXB/hpXu8A1vjUnpZYnUzYA=
Received: by 10.181.214.8 with SMTP id r8mr4279564bkq.206.1228233390757;
        Tue, 02 Dec 2008 07:56:30 -0800 (PST)
Received: by 10.181.7.9 with HTTP; Tue, 2 Dec 2008 07:56:30 -0800 (PST)
Message-ID: <5c9cd53b0812020756r23baed36j8204b0a7c1a6b792@mail.gmail.com>
Date:	Tue, 2 Dec 2008 10:56:30 -0500
From:	"mike zheng" <mail4mz@gmail.com>
To:	Phil.Staub@windriver.com
Subject: Re: How to start Linux kernel on MIPS32
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20081201185317.GB9467@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5c9cd53b0811282042w677979bawc692d3ffbbe6686b@mail.gmail.com>
	 <20081201185317.GB9467@windriver.com>
Return-Path: <mail4mz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mail4mz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Phil,

It turns out that I have to pass parameters to the linux kernel. I
have to do the jump as following:

        entryPoint = (void *) 0x8036a000;
        entryPoint(2, args, NULL);

If I am using entryPoint(), there will be exception in the early stage
of linux kernel. I still don't understand why this works. When I use
BDM to jump to 0x8036a000, there is no parameter passed in.

Thanks,

Mike

On Mon, Dec 1, 2008 at 1:53 PM, Phil Staub <phil.staub@windriver.com> wrote:
> On Fri, Nov 28, 2008 at 08:42:33PM -0800, mike zheng wrote:
>> Hello,
>>
>> I am doing development on a MIPS32 processor. However it failed to
>> boot when I try to use a boot loader to start the kernel in the
>> memory. The boot loader uses following command to jump to kernel entry
>> point in the memory:
>>          entryPoint = (void *) 0x8036a000;
>>          entryPoint();
>> I confirm the kernel image is able to boot up. Using JTAG debugger. I
>> set PC to the entry point of memory 0x8036a000, the kernel boots up. I
>> also disable the Cache before the jump.
>>
>> Any idea on this issue?
>
> I ran into something like this several years ago on a Malta board that
> behaved differently when the OS was started from JTAG compared to
> Yamon.
>
> In that case there were control registers that allowed relocating the
> base addresses of many of the control registers. The board registers had
> reset/power up values that the kernel startup code assumed was in
> effect, which worked fine with the JTAG debugger, especially if it
> (the debugger) doesn't touch the control registers before jumping into
> the code.
>
> But the YAMON boot loader re-programmed the base address of several of
> the peripherals and I beleive even the DRAM controller, so the kernel
> startup code was trying to initialize the registers at the reset
> addresses, but those registers were no longer there.
>
> If this is the case, you'll have to determine a) which registers have
> been modified by the bootloader, and b) what they have been changed
> to. Then, (hopefully) you can use the JTAG debugger to program in
> those register settings each time it resets the chip. In short, you
> need the initial execution environment to be equivalent whether you are
> starting it from the debugger or from the bootloader.
>
> HTH,
> Phil
>
>>
>> Thanks,
>>
>> Mike
>>
>
> --
> Phil Staub, Senior Member of Technical Staff, Wind River
> Direct: 702.395.WIND (9463) Fax: 702.365.WIND (9463)
>
>
