Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2003 00:29:58 +0000 (GMT)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:20889 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225354AbTKTA3q>;
	Thu, 20 Nov 2003 00:29:46 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 19 Nov 2003 16:29:44 -0800
Message-ID: <3FBC0AF7.90600@avtrex.com>
Date: Wed, 19 Nov 2003 16:29:43 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: Re: How reliable is GCC-3.3.1 wrt building mipsel-linux kernel?
References: <3FBACA0F.7070207@avtrex.com> <20031119233023.GA30962@linux-mips.org>
In-Reply-To: <20031119233023.GA30962@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Nov 2003 00:29:44.0132 (UTC) FILETIME=[65057040:01C3AEFD]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Tue, Nov 18, 2003 at 05:40:31PM -0800, David Daney wrote:
>  
>
>><...>
>>But my main question is this:  Have other people experienced 
>>miscompilation (ie bad code generation) with gcc 3.3.1?
>>    
>>
>
>Quite frequently using a new, possibly more agressive compiler triggers
>bugs in the kernel code ...
>
>  Ralf
>  
>
That's the whole point of my question.

Which options have other people used with gcc 3.3.1 with good results?

David Daney.
