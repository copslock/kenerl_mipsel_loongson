Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2004 21:53:00 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:53749 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224989AbULFVwz>; Mon, 6 Dec 2004 21:52:55 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 40AEE184FF; Mon,  6 Dec 2004 13:52:54 -0800 (PST)
Message-ID: <41B4D4B5.5030104@mvista.com>
Date: Mon, 06 Dec 2004 13:52:53 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Ocelot-3 supports 256 MB memory
References: <20041206212720.GA11390@prometheus.mvista.com> <20041206214346.GA1182@linux-mips.org>
In-Reply-To: <20041206214346.GA1182@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Dec 06, 2004 at 01:27:20PM -0800, Manish Lachwani wrote:
> 
> 
>>Small patch for Ocelot-3 to support 256 MB memory. Please apply ...
> 
> 
> Does this board really have a fixed memory configuration?  If not we should
> use a safe default, the minimum configuration.  Or probe which obviously
> is the right thing to do.
> 
>   Ralf

Probing is a better idea. Let me put that together and send another patch

Thanks
Manish Lachwani
