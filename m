Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 19:13:28 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:36100 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225358AbTLITN1>; Tue, 9 Dec 2003 19:13:27 +0000
Received: from flavia.localnet ([192.168.1.11] helo=bitbox.co.uk)
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1ATnIQ-0004oJ-00
	for <linux-mips@linux-mips.org>; Tue, 09 Dec 2003 19:13:22 +0000
Message-ID: <3FD61ED1.2040506@bitbox.co.uk>
Date: Tue, 09 Dec 2003 19:13:21 +0000
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
References: <3FD5FE41.8040909@bitbox.co.uk> <20031209181719.GC13411@bogon.ms20.nix>
In-Reply-To: <20031209181719.GC13411@bogon.ms20.nix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Guido Guenther wrote:

>Hi Peter,
>On Tue, Dec 09, 2003 at 04:54:25PM +0000, Peter Horton wrote:
>  
>
>>The kernel boots okay from the HD, but I get strange segmentation faults 
>>and other errors whilst running Debian's "dpkg" to install packages. If 
>>I repeat the installation from scratch I get exactly the same errors in 
>>exactly the same places :-(
>>    
>>
>This has been reported several times. AFAIK 2.4.17 worked for several
>people, but people who actually own the hardware will now better. It
>would be a _huge_ help if somebody could track down the date in
>linux-mips.org CVS where things broke exactly.
>Cheers,
> -- Guido
>  
>

Thanks. I'll start at 2.4.17 and work my way forwards ...

P.
