Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Nov 2004 16:46:26 +0000 (GMT)
Received: from web81001.mail.yahoo.com ([IPv6:::ffff:206.190.37.146]:60066
	"HELO web81001.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225255AbUKPQqS>; Tue, 16 Nov 2004 16:46:18 +0000
Message-ID: <20041116164606.73956.qmail@web81001.mail.yahoo.com>
Received: from [63.194.214.47] by web81001.mail.yahoo.com via HTTP; Tue, 16 Nov 2004 08:46:06 PST
X-RocketYMMF: pvpopov@pacbell.net
Date: Tue, 16 Nov 2004 08:46:06 -0800 (PST)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: zboot on 2.6
To: Gilad Rom <gilad@romat.com>, linux-mips@linux-mips.org
In-Reply-To: <0bbe01c4cbe9$60fa9570$a701a8c0@lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


--- Gilad Rom <gilad@romat.com> wrote:

> Hello list,
> 
> Is zboot supported on the linux-mips cvs 2.6 kernel
> tree,
> like it is on 2.4?

It's not in the kernel source tree yet. Grab
ftp.linux-mips.org:/pub/linux/mips/people/ppopov/2.6/zImage_2_6_10-rc1.patch

There's no more zboot directory. The compressed kernel
is under arch/mips/boot/compressed.

Pete
