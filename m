Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2003 17:02:40 +0100 (BST)
Received: from mail.securewebs.net ([IPv6:::ffff:80.190.40.19]:59654 "EHLO
	izd.de") by linux-mips.org with ESMTP id <S8225222AbTEOQCg> convert rfc822-to-8bit;
	Thu, 15 May 2003 17:02:36 +0100
Received: from so9 [80.132.171.173] by izd.de with ESMTP
  (SMTPD32-7.15) id AA1A122A009A; Thu, 15 May 2003 18:02:34 +0200
From: "Michael Weichselgartner" <mw@izd.de>
To: <linux-mips@linux-mips.org>
Subject: RaQ2+ NIC problem
Date: Thu, 15 May 2003 18:02:34 +0200
Message-ID: <002101c31afb$663f6510$0300a8c0@so9>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Return-Path: <mw@izd.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mw@izd.de
Precedence: bulk
X-list: linux-mips

hello,

i currently have a big problem and i hope someone could help.

I am running debian woody with kernel 2.4.18 (fresh from the current 
cvs tree)on a cobalt RaQ2+. Everything works smooth but one or two 
times a day all network traffic stops. The server is still running 
and i can log into the RaQ2+ on the serial console. If i restart the 
network (/etc/init.d/netwroking restart) i get no errors and 
everything works well again.

The tulip driver is 0.9.15-pre9. So i decided to upgrade to kernel
 2.4.20 because the driver there is 0.9.15-pre12. It took some time 
to get a stabel configuration. Now with the kernel 2.4.20 the 
network problem is bigger than ever. Simply loging into the RaQ with 
ssh and running midnight commander is freezing the nics. Or if i log 
into webmin the nics freeze as soon as the first website appears.

The same effect is with kernel 2.4.21. Therefore i recompiled all 
kernels with tulip support as module to get greater flexibility 
(it´s much easyer to play with insmod and rmmod). No matter what 
otpions i use (10Mbit, 100Mbit, Half or Fulldublex) the results 
are still the same: 

- kernel 2.4.18 with tulip 0.9.15-pre9: nics freeze 1 to 2 times a day 
- kernel > 2.4.18 with tulip 0.9.15-pre12: nics freeze after just a few
minutes

I played with the tulip drivers and compiled later revisions as 
modules to use with kernel 2.4.18 and earlyer revisions to use 
with kernel 2.4.20 and above. No effort.

Fortunately i have six RaQ2+ so i can test different kernels with 
different tulip drivers but this is driving me nuts. I spent nearly 
4 hours each day for the past 4 weeks to get rid of this nic problem 
but i dont know what to do next.

Btw. even if i use only one nic (no matter wether eth0 or eth1) the 
problem occurs. I have an old RaQ2 with only 1 nic running stable 
on 2.4.18 with tulip 0.9.15-pre9.

Unfortunately tulip debug mode is not working (neither in the kernel 
nor as an option while loading the module) so i cant see any 
problems within the nic driver. I tried to compile tulip-diag but 
this is not working due to limitations of the kernel source tree.

>From other lists i know there are many people having this problem 
but none of them has ever solved it. Any ideas what i could do next 
or do you have a solution?

Your feedback is welcome.

Best regards

Michael
