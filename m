Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Mar 2007 12:27:43 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.249]:27214 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20038418AbXCDM1l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Mar 2007 12:27:41 +0000
Received: by an-out-0708.google.com with SMTP id c8so1100980ana
        for <linux-mips@linux-mips.org>; Sun, 04 Mar 2007 04:27:37 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        b=az89yB9YBI9ZnX2G9Be1TQ5AKO71asiwlhhJVoVACojvp81gN5HvBT87acWhKElE5hSQ2KM8mu5ngjRRtL5bKulrpYZEfAFP89+4mie6I50kBBMglQp5DPFZXgq41nPI9kNDby09+A+Hate5vogYO1ji4hwaMNjNmjpPW6on46k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=iJOokR0xIHHDuBocAiBzTza6Ue4odppLjh0FEsTmPpBVDMYydUiNldZiBMTiyboVgEamks/JHLZ9jLZUEdMRGF2xHYzoMAztuo3FmZCy/A4TwxtEYdOq7UA3DE5Kx5ycrbkYC0QNEQZe2eiTIuVIX8sFqkyqZCPW/0Ks10EKGns=
Received: by 10.114.126.1 with SMTP id y1mr940827wac.1173011257053;
        Sun, 04 Mar 2007 04:27:37 -0800 (PST)
Received: by 10.114.80.18 with HTTP; Sun, 4 Mar 2007 04:27:37 -0800 (PST)
Message-ID: <d459bb380703040427g4a8cad08kd8e3190f7d109c86@mail.gmail.com>
Date:	Sun, 4 Mar 2007 13:27:37 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Linux kernel 2.6.20, PCI and hpt266
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_114607_12873744.1173011257020"
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_114607_12873744.1173011257020
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, I am trying to run kernel 2.6.20 on an Au1500 based board. Versions
2.4.x of the kernel are correctly working.

Problem: on the board there is a HighPoint 371N ATA controller. At the
moment the kernel 2.6.20 boots and runs, but the ATA controller does not
recognize the IDE disk.

Details:
The driver I use is "drivers/ide/pci/hpt266.c". I've already fixed the
timing problems and PLL configuration that afflict this controller, and
removed RESOURCE_64BIT to fix problems with the PCI bus on mips and
resource_size_t casts.

I've managed to follow the problem to ide-probe.c, in function
"actual_try_to_identify". It seems that the values read from the ATA
registers through IO ports are not correct. As every ATA controller, it
needs 8 bytes in IO port space for Command Block registers, and 4 bytes for
the Control Block registers. They are mapped by the kernel at:

1400-1407 (8 bytes) Command block channel 0
1408-140F (8 bytes) Command block channel 1
1410-1413 (4 bytes) Control block channel 0
1414-1417 (4 bytes) Control block channel 1

Notice that Highpoint 371N has registers for 2 channel, but the pinout for
only 1 channel. In fact the first channel is disabled by the driver, so the
actual registers are in the range 1408-140F and 1414-1417. The first sign of
the problem is that INB do not read the correct values for the ALTSTATUS
register. In fact the kernel reports:

 ... probing with STATUS(...) instead of ALTSTATUS(...)

[as in ide-probe.c, line 290]

The values read from the ATA registers are completely wrong. The registers
are accessed through hwif->INB, that are common "inb" functions. This makes
me suspect that "inX" functions are not working, but I don't know how to
test this. Notice that the PCI controller configuration space is correctly
accessed, as I can confirm reading sys/bus/pci/.../config.

Can you help or suggest me anything?
Thanx!

------=_Part_114607_12873744.1173011257020
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, I am trying to run kernel 2.6.20 on an Au1500 based board. Versions 2.4.x of the kernel are correctly working.<br><br>Problem: on the board there is a HighPoint 371N ATA controller. At the moment the kernel 2.6.20 boots and runs, but the ATA controller does not recognize the IDE disk.
<br><br>Details:<br>The driver I use is &quot;drivers/ide/pci/hpt266.c&quot;. I&#39;ve already fixed the timing problems and PLL configuration that afflict this controller, and removed RESOURCE_64BIT to fix problems with the PCI bus on mips and resource_size_t casts.
<br><br>I&#39;ve managed to follow the problem to ide-probe.c, in function &quot;actual_try_to_identify&quot;. It seems that the values read from the ATA registers through IO ports are not correct. As every ATA controller, it needs 8 bytes in IO port space for Command Block registers, and 4 bytes for the Control Block registers. They are mapped by the kernel at:
<br><br>1400-1407 (8 bytes) Command block channel 0<br>1408-140F (8 bytes) Command block channel 1<br>1410-1413 (4 bytes) Control block channel 0<br>1414-1417 (4 bytes) Control block channel 1<br><br>Notice that Highpoint 371N has registers for 2 channel, but the pinout for only 1 channel. In fact the first channel is disabled by the driver, so the actual registers are in the range 1408-140F and 1414-1417. The first sign of the problem is that INB do not read the correct values for the ALTSTATUS register. In fact the kernel reports:
<br><br>&nbsp;... probing with STATUS(...) instead of ALTSTATUS(...)<br><br>[as in ide-probe.c, line 290]<br><br>The values read from the ATA registers are completely wrong. The registers are accessed through hwif-&gt;INB, that are common &quot;inb&quot; functions. This makes me suspect that &quot;inX&quot; functions are not working, but I don&#39;t know how to test this. Notice that the PCI controller configuration space is correctly accessed, as I can confirm reading sys/bus/pci/.../config.
<br><br>Can you help or suggest me anything?<br>Thanx!<br><br>

------=_Part_114607_12873744.1173011257020--
