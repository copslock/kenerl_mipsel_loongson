Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2007 12:37:58 +0000 (GMT)
Received: from mail197.abchk.net ([203.194.196.197]:60045 "EHLO
	webmail.abchk.net") by ftp.linux-mips.org with ESMTP
	id S20026290AbXKNMht (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Nov 2007 12:37:49 +0000
Received: (qmail 10220 invoked by uid 89); 14 Nov 2007 12:36:33 -0000
Received: from unknown (HELO localhost) (127.0.0.1)
  by webmail.abchk.net with SMTP; 14 Nov 2007 12:36:33 -0000
Received: from pcd309118.netvigator.com (pcd309118.netvigator.com [203.218.99.118]) 
	by webmail.pixelmagicsystems.com (IMP) with HTTP 
	for <david@pixelmagicsystems.com@127.0.0.1>; Wed, 14 Nov 2007 20:36:31 +0800
Message-ID: <1195043791.473aebcfdc740@webmail.pixelmagicsystems.com>
Date:	Wed, 14 Nov 2007 20:36:31 +0800
From:	david@pixelmagicsystems.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Kuk <david.kuk@entone.com>, linux-mips@linux-mips.org
Subject: Re: smp8634 add memory at dram1
References: <473AB56B.2070107@entone.com> <20071114110426.GA19693@linux-mips.org>
In-Reply-To: <20071114110426.GA19693@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=BIG5
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 203.218.99.118
Return-Path: <david@pixelmagicsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david@pixelmagicsystems.com
Precedence: bulk
X-list: linux-mips

Quoting Ralf Baechle <ralf@linux-mips.org>:

>
> I don't know what processor core Sigma is using in this SOC.  In case its a
> 64-bit core, don't waste even a nanosecond on highmem, just go for a 64-bit
> kernel, it's much less painful than highmem.
>
>   Ralf
>
>

It is a MIPS 4KEc core.
