Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FCmB8d020218
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 05:48:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FCmBWS020217
	for linux-mips-outgoing; Mon, 15 Apr 2002 05:48:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FCm78d020210
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 05:48:08 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA21527;
	Mon, 15 Apr 2002 14:49:11 +0200 (MET DST)
Date: Mon, 15 Apr 2002 14:49:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guido Guenther <agx@sigxcpu.org>
cc: linux-mips@oss.sgi.com
Subject: Re: head.S and init_task.c vs addinitrd
In-Reply-To: <20020413192811.GA25750@bogon.ms20.nix>
Message-ID: <Pine.GSO.3.96.1020415144452.19735I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 13 Apr 2002, Guido Guenther wrote:

> some of the recent head.S/init_task.c changes break addinitrd. In 2.4.16
> we had two segments which allowed elf2ecoff to put everything (besides
> bss) into one text section (dropping REGINFO) in the ecoff image leaving
> the data section emtpy. Addinitrd then later merged the initial ramdisk
> into that empty data section.

 Hmm, isn't that broken?  I believe an initial RAM disk should be added to
an ELF image, before converting it to ECOFF.  Not everyone uses ECOFF and
ELF is the "canonical" executable format for Linux.  Everything else is a
derivative.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
