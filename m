Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2006 17:13:22 +0000 (GMT)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:47822 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S20039846AbWKHRNQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Nov 2006 17:13:16 +0000
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id kA8HCrUF003452;
	Wed, 8 Nov 2006 17:12:57 GMT
Received: from [43.134.85.135] ([43.134.85.135])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id kA8HCrQh022880;
	Wed, 8 Nov 2006 17:12:53 GMT
Message-ID: <45521167.9010603@am.sony.com>
Date:	Wed, 08 Nov 2006 09:18:31 -0800
From:	Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	=?UTF-8?B?77+9?= <barrioskmc@gmail.com>
CC:	"'Thiemo Seufer'" <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: MIPS processors gain GNU/Linux binary prelinker
References: <000801c702fb$c96e89e0$0202fea9@swcenter.sec.samsung.co.kr>
In-Reply-To: <000801c702fb$c96e89e0$0202fea9@swcenter.sec.samsung.co.kr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <tim.bird@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tim.bird@am.sony.com
Precedence: bulk
X-list: linux-mips

� wrote:
> Who know anymore about prelink for mips architecture? 
> Let me know prelink for mips detaily.
> Thanks in advance.

There's a white paper available.  See the linuxdevices article
for a link to it:

http://www.linuxdevices.com/news/NS6220941326.html

> 
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.
> org] On Behalf Of Thiemo Seufer
> Sent: Tuesday, November 07, 2006 11:05 PM
> To: Tim Bird
> Cc: CE Linux Developers List; linux-mips@linux-mips.org
> Subject: Re: MIPS processors gain GNU/Linux binary prelinker
> 
> Tim Bird wrote:
>> FYI - For those interested in bootup time improvements on MIPS
>> processors, here is some information about the recently
>> developed MIPS prelinking feature, done by CodeSourcery
>> and MIPS Technologies.
> 
> The patches are showing up piecemeal now on the various mailing lists,
> I also dumped a debian-styleish patchset at
> ftp://ftp.linux-mips.org/pub/linux/mips/people/ths/mips-prelinker-patches-
> debian/
> 
> 
> Thiemo
> 
> 


-- 
=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
