Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2004 20:53:55 +0000 (GMT)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:50479 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225227AbUL1Uxu>;
	Tue, 28 Dec 2004 20:53:50 +0000
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Tue, 28 Dec 2004 12:53:50 -0800
Received: by miles.echelon.com with Internet Mail Service (5.5.2653.19)
	id <ZK16SYJG>; Tue, 28 Dec 2004 12:53:37 -0800
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB59016543DA@miles.echelon.com>
From: Prashant Viswanathan <vprashant@echelon.com>
To: 'Peter Popov' <ppopov@embeddedalley.com>,
	Prashant Viswanathan <vprashant@echelon.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: defconfig for dbAu1550 (Cabarnet) and problems booting kernel
Date: Tue, 28 Dec 2004 12:53:37 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips


>> I am trying to get Linux up and running on the
>> DbAu1550 (Cabarnet) using the
>> latest code from linux-mips.org.  I was wondering if
>> somebody would have a default config file 
>> for building the kernel.

> The DbAu1550 should just work with the default config
> that's in arch/mips/defconfigs. There have been a
> number of patches that went into the tree since I was
> built a kernel for that board, but assuming the
> patches did not break anything, the kernel should
> boot.

When I pull the sources from linux-mips.org, I don't get anything in the
arch/mips/defconfigs directory. I see a lot of files in the "Attic", but not
one for the DbAu1550.

Thanks
Prashant
