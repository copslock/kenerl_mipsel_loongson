Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2006 00:43:08 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.194]:7645 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133953AbWCJAnA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Mar 2006 00:43:00 +0000
Received: by nproxy.gmail.com with SMTP id m19so436107nfc
        for <linux-mips@linux-mips.org>; Thu, 09 Mar 2006 16:51:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bQjx4+k5Wt7yQ6KyaSJ4aiV0e2vKhdRfGJBxDjU5QTj9BGx6GyglnLtV9w741FnW7WkSV3SjcSSwDqLaeg0lXap6I7gi3QXEWu2FB76hKmWEmkX7KSAGPi7e6IUskKzjsVvjhTfiGnz75e0fSQbkTHUdebvvLthGTPUlvzoo5BM=
Received: by 10.49.39.4 with SMTP id r4mr83968nfj;
        Thu, 09 Mar 2006 16:51:39 -0800 (PST)
Received: by 10.48.144.19 with HTTP; Thu, 9 Mar 2006 16:51:39 -0800 (PST)
Message-ID: <50c9a2250603091651k15088a83l85767ba8d919b6d2@mail.gmail.com>
Date:	Fri, 10 Mar 2006 08:51:39 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"David Daney" <ddaney@avtrex.com>
Subject: Re: how to select the filesystem for nand flash?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <44105361.9000909@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250603081748u639d35c0n272d53e24acc9f02@mail.gmail.com>
	 <44105361.9000909@avtrex.com>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/10/06, David Daney <ddaney@avtrex.com> wrote:
> zhuzhenhua wrote:
> > In the linux, I find there are two solutions for nand flash: one is
> > YAFFS2/JFFS2 + MTD, other is EXT2/EXT3+FTL. Because we have to
> > implement vfat based FTL for our u-disk,so i wonder if  the ext2/ext3
> > + FTL is stable enough to be root filesystem?
> > thanks for any hints.
>
> If you are going to be writing to the rootfs then you will want either
> yaffs or jffs2 as they distribute the wear across the entire device
> instead of concentrating it on a few blocks.
>
> Most implementations I have seen (and what I do myself) is to have a
> read-only rootfs on cramfs of squashfs, and then have a seperate
> writable partition with either yaffs or jffs2.
>
> David Daney.
>
thanks for your advice.
if i don't want u-disk function, i will select your solution.
but i don't know how to use yaffs or jffs2 to implement a u-disk
it seems that i have to use fat+FTL
