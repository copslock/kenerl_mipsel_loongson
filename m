Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2JIE1705220
	for linux-mips-outgoing; Mon, 19 Mar 2001 10:14:01 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2JIE1M05217
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 10:14:01 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f2JI8u303447;
	Mon, 19 Mar 2001 10:08:56 -0800
Message-ID: <3AB64B83.B645CCB@mvista.com>
Date: Mon, 19 Mar 2001 10:10:11 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: SCSI card [Re: Bug in the _save_fp_context.]
References: <3AB61293.5652407C@mips.com> <00e901c0b08b$50bed400$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:

> On another topic, now that I've patched the kernel to
> turn off the stupid stuck interrupt on my Malta board,
> I've realized that I can't just connect my old Atlas SCSI
> disk.  I'm torn between ordering a Tekram 390 PCI
> SCSI card, which should be able to use our "MIPS
> safe" NCR driver as-is (I hope) and buying an IDE
> disk and going through the network install ritual.
> Which do you recommend?  One thing I really never
> knew was just what kernel config options I need to
> select to build a kernel that can do the NFS-root
> bootstrap.  Can you help me there?
> 

Kevin,

If you store your kernel image on flash and boots from there, using a local
hard disk is not a bad idea.  I recently used a SCSI card based on NCR
53C895A.  I have to turn off some optimization in the driver in order to get
it work.  See some related configs below.

CONFIG_SCSI_NCR53C8XX=y
# CONFIG_SCSI_SYM53C8XX is not set
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=0
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=0

In general NFS root is always easier to get kernel going.  Many defconfigs
under arch/mips/ already have NFS root fs configured as default, at least in
the two I put in, DDB5476 and ocelot.

Jun
