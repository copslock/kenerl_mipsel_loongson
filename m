Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2003 18:59:04 +0100 (BST)
Received: from mail3.efi.com ([IPv6:::ffff:192.68.228.90]:35087 "HELO
	fcexgw03.efi.internal") by linux-mips.org with SMTP
	id <S8225222AbTFWR7C> convert rfc822-to-8bit; Mon, 23 Jun 2003 18:59:02 +0100
Received: from 10.3.12.12 by fcexgw03.efi.internal (InterScan E-Mail VirusWall NT); Mon, 23 Jun 2003 10:58:47 -0700
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: ASID query : 2.4.20
Date: Mon, 23 Jun 2003 10:58:41 -0700
Message-ID: <D9F6B9DABA4CAE4B92850252C52383AB0796834F@ex-eng-corp.efi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ASID query : 2.4.20
Thread-Index: AcM5sRTLV3ntFN3KScCMq6cmkv1eXw==
From: "Ranjan Parthasarathy" <ranjanp@efi.com>
To: <linux-mips@linux-mips.org>
Return-Path: <ranjanp@efi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ranjanp@efi.com
Precedence: bulk
X-list: linux-mips

I am seeing an issue with the way the current ASID circulation is implemented. The processor I am working on has the global bit implemented in the entryhi instead of the lo0 and lo1 registers.

Entry hi

31:13 : VPN2
12:7   : Reserved
6       : Global Bit
5:0    :  ASID

The ASID_MASK is 0x3f and ASID_FIRST_VERSION becomes 0x40 which seems to be written to the entryhi if we use the current code. On most processors the bits after the ASID upto the VPN/VPN2 bits seem to be reserved,RO, writes are ignored and so things do not break. In our case this does not work as ASID_FIRST_VERSION would enable the global bit when we launch the first process.

The code in asm-mips/mmu_context.h should use

write_c0_entryhi(cpu_asid(cpu,next));
instead of 
write_c0_entryhi(cpu_context(cpu,next));

in functions switch_mm,activate_mm,drop_mmu_context.

Any comments, feedback is most welcome.

Thanks

Ranjan
