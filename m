Received:  by oss.sgi.com id <S553936AbQKAIX6>;
	Wed, 1 Nov 2000 00:23:58 -0800
Received: from mx.mips.com ([206.31.31.226]:32253 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553840AbQKAIXt>;
	Wed, 1 Nov 2000 00:23:49 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA18633;
	Wed, 1 Nov 2000 00:23:27 -0800 (PST)
Received: from Ulysses (par-qbu-gpb-vty6.as.wcom.net [195.232.111.6])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA11623;
	Wed, 1 Nov 2000 00:23:33 -0800 (PST)
Message-ID: <001501c043dd$7ed69780$066fe8c3@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Brady Brown" <bbrown@ti.com>, "Nicu Popovici" <octavp@isratech.ro>
Cc:     <linux-mips@oss.sgi.com>
References: <39FF1A83.387D0E1F@isratech.ro> <39FF2AEB.3137F75E@ti.com>
Subject: Re: MIPS ftp problem!
Date:   Wed, 1 Nov 2000 09:26:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> > I have a problem with the mips machine. I have an Atlas board and when I
> > do ftp on the mips machine from a intel one and I try to transfer files
> > ( it works very very slow 0,0234 bytes/s). The same is happening when I
> > try to make ftp from the mips machine on a intel box ( all running Linux
> > ).
> >
> > Thanks,
> > Nicu
>
> Is this using the Atlas on-board NIC? We found some pretty bad performance
> with the on-board NIC and went to the very cheap RTL8139 PCI card from
> OvisLink (used the 8139too.o driver). Performance there is pretty good.

There seems to be a problem with the on-board NIC on the Philips
multi-I/O part misbehaving under load.   It seems to be OK
for TFTP downloading and telnet sessions, but loses packets/interrupts
under FTP or NFS.  So I heartily second Brady's recommendation
of using an add-in PCI NIC. At MIPS, we use AMD PCnet cards,
for which there is a MIPS cache-and-endianness-clean driver in the
kernel sources on the MIPS FTP site (and I think built into the kernel
binary there as well).

            Regards,

            Kevin K.
