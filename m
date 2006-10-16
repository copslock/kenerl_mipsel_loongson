Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 15:42:53 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:48013 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039606AbWJPOmu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 15:42:50 +0100
Received: by nf-out-0910.google.com with SMTP id l23so2507031nfc
        for <linux-mips@linux-mips.org>; Mon, 16 Oct 2006 07:42:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=K7NEb6jb4nVWO96ZI3w0KBW8v7woKRClp6+qy+LINNonNtIztF32S+em3AAjDG1MoJEJJgHjD8Jb7w8uR+6+Qfhv3I3kS0hCuQddldakETLcn9dVi3NgZbYjgPxrTXAZWu8rmcHOWsqE6ZVaCrCqTiU18xzkdAzCzpe7+wrrW+k=
Received: by 10.49.21.8 with SMTP id y8mr12301650nfi;
        Mon, 16 Oct 2006 07:42:49 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id a24sm940193nfc.2006.10.16.07.42.48;
        Mon, 16 Oct 2006 07:42:48 -0700 (PDT)
Message-ID: <45339A6B.2050406@innova-card.com>
Date:	Mon, 16 Oct 2006 16:42:51 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
References: <45333CC1.3090704@innova-card.com>	<20061016.171046.55511403.nemoto@toshiba-tops.co.jp>	<45334765.6000805@innova-card.com> <20061016.180740.88700024.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061016.180740.88700024.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 16 Oct 2006 10:48:37 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> thanks but it doesn't explain anything either...Anyways what about this
>> patch on top of the previous one ?
> 
>> +	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + sizeof(u32) * 2 + 1));
> 
> This breaks the addinitrd.  You mean this perhaps?
> 
> initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + sizeof(u32) * 2)) - sizeof(u32) * 2;
> 

you're right, but I really don't see how this work and IMHO this
code is broken.

In my mind, I was thinking that initrd_head had to be PAGE_SIZE
aligned and that was the reason of that weird code...

> 
> BTW, I'm a bit uncomfortable with current automatic initrd detection.
> Now we have rd_start= option.  If I enabled BLK_DEV_INITRD and did
> pass nfsroot= instead of rd_start= option, I want kernel do not search
> initrd_header at all.  Note that in this case current kernel might
> misdetect initrd_header from garbage beyond "_end".
> 

Well that might happen if you want a nfs rootfs but want to execute
an initrd before mounting the rootfs and this initrd has been included
in the kernel image with the 'addinitrd' stuff.

> I think something like CONFIG_INITRD_AUTODETECT to control this
> behaviour is useful.  What do you think?
> 

It's safer although it can be enough to check against a magic number 
well chosen. Maybe we can introduce a new option to the command line, 
'initrd_noprobe' for example. But in any case make the default to
auto detect initrd to avoid breaking some old configs.

		Franck
