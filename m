Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2007 13:21:34 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.173]:7445 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021865AbXCJNV3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Mar 2007 13:21:29 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1880506uga
        for <linux-mips@linux-mips.org>; Sat, 10 Mar 2007 05:20:28 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=o5bqfyZUbcGhxoKlcFZ7MZycm7bNM5Md2E4FUirHx/+qfkcnHPqqt51lWEschy6JnaMEijyu4LtU7QHd2ayOtbP63tvGeaE4npd8KUKtGhzdMQj+pGnZLPeuYj5wNvZNt3SiqT00qktBfXu44epKZec2jkPrXK8raGFaTOcYHlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=frWxhPCgubyq1gjZnuUB+G8zr6LK+2O96sRW6GsJ9mROvR2V9zutjz61WCS0vFOjA03LBCQ1ZOq0W2Ik4JWhhtw3mduW2iQzGTXMMvS5e8zrwoeCHJkVRAXMkMVSUBuOGSjK23beNErleMqLVk72UH0Ng7Ltw2s38xmKDqaMNjU=
Received: by 10.115.55.1 with SMTP id h1mr184906wak.1173532827779;
        Sat, 10 Mar 2007 05:20:27 -0800 (PST)
Received: by 10.114.80.18 with HTTP; Sat, 10 Mar 2007 05:20:27 -0800 (PST)
Message-ID: <d459bb380703100520i3a2309f1le73499279b19b0b3@mail.gmail.com>
Date:	Sat, 10 Mar 2007 14:20:27 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	"Freddy Spierenburg" <freddy@dusktilldawn.nl>
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070309103307.GI25248@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_839_2596812.1173532827737"
References: <20070307104930.GD25248@dusktilldawn.nl>
	 <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com>
	 <20070309103307.GI25248@dusktilldawn.nl>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_839_2596812.1173532827737
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Freddy,

Friday I've had some time to explore the problem. My current experience is
with an Au1500 based custom board. I've compiled the ALSA modules for the
integrated AC97 in kernel 2.6.17.14. I've still not noticed the problem with
the missing controls, but my most frequent issue is with the "AC'97 0 access
error (not audio or modem codec)" error message. Notice that when this
message is issued the module is not loaded, so I have to reload it.

At the moment the only solution for this problem is to force a device reset
during the board setup. Strange enough, it is exactly the same thing done in
the module with the lines:

    /* Initialise Au1000's AC'97 Control Block */
    au1000->ac97_ioport->cntrl = AC97C_RS | AC97C_CE;
    udelay(10);
    au1000->ac97_ioport->cntrl = AC97C_CE;
    udelay(10);

Perhaps the delays are not correct, and doing them in the board setup (at
kernel start) leaves enought time for the clocks to stabilize (just
guessing).

Basically you have to play with bits 0 and 1 in the device control register
(0xB000 0010).

I'll check the issue again next monday, but I am for sure not a kernel guru.

------=_Part_839_2596812.1173532827737
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Freddy,<br><br>Friday I&#39;ve had some time to explore the problem. My current experience is with an Au1500 based custom board. I&#39;ve compiled the ALSA modules for the integrated AC97 in kernel <a href="http://2.6.17.14">
2.6.17.14</a>. I&#39;ve still not noticed the problem with the missing controls, but my most frequent issue is with the &quot;AC&#39;97 0 access error (not audio or modem codec)&quot; error message. Notice that when this message is issued the module is not loaded, so I have to reload it.
<br><br>At the moment the only solution for this problem is to force a device reset during the board setup. Strange enough, it is exactly the same thing done in the module with the lines:<br><br>&nbsp;&nbsp;&nbsp; /* Initialise Au1000&#39;s AC&#39;97 Control Block */
<br>&nbsp;&nbsp;&nbsp; au1000-&gt;ac97_ioport-&gt;cntrl = AC97C_RS | AC97C_CE;<br>&nbsp;&nbsp;&nbsp; udelay(10);<br>&nbsp;&nbsp;&nbsp; au1000-&gt;ac97_ioport-&gt;cntrl = AC97C_CE;<br>&nbsp;&nbsp;&nbsp; udelay(10);<br><br>Perhaps the delays are not correct, and doing them in the board setup (at kernel start) leaves enought time for the clocks to stabilize (just guessing).
<br><br>Basically you have to play with bits 0 and 1 in the device control register (0xB000 0010).<br><br>I&#39;ll check the issue again next monday, but I am for sure not a kernel guru.<br><br><br>

------=_Part_839_2596812.1173532827737--
