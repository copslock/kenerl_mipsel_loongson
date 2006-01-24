Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 00:00:00 +0000 (GMT)
Received: from grayson.netsweng.com ([207.235.77.11]:19127 "EHLO
	grayson.netsweng.com") by ftp.linux-mips.org with ESMTP
	id S3458475AbWAWX7l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 23:59:41 +0000
Received: from amavis by grayson.netsweng.com with scanned-ok (Exim 3.36 #1 (Debian))
	id 1F1Bf5-0005Su-00
	for <linux-mips@linux-mips.org>; Mon, 23 Jan 2006 19:03:51 -0500
Received: from grayson.netsweng.com ([127.0.0.1])
	by localhost (grayson [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21001-01 for <linux-mips@linux-mips.org>;
	Mon, 23 Jan 2006 19:03:43 -0500 (EST)
Received: from h190.39.29.71.ip.alltel.net ([71.29.39.190] helo=trantor.stuart.netsweng.com)
	by grayson.netsweng.com with esmtp (Exim 3.36 #1 (Debian))
	id 1F1BcO-0005Oz-00
	for <linux-mips@linux-mips.org>; Mon, 23 Jan 2006 19:01:04 -0500
Date:	Mon, 23 Jan 2006 19:01:01 -0500 (EST)
From:	Stuart Anderson <anderson@netsweng.com>
X-X-Sender: anderson@trantor.stuart.netsweng.com
To:	linux-mips@linux-mips.org
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
In-Reply-To: <20060123161620.GB22656@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0601231858420.5858@trantor.stuart.netsweng.com>
References: <20060123150507.GA18665@linux-mips.org> <43D4FE76.1070805@rtschenk.de>
 <20060123161620.GB22656@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at netsweng.com
Return-Path: <anderson@netsweng.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anderson@netsweng.com
Precedence: bulk
X-list: linux-mips

On Mon, 23 Jan 2006, Ralf Baechle wrote:

> On Mon, Jan 23, 2006 at 05:04:06PM +0100, Rojhalat Ibrahim wrote:
>
>>> I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
>>> below.
>>>
>>
>> Works for me. The compilation errors are gone and the kernel
>> seems to be running fine.
>
> Excellent, thanks for testing.  I pushed the patch to lmo's git repository.

I'm still playing catch up a bit from traveling, but I replaced my fix
with this one in git, and confirmed that the kernel built and ran as
well as it did with the old fix.


                                 Stuart

Stuart R. Anderson                               anderson@netsweng.com
Network & Software Engineering                   http://www.netsweng.com/
1024D/37A79149:                                  0791 D3B8 9A4C 2CDC A31F
                                                  BD03 0A62 E534 37A7 9149
