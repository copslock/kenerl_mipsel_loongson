Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2004 22:09:40 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:8692 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225211AbUKBWJf>; Tue, 2 Nov 2004 22:09:35 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 5D9AE185D1; Tue,  2 Nov 2004 14:09:33 -0800 (PST)
Message-ID: <4188059D.1000601@mvista.com>
Date: Tue, 02 Nov 2004 14:09:33 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Manish Lachwani <mlachwani@prometheus.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Support for PMC-Sierra Ocelot-3 in 2.6
References: <20041102201720.GB24674@prometheus.mvista.com> <20041102230733.GC28025@linux-mips.org>
In-Reply-To: <20041102230733.GC28025@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Nov 02, 2004 at 12:17:20PM -0800, Manish Lachwani wrote:
> 
> 
>>+#ifdef CONFIG_MIPS64
>>+		0xfffffffffc807000;
>>+#else
>>+		0xfc807000;
>>+#endif
> 
> 
> Ouch.  Rather ugly.  I suggest you rely on the implicit sign extension
> of the compiler instead.
> 
>   Ralf
> 
  Got it. Will send a patch with the changes and with PCI included

Thanks
Manish Lachwani
