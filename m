Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2003 22:51:46 +0000 (GMT)
Received: from adsl-66-123-66-42.dsl.pltn13.pacbell.net ([IPv6:::ffff:66.123.66.42]:22657
	"EHLO stella-blue.herbertphamily.com") by linux-mips.org with ESMTP
	id <S8225247AbTL2Wvp>; Mon, 29 Dec 2003 22:51:45 +0000
Received: from [192.168.1.106] (adsl-68-120-138-250.dsl.snfc21.pacbell.net [68.120.138.250])
	(authenticated bits=0)
	by stella-blue.herbertphamily.com (8.12.8/8.12.8) with ESMTP id hBTMpafG026203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mips@linux-mips.org>; Mon, 29 Dec 2003 14:51:42 -0800
Subject: Recommended gcc/gas for SB1 builds?
From: Kevin Paul Herbert <kph@cisco.com>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: cisco Systems, Inc.
Message-Id: <1072738240.15369.310.camel@shakedown>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Dec 2003 14:51:37 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <kph@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kph@cisco.com
Precedence: bulk
X-list: linux-mips

What's the recommended gcc/gas versions for building the 2.6 kernel for
the SB1 processor? I'm being bit by the use of dclz in
arch/mips/sibyte/sb1250/irq_handler.S when compiling with 3.3.2. I am in
the process of building the 20030910 snapshot of gcc 3.4 and while it
does have dclz support there are various warnings when compiling the
machine description, so I am wondering if there is a better version to
try.

Thanks,
Kevin
-- 
Kevin Paul Herbert <kph@cisco.com>
cisco Systems, Inc.
