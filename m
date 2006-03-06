Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2006 16:33:26 +0000 (GMT)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:52944 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133494AbWCFQdP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Mar 2006 16:33:15 +0000
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k26GfTHO009198;
	Mon, 6 Mar 2006 16:41:29 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k26GfS5M024093;
	Mon, 6 Mar 2006 16:41:28 GMT
Message-ID: <440C6638.7000909@am.sony.com>
Date:	Mon, 06 Mar 2006 08:41:28 -0800
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	zhuzhenhua <zzh.hust@gmail.com>
CC:	linux-mips <linux-mips@linux-mips.org>,
	Hiroyuki Machida <machida@sm.sony.co.jp>
Subject: Re: does the linux support rootfs on vfat?
References: <50c9a2250603042217l475e84pc9ab7ce87c40eb76@mail.gmail.com>
In-Reply-To: <50c9a2250603042217l475e84pc9ab7ce87c40eb76@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

zhuzhenhua wrote:
> if in my product based ide disk, i want to it to support the
> u-disk(with vfat fs), and can i set the root fs as vfat too?
> if use vfat as rootfs, what's disadvantage of the selection?
> 

See these threads, 'Posix file attribute support on VFAT', which
disscusses using VFAT for a root fs:

  http://lkml.org/lkml/2005/8/8/76
  http://lkml.org/lkml/2005/8/8/326

-Geoff
