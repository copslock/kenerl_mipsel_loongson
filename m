Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2003 16:39:21 +0100 (BST)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:50389 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8225238AbTGBPgV>;
	Wed, 2 Jul 2003 16:36:21 +0100
Received: from dlep51.itg.ti.com ([157.170.141.75])
	by go4.ext.ti.com (8.12.9/8.12.9) with ESMTP id h62FaCwD010146;
	Wed, 2 Jul 2003 10:36:12 -0500 (CDT)
Received: from dlep98.itg.ti.com (localhost [127.0.0.1])
	by dlep51.itg.ti.com (8.12.9/8.12.9) with ESMTP id h62FaBBO015247;
	Wed, 2 Jul 2003 10:36:11 -0500 (CDT)
Received: from dlee70.itg.ti.com (dlee70.itg.ti.com [157.170.135.145])
	by dlep98.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA21445;
	Wed, 2 Jul 2003 10:36:11 -0500 (CDT)
Received: by dlee70.itg.ti.com with Internet Mail Service (5.5.2653.19)
	id <NZW1NKCA>; Wed, 2 Jul 2003 10:36:11 -0500
Received: from ti.com (cbc0794930.isr.asp.ti.com [137.167.176.14]) by dile70.itg.ti.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id NN6XFQ3P; Wed, 2 Jul 2003 18:36:01 +0300
From: "Sirotkin, Alexander" <demiurg@ti.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Message-ID: <3F02FBE1.7070107@ti.com>
Date: Wed, 02 Jul 2003 18:36:01 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: do_ri
References: <Pine.GSO.3.96.1030702172634.21225B-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <Pine.GSO.3.96.1030702172634.21225B-100000@delta.ds2.pg.gda.pl>
Content-Type: multipart/alternative;
 boundary="------------060800000009070604090303"
Return-Path: <demiurg@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2754
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiurg@ti.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060800000009070604090303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Are you sure ?

Because "grep -r" shows only 

./arch/mips/kernel/traps.c:asmlinkage void do_ri(struct pt_regs *regs)
./arch/mips/kernel/traps.c:             do_ri(regs);
./arch/mips/lx/lxRi.c:  do_ri(regp);

On my linux-2.4.17_mvl21 kernel. And I'm quite sure that when my kernel 
crashes it's not being called from any of these places.

But then again, may be in may case it's getting called only because some

memory get overwritten.

Maciej W. Rozycki wrote:


On Wed, 2 Jul 2003, Sirotkin, Alexander wrote:



  

Can anyone please enlighten me about the do_ri function ? I could not

find any reference to what it does and when it's  called anywhere.

    



 It's called from arch/mips/kernel/entry.S or

arch/mips64/kernel/r4k_genex.S to handle the Reserved Instruction

exception. 



  


-- 

Alexander Sirotkin

SW Engineer



Texas Instruments

Broadband Communications Israel (BCIL)

Tel:  +972-9-9706587

________________________________________________________________________

"Those who do not understand Unix are condemned to reinvent it, poorly."

      -- Henry Spencer 

--------------060800000009070604090303
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Are you sure ?<br>
<br>
Because "grep -r" shows only <br>
<br>
./arch/mips/kernel/traps.c:asmlinkage void do_ri(struct pt_regs *regs)<br>
./arch/mips/kernel/traps.c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_ri(regs);<br>
./arch/mips/lx/lxRi.c:&nbsp; do_ri(regp);<br>
<br>
On my linux-2.4.17_mvl21 kernel. And I'm quite sure that when my kernel
<br>
crashes it's not being called from any of these places.<br>
<br>
But then again, may be in may case it's getting called only because
some <br>
memory get overwritten.<br>
<br>
Maciej W. Rozycki wrote:<br>
<blockquote type="cite"
 cite="midPine.GSO.3.96.1030702172634.21225B-100000@delta.ds2.pg.gda.pl">
  <pre wrap="">On Wed, 2 Jul 2003, Sirotkin, Alexander wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">Can anyone please enlighten me about the do_ri function ? I could not
find any reference to what it does and when it's  called anywhere.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
 It's called from arch/mips/kernel/entry.S or
arch/mips64/kernel/r4k_genex.S to handle the Reserved Instruction
exception. 

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

--------------060800000009070604090303--
