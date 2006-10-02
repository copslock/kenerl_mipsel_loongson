Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Oct 2006 02:39:29 +0100 (BST)
Received: from ns2.nec.com.au ([147.76.180.2]:22725 "EHLO ns2.nec.com.au")
	by ftp.linux-mips.org with ESMTP id S20040343AbWJBBj1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 2 Oct 2006 02:39:27 +0100
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP id B979C3B6A7
	for <linux-mips@linux-mips.org>; Mon,  2 Oct 2006 11:39:16 +1000 (EST)
Received: from [147.76.208.162] ([147.76.208.162])
	by tns.neca.nec.com.au (8.12.8/8.12.8) with ESMTP id k921ipZl001952;
	Mon, 2 Oct 2006 11:44:52 +1000
Message-ID: <45206D4C.1040005@nec.com.au>
Date:	Mon, 02 Oct 2006 11:37:16 +1000
From:	Pak Woon <pak.woon@nec.com.au>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Andrew Sharp <asharp@2wire.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Introduction and problems cloning repository
References: <451C7CE7.8040909@nec.com.au>	<20060929094944.GA10597@linux-mips.org> <20060929105241.423a1ade@ripper>
In-Reply-To: <20060929105241.423a1ade@ripper>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pak.woon@nec.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pak.woon@nec.com.au
Precedence: bulk
X-list: linux-mips

>>>First time poster to this mailing list so if I am not following the 
>>>correct protocol please let me know.
>>>
>>>Introduction. I am a firmware developer working for NEC Australia.
>>>We  are currently developing a MIPS SOC device made by Wintegra.
>>>
>>>I am trying to clone the linux-malta.git repository using the
>>>command "git clone http://ftp.linux-mips.org/pub/scm/linux-malta.git
>>>
>>>./linux-malta.git" but I receieve an "error: Can't lock ref". I have
>>>to  use http because I am sure port 9418 is blocked by the sysadmin
>>
>>An good old access permission problem on the web server but I won't
>>have time to sort it out now.
> 
> 
> I had this same problem.  Turns out that for the http method of git, you
> have to use the name 'www.linux-mips.org'.  So it would be 
> 
> git clone http://www.linux-mips.org/pub/scm/linux-malta.git linux-malta.git
> 
> 
>>  cvs -d :pserver:anonymous@git.linux-mips.org:/pub/scm/linux.git co
>>  -d linux-malta -P <branch>
>>
>>Where <branch> is one of linux-2.0, linux-2.2, linux-2.4,
>>MaltaRef_2_4, MaltaRef_2_6 and master - if your firewall allows port
>>2401 that is ...
>>
>>But why are you still using the linux-malta repository?  Since ~ 5
>>months it is no longer being updated and has effectivly been replaced
>>with linux.git repository.  Of this repository there are also
>>snapshots of all tagged versions available.
> 
> 
> Good point.
Probably because on http://www.linux-mips.org/wiki/Getting_the_kernel it 
mentions MIPS technologies is maintaining "a stable and tested kernel 
with focus on hardware support for ... the Malta Eval board" and I 
thought it would be quicker to develop with.

Are they no longer doing the maintainace?

Regards,
Pak
