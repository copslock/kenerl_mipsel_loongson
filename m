Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6IBsQ129658
	for linux-mips-outgoing; Wed, 18 Jul 2001 04:54:26 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6IBsOV29655
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 04:54:24 -0700
Message-Id: <200107181154.f6IBsOV29655@oss.sgi.com>
Received: (qmail 9952 invoked from network); 18 Jul 2001 11:48:38 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 18 Jul 2001 11:48:38 -0000
Date: Wed, 18 Jul 2001 19:53:48 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: help on linux-mipsel frame buffer
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f6IBsPV29656
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello,Geert Uytterhoeven£¡
2001-07-18 09:18:00£º
>On Tue, 17 Jul 2001, James Simmons wrote:
>> >   First I try the vga16 frame buffer driver,but i can only get
>> > some black/white strips on the screen.(after made some changes 
>> > to the source,most important one is use pci to find and set the
>> > vbase address). 
>> 
>> It is hardwired into the vga16fb driver the memory region (0xA000). This
>> is very wrong on non intel platforms. So that drivers pretty much doesn't
>> work on anything else.
>
>Does your firmware initialize the VGA card to VGA text mode? Vga16fb requires
>this initialization, which is normally done by the VGA BIOS. An x86
>BIOS-emulator may be your friend.
Cound you give me a link to such a emulator?My firmware doesn't initialize VGA card.That seems the real problem.
Thank you.
>
>> >   Then I try to use vesa driver. This one use some vgabios code 
>> > I commented out the x86 relevant codes and made it compiled,
>> 
>> The VESA framebuffer is also intel specific. It uses the BIOS to setup the
>> video mode. This is done long before the cpu is placed into protect mode.
>
>Similar issue here.
>
>Gr{oetje,eeting}s,
>
>						Geert
>
>--
>Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
>Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
>Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium

Regards
            Fuxin Zhang
            fxzhang@ict.ac.cn
