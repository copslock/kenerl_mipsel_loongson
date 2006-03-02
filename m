Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 00:48:09 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.196]:39920 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133716AbWCBAr7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Mar 2006 00:47:59 +0000
Received: by nproxy.gmail.com with SMTP id h2so194092nfe
        for <linux-mips@linux-mips.org>; Wed, 01 Mar 2006 16:55:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rbtMfOZ1oSj2htWvqVMHULkbkY4FntqXj2aFvvCHpChamKGZnCbom6RxFi3xauScFux7+zct+yBRpiH4F4eMBqhsWPMQjqAiOmS2wq/DG1LGV6V/EpYIdbFbjm2Kteht6Y+O7FfxUs1ncgK3eTdxJjzj2Iv7vaPZsvzDqp6XnGw=
Received: by 10.48.238.3 with SMTP id l3mr388395nfh;
        Wed, 01 Mar 2006 16:55:51 -0800 (PST)
Received: by 10.48.249.14 with HTTP; Wed, 1 Mar 2006 16:55:51 -0800 (PST)
Message-ID: <50c9a2250603011655m4a61c262v41898d496056d3a7@mail.gmail.com>
Date:	Thu, 2 Mar 2006 08:55:51 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>
Subject: Re: how to select a rootfs for embedded linux based hardisk?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20060301124341.GM24493@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250603010418s6f778c25s799d79cee2b79333@mail.gmail.com>
	 <20060301124341.GM24493@deprecation.cyrius.com>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/1/06, Martin Michlmayr <tbm@cyrius.com> wrote:
> * zhuzhenhua <zzh.hust@gmail.com> [2006-03-01 20:18]:
> > i want to port the linux to our board based hardisk with
> > mips arch. i do not find too much file sytem for rootfs on hardisk
> > besides ext2/ext3.
> > but it seems ext2/ext3 is not suitable for embedded system.
> > does someone have idea or experience with these products?
>
> How large is your hard drive exactly and is it a real IDE hard drive
> or some kind of flash?  If the disk/flash is very small, ext3 may be a
> bad choice since it's a journalling file system which means that a)
> it'll take up quite a significant portion of space on a small drive
> and b) it'll write to the same sectors all the time, which will kill
> the flash in no time.
> --
> Martin Michlmayr
> http://www.cyrius.com/
>

i mean the real IDE hard, and it will at least > 2GB,and for these ide
hard,someone said the ext2 or ext3 not suitable for embedded.but i
still find no other file system available.

Best Regards

Zhuzhenhua
