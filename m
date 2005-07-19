Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 17:04:01 +0100 (BST)
Received: from [IPv6:::ffff:62.253.252.7] ([IPv6:::ffff:62.253.252.7]:18596
	"EHLO exterity.co.uk") by linux-mips.org with ESMTP
	id <S8226887AbVGSQDn> convert rfc822-to-8bit; Tue, 19 Jul 2005 17:03:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: SNR calculation in stv0299 driver
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date:	Tue, 19 Jul 2005 17:08:10 +0100
Message-ID: <CEA5455795C8AA44AA1E18EF32379B210BA979@exterity-serv1.Exterity.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SNR calculation in stv0299 driver
Thread-Index: AcWMfA7+zUQuRUwsRJCe8P1oYSmlsg==
From:	"Gill Robles-Thome" <gill.robles@exterity.co.uk>
To:	<linux-mips@linux-mips.org>
Return-Path: <gill.robles@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gill.robles@exterity.co.uk
Precedence: bulk
X-list: linux-mips

Hi -

Can anyone explain the algorithm used to calculate the SNR for the
stv0299 driver? Ie


	case FE_READ_SNR:
	{
		s32 snr = 0xffff - ((stv0299_readreg (i2c, 0x24) << 8)
				   | stv0299_readreg (i2c, 0x25));
		snr = 3 * (snr - 0xa100);
		*((u16*) arg) = (snr > 0xffff) ? 0xffff :
				(snr < 0) ? 0 : snr;
		break;
	}
 

I don't understand where the 0xa100 value comes from, or why the result
is them multiplied by 3!  Registers 0x24 and 0x25 are apparently "Noise
Indicator" registers, but the stv0299 specification doesn't explain very
well how these registers should be used.

Thanks for your help,
Gill
