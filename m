Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2005 00:08:13 +0100 (BST)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:21737
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225755AbVC1XH5>;
	Tue, 29 Mar 2005 00:07:57 +0100
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 28 Mar 2005 15:07:55 -0800
  id 0000847B.42488E4B.00001A76
Message-ID: <42488DFC.20408@jg555.com>
Date:	Mon, 28 Mar 2005 15:06:36 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Peter Horton <pdh@colonel-panic.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Build 64bit on RaQ2
References: <42449F47.8010002@jg555.com> <20050326091218.GA2471@skeleton-jack>
In-Reply-To: <20050326091218.GA2471@skeleton-jack>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Peter Horton wrote:

>On Fri, Mar 25, 2005 at 03:31:19PM -0800, Jim Gifford wrote:
>  
>
>>  Has anyone had any luck compiling a 64 bit version on the RaQ2. I can 
>>get it to compile but, it locks up during boot up.
>>
>>elf64: 00080000 - 0042fd3f (ffffffff,803e6000) (ffffffff,8000000)
>>elf64: ffffffff,80080000 (8008000) 3731589t + 134331t
>>
>>That's all I got during bootup, no error messages or anything.
>>
>>    
>>
>
>As a starting point you need to ensure the "cpu_has_llsc" is false for
>64-bit Cobalt kernels. LLD/SCD is broken on RM5230/5231. There is an
>experimental patch for 2.6.9 on
>http://www.colonel-panic.org/cobalt-mips.
>
>P.
>  
>
Peter,
    Got it to compile, but the tulip driver is giving me fits. I built 
it as a module and into the kernel


0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed
0000:00:07.0: tulip_stop_rxtx() failed


-- 
----
Jim Gifford
maillist@jg555.com
