Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 20:46:57 +0000 (GMT)
Received: from smtp1.infineon.com ([IPv6:::ffff:194.175.117.76]:48107 "EHLO
	smtp1.infineon.com") by linux-mips.org with ESMTP
	id <S8225223AbTCMUq5>; Thu, 13 Mar 2003 20:46:57 +0000
Received: from mucse011.eu.infineon.com (mucse011.ifx-mail1.com [172.29.27.228])
	by smtp1.infineon.com (8.12.8/8.12.8) with ESMTP id h2DKcD5X011807
	for <linux-mips@linux-mips.org>; Thu, 13 Mar 2003 21:38:13 +0100 (MET)
Received: by mucse011.eu.infineon.com with Internet Mail Service (5.5.2653.19)
	id <G626QV0C>; Thu, 13 Mar 2003 21:46:50 +0100
Message-ID: <3A5A80BF651115469CA99C8928706CB603D7B312@mucse004.eu.infineon.com>
From: ZhouY.external@infineon.com
To: linux-mips@linux-mips.org
Subject: How can I know whether the timer of the Linux is correct or not?
Date: Thu, 13 Mar 2003 21:46:50 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <ZhouY.external@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ZhouY.external@infineon.com
Precedence: bulk
X-list: linux-mips

Hello everyone,
  I am using a pre-compiled Linux kernel(2.4.18) to boot my MIPS 4Kc Malta
Board. Since I want to measure the performance of my applications, I decided
to use the syscall 'clock_gettime' to get the time data, but how can I
determine whether these time results fits my board's frequency or not, i.e.
are these results true?
  Anybody knows that?
  Thanks in advance!

  Best regards,

  Yidan Zhou
  
  
