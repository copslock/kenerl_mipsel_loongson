Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 09:18:45 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:57801 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20041936AbWHIIQh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 09:16:37 +0100
Received: by nf-out-0910.google.com with SMTP id y38so77603nfb
        for <linux-mips@linux-mips.org>; Wed, 09 Aug 2006 01:16:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=qYO7xbVpJQg4ZsqRfc0pZANb7FTLNTa/gXu9tgS9SJq4c/fPt2yylKfBAOggrQdkgYxwDnHRgkNSVB+u8HJJNT5cQcuG9kfNqQr67ClMr1warHq70PKmn1DVJNg5xkX+kaQa0ghohPQ07gk/oIG5yA4F/MWJjV1deX7bL9ZGqZ8=
Received: by 10.49.21.8 with SMTP id y8mr1256076nfi;
        Wed, 09 Aug 2006 01:16:06 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id m15sm794460nfc.2006.08.09.01.16.05;
        Wed, 09 Aug 2006 01:16:06 -0700 (PDT)
Message-ID: <44D9999E.60908@innova-card.com>
Date:	Wed, 09 Aug 2006 10:15:26 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>, franck.bui-huu@innova-card.com
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org,
	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 6/6] setup.c: use early_param() for early command line
 parsing
References: <1155041312273-git-send-email-vagabon.xyz@gmail.com> <1155041313139-git-send-email-vagabon.xyz@gmail.com> <20060808125604.GI29989@networkno.de> <44D898FE.7080006@innova-card.com> <20060808151409.GA1177@networkno.de>
In-Reply-To: <20060808151409.GA1177@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Franck Bui-Huu wrote:
>> Thiemo Seufer wrote:
>>> Franck Bui-Huu wrote:
>>>> There's no point to rewrite some logic to parse command line
>>>> to pass initrd parameters or to declare a user memory area.
>>>> We could use instead parse_early_param() that does the same
>>>> thing.
>>>>
>>>> NOTE ! This patch also changes the initrd semantic. Old code
>>>> was expecting "rd_start=xxx rd_size=xxx" which uses two
>>>> parameters. Now the code expects "initrd=xxx@yyy" which is
>>>> really simpler to parse and to use. No default config files
>>>> use these parameters anyways but not sure for bootloader's
>>>> users...
>>> This code is there precisely because most mips bootloaders use
>>> rd_start/rd_size.
>> OK, I guess we have to stick with this weird semantic...
>>
>>> It also is IMHO a bad idea to overload the
>>> semantics of initrd= with both file names and memory locations.
>> I wasn't aware of any file name usages. Can you give a pointer ?
> 
> Documentation/initrd.txt
> Documentation/filesystems/ramfs-rootfs-initramfs.txt
> 

I was asking for pointers on MIPS bootloaders which use
initrd=/path/to/initrd...

Anyways, you're talking about specific bootloader's parameters,
aren't you ? I don't know any MIPS bootloaders, but I wouldn't 
expect them to pass their own parameters to the kernel, that 
would be surprising...

What are you suggesting ? kernel_initrd ?

BTW, what do you think about rd_start/rd_size names ?

thanks

		Franck
