Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2007 01:06:27 +0100 (BST)
Received: from terminus.zytor.com ([192.83.249.54]:18392 "EHLO
	terminus.zytor.com") by ftp.linux-mips.org with ESMTP
	id S20026674AbXFEAGW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Jun 2007 01:06:22 +0100
Received: from tazenda.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l5504C0L008097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2007 17:04:13 -0700
Message-ID: <4664A87C.5040609@zytor.com>
Date:	Mon, 04 Jun 2007 17:04:12 -0700
From:	"H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
MIME-Version: 1.0
To:	David Miller <davem@davemloft.net>
CC:	joseph@codesourcery.com, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, linux-arch@vger.kernel.org
Subject: Re: 64-bit syscall ABI issue
References: <Pine.LNX.4.64.0706042051280.16431@digraph.polyomino.org.uk> <20070604.142557.68139332.davem@davemloft.net>
In-Reply-To: <20070604.142557.68139332.davem@davemloft.net>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.88.7/3351/Mon Jun  4 15:52:05 2007 on terminus.zytor.com
X-Virus-Status:	Clean
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips

David Miller wrote:
> From: "Joseph S. Myers" <joseph@codesourcery.com>
> Date: Mon, 4 Jun 2007 20:56:57 +0000 (UTC)
> 
> [ added linux-arch which is a great place to discuss these
>   kinds of issues. ]
> 
>> What should the kernel syscall ABI be in such cases (any case where the 
>> syscall implementations expect arguments narrower than registers, so 
>> mainly 32-bit arguments on 64-bit platforms)?  There are two obvious 
>> possibilities:
> 
> In general we've taken the stance that the syscall dispatch
> should create the proper calling environment for C code
> implementing the system calls, and this thus means properly
> sign and zero extending the arguments as expected by the C
> calling convention.

This is, in fact, rather fundamental (some ABIs don't require sign or
zero extension, e.g. x86-64); otherwise libc's job becomes a whole lot
harder.

	-hpa
