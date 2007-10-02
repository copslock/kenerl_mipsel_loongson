Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 00:08:54 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:17593 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20023808AbXJBXIp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Oct 2007 00:08:45 +0100
Received: (qmail 920 invoked by uid 507); 3 Oct 2007 07:04:51 +0800
Received: from unknown (HELO ?192.168.1.8?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 3 Oct 2007 07:04:51 +0800
Message-ID: <4702CF4A.8050609@ict.ac.cn>
Date:	Wed, 03 Oct 2007 07:07:54 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: IceDove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: cmpxchg broken in some situation
References: <46FF7BC2.5050905@ict.ac.cn> <20071001025340.GA7091@linux-mips.org> <47010E15.7060109@ict.ac.cn> <20071001152620.GB15820@linux-mips.org> <470210B4.8020902@ict.ac.cn> <20071002103551.GB5152@linux-mips.org> <4702CABC.40600@ict.ac.cn> <20071002225250.GB21687@linux-mips.org>
In-Reply-To: <20071002225250.GB21687@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

en? It seems that it is working for my case now.

Ralf Baechle 写道:
> On Wed, Oct 03, 2007 at 06:48:28AM +0800, Fuxin Zhang wrote:
>
>   
>> And the comment "# cmpxchg_u32" is out of date too:)
>>     
>
> I've seen worse bugs ;-)
>
>   Ralf
>
>
>
>
>   
