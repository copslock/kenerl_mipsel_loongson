Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2004 14:56:29 +0000 (GMT)
Received: from [IPv6:::ffff:209.47.22.60] ([IPv6:::ffff:209.47.22.60]:5534
	"EHLO torexcl1.gmi.domain") by linux-mips.org with ESMTP
	id <S8225210AbUBQO42> convert rfc822-to-8bit; Tue, 17 Feb 2004 14:56:28 +0000
Received: from INDIAEXCH ([10.41.1.181]) by torexcl1.gmi.domain with Microsoft SMTPSVC(5.0.2195.5329);
	 Tue, 17 Feb 2004 09:56:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
Subject: Linux booting on malta board
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Tue, 17 Feb 2004 20:26:21 +0530
Message-ID: <9A45247F1AEBB94189B16E7083981F930588A9@INDIAEXCH.gmi.domain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux booting on malta board
Thread-Index: AcP1ZJMVsdo19DqpT5SmE/2jzAwMnQAAJnTAAAA++nA=
From: "Nilanjan Roychowdhury" <nilanjan@genesis-microchip.com>
To: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 17 Feb 2004 14:56:27.0263 (UTC) FILETIME=[381140F0:01C3F566]
Return-Path: <nilanjan@genesis-microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nilanjan@genesis-microchip.com
Precedence: bulk
X-list: linux-mips





I have a MIPS based malta board. For this board I also have two LINUX  images. One the non real time flavor obtained from MIPS technologies and other is a small footprint embedded image from monta vista.

I have first booted the board with the monitor program and then tried to download the linux images from my linux host using NFS + TFTP.
Now I am able to load the images but when I say go in the monitor prompt...it shows me a message like "LINUX started" in my mincom screen @ host ;also the LED on the board shows "LINUX" but after that the board just hangs. ( it does not respond to any ping ).
The same problem occurs with both the non real time as well as the image from monta vista.


Have you ever faced any such issues??? Any first hand comments???
Regards
Nilanjan
