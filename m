Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8CGn4g13357
	for linux-mips-outgoing; Wed, 12 Sep 2001 09:49:04 -0700
Received: from mail.aeptec.com (mail.aeptec.com [12.38.17.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8CGmwe13354
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 09:48:58 -0700
Received: by MAIL with Internet Mail Service (5.5.2653.19)
	id <RY2D6M6P>; Wed, 12 Sep 2001 12:48:57 -0400
Message-ID: <32CC5B62AF0BD2119E4C00A0C9663E226F8E29@MAIL>
From: "Sun, Lei" <lsun@3eti.com>
To: "'Zhang Fuxin'" <fxzhang@ict.ac.cn>, "Sun, Lei" <lsun@3eti.com>
Cc: linux-mips@oss.sgi.com
Subject: RE: RE: _gp_disp
Date: Wed, 12 Sep 2001 12:48:57 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8CGmxe13355
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi:
  Unfortunately, make clean didn't work, the linking problem still sit
there!

thanks
lei 

-----Original Message-----
From: Zhang Fuxin [mailto:fxzhang@ict.ac.cn]
Sent: Wednesday, September 12, 2001 12:38 PM
To: Sun, Lei
Cc: linux-mips@oss.sgi.com
Subject: Re: RE: _gp_disp


Sun, Lei£¬ÄúºÃ£¡

 I think a make clean will do.
 You got some .o lurking compiled without the flags

ÔÚ 2001-09-12 11:57:00 ÄúÐ´µÀ£º
>Thanks for the kind response.
>after modified my Makefile according to Pete's suggestion, But I got the
>following erro when linking
>/opt/Embedix/tools/mipsel-linux/bin/ld: prism2dl.o: linking PIC files with
>non-P
>IC files
>/opt/Embedix/tools/mipsel-linux/bin/ld: prism2dl.o: uses different e_flags
>(0x100) fields than previous modules(0x0)
>Bad value: failed to merge target specific data of file prism2dl.o
>
>ANy more input?
>thank you!
>lei 
>
>-----Original Message-----
>From: Jun Sun [mailto:jsun@mvista.com]
>Sent: Monday, September 10, 2001 7:18 PM
>To: Pete Popov
>Cc: Sun, Lei; Debian-Mips (E-mail)
>Subject: Re: _gp_disp
>
>
>Pete Popov wrote:
>> 
>> Sun, Lei wrote:
>> > Hi:
>> >   I was trying to port a wireless lan driver to MIPS based platform
(IDT
>> > 79S334), the compilation seems fine, But when I try to load the created
>> > module, it tells me "unresoved symbol _gp_disp".( I cross-compiled it
by
>> > mipsel-gcc compiler).
>> >   By doing a quick grep in the driver source, I didn't find the gp_disp
>> > symbol. My question is where did the _gp_disp come from and how I
should
>> > solve this problem?
>> >
>> > Appreciate your help!
>> 
>> You did not use the correct gcc options. Add these to your gcc flags and
>it
>> should work (replace -mcpu=<cpu> if you need to):
>> 
>> -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-G
>0
>> -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -Wa,--trap -pipe -DMODULE
>-mlong-calls
>>    -DEXPORT_SYMTAB
>> 
>
>I think some of the options might not be necessary, but you definitely need
>"-DKERNEL"
>
>Jun
>
>
>-- 
>To UNSUBSCRIBE, email to debian-mips-request@lists.debian.org
>with a subject of "unsubscribe". Trouble? Contact
listmaster@lists.debian.org

                    ÖÂ
Àñ£¡

            Zhang Fuxin
            fxzhang@ict.ac.cn
