Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6B8pSI30588
	for linux-mips-outgoing; Wed, 11 Jul 2001 01:51:28 -0700
Received: from godevin.myreseau.loc (IDENT:105@r30m101.cybercable.tm.fr [195.132.30.101])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6B8pQV30584
	for <linux-mips@oss.sgi.com>; Wed, 11 Jul 2001 01:51:26 -0700
Received: from noos.fr (godevin.myreseau.loc [192.168.0.1])
	by godevin.myreseau.loc (Postfix) with ESMTP id 9BC0A47801
	for <linux-mips@oss.sgi.com>; Wed, 11 Jul 2001 10:51:42 +0200 (CEST)
Message-ID: <3B4C139E.BBE2A641@noos.fr>
Date: Wed, 11 Jul 2001 10:51:42 +0200
From: =?iso-8859-1?Q?J=E9r=F4me?= Schell <jschell@noos.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Re: Boot-Problem on an indy
References: <20010711091139.A24847@tuvok.allgaeu.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Robert Einsle wrote:
> 
> Hy *
> 
> I had installd debian-linux on an indy r4400, 160 mhz
> from an howto. but when running dvhtool it gives me an
> error back. Now i don't knew if i make a correct
> partition-table with right items or any other thing is
> wrong.
> I called dvhtool:
> 
> dvhtool -d /dev/sda vmlinux-2.4.3.ecoff linux

Is it not:
dvhtool -d /dev/sda --unix-to-vh vmlinux-2.4.3.ecoff linux

Jérôme
