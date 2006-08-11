Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 16:13:44 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.206]:13329 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20044751AbWHKPNm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 16:13:42 +0100
Received: by nz-out-0102.google.com with SMTP id i1so232736nzh
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2006 08:13:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=fRq+eSRu7yeslti7/doz5ZnxONKkhCInsWCboKyPwxCE1KE1UtJ9lqMUqhGT7c5u9LYEf8JQSPnqhGUq0kmGfr/y6A8ZdQU+kImlU8UXvSkphcIRrmCJLt3yrt9RfPiVtoD+ZBckhOfM7QE4IH2zsWLC0xvxvsb76vLGFx3+lf0=
Received: by 10.65.139.9 with SMTP id r9mr4048948qbn;
        Fri, 11 Aug 2006 08:13:38 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id e16sm2063819qbe.2006.08.11.08.13.36;
        Fri, 11 Aug 2006 08:13:38 -0700 (PDT)
Message-ID: <44DC9E7D.1000303@innova-card.com>
Date:	Fri, 11 Aug 2006 17:13:01 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 2/6] setup.c: move initrd code inside dedicated functions
References: <11551351581277-git-send-email-vagabon.xyz@gmail.com>	<1155135159394-git-send-email-vagabon.xyz@gmail.com> <20060811.235056.126141886.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060811.235056.126141886.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed,  9 Aug 2006 16:52:34 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> +	unsigned long initrd_size = 
>> +		(unsigned long)initrd_end - (unsigned long)initrd_start;
> 
> While initrd_end and initrd_start are unsigned long, these casts are
> redundant.
> 

Absolutely. I don't remember why I added these useless casts...

>> +	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
>> +	       (void *)initrd_start, initrd_size);
> 
> You can use "0x%lx" for initrd_start and remove the cast.  I know this
> fragment are copied from corrent code as is, but it would be a good
> chance to clean it up.
> 

You're right.

I'll change that and make a take #3.

Thanks for your comments.

		Franck
