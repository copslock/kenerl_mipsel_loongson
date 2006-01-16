Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 17:30:55 +0000 (GMT)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:59414
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S3458552AbWAPRae (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 17:30:34 +0000
Received: from [192.168.7.222] ([192.168.7.222]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 16 Jan 2006 09:34:04 -0800
Message-ID: <43CBD91B.4020607@avtrex.com>
Date:	Mon, 16 Jan 2006 09:34:19 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Kishore K <hellokishore@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: gcc -3.4.4 and linux-2.4.32
References: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com>
In-Reply-To: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2006 17:34:04.0360 (UTC) FILETIME=[0BAEFC80:01C61AC3]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Kishore K wrote:
> hi
> When 2.4.32 kernel (from linux-mips) is compiled with the tool chain 
> based on gcc 3.4.4 and binutils 2.16.1, the kernel crashes on malta 
> board. The crash file is enclosed along with the mail. If the same 
> kernel is compiled with the tool chain based on gcc 3.3.6, no problem is 
> observed.
> 
> May I know, whether it is because of the changes in ABI in gcc 3.4.

Not exactly.  It has to do with -funit-at-a-time.  In the 2.4.x kernel 
it is assumed that gcc will not reorder top level asm statements and 
functions.  For gcc-3.3.x and earlier this was a valid assumption.  With 
3.4.x and later it is not.

> If 
> so, has any one got the patch to make 2.4.x kernels work with gcc 3.4 
> compilers? From the changelog, I can infer that, some changes have been 
> done in 2.4.28 kernel to work with gcc 3.4 for i386. If so, has the same 
> thing been done for MIPS as well.
> 
IIRC the patches were never applied to linux-mips.org.  If you search 
the archives of this list for messages that I sent, you can find the 
patches.

David Daney.
