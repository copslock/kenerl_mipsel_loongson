Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2006 16:41:20 +0000 (GMT)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:1238 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133566AbWCFQlF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Mar 2006 16:41:05 +0000
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k26GnO96010558;
	Mon, 6 Mar 2006 16:49:25 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k26GnO59025633;
	Mon, 6 Mar 2006 16:49:24 GMT
Message-ID: <440C6814.4020204@am.sony.com>
Date:	Mon, 06 Mar 2006 08:49:24 -0800
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	zhuzhenhua <zzh.hust@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: does the linux support rootfs on vfat?
References: <50c9a2250603042217l475e84pc9ab7ce87c40eb76@mail.gmail.com> <20060305080958.GX19232@lug-owl.de> <20060305112247.GA4243@linux-mips.org>
In-Reply-To: <20060305112247.GA4243@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Mar 05, 2006 at 09:09:58AM +0100, Jan-Benedict Glaw wrote:
> 
>> On Sun, 2006-03-05 14:17:56 +0800, zhuzhenhua <zzh.hust@gmail.com> wrote:
>> > if in my product based ide disk, i want to it to support the
>> > u-disk(with vfat fs), and can i set the root fs as vfat too?
>> > if use vfat as rootfs, what's disadvantage of the selection?
>> 
>> Well, most notably you won't have device nodes. Maybe a ram-backed
>> filesystem mounted to /dev/ could solve that, but you'd probably need
>> an initrd for that to do.
> 
> It's anso case-insensitive which may cause some further troubles.  It's
> doesn't have proper inodes, no UNIX file modes, no UID / GID support (These
> two can be kludges in awfully insufficient way through mount options), not
> only lacks device special files but also no FIFO, no UNIX domain sockets,
> no hard or soft links.  It's simply a sorry excuse for a useful filesystem.

It's attractive for a limited resource device that needs to have FAT support
for a removable flash memory card (for Windows PC interoperability).  If you
can use FAT for the root fs, that reduces the system resource needs.

It doesn't make sense if his ide disk is non-removable though.

-Geoff
