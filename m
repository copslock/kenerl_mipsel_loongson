Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2009 17:07:58 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:63707 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21103620AbZBQRH4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Feb 2009 17:07:56 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B499aee9a0001>; Tue, 17 Feb 2009 12:06:39 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 09:06:32 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 09:06:32 -0800
Message-ID: <499AEE98.1010908@caviumnetworks.com>
Date:	Tue, 17 Feb 2009 09:06:32 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	post@pfrst.de, Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: cacheflush system call-MIPS
References: <f5a7b3810902100716t2658ce95t2dcc7f85634522@mail.gmail.com> <20090211131649.GA1365@linux-mips.org> <Pine.LNX.4.58.0902140002180.408@Indigo2.Peter> <20090213235603.GA32274@linux-mips.org> <Pine.LNX.4.58.0902150312460.459@Indigo2.Peter>
In-Reply-To: <Pine.LNX.4.58.0902150312460.459@Indigo2.Peter>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2009 17:06:32.0444 (UTC) FILETIME=[15069BC0:01C99122]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

peter fuerst wrote:
>> Why does it need that flush?
> 
> To prepare the update-area (in the Shadow-FB) for DMA to RE.
> 
> 

And on systems where the root frame buffer is directly manipulated by 
the CPU, the video system is continually using DMA to refresh the 
display.  A cache flush can be required to eliminate transient visual 
glitches.

David Daney



> kind regards
> 
> 
> 
> On Fri, 13 Feb 2009, Ralf Baechle wrote:
> 
>> Date: Fri, 13 Feb 2009 23:56:03 +0000
>> From: Ralf Baechle <ralf@linux-mips.org>
>> To: peter fuerst <post@pfrst.de>
>> Cc: naresh kamboju <naresh.kernel@gmail.com>, linux-mips@linux-mips.org
>> Subject: Re: cacheflush system call-MIPS
>>
>> On Sat, Feb 14, 2009 at 12:50:46AM +0100, peter fuerst wrote:
>>
>>> there is one more good reason to ... : the Impact Xserver needs to do
>>> a cacheflush(a,w,DCACHE) as part of the refresh-sequence.
>>> And hence requires a sys_cacheflush, let's say, more conforming to the
>>> man-page (or some disgusting new ioctl in the Impact kernel-driver to
>>> do an equivalent operation ;-)
>> Why does it need that flush?
>>
>>   Ralf
>>
>>
> 
> 
