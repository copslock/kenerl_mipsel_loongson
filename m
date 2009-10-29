Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 17:20:02 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19103 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492622AbZJ2QTz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 17:19:55 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae9c0140000>; Thu, 29 Oct 2009 09:17:29 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 Oct 2009 09:17:25 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 Oct 2009 09:17:25 -0700
Message-ID: <4AE9C012.5090203@caviumnetworks.com>
Date:	Thu, 29 Oct 2009 09:17:22 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Wu Zhangjin <wuzhangjin@gmail.com>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH -v1] MIPS: a few of fixups and cleanups for the compressed
 kernel support
References: <1256797212-7794-1-git-send-email-wuzhangjin@gmail.com>
In-Reply-To: <1256797212-7794-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2009 16:17:25.0182 (UTC) FILETIME=[4D3E9DE0:01CA58B3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
[...]
>  	.comm .heap,BOOT_HEAP_SIZE,4
>  	.comm .stack,4096*2,4
> +	.set reorder

I feel a little ambivalent about the '.set reorder'.

Since it is at the end of the file, you could omit it.  If you think you 
will add more things around it, you could put a '.set push' at the top 
and then use '.set pop' here.  Or you could leave it as is.

David Daney
