Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 11:15:55 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:36067 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225244AbUC3KPy>; Tue, 30 Mar 2004 11:15:54 +0100
Received: from sprocket.localnet ([192.168.1.27] helo=bitbox.co.uk)
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1B8GHc-0003tG-00; Tue, 30 Mar 2004 11:15:48 +0100
Message-ID: <406948D4.4050708@bitbox.co.uk>
Date: Tue, 30 Mar 2004 11:15:48 +0100
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominique Quatravaux <dom@idealx.com>
CC: linux-mips@linux-mips.org
Subject: Re: Best kernel for a Cobalt Qube 2
References: <4018EA65.40407@c-gix.com> <40190154.10601@bitbox.co.uk> <20040330100959.GA7466@idealx.com>
In-Reply-To: <20040330100959.GA7466@idealx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Dominique Quatravaux wrote:

>Hello Stéphane, Peter and the list,
>
>I'm replying to an old (Jan 2004) thread where the following messages
>were exchanged:
>
>[Stéphane]
>  
>
>>>I'm using a Cobalt Qube 2 for a long time now, it's under a 2.4.14 
>>>kernel working 24/24 7/7 without any problem (no weird hang, no tulip 
>>>problems, both internal network cards used).
>>>      
>>>
>
>[Peter]
>  
>
>>2.4.23 is running solid here, but it needs a couple of patches (one 
>>fixes a cache aliasing bug triggered by IDE in PIO mode, another fixes 
>>up Galileo so the network driver works without stalling). I'll mail the 
>>patches when I get home.
>>    
>>
>
>I'm interested in upgrading my RaQ2 kernel too. Would you be so kind
>as to (re)post patches, URLs and success stories to me and/or the
>list? (I will post a summary, and I can jot down a quick Web page for
>the patches if needed). Thanks!
>
>  
>
http:///www.colonel-panic.org/cobalt-mips

P.
