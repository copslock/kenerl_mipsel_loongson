Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9IN36l08564
	for linux-mips-outgoing; Thu, 18 Oct 2001 16:03:06 -0700
Received: from hell.ascs.muni.cz (hell.ascs.muni.cz [147.251.60.186])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9IN30D08561
	for <linux-mips@oss.sgi.com>; Thu, 18 Oct 2001 16:03:00 -0700
Received: (from xhejtman@localhost)
	by hell.ascs.muni.cz (8.11.2/8.11.2) id f9IN5er01625;
	Fri, 19 Oct 2001 01:05:40 +0200
Date: Fri, 19 Oct 2001 01:05:40 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Wilbern Cobb <vedge@csoft.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Origin 200[B
Message-ID: <20011019010540.I1089@mail.muni.cz>
References: <20011018163605.F1089@mail.muni.cz> <Pine.BSO.4.33.0110181945150.31704-100000@oddbox.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSO.4.33.0110181945150.31704-100000@oddbox.cn>; from vedge@csoft.org on Thu, Oct 18, 2001 at 07:50:14PM -0300
X-MIME-Autoconverted: from 8bit to quoted-printable by hell.ascs.muni.cz id f9IN5er01625
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f9IN31D08562
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Oct 18, 2001 at 07:50:14PM -0300, Wilbern Cobb wrote:
> > I've finally got our origin to load linux kernel via bootp/tftp (Btw, it
> > _must_ be the same server for bootp and tftp?)
> 
> I'm using different bootp and tftp/nfs servers without problems. My router
> serves bootp, bootparam, rarp, and my development box serves NFS and tftp.

However, my origin only boots if tftp server runs on the same server as bootp

if 'sa' option in bootptab is present origin does not boot.

> Interesting. Just a guess, have you tried disabling the serial driver?  The
> faulty address is a kernel one, that's all I can deduce from that panic.
> I need to get one of these boxes some day..

I can try, but origin have only serial console so will I see output if I disable
the serial driver?

2 times the last message seen from kernel was:
Memory: 60824k/65536k available (1423k kernel code, 4712k reserved, 184k data, 220k init)
And nothing more, no oops.

once the last message was about serial ports (two detected) and nothing more.
[ cut ]
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI
enabled
ttyS00 at iomem 0x9200000008620178 (irq = 0) is a 16550A
ttyS01 at iomem 0x9200000008620170 (irq = 0) is a 16550A
Ass well nothing more just stoped.


for fourth time it writed:
.... [ cut ]...
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Unhandled kernel unaligned access: 0000
Cpu 0
$0      : 0000000000000000 ffffffffc11f0000 0000000000000003 a80000000025be6

So it did oops before kswapd started.

fifth time message I've already posted.

-- 
Luká¹ Hejtmánek
