Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3CEV4k08970
	for linux-mips-outgoing; Thu, 12 Apr 2001 07:31:04 -0700
Received: from servidor.spania-hq.com ([212.170.16.42])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3CEV3M08967
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 07:31:03 -0700
Received: from jungo.com ([194.90.113.98] RDNS failed) by servidor.spania-hq.com with Microsoft SMTPSVC(5.0.2195.1600);
	 Thu, 12 Apr 2001 16:32:07 +0200
Message-ID: <3AD5BBDF.8060101@jungo.com>
Date: Thu, 12 Apr 2001 17:29:51 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Linux/MIPS <linux-mips@oss.sgi.com>, FR Linux/MIPS <linux-mips@fnet.fr>
Subject: Re: Dynamic linker and .interp section
References: <Pine.GSO.3.96.1010412160800.24526A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2001 14:32:15.0003 (UTC) FILETIME=[5E6E36B0:01C0C35D]
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Maciej W. Rozycki wrote:

> On Thu, 12 Apr 2001, Michael Shmulevich wrote:
> 
> 
>> So my question sounds like: can I specify a non-existing linker and tell 
>> ld to ignore missing file?
> 
> 
>  You can.  Ld never checks for its existence.

As with binutils-2.10 it is not true. Not only ld looks for it, it opens 
the file, checks the architecture and even checks for SO_NAME (adds it 
do NEEDS list). I have tried it several times.


Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
