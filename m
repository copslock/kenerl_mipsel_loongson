Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2008 20:37:13 +0100 (BST)
Received: from terminus.zytor.com ([198.137.202.10]:45797 "EHLO
	terminus.zytor.com") by ftp.linux-mips.org with ESMTP
	id S20022455AbYECThJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 May 2008 20:37:09 +0100
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m43JaOJQ013923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 May 2008 12:36:24 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m43JaNu3030247;
	Sat, 3 May 2008 12:36:23 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m43JaLEa021939;
	Sat, 3 May 2008 12:36:22 -0700
Message-ID: <481CBEB5.803@zytor.com>
Date:	Sat, 03 May 2008 12:36:21 -0700
From:	"H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	Adrian Bunk <bunk@kernel.org>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6 patch] fix asm-mips/types.h syntax error
References: <20080503192617.GQ5838@cs181133002.pp.htv.fi>
In-Reply-To: <20080503192617.GQ5838@cs181133002.pp.htv.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.92.1/7015/Sat May  3 04:57:16 2008 on terminus.zytor.com
X-Virus-Status:	Clean
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips

Adrian Bunk wrote:
> This patch fixes the following compile error caused by
> commit 23cf11ddb5099f8c7f7cb3eb154bff0faf31cae9
> (mips: types: use <asm-generic/int-*.h> for the mips architecture):
> 
> <--  snip  -->
> 
> ...
>   CC      kernel/bounds.s
> In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/types.h:12,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/page-flags.h:8,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/kernel/bounds.c:9:
> include2/asm/types.h:56:2: error: #endif without #if
> make[2]: *** [kernel/bounds.s] Error 1
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 

Acked-by: H. Peter Anvin <hpa@zytor.com>

Went through the other patches, too, to verify none of the other 
architectures were similarly affected.

	-hpa
