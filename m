Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACJgAl05179
	for linux-mips-outgoing; Mon, 12 Nov 2001 11:42:10 -0800
Received: from gw-us4.philips.com (gw-us4.philips.com [63.114.235.90])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACJg7005176
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 11:42:07 -0800
Received: from smtpscan-us1.philips.com (localhost.philips.com [127.0.0.1])
          by gw-us4.philips.com with ESMTP id NAA25000
          for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 13:42:06 -0600 (CST)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-us1.philips.com(167.81.233.25) by gw-us4.philips.com via mwrap (4.0a)
	id xma024996; Mon, 12 Nov 01 13:42:06 -0600
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id NAA20113
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 13:42:11 -0600 (CST)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id NAA23596
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 13:42:11 -0600 (CST)
Subject: initrd disabled
To: linux-mips@oss.sgi.com
Date: Mon, 12 Nov 2001 11:42:45 -0800
Message-ID: <OF185C54D7.3D8B2C10-ON88256B02.006AFF59@diamond.philips.com>
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 12/11/2001 13:46:11
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Hello,

I have been working in the linux kernel 2.4.3 which was ported for mips32 ISA.
I cant understand certain things.
The variable max_low_pfn is used to compare the initrd_end.
I can see the max_low_pfn being zero and as a result the phys_to_virt(PFN_PHYS(max_low_pfn))
is zero. Hence in the setup_arch, the initrd comparision fails and the initrd is disabled.
I get the following  messages,

Initial ramdisk at: 0x8010e000 (1916920 bytes)
initrd extends beyond end of memory (0x802e1ff8 > 0x80000000)
disabling initrd

I dont know how this variable gets a value.
Also I get some messages like the below in the bootmem.c. while accessing
the reserve_bootmem function.  Is this a kernel BUG or is it something with my hardware?

kernel BUG at bootmem.c:84!
kernel BUG at bootmem.c:87!
kernel BUG at bootmem.c:181!

Any help would be greatly appreciated.

regards,
Balaji
