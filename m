Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7TMfsZ03408
	for linux-mips-outgoing; Wed, 29 Aug 2001 15:41:54 -0700
Received: from zikova.cvut.cz (zikova.cvut.cz [147.32.235.100])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7TMfod03405
	for <linux-mips@oss.sgi.com>; Wed, 29 Aug 2001 15:41:50 -0700
Received: from vcnet.vc.cvut.cz (vcnet.vc.cvut.cz [147.32.240.61])
	by zikova.cvut.cz (8.9.0.Beta5/8.9.0.Beta5) with ESMTP id BAA44638;
	Thu, 30 Aug 2001 01:27:04 +0200
Received: from VCNET/SpoolDir by vcnet.vc.cvut.cz (Mercury 1.21);
    30 Aug 101 00:41:42 MET-1MEST
Received: from SpoolDir by VCNET (Mercury 1.30); 30 Aug 101 00:41:31 MET-1MEST
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization:  CC CTU Prague
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Date:          Thu, 30 Aug 2001 00:41:26 MET-1
MIME-Version:  1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject:       Re: help on matroxfb
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
X-mailer: Pegasus Mail v3.40
Message-ID: <1F923C36F6A@vcnet.vc.cvut.cz>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

[I'm not on linux-mips, so cc me if needed]

On 30 Aug 01 at 6:25, Fuxin Zhang wrote:
>     I have touble to make matroxfb work,could you be so kind to help me out? 
> 
>     My configuration:
>      Algorithmics P6032 evaluation board + idt64474 mipsel CPU
>        (with pci slot,no AGP)
>      Millennium G450 (PCI),16M DDR mem,Dual head.

>      2. memory cannot be autodetected. getmemory exit with realSize=0
>      3. if i set video.len mannually to 0x1000000(16M),then all seems
>          to work,but the screen shows only some regular vertical lines
>          and a real BIG cursor(about 2cm x 2cm!). There is about 
>          0.5cm between two vertical lines.

Unfortunately, you are out of luck, matroxfb can initialize only
old Millenniums/Mysqtiques and G200 from scratch. If you have some 
PC around, you can try either reading PCI registers from initialized
hardware, and set them by this during initialization in G100_preinit.
You must also initialize G450->video memory interface, and as this inteface
differs from G400, and G450 datasheet is still unavailable, it
can be tricky.

You can try contacting 'hollis@austin.ibm.com' (I hope that he wont mind),
he asked about 3 weeks ago same question, but for their PPC hardware.
So maybe that he already has some initialization code ready.

>       2. try all kind of options: novga,nobios,noaccel,nohwcursor etc
>          but nothing seems to really help(with nohwcursor,the big
>          cursor disappears)(of course,I may have left out the 
>          correct combination:,it is impossible to try all)

You can try 'init' together with different 'memtype' values.

>     One thing that may be useful is that pci initialization may have 
>    problems because my firmware (pmon from algor) has some bugs which 
>    prevent it from recognize and initialize the matrox card correctly.

It is not enough. You must also execute x86 initialization code to
bring chip to live, otherwise couple of parts of chip are powered
off (second head...), and uninitialized (memory interface, AGP), and
matroxfb does not care because of these init sequences and values are
undocumented (and on PC it requires two videocards in the box, and it
is currently impossible for me as all 6 PCI/AGP slots are used in my
testbox).

I'm currently (and will for at least several next weeks) overloaded
with work I'm doing for my employer, so I cannot reverse engineer this
myself.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
