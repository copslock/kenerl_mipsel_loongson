Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2004 00:43:10 +0000 (GMT)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:11015 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225285AbUL2AnF>;
	Wed, 29 Dec 2004 00:43:05 +0000
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Tue, 28 Dec 2004 16:43:04 -0800
Received: by miles.echelon.com with Internet Mail Service (5.5.2653.19)
	id <ZK16S64D>; Tue, 28 Dec 2004 16:42:52 -0800
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB59016543DF@miles.echelon.com>
From: Prashant Viswanathan <vprashant@echelon.com>
To: 'Peter Popov' <ppopov@embeddedalley.com>,
	Prashant Viswanathan <vprashant@echelon.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: dbAu1550 (Cabarnet) - problems booting kernel - hangs at "Sen
	ding BOOTP" and root file system for MIPS (BE)
Date: Tue, 28 Dec 2004 16:42:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips


>> When I pull the sources from linux-mips.org, I don't
>> get anything in the
>> arch/mips/defconfigs directory. I see a lot of files
>> in the "Attic", but not one for the DbAu1550.

> Sorry, I meant arch/mips/configs. There is a
> db1550_defconfig there.

I was able to build and load the kernel using this file. Thanks to Pete for
that. 

The only change I had to make was to drivers/mtd/maps/db1550-flash.c which
was referencing asm/au1000.h. This file has moved to
asm/mach-au1x00/au1000.h. I also changed the config file to indicate Big
Endian instead of Little Endian default. The tool chain was BE and the board
was configured to boot in BE too.

However, the kernel seems to hang in "Sending BOOTP Requests"
<snip>
Sending BOOTP requests .<6>eth0: link up
eth1: link up
..... timed out!
IP-Config: Reopening network devices...
Sending BOOTP requests ....
</snip>

The same happens whether I use "go . ip=any" or "go . ip=10.2.11.185" from
yamon. All the other nodes on this network also use DHCP to get their
addresses and they have no problems. The board itself boots using tftp so
the network connectivity must be good.

My next step would be to specify a root file system. Where can I find a root
file system (or/and compiled package) for MIPS (BE)? I saw this thread (link
below) on the mailing list, but none of these links work now. 
http://www.linux-mips.org/archives/linux-mips/2001-03/threads.html#00008


Thanks
Prashant
