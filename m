Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7UDxU520487
	for linux-mips-outgoing; Thu, 30 Aug 2001 06:59:30 -0700
Received: from relay ([207.81.96.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7UDxOd20484
	for <linux-mips@oss.sgi.com>; Thu, 30 Aug 2001 06:59:24 -0700
Received: from quicklogic.com ([207.81.96.153])
	by relay (8.8.7/8.8.7) with ESMTP id JAA20175;
	Thu, 30 Aug 2001 09:57:42 -0400
Message-ID: <3B8E4699.7030706@quicklogic.com>
Date: Thu, 30 Aug 2001 09:58:49 -0400
From: Dan Aizenstros <dan@quicklogic.com>
Organization: QuickLogic Canada
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Fuxin Zhang <fxzhang@ict.ac.cn>
CC: "vandrove@vc.cvut.cz" <vandrove@vc.cvut.cz>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: help on matroxfb
References: <200108292223.f7TMNad02851@oss.sgi.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello Fuxin,

Looking at the lspci file I see the following addresses for the video card

Region 0: Memory at 08000000 (32-bit, prefetchable) [size=32M]
Region 1: Memory at 077dc000 (32-bit, non-prefetchable) [size=16K]
Region 2: Memory at 07800000 (32-bit, non-prefetchable) [size=8M]
Expansion ROM at 077e0000 [size=128K]

but looking at the output from your log.txt file I see

ctrl=177dc000,video=18000000,memsize=2000000

which does not match.  This means that Linux is not able to write
to the frambuffer.  You can try to adjust the addresses of the
either the VGA adapter and PCI bridge or the Linux matroxfb
drivers framebuffer pointer.

I hope this helps,

Dan Aizenstros
QuickLogic Canada

Fuxin Zhang wrote:
> hello,
> 
>     I have touble to make matroxfb work,could you be so kind to help me out? 
> 
>     My configuration:
>      Algorithmics P6032 evaluation board + idt64474 mipsel CPU
>        (with pci slot,no AGP)
>      Millennium G450 (PCI),16M DDR mem,Dual head.
>      linux kernel 2.4.2 from hardhat (www.mvista.com) with some 
>        code by me to port it to p6032
>       (BTW,I just can't find where the often-mentioned sgi cvs
>        tree is,the one listed in FAQ seems not work for me,so i 
>        have to use hardhat kernel,if possible,I am willing to
>        contribute to linux-mips:)
>     
>     symptom:
>      1. The card is detected as a G450 (AGP) 
>      2. memory cannot be autodetected. getmemory exit with realSize=0
>      3. if i set video.len mannually to 0x1000000(16M),then all seems
>          to work,but the screen shows only some regular vertical lines
>          and a real BIG cursor(about 2cm x 2cm!). There is about 
>          0.5cm between two vertical lines.
>      4. I can use fbset to change fb modes,and the screen do react to
>          changes,but only with slightly different lines or blank sc.
>      5. I can input with a keyboard,the big cursor moves as expected
>         just no text is output.
>     
>     tweaks I have tried:
>       1. Update matroxfb to the one in 2.4.9-ac2,it doesn't help
>       2. try all kind of options: novga,nobios,noaccel,nohwcursor etc
>          but nothing seems to really help(with nohwcursor,the big
>          cursor disappears)(of course,I may have left out the 
>          correct combination:,it is impossible to try all)
>       
>     One thing that may be useful is that pci initialization may have 
>    problems because my firmware (pmon from algor) has some bugs which 
>    prevent it from recognize and initialize the matrox card correctly.
>    ( e.g. There is a type error in type1 configuration access code so
>      it can't initialize devices behind pci-pci bridge)
>    I fixed part of it but not sure enough is done.So i attached an
>    output of "lspci -vv" for your reference.
> 
>      The other attachment is boot time messages.I switch on most of
>    the matroxfb debug option so it contains many related info.
>   
>    Thank you in advance.
> 
> 
> Regards
>             Fuxin Zhang
>             fxzhang@ict.ac.cn
> 
> lspci
> 
> Content-Type:
> 
> application/octet-stream
> Content-Encoding:
> 
> base64
> 
> 
> ------------------------------------------------------------------------
> log.txt
> 
> Content-Type:
> 
> application/octet-stream
> Content-Encoding:
> 
> base64
> 
> 
