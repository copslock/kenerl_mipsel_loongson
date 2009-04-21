Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 15:32:10 +0100 (BST)
Received: from gateway12.websitewelcome.com ([67.18.44.21]:19419 "HELO
	gateway12.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S20026873AbZDUOcA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Apr 2009 15:32:00 +0100
Received: (qmail 26411 invoked from network); 21 Apr 2009 14:34:01 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway12.websitewelcome.com with SMTP; 21 Apr 2009 14:34:01 -0000
Received: from [217.109.65.213] (port=1675 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LwH0q-0006Tg-11; Tue, 21 Apr 2009 09:31:52 -0500
Message-ID: <49EDD8DA.7060009@paralogos.com>
Date:	Tue, 21 Apr 2009 16:31:54 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	nagalakshmi veeramallu <lucky.veeramallu@gmail.com>
CC:	Geert Uytterhoeven <geert@linux-m68k.org>,
	"M. Warner Losh" <imp@bsdimp.com>, florian@openwrt.org,
	linux-mips@linux-mips.org
Subject: Re: in mips how to change the start address to the new second boot
 	loader ?
References: <d77cedf30904142309na4355e6w63ecea63b0966c92@mail.gmail.com>	 <200904201100.39164.florian@openwrt.org>	 <20090420.085929.-1089997132.imp@bsdimp.com>	 <d77cedf30904202350g602c740dh26641f145677ddd5@mail.gmail.com>	 <49EDC965.60507@paralogos.com>	 <d77cedf30904210646v2ea71655ye83c8b57fecab761@mail.gmail.com>	 <10f740e80904210710sdc9e5c2ic310e689ca6677b5@mail.gmail.com> <d77cedf30904210720m1a5862ccx220fea16f3a0f01a@mail.gmail.com>
In-Reply-To: <d77cedf30904210720m1a5862ccx220fea16f3a0f01a@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------080803030107080303060308"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080803030107080303060308
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Either you have control of what is in the boot ROM at 0x1fc00000 or you
do not.  If you have control, you can do whatever you like - read
switches, reference environment variables stored in FLASH somehow,
whatever - to decide how you want to proceed.  But it's your problem to
know where the switches are, where and how the NVRAM is to be accessed
and interpreted, etc.  If you do not have control over the code at
0x1fc00000, you need to find out what options it provides, either by
RTFM or by reverse engineering.

There is no magic here, just low-level, brute-force programming.

          Regards,

          Kevin K.

nagalakshmi veeramallu wrote:
> Hi,
> will this approach work? if i used "start" environmental variable will
> it go to new boot loader address directly.
>
>
> Regards,
> Lucky
>
>
> On Tue, Apr 21, 2009 at 7:40 PM, Geert Uytterhoeven
> <geert@linux-m68k.org <mailto:geert@linux-m68k.org>> wrote:
>
>     On Tue, Apr 21, 2009 at 15:46, nagalakshmi veeramallu
>     <lucky.veeramallu@gmail.com <mailto:lucky.veeramallu@gmail.com>>
>     wrote:
>     > hi,
>     >          --          if we set environmental variable “start” as “go
>     > new_address”, will it go directly to the new bootloader in the next
>     > power-on.
>     > what about using system environmental "start" ,can you tell me
>     at which
>     > context after power on environmental variables come onto picture.
>
>     Environment variables are parsed by the boot loader, whose code
>     resides at,
>     guess what, 0x1fc00000...
>
>     > On Tue, Apr 21, 2009 at 6:55 PM, Kevin D. Kissell
>     <kevink@paralogos.com <mailto:kevink@paralogos.com>>
>     > wrote:
>     >>
>     >> nagalakshmi veeramallu wrote:
>     >>
>     >> -           Mips atlas board has jumper  which will redirect
>     accesses from
>     >> “Bootcode” range to either “Monitor flash” (0x1e000000) or the
>     upper 4MB of
>     >> “System flash” (0x1dc00000) based on jumper settings. if my kmc
>     board have
>     >> some jumper like this, can I redirect the start address.
>     >>
>     >> Of course, what is really happening there is that the Atlas
>     boot ROM has a
>     >> vector at 0x1fc00000 which reads the jumper and jumps to one
>     address or the
>     >> other depending on the jumper setting. If you control what is
>     in ROM at
>     >> 0x1fc00000 and you have a software-readable jumper on your KMC
>     board, you
>     >> can do the same thing.
>     >>
>     >>           Regards,
>     >>
>     >>           Kevin K.
>     >>
>     >
>     >
>
>
>
>     --
>     Gr{oetje,eeting}s,
>
>                                                    Geert
>
>     --
>     Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
>     geert@linux-m68k.org <mailto:geert@linux-m68k.org>
>
>     In personal conversations with technical people, I call myself a
>     hacker. But
>     when I'm talking to journalists I just say "programmer" or
>     something like that.
>                                                                --
>     Linus Torvalds
>
>


--------------080803030107080303060308
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=windows-1252"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Either you have control of what is in the boot ROM at 0x1fc00000 or you
do not.  If you have control, you can do whatever you like - read
switches, reference environment variables stored in FLASH somehow,
whatever - to decide how you want to proceed.  But it's your problem to
know where the switches are, where and how the NVRAM is to be accessed
and interpreted, etc.  If you do not have control over the code at
0x1fc00000, you need to find out what options it provides, either by
RTFM or by reverse engineering.<br>
<br>
There is no magic here, just low-level, brute-force programming.<br>
<br>
          Regards,<br>
<br>
          Kevin K.<br>
<br>
nagalakshmi veeramallu wrote:
<blockquote
 cite="mid:d77cedf30904210720m1a5862ccx220fea16f3a0f01a@mail.gmail.com"
 type="cite">
  <div>Hi,</div>
will this approach work? if i used "start" environmental variable will
it go to new boot loader address directly.
  <div><br>
  <br>
  </div>
  <div>Regards,</div>
  <div>Lucky</div>
  <div><br>
  </div>
  <div><br>
  <div class="gmail_quote">On Tue, Apr 21, 2009 at 7:40 PM, Geert
Uytterhoeven <span dir="ltr">&lt;<a moz-do-not-send="true"
 href="mailto:geert@linux-m68k.org">geert@linux-m68k.org</a>&gt;</span>
wrote:<br>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On
Tue, Apr 21, 2009 at 15:46, nagalakshmi veeramallu<br>
    <div class="im">&lt;<a moz-do-not-send="true"
 href="mailto:lucky.veeramallu@gmail.com">lucky.veeramallu@gmail.com</a>&gt;
wrote:<br>
    </div>
    <div class="im">&gt; hi,<br>
&gt;          --          if we set environmental variable “start” as
“go<br>
&gt; new_address”, will it go directly to the new bootloader in the next<br>
&gt; power-on.<br>
&gt; what about using system environmental "start" ,can you tell me at
which<br>
&gt; context after power on environmental variables come onto picture.<br>
    <br>
    </div>
Environment variables are parsed by the boot loader, whose code resides
at,<br>
guess what, 0x1fc00000...<br>
    <div class="im"><br>
&gt; On Tue, Apr 21, 2009 at 6:55 PM, Kevin D. Kissell &lt;<a
 moz-do-not-send="true" href="mailto:kevink@paralogos.com">kevink@paralogos.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; nagalakshmi veeramallu wrote:<br>
&gt;&gt;<br>
&gt;&gt; -           Mips atlas board has jumper  which will redirect
accesses from<br>
&gt;&gt; “Bootcode” range to either “Monitor flash” (0x1e000000) or the
upper 4MB of<br>
&gt;&gt; “System flash” (0x1dc00000) based on jumper settings. if my
kmc board have<br>
&gt;&gt; some jumper like this, can I redirect the start address.<br>
&gt;&gt;<br>
&gt;&gt; Of course, what is really happening there is that the Atlas
boot ROM has a<br>
&gt;&gt; vector at 0x1fc00000 which reads the jumper and jumps to one
address or the<br>
&gt;&gt; other depending on the jumper setting. If you control what is
in ROM at<br>
&gt;&gt; 0x1fc00000 and you have a software-readable jumper on your KMC
board, you<br>
&gt;&gt; can do the same thing.<br>
&gt;&gt;<br>
&gt;&gt;           Regards,<br>
&gt;&gt;<br>
&gt;&gt;           Kevin K.<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
    <br>
    <br>
    <br>
    </div>
--<br>
Gr{oetje,eeting}s,<br>
    <br>
                                               Geert<br>
    <font color="#888888"><br>
--<br>
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- <a
 moz-do-not-send="true" href="mailto:geert@linux-m68k.org">geert@linux-m68k.org</a><br>
    <br>
In personal conversations with technical people, I call myself a
hacker. But<br>
when I'm talking to journalists I just say "programmer" or something
like that.<br>
                                                           -- Linus
Torvalds<br>
    </font></blockquote>
  </div>
  <br>
  </div>
</blockquote>
<br>
</body>
</html>

--------------080803030107080303060308--
