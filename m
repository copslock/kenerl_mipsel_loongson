Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8CGvtS13806
	for linux-mips-outgoing; Wed, 12 Sep 2001 09:57:55 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8CGvle13801
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 09:57:47 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8CH1OA25418;
	Wed, 12 Sep 2001 10:01:24 -0700
Message-ID: <3B9F94C6.90300@pacbell.net>
Date: Wed, 12 Sep 2001 10:00:54 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Sun, Lei" <lsun@3eti.com>
CC: "'Zhang Fuxin'" <fxzhang@ict.ac.cn>, linux-mips@oss.sgi.com
Subject: Re: _gp_disp
References: <32CC5B62AF0BD2119E4C00A0C9663E226F8E29@MAIL>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8CGvle13802
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Sun, Lei wrote:
> Hi:
>   Unfortunately, make clean didn't work, the linking problem still sit
> there!

Do you have a binary image that you're trying to link, such as a ramdisk?

Pete

> 
> thanks
> lei 
> 
> -----Original Message-----
> From: Zhang Fuxin [mailto:fxzhang@ict.ac.cn]
> Sent: Wednesday, September 12, 2001 12:38 PM
> To: Sun, Lei
> Cc: linux-mips@oss.sgi.com
> Subject: Re: RE: _gp_disp
> 
> 
> Sun, Lei£¬ÄúºÃ£¡
> 
>  I think a make clean will do.
>  You got some .o lurking compiled without the flags
> 
> ÔÚ 2001-09-12 11:57:00 ÄúÐ´µÀ£º
> 
>>Thanks for the kind response.
>>after modified my Makefile according to Pete's suggestion, But I got the
>>following erro when linking
>>/opt/Embedix/tools/mipsel-linux/bin/ld: prism2dl.o: linking PIC files with
>>non-P
>>IC files
>>/opt/Embedix/tools/mipsel-linux/bin/ld: prism2dl.o: uses different e_flags
>>(0x100) fields than previous modules(0x0)
>>Bad value: failed to merge target specific data of file prism2dl.o
>>
>>ANy more input?
>>thank you!
>>lei 
>>
>>-----Original Message-----
>>From: Jun Sun [mailto:jsun@mvista.com]
>>Sent: Monday, September 10, 2001 7:18 PM
>>To: Pete Popov
>>Cc: Sun, Lei; Debian-Mips (E-mail)
>>Subject: Re: _gp_disp
>>
>>
>>Pete Popov wrote:
>>
>>>Sun, Lei wrote:
>>>
>>>>Hi:
>>>>  I was trying to port a wireless lan driver to MIPS based platform
>>>>
> (IDT
> 
>>>>79S334), the compilation seems fine, But when I try to load the created
>>>>module, it tells me "unresoved symbol _gp_disp".( I cross-compiled it
>>>>
> by
> 
>>>>mipsel-gcc compiler).
>>>>  By doing a quick grep in the driver source, I didn't find the gp_disp
>>>>symbol. My question is where did the _gp_disp come from and how I
>>>>
> should
> 
>>>>solve this problem?
>>>>
>>>>Appreciate your help!
>>>>
>>>You did not use the correct gcc options. Add these to your gcc flags and
>>>
>>it
>>
>>>should work (replace -mcpu=<cpu> if you need to):
>>>
>>>-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
>>>
> -G
> 
>>0
>>
>>>-mno-abicalls -fno-pic -mcpu=r4600 -mips2 -Wa,--trap -pipe -DMODULE
>>>
>>-mlong-calls
>>
>>>   -DEXPORT_SYMTAB
>>>
>>>
>>I think some of the options might not be necessary, but you definitely need
>>"-DKERNEL"
>>
>>Jun
>>
>>
>>-- 
>>To UNSUBSCRIBE, email to debian-mips-request@lists.debian.org
>>with a subject of "unsubscribe". Trouble? Contact
>>
> listmaster@lists.debian.org
> 
>                     ÖÂ
> Àñ£¡
> 
>             Zhang Fuxin
>             fxzhang@ict.ac.cn
> 
> 
