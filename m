Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2003 17:11:34 +0100 (BST)
Received: from news.ti.com ([IPv6:::ffff:192.94.94.33]:1182 "EHLO
	dragon.ti.com") by linux-mips.org with ESMTP id <S8225260AbTGBQJq>;
	Wed, 2 Jul 2003 17:09:46 +0100
Received: from dlep50.itg.ti.com ([157.170.141.74])
	by dragon.ti.com (8.12.9/8.12.9) with ESMTP id h62G9Z1p007277;
	Wed, 2 Jul 2003 11:09:35 -0500 (CDT)
Received: from dlep98.itg.ti.com (localhost [127.0.0.1])
	by dlep50.itg.ti.com (8.12.9/8.12.9) with ESMTP id h62G9Y20000355;
	Wed, 2 Jul 2003 11:09:35 -0500 (CDT)
Received: from dlee70.itg.ti.com (dlee70.itg.ti.com [157.170.135.145])
	by dlep98.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA13646;
	Wed, 2 Jul 2003 11:09:34 -0500 (CDT)
Received: by dlee70.itg.ti.com with Internet Mail Service (5.5.2653.19)
	id <NZW1NMYX>; Wed, 2 Jul 2003 11:09:34 -0500
Received: from ti.com (cbc0794930.isr.asp.ti.com [137.167.176.14]) by dile70.itg.ti.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id NN6XFQTF; Wed, 2 Jul 2003 19:08:56 +0300
From: "Sirotkin, Alexander" <demiurg@ti.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Message-ID: <3F030399.8070801@ti.com>
Date: Wed, 02 Jul 2003 19:08:57 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: do_ri
References: <Pine.GSO.4.21.0307021750091.15047-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0307021750091.15047-100000@vervain.sonytel.be>
Content-Type: multipart/alternative;
 boundary="------------030706030201000708080205"
Return-Path: <demiurg@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2757
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiurg@ti.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030706030201000708080205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Got it. 10x.

Geert,
You save me for second time in a row today, I feel like I owe you a beer
:)

Geert Uytterhoeven wrote:


On Wed, 2 Jul 2003, Sirotkin, Alexander wrote:

  

Are you sure ?



Because "grep -r" shows only 



./arch/mips/kernel/traps.c:asmlinkage void do_ri(struct pt_regs *regs)

./arch/mips/kernel/traps.c:             do_ri(regs);

./arch/mips/lx/lxRi.c:  do_ri(regp);



On my linux-2.4.17_mvl21 kernel. And I'm quite sure that when my kernel 

crashes it's not being called from any of these places.

    



I remember getting bitten by that one, too...



Check out BUILD_HANDLER(ri,ri,sti,silent) in arch/mips/kernel/entry.S.



Grep isn't always your friend, `nm -g' is, in this case :-)



Gr{oetje,eeting}s,



						Geert



--

Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org <mailto:geert@linux-m68k.org> 



In personal conversations with technical people, I call myself a hacker.
But

when I'm talking to journalists I just say "programmer" or something
like that.

							    -- Linus
Torvalds

  


-- 

Alexander Sirotkin

SW Engineer



Texas Instruments

Broadband Communications Israel (BCIL)

Tel:  +972-9-9706587

________________________________________________________________________

"Those who do not understand Unix are condemned to reinvent it, poorly."

      -- Henry Spencer 

--------------030706030201000708080205
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Got it. 10x.<br>
<br>
Geert,<br>
You save me for second time in a row today, I feel like I owe you a
beer :)<br>
<br>
Geert Uytterhoeven wrote:<br>
<blockquote type="cite"
 cite="midPine.GSO.4.21.0307021750091.15047-100000@vervain.sonytel.be">
  <pre wrap="">On Wed, 2 Jul 2003, Sirotkin, Alexander wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Are you sure ?

Because "grep -r" shows only 

./arch/mips/kernel/traps.c:asmlinkage void do_ri(struct pt_regs *regs)
./arch/mips/kernel/traps.c:             do_ri(regs);
./arch/mips/lx/lxRi.c:  do_ri(regp);

On my linux-2.4.17_mvl21 kernel. And I'm quite sure that when my kernel 
crashes it's not being called from any of these places.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I remember getting bitten by that one, too...

Check out BUILD_HANDLER(ri,ri,sti,silent) in arch/mips/kernel/entry.S.

Grep isn't always your friend, `nm -g' is, in this case :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- <a class="moz-txt-link-abbreviated" href="mailto:geert@linux-m68k.org">geert@linux-m68k.org</a>

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
  </pre>
</blockquote>
<br>
<pre class="moz-signature" cols="72">-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 
</pre>
</body>
</html>

--------------030706030201000708080205--
