Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2005 09:02:25 +0100 (BST)
Received: from turtle.dnsmaster.net ([IPv6:::ffff:212.84.160.23]:7049 "EHLO
	turtle.dnsmaster.net") by linux-mips.org with ESMTP
	id <S8225962AbVD2ICJ>; Fri, 29 Apr 2005 09:02:09 +0100
Received: from Charles (host81-129-41-101.range81-129.btcentralplus.com [81.129.41.101])
	by turtle.dnsmaster.net (8.13.1/8.12.8) with ESMTP id j3T825ZI024072
	for <linux-mips@linux-mips.org>; Fri, 29 Apr 2005 08:02:06 GMT
Message-ID: <000a01c54c91$bd2d03e0$0410a8c0@Charles>
From:	"Charles Palmer" <charles.palmer@acutetechnology.com>
To:	<linux-mips@linux-mips.org>
Subject: Obtaining cardmgr, cardctl for Alchemy
Date:	Fri, 29 Apr 2005 09:02:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <charles.palmer@acutetechnology.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charles.palmer@acutetechnology.com
Precedence: bulk
X-list: linux-mips

I am working with AMD's DBAu1200 development board and want to get the 
PCMCIA working. It looks like I am missing a package containing cardmgr, 
cardctl etc. Does anyone know where I can download this from? I am using 
2.4.26 kernel, based on a source tree provided with AMD's development kit, 
but it appears to lack this package.

AMD's pcmcia.txt readme says this: "Install the MVL HHL PCMCIA package, file 
named hhl-mips_fp_le-pcmcia-cs-3.1.24-db010812.1.mips_fp_le.rpm. This 
pacakge contains the scripts and utilities (specifically cardmgr and 
cardctl) for making PCMCIA work". I am using 2.4.26 kernel, based on a 
source tree provided with AMD's development kit, but it appears to lack this 
package.

Thanks - Charles Palmer 
