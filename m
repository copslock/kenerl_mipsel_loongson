Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2006 00:30:57 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:9644 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20037559AbWITXaz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Sep 2006 00:30:55 +0100
Received: (qmail 2298 invoked by uid 101); 20 Sep 2006 23:30:44 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 20 Sep 2006 23:30:44 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k8KNUhea019606;
	Wed, 20 Sep 2006 16:30:43 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <PW6259ZJ>; Wed, 20 Sep 2006 16:30:43 -0700
Message-ID: <C28979E4F697C249ABDA83AC0C33CDF8344246@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	Alex Gonzalez <langabe@gmail.com>, linux-mips@linux-mips.org
Subject: RE: PMC RM9000x2 GL titan (yosemite) multicast address filtering
Date:	Wed, 20 Sep 2006 16:30:39 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Alex,

The algorithm used for computing the crc32:
1. compute crc32 over the 48-bits of mac dest. Address as follow:
crc := (OTHERS => `1`);
FOR i IN 0 TO 47 LOOP
feed := crc(31) XOR da(i);
crc := crc(30 DOWNTO 26) & (crc(25) XOR feed) & crc(24 DOWNTO 23) &
(crc(22) XOR feed) & (crc(21) XOR feed) & crc(20 DOWNTO 16) &
(crc(15) XOR feed) & crc(14 DOWNTO 12) & (crc(11) XOR feed) &
(crc(10) XOR feed) & (crc(9) XOR feed) & crc(8) &
(crc(7) XOR feed) & (crc(6) XOR feed) & crc(5) &
(crc(4) XOR feed) & (crc(3) XOR feed) & crc(2) &
(crc(1) XOR feed) & (crc(0) XOR feed) & feed; END LOOP;

2. Swap the bits in each bytes of the calculated crc32

3. Perform 1's complement of the crc32, and use the appropriate 6 bits from the 32-bits of the CRC for indexing based on MHASH_INDEX.


Kiran

-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Alex Gonzalez
Sent: Thursday, September 07, 2006 4:54 AM
To: linux-mips@linux-mips.org
Subject: PMC RM9000x2 GL titan (yosemite) multicast address filtering

Hi, I am trying to configure the ethernet subsystem to filter out multicast streams selectively, and I am running into some problems.

If anyone has done this before, could you try to answer the following questions?

1) For an incoming packet, the chip computes a non-inverted CRC32 calculation over the destination MAC address, and uses the top 6 bits (using the default values of MHASH_INDEX) to hash into the 64bin multicast hash table to decide whether to filter the packet out or not.

As an example, if I set the multicast filter to accept packets from
225.10.10.0/255.255.255.252 ( MACs - 008a000a0a00 to 008a000a0a03 ).

The port configuration is,

AFAFIL1 0xffff0003
multicast 64bin hash filter 4000:0008:0100:0000 (high, mid-high , mid-low , low)

With this configuration, the box sees streams like 225.10.10.11, but filters out 225.11.10.1.

I would like to make sure that the CRC32 algorithm that the chip is using is the same I'm using. I have tried two different implementations that don't seem to work (in both cases they filter out some multicast streams but not the correct ones).

My CRC32 implementation details are:

CRC32(123456789) is 2dfd2d88, which is a bytes reversed, non-inverted result, seeded on 0x00000000 and with a polynomial base 0x04c11db7 implementation.
CRC32(123456789) is cbf43926, which is a bytes reversed, result inverted, seeded on 0xffffffff and with a polynomial base 0x04c11db7 implementation.

Has anybody tried this before? Could this be an endianness problem with my CRC32 calculations (even though they both give the correct checksum over the '123456789' pattern?

2) I will just mention my second problem just in case somebody else has seen it. I have three ethernet ports, eth0, eth1 and eth2, and I use the same code with the correct register offsets to write to the address filtering logic. I can't write any values to eth1, even though it works perfectly for eth0 and eth2.

Thanks,
Alex
