Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Oct 2009 13:16:07 +0100 (CET)
Received: from rs1.rw-gmbh.net ([213.239.201.58]:48869 "EHLO rs1.rw-gmbh.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493251AbZJaMQA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 31 Oct 2009 13:16:00 +0100
Received: from pd9519f28.dip0.t-ipconnect.de ([217.81.159.40] helo=[192.168.178.24])
	by rs1.rw-gmbh.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <ralf.roesch@rw-gmbh.de>)
	id 1N4Cs8-0000JV-0w; Sat, 31 Oct 2009 13:15:56 +0100
Message-ID: <4AEC2A73.3060009@rw-gmbh.de>
Date:	Sat, 31 Oct 2009 13:15:47 +0100
From:	Ralf Roesch <ralf.roesch@rw-gmbh.de>
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	=?ISO-8859-1?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>,
	linux-mips@linux-mips.org, sam@ravnborg.org, manuel.lauss@gmail.com
Subject: Re: mips: fix build of vmlinux.lds
References: <4AEAEF43.7060200@rw-gmbh.de> <20091031113446.GA3172@linux-mips.org>
In-Reply-To: <20091031113446.GA3172@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

On Sat Oct 31 2009 12:34:46 GMT+0100 (CET), Ralf Baechle 
<ralf@linux-mips.org>  wrote:
> On Fri, Oct 30, 2009 at 02:50:59PM +0100, Ralf Rösch wrote:
>
>   
>> could you please cherry-pick commit   
>> fd6b6a85c525824bece9543fae5ed68c00ad65a7
>> (or fd6b6a85c525824bece9543fae5ed68c00ad65a7, seems to be identical)
>>     
>
> Identical numbers tend to be identical ;-)
>
>   
Oops, typo, second should be d71789b6fa37c21ce5eb588d279f57904a62e7e2
BTW, there are more "double entries" in the revision history, is this o.k.?


--
Ralf R.
