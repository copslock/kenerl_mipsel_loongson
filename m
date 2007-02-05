Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 06:01:03 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:27624 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20027577AbXBEGAx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 06:00:53 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id D5FA4297F8B;
	Mon,  5 Feb 2007 01:00:15 -0500 (EST)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Mon,  5 Feb 2007 01:00:15 -0500 (EST)
Received: from [192.168.7.229] ([192.168.7.229]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 4 Feb 2007 22:00:13 -0800
Message-ID: <45C6C7F0.7000502@avtrex.com>
Date:	Sun, 04 Feb 2007 22:00:16 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Question about signal syscalls !
References: <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com> <45C21CFE.9060804@avtrex.com> <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com> <45C3611D.7000702@avtrex.com> <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com> <45C36D46.5040409@avtrex.com> <cda58cb80702021158n42bdb5fbi6cca4f2c8dff6782@mail.gmail.com> <45C3A1E3.8010802@avtrex.com> <20070205005516.GA1581@nevyn.them.org> <20070205011048.GA26654@linux-mips.org> <20070205023039.GA5438@nevyn.them.org>
In-Reply-To: <20070205023039.GA5438@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2007 06:00:13.0728 (UTC) FILETIME=[E6EE6A00:01C748EA]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
> On Mon, Feb 05, 2007 at 01:10:48AM +0000, Ralf Baechle wrote:
>   
>> Not saving the s-registers into the signal frame would be a neat
>> optimization.  It wouldn't only make things a little faster it would
>> also free space in the signal frame which is needed for CPU
>> architecture extensions that have more state to save.  I had to burn
>> almost the entire available space for the DSP extensions, so I wonder
>> if we could get GDB to work?  The alternative is probably a new version
>> of the sigrestore.
>>     
>
> I'm sure that, if we tried, we could get GDB to work.  Every time this
> comes up I just worry about other things that we don't know about which
> use the saved information.  These structures are just in too many
> places to change comfortably.
>   
If you are keeping track, add MD_FALLBACK_FRAME_STATE in libgcc, which 
allows throwing C++ and java exceptions through signal handlers.

If gdb can be made to work, so can libgcc.  The thing I worry about is I 
think people upgrade their kernel much more often than their 
toolchains.  So you could be in a position of having to use a very new 
GCC.  That might make some uncomfortable.

David Daney
