Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 14:26:05 +0100 (BST)
Received: from gateway14.websitewelcome.com ([69.56.150.9]:39320 "HELO
	gateway14.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S20025655AbZDUNZ7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Apr 2009 14:25:59 +0100
Received: (qmail 6770 invoked from network); 21 Apr 2009 13:29:28 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway14.websitewelcome.com with SMTP; 21 Apr 2009 13:29:28 -0000
Received: from [217.109.65.213] (port=1076 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LwFyy-0007KE-SP; Tue, 21 Apr 2009 08:25:53 -0500
Message-ID: <49EDC965.60507@paralogos.com>
Date:	Tue, 21 Apr 2009 15:25:57 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	nagalakshmi veeramallu <lucky.veeramallu@gmail.com>
CC:	"M. Warner Losh" <imp@bsdimp.com>, florian@openwrt.org,
	linux-mips@linux-mips.org
Subject: Re: in mips how to change the start address to the new second boot
 	loader ?
References: <d77cedf30904142309na4355e6w63ecea63b0966c92@mail.gmail.com>	 <200904201100.39164.florian@openwrt.org>	 <20090420.085929.-1089997132.imp@bsdimp.com> <d77cedf30904202350g602c740dh26641f145677ddd5@mail.gmail.com>
In-Reply-To: <d77cedf30904202350g602c740dh26641f145677ddd5@mail.gmail.com>
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=windows-1252"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
nagalakshmi veeramallu wrote:
<blockquote
 cite="mid:d77cedf30904202350g602c740dh26641f145677ddd5@mail.gmail.com"
 type="cite">
  <p><span style="font-size: 10pt; font-family: Arial; color: black;"><span
 class="apple-converted-space"></span></span></p>
  <p style="margin-left: 0.5in; text-indent: -0.25in;"><span
 style="font-size: 10pt; font-family: Arial; color: black;"><span
 style="">-<span
 style="font-family: &quot;Times New Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch: normal;">         
  </span></span></span><span
 style="font-size: 10pt; font-family: Arial; color: black;"><span
 style=""> </span>Mips atlas board has jumper
  <span style=""> </span>which will redirect accesses from “Bootcode”
range to either “Monitor flash” (0x1e000000) or the upper 4MB of
“System flash”
(0x1dc00000) based on jumper settings. if<span style=""> </span>my kmc
board have some jumper like this, can I redirect the start address.</span></p>
</blockquote>
Of course, what is really happening there is that the Atlas boot ROM
has a vector at 0x1fc00000 which reads the jumper and jumps to one
address or the other depending on the jumper setting. If you control
what is in ROM at 0x1fc00000 and you have a software-readable jumper on
your KMC board, you can do the same thing.<br>
<br>
          Regards,<br>
<br>
          Kevin K.<br>
<br>
</body>
</html>
