Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 13:41:51 +0100 (BST)
Received: from terminus.zytor.com ([198.137.202.10]:12228 "EHLO
	terminus.zytor.com") by ftp.linux-mips.org with ESMTP
	id S20022636AbXG3Mlt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 13:41:49 +0100
Received: from titan.hos.anvin.org ([66.0.95.132])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l6UCff7n003534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Jul 2007 05:41:45 -0700
Message-ID: <46ADDC78.8080405@zytor.com>
Date:	Mon, 30 Jul 2007 05:41:28 -0700
From:	"H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	maximilian attems <max@stro.at>, linux-mips@linux-mips.org,
	klibc@zytor.com
Subject: Re: [klibc] klibc kernelheaders build failure on mips/mipsel
References: <20070729095217.GE7448@stro.at> <46AC997B.2030706@zytor.com> <20070730120557.GE11436@linux-mips.org> <20070730121257.GA14368@linux-mips.org>
In-Reply-To: <20070730121257.GA14368@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.88.7/3820/Mon Jul 30 05:13:24 2007 on terminus.zytor.com
X-Virus-Status:	Clean
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> Oh, the canonical place for these headers outside the kernel is either
> <{regdef,fpregdef,asm}.h> and <sys/{regdef,fpregdef,asm}.h>, not <asm/...>.
> 

Well, yes, but klibc implements a lot of headers by #including 
appropriate kernel bits.

	-hpa
