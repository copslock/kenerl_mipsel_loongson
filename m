Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2004 13:28:00 +0100 (BST)
Received: from host-212-158-214-243.bulldogdsl.com ([IPv6:::ffff:212.158.214.243]:9736
	"EHLO megablaster5.clown-smart.co.uk") by linux-mips.org with ESMTP
	id <S8226105AbUD1M16>; Wed, 28 Apr 2004 13:27:58 +0100
Received: from [127.0.0.1] (host-212-158-214-244.bulldogdsl.com [212.158.214.244])
	by megablaster5.clown-smart.co.uk (Postfix) with ESMTP
	id BA3AA32E57; Wed, 28 Apr 2004 13:39:49 +0100 (BST)
Message-ID: <408FA3C3.3060304@clown-fish.com>
Date: Wed, 28 Apr 2004 13:29:55 +0100
From: Damian Presswell <damian@clown-fish.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040426)
X-Accept-Language: en
MIME-Version: 1.0
To: ilya@theIlya.com
Cc: Damian Presswell <damian@clown-fish.com>, linux-mips@linux-mips.org
Subject: Re: Linux Mips SGI O2 R5000 IP32 INSTALL
References: <408D6BFC.6030902@clown-fish.com> <20040426222441.GC1276@gateway.total-knowledge.com>
In-Reply-To: <20040426222441.GC1276@gateway.total-knowledge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <damian@clown-fish.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: damian@clown-fish.com
Precedence: bulk
X-list: linux-mips

Hi Ilya -

thanks for coming back to me -

I have managed to build a root filesystem using the gentoo sources that 
you suggested - however -
I am unable to boot off the hardisk -
I have fdisked the first scsi disk, created a 50 meg vlhdr, where I have 
copied my pre-compiled vmlinux binaries  -
it  appears to load and provide an entry point but then just hangs and 
goes no further -
I have also added the original netboot vmlinux  binary that I use to 
boot via tftpboot to the HD's volume header but it does the same thing - 
just hangs after the entry point -

I can boot the system using bootp(): and the kernel binary located  in  
the tftpboot using  root=dev/sda3 - but  cannot figure why it  doesnt 
seem to work off the volume header of the HD -

 once again -

any help would be appreciated -

thanks



ilya@theIlya.com wrote:

>Use Gentoo.
>Also, Glaurung's kernels are bit out-od-date. Use self-built
>kernel from recent linux-mips.org CVS. In worst case, use
>one of Gentoo's kernel binaries.
>
>	Ilya.
>
>On Mon, Apr 26, 2004 at 09:07:24PM +0100, Damian Presswell wrote:
>  
>
>>My apologies if this is the wrong mailing list for this question -
>>
>>I have recently aquired an SGI  O2 ip32 R5k box that I am trying to 
>>install linux onto -
>>
>>I have managed to get a binary 64bit kernel to boot vis nfs and bootp() 
>>that I downloaded from Glaurungs website:
>>
>>http://www.linux-mips.org/~glaurung/
>>
>>however I am unsure as to the correct rootfs that I am suposed to use - 
>>I pulled down the redhat 7.1 rootfs from somewhere but it hangs when 
>>trying to start the 'local' service - and wont boot if this service is 
>>switched off -
>>
>>I would be grateful if you could suggest where I may download a suitable 
>>rootfs and ecoff boot image that will work together on my O2 box - would 
>>hate to give in at this stage - and indeed any other help you may be 
>>able to give me as a linux mips O2 user - I will put together an updated 
>>HOWTO once I am sure exactly what I am supposed to be doing - the 
>>information and resources on this subject do seem to be a little vague -
>>
>>thanks for your time
>>
>>Damian
>>
>>
>>    
>>
>
>  
>
