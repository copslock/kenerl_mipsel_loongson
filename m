Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 19:59:56 +0100 (BST)
Received: from web32510.mail.mud.yahoo.com ([IPv6:::ffff:68.142.207.220]:338
	"HELO web32510.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225995AbVEZS7i>; Thu, 26 May 2005 19:59:38 +0100
Received: (qmail 58039 invoked by uid 60001); 26 May 2005 18:59:31 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=CvfWttYEJdCum2WwOocD/uLP8D0TTinQeAze1ePT3sTBq2ahs2J1dBMM9Ph5id7iQjBp6tbN+cLcCKy9hWmL3hTZGupeilphZTv5K9KsQ44sYH5QbVRT3XQy9LreZ4DBeFMLILRNgU5Pb5vaIpe6xck2oNSFGakXStpICjb/jBE=  ;
Message-ID: <20050526185931.58037.qmail@web32510.mail.mud.yahoo.com>
Received: from [217.132.178.211] by web32510.mail.mud.yahoo.com via HTTP; Thu, 26 May 2005 11:59:31 PDT
Date:	Thu, 26 May 2005 11:59:31 -0700 (PDT)
From:	Michael Belamina <belamina1@yahoo.com>
Subject: Re: 64 bit kernel for BCM1250
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <belamina1@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: belamina1@yahoo.com
Precedence: bulk
X-list: linux-mips


I have tried the patch on kernel version 2.4.28 and it
seems that the fix is not working for this kernel
version. I used gcc version 2.95.4 and it is working. 

Another questions:

 I am using 32 bit application and 64 bit device
driver that I wrote. ioctl fails with "unknown ioctl"
message. 

1. What is the best way to translate 32 bit ioctl
codes to 64 bit?

2. How 64 bit kernel space buffers will  be used by a
32 bit application (using mmap)? 

3.What is the maximum usable ram out of 2GB I will
have if I am using a 32 bit application and 64 bit
kernel and the kernel is allocating the buffers using
__get_free_pages (I need the buffers for DMA - and I
need them to be physically continuous)?

Thanks,
 Michael








--- "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> On Thu, 19 May 2005, Michael Belamina wrote:
> 
> >    I am still not sure about the following:
> > 
> >    1. Is this problem related only to kernels
> > downloaded from linux-mips.org or it is a more
> general
> > one?
> 
>  The problem is Linux 2.4 is generally in the
> maintenance mode, which 
> means no new development is done on it (although
> still an occasional 
> backport from 2.6 may happen).  As a result
> maintainers are rather 
> hesitant about applying changes unless they fix
> critical bugs.  Bugs 
> revealed by new versions of build tools are not
> usually considered as 
> critical, because you may work them around by using
> an old version of the 
> triggering tool.
> 
>  Still for the MIPS port what you can get from
> linux-mips.org is probably 
> less behind than what there is at kernel.org.
> 
> >    2. Can someone point to a known to work 64 bit
> > versions of gcc and binutil for BCM1250 (the
> problem
> > that started this thread was actually a problem of
> the
> > mip64-linux-ld I was using).
> 
>  For 64-bit builds you probably want to use fairly
> recent versions or you 
> risk hitting serious bugs that used to exist in
> older versions.  Using 
> David's patch (or preferably mine ;-) -- as
> available here: 
>
"http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.LNX.4.55.0406281509170.23162%40jurand.ds.pg.gda.pl";
> 
> which I keep using with GCC 4.0.0) is probably the
> lesser evil.
> 
>   Maciej
> 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new Resources site
http://smallbusiness.yahoo.com/resources/
