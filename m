Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Sep 2006 12:54:31 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:55341 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038567AbWIGLy3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Sep 2006 12:54:29 +0100
Received: by nf-out-0910.google.com with SMTP id l23so471438nfc
        for <linux-mips@linux-mips.org>; Thu, 07 Sep 2006 04:54:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fF5Xv1k3voXa4NjnbHT/O9+qfanOMnW5YSvKoGo9CeztKvUgmi7iFJclF5WVEEVarJ4RMCrXbX3s+o9MFGrMFV4UqVagjn0NVMIG6FNUF2/FxVmcTEonkD8uCFq14ggm1yvTgVtFTVryxyUAZbvpEBD6e/Us8eeuXeIl16qwAlA=
Received: by 10.48.220.15 with SMTP id s15mr2400831nfg;
        Thu, 07 Sep 2006 04:54:26 -0700 (PDT)
Received: by 10.49.31.3 with HTTP; Thu, 7 Sep 2006 04:54:26 -0700 (PDT)
Message-ID: <c58a7a270609070454n1e99f0e5q9103e6c5c105277@mail.gmail.com>
Date:	Thu, 7 Sep 2006 12:54:26 +0100
From:	"Alex Gonzalez" <langabe@gmail.com>
To:	linux-mips@linux-mips.org
Subject: PMC RM9000x2 GL titan (yosemite) multicast address filtering
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: langabe@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, I am trying to configure the ethernet subsystem to filter out
multicast streams selectively, and I am running into some problems.

If anyone has done this before, could you try to answer the following questions?

1) For an incoming packet, the chip computes a non-inverted CRC32
calculation over the destination MAC address, and uses the top 6 bits
(using the default values of MHASH_INDEX) to hash into the 64bin
multicast hash table to decide whether to filter the packet out or
not.

As an example, if I set the multicast filter to accept packets from
225.10.10.0/255.255.255.252 ( MACs - 008a000a0a00 to 008a000a0a03 ).

The port configuration is,

AFAFIL1 0xffff0003
multicast 64bin hash filter 4000:0008:0100:0000 (high, mid-high , mid-low , low)

With this configuration, the box sees streams like 225.10.10.11, but
filters out 225.11.10.1.

I would like to make sure that the CRC32 algorithm that the chip is
using is the same I'm using. I have tried two different
implementations that don't seem to work (in both cases they filter out
some multicast streams but not the correct ones).

My CRC32 implementation details are:

CRC32(123456789) is 2dfd2d88, which is a bytes reversed, non-inverted
result, seeded on 0x00000000 and with a polynomial base 0x04c11db7
implementation.
CRC32(123456789) is cbf43926, which is a bytes reversed, result
inverted, seeded on 0xffffffff and with a polynomial base 0x04c11db7
implementation.

Has anybody tried this before? Could this be an endianness problem
with my CRC32 calculations (even though they both give the correct
checksum over the '123456789' pattern?

2) I will just mention my second problem just in case somebody else
has seen it. I have three ethernet ports, eth0, eth1 and eth2, and I
use the same code with the correct register offsets to write to the
address filtering logic. I can't write any values to eth1, even though
it works perfectly for eth0 and eth2.

Thanks,
Alex
