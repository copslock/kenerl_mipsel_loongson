Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2004 23:42:43 +0000 (GMT)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:25103 "HELO
	[205.229.50.10]") by linux-mips.org with SMTP id <S8225305AbUBDXmm>;
	Wed, 4 Feb 2004 23:42:42 +0000
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 4 Feb 2004 23:42:42 UT
Received: by miles.echelon.com with Internet Mail Service (5.5.2653.19)
	id <Z7JW9XRX>; Wed, 4 Feb 2004 15:38:33 -0800
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB59383A14@miles.echelon.com>
From: Prashant Viswanathan <vprashant@echelon.com>
To: Prashant Viswanathan <vprashant@echelon.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: loading kernel via EJTAG interface
Date: Wed, 4 Feb 2004 15:38:30 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips

Hi, 

I am trying to load a linux kernel through a EJTAG device. I was told that I
should modify the kernel so that it doesnt attempt to use the parameters
passed to it by the loader. However, I am not quite sure as to what it means
and what exactly one has to do. I would really appreciate any
pointers/help/suggestions.

Thanks!
Prashant
