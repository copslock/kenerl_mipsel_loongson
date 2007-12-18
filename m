Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 22:18:08 +0000 (GMT)
Received: from terminus.zytor.com ([198.137.202.10]:32139 "EHLO
	terminus.zytor.com") by ftp.linux-mips.org with ESMTP
	id S28580313AbXLRWR7 (ORCPT <rfc822;linux-mips@ftp.linux-mips.org>);
	Tue, 18 Dec 2007 22:17:59 +0000
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.1/8.13.8) with ESMTP id lBIMBdXJ017120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 14:11:39 -0800
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.13.8/8.13.8) with ESMTP id lBIMBdeo007385;
	Tue, 18 Dec 2007 14:11:39 -0800
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.1/8.13.6) with ESMTP id lBIMBcf1001679;
	Tue, 18 Dec 2007 14:11:38 -0800
Message-ID: <4768459A.3000003@zytor.com>
Date:	Tue, 18 Dec 2007 14:11:38 -0800
From:	"H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Alon Bar-Lev <alon.barlev@gmail.com>
CC:	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [MIPS] Build an embedded initramfs into mips kernel
References: <9e0cf0bf0712181208m7f16b9acpf3dba67f3556a613@mail.gmail.com>	 <47683B2D.9030608@zytor.com> <9e0cf0bf0712181409p2475e1fdk779fdee4fa274722@mail.gmail.com>
In-Reply-To: <9e0cf0bf0712181409p2475e1fdk779fdee4fa274722@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.91.2/5174/Tue Dec 18 11:07:58 2007 on terminus.zytor.com
X-Virus-Status:	Clean
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips

Alon Bar-Lev wrote:
> On 12/18/07, H. Peter Anvin <hpa@zytor.com> wrote:
>> Make sure your /init doesn't depend on an interpreter or library which
>> isn't available.
> 
> Thank you for your answer.
> 
> I already checked.
> 
> /init is hardlink to busybox, it depends on libc.so.0 which is available at /lib
> 
> But shouldn't I get a different error code if this is the case?

Don't think so.

	-hpa
