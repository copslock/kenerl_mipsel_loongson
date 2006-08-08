Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 15:01:29 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:7485 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20041184AbWHHOBX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Aug 2006 15:01:23 +0100
Received: by nf-out-0910.google.com with SMTP id o60so262491nfa
        for <linux-mips@linux-mips.org>; Tue, 08 Aug 2006 07:01:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=T1/3yy+3EDf+J74XIizhrtqKq6HvNGwVhorvdPQH/NUt4b3GDi1YAfORmIjMqTf+CvQ0cAX/CGUmEYOwFKira0HhK2QvPoeUxaZzG9dyisFpdqfOFmDrF6Q945w9KLydEGNy7OXPHGWPbbb92cvf5/C6Lf0vMuWVMqpgO55aoJw=
Received: by 10.48.48.15 with SMTP id v15mr451953nfv;
        Tue, 08 Aug 2006 07:01:18 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id o53sm838384nfa.2006.08.08.07.01.14;
        Tue, 08 Aug 2006 07:01:17 -0700 (PDT)
Message-ID: <44D898FE.7080006@innova-card.com>
Date:	Tue, 08 Aug 2006 16:00:30 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org,
	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 6/6] setup.c: use early_param() for early command line
 parsing
References: <1155041312273-git-send-email-vagabon.xyz@gmail.com> <1155041313139-git-send-email-vagabon.xyz@gmail.com> <20060808125604.GI29989@networkno.de>
In-Reply-To: <20060808125604.GI29989@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Franck Bui-Huu wrote:
>> There's no point to rewrite some logic to parse command line
>> to pass initrd parameters or to declare a user memory area.
>> We could use instead parse_early_param() that does the same
>> thing.
>>
>> NOTE ! This patch also changes the initrd semantic. Old code
>> was expecting "rd_start=xxx rd_size=xxx" which uses two
>> parameters. Now the code expects "initrd=xxx@yyy" which is
>> really simpler to parse and to use. No default config files
>> use these parameters anyways but not sure for bootloader's
>> users...
> 
> This code is there precisely because most mips bootloaders use
> rd_start/rd_size.

OK, I guess we have to stick with this weird semantic...

> It also is IMHO a bad idea to overload the
> semantics of initrd= with both file names and memory locations.
> 

I wasn't aware of any file name usages. Can you give a pointer ?

Thanks

		Franck
