Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2004 14:58:49 +0000 (GMT)
Received: from rrcs-sw-24-153-140-91.biz.rr.com ([IPv6:::ffff:24.153.140.91]:46216
	"EHLO public.nshore.com") by linux-mips.org with ESMTP
	id <S8225385AbUCAO6r>; Mon, 1 Mar 2004 14:58:47 +0000
Received: from nshore.com (gate.nshore.com [192.168.1.2])
	by public.nshore.com (8.11.6/8.11.6) with ESMTP id i21Ew0c03462;
	Mon, 1 Mar 2004 08:58:01 -0600
Message-ID: <40434F9D.3010007@nshore.com>
Date: Mon, 01 Mar 2004 08:58:37 -0600
From: Tahoma Toelkes <tahoma@nshore.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sundar <sundar@pst.fujitsu.com>
CC: linux-mips@linux-mips.org
Subject: Re: Problem after kernel entry point
References: <001701c3ff2e$b12d4b60$cb9b5a0a@indofuji2>
In-Reply-To: <001701c3ff2e$b12d4b60$cb9b5a0a@indofuji2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tahoma@nshore.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tahoma@nshore.com
Precedence: bulk
X-list: linux-mips

sundar wrote:

>I am trying to port kernel to mips arch.
>After building the image, it just displays the kernel entry point and
>stops it.It is not going further and no error message too.
>What may be th problem? How i can debug this? 
>  
>
Sathis,

Could you post a capture of the kernel's output until it stops?  Without 
more information, even the most expert of individuals would have 
difficulty giving you more assistance than "go read this document".

Also, it might be helpful to know the versions of the components in your 
cross-compilation toolchain, the kernel version you are building, and 
what patches you have applied.


-- Tahoma
