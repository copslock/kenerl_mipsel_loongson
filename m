Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2004 22:46:30 +0000 (GMT)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:64776 "HELO
	[205.229.50.10]") by linux-mips.org with SMTP id <S8225301AbUBDWqa>;
	Wed, 4 Feb 2004 22:46:30 +0000
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 4 Feb 2004 22:46:29 UT
Received: by miles.echelon.com with Internet Mail Service (5.5.2653.19)
	id <Z7JW9XM7>; Wed, 4 Feb 2004 14:42:21 -0800
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB59383A13@miles.echelon.com>
From: Prashant Viswanathan <vprashant@echelon.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: configuring console to use a different UART
Date: Wed, 4 Feb 2004 14:42:13 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips

Hi,

How can I change the kernel so that it uses the UART I specify for the
console instead of the first available one? I dont want to pass this on the
bootline but want to compile this into vmlinux.

Thanks
Prashant
