Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9MC76832386
	for linux-mips-outgoing; Mon, 22 Oct 2001 05:07:06 -0700
Received: from mail.minus-9.com (IDENT:postfix@minus-9.com [195.26.32.62])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9MC72D32382
	for <linux-mips@oss.sgi.com>; Mon, 22 Oct 2001 05:07:02 -0700
Received: by mail.minus-9.com (Postfix, from userid 500)
	id 822B9FB4A; Mon, 22 Oct 2001 13:06:59 +0100 (BST)
Date: Mon, 22 Oct 2001 13:06:59 +0100
From: Mat Withers <mat@minus-9.com>
To: linux-mips@oss.sgi.com
Subject: First attempt to install Linux on my Indigo 2
Message-ID: <20011022130659.B20721@minus-9.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi

I've been subscribed to the list for quite a while but am just about to try installing Linux on my Indigo2 (R4400SC / 128Mb RAM) for the first time.

I want to try H J Lu's port of Radhat 7.1. I've read the the howto at http://oss.sgi.com/mips/mips-howto.html, have set up a tftp server a bootp server an nfs server and have made up a working serial cable. Now having browsed ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/ I am unsure what to do next. I assume I will need a kernel image and a root filing system to nfs mount but can't see anything resembling them on the ftp site.

I have a spare 4Gb scsi disk that I want to attempt the install on. I assume that once I have got the machine booted using an nfs root I can partion the hard disk - somehow install the RPMS on it and then use dvhtool to get my SGI to boot from the hard disk.

Is this all feasible ? has anyone got any hints or gottcha's ?

Thanks in advance for any help

Cheers

Mat

-- 

Mat Withers
mat@minus-9.com
http://minus-9.com
phone/fax: +44 07092 375299
"a sarcasm detector, *that's* a real useful invention."
