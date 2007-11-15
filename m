Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 10:51:47 +0000 (GMT)
Received: from mail153.messagelabs.com ([216.82.253.51]:37750 "HELO
	mail153.messagelabs.com") by ftp.linux-mips.org with SMTP
	id S20025588AbXKOKvi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2007 10:51:38 +0000
X-VirusChecked:	Checked
X-Env-Sender: marcus.gustafsson@motorola.com
X-Msg-Ref: server-7.tower-153.messagelabs.com!1195123771!13775708!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [129.188.136.8]
Received: (qmail 31562 invoked from network); 15 Nov 2007 10:49:31 -0000
Received: from motgate8.mot.com (HELO motgate8.mot.com) (129.188.136.8)
  by server-7.tower-153.messagelabs.com with SMTP; 15 Nov 2007 10:49:31 -0000
Received: from il06exr02.mot.com (il06exr02.mot.com [129.188.137.132])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id lAFAnQ29020904
	for <linux-mips@linux-mips.org>; Thu, 15 Nov 2007 03:49:30 -0700 (MST)
Received: from il06vts02.mot.com (il06vts02.mot.com [129.188.137.142])
	by il06exr02.mot.com (8.13.1/Vontu) with SMTP id lAFAnQMM020809
	for <linux-mips@linux-mips.org>; Thu, 15 Nov 2007 04:49:26 -0600 (CST)
Received: from zuk35exm65.ds.mot.com (zuk35exm65.ea.mot.com [10.178.4.21])
	by il06exr02.mot.com (8.13.1/8.13.0) with ESMTP id lAFAnOqI020799
	for <linux-mips@linux-mips.org>; Thu, 15 Nov 2007 04:49:25 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: smp8634 add memory at dram1
Date:	Thu, 15 Nov 2007 10:49:23 -0000
Message-ID: <8D20BBB55F590E42AADF592A815E86170155CEB0@zuk35exm65.ds.mot.com>
In-Reply-To: <473B1DD0.2090903@avtrex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: smp8634 add memory at dram1
Thread-Index: Acgm2QB4xn+6fb3YRXGJOOt6dN86XAAm96dA
From:	"Gustafsson Marcus-MGU001" <marcus.gustafsson@motorola.com>
To:	<linux-mips@linux-mips.org>
X-CFilter-Loop:	Reflected
Return-Path: <marcus.gustafsson@motorola.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcus.gustafsson@motorola.com
Precedence: bulk
X-list: linux-mips

 
David Daney wrote
> I think your understanding of the 8634 is at least close to correct.
> 
> It may be possible (but I have not tried it yet) to use the 
> remapping registers to move dram1 into the first 512MB of the 
> memory space.  If it is possible, you would then have to 
> modify the gbus access functions accordingly.  Also the 8634 
> media drivers would probably have to be changed as well.  I 
> am not sure about the microcode for the media DSPs, but if it 
> is dependent on the mapping of the DRAM, then you would 
> probably have to get the vendor's help.
> 
> Let me know if you are successful.
AFAIK the memory bandwith available is not enough for supporting video
decoding and Linux usage at the same dram controller.

/Marcus Gustafsson
