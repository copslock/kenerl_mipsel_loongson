Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 21:58:31 +0000 (GMT)
Received: from email.crossroads.com ([IPv6:::ffff:65.68.235.6]:26756 "HELO
	email.crossroads.com") by linux-mips.org with SMTP
	id <S8225506AbUAUV6b> convert rfc822-to-8bit; Wed, 21 Jan 2004 21:58:31 +0000
Received: from HQMAILNODE1.COMMSTOR.Crossroads.com ([10.5.1.42]) by email.crossroads.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 21 Jan 2004 15:58:24 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: How to add more memory?
Date: Wed, 21 Jan 2004 15:58:24 -0600
Message-ID: <CFD808D1D39ACB47ABFF586D484CC52EADE212@hqmailnode1.commstor.crossroads.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to add more memory?
Thread-Index: AcPgagduokXno7WkRMilFLIIHpgaow==
From: "Nils Larson" <nlarson@Crossroads.com>
To: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 21 Jan 2004 21:58:25.0161 (UTC) FILETIME=[B18EA790:01C3E069]
Return-Path: <nlarson@Crossroads.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nlarson@Crossroads.com
Precedence: bulk
X-list: linux-mips

Hi,
We currently have a mips platform running Linux with 256MB of
RAM starting at 0x8000_0000. We would like to add an additional
1GB of RAM, maybe starting at 0x4000_0000, that would be used
for user apps (user virtual memory). The memory map is:
0x8000_0000 - 256MB RAM
0xA000_0000 - uncached version of the same 256MB
0xB000_0000 - PCI memory windows.
This is a diskless setup booting from a ramdisk.
So, the (sort of newbie) questions are:
1. How do we tell Linux to use the new memory?
2. Is this feasible?
3. Is there a better way to add more memory?
We need more space for user data.
Thanks,
Nils
