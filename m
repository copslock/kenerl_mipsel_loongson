Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4A8rvw27005
	for linux-mips-outgoing; Thu, 10 May 2001 01:53:57 -0700
Received: from mailgw3.netvision.net.il (mailgw3.netvision.net.il [194.90.1.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4A8rPF26994;
	Thu, 10 May 2001 01:53:26 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw3.netvision.net.il (8.9.3/8.9.3) with ESMTP id LAA27494;
	Thu, 10 May 2001 11:51:48 +0300 (IDT)
Message-ID: <3AFA56F8.9090504@jungo.com>
Date: Thu, 10 May 2001 11:53:12 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Shay Deloya <shay@jungo.com>, linux-mips@oss.sgi.com
Subject: Re: insmod problems
References: <01050619134301.01140@athena.home.krftech.com> <20010508234036.A1216@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Ralf Baechle wrote:

> On Sun, May 06, 2001 at 07:13:43PM +0300, Shay Deloya wrote:
> 
> 
>> I have an old problem came up again and the old solution aren't helping.
>> Relocation overflow of type 4 for
>> Is it insmod knowen bugs that the relocation is done in bad way or 
>> a linker/compiler bug. I'm using compiler: egcs ver 1.0.3a
>> I'm checking this problem at the moment and looking for insmod bug.
> 
> 
> You'll have to upgrade to very current binutils which for mips*-linux
> targets default to elf32-trad{big,little}mips, not IRIX ELF format.  Also
> it seems your modutils are a bit rotten, get the latest from ftp.kernel.org.
> 
>   Ralf

On the same topic: same source (!!) 'insmod' executable compiled with 
new (2.10) binutils doesn't exibit such relocation problem.

What may be causing 'insmod' to be dependant on binutils which compile 
it? The module *.o is exactly same as it was before.


Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
