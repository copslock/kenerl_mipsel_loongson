Received:  by oss.sgi.com id <S553768AbQJXOGO>;
	Tue, 24 Oct 2000 07:06:14 -0700
Received: from gandalf1.physik.uni-konstanz.de ([134.34.144.69]:47119 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553759AbQJXOFw>; Tue, 24 Oct 2000 07:05:52 -0700
Received: from frodo.physik.uni-konstanz.de [134.34.144.82] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 13o4hH-0007Mu-00; Tue, 24 Oct 2000 16:04:59 +0200
Received: from agx by frodo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13o4hH-00018O-00; Tue, 24 Oct 2000 16:04:59 +0200
Date:   Tue, 24 Oct 2000 16:04:59 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Nicu Popovici <octavp@isratech.ro>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Linux Mips kernel!
Message-ID: <20001024160459.A4351@frodo.physik.uni-konstanz.de>
References: <39F5EF83.6AFF6A5D@isratech.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <39F5EF83.6AFF6A5D@isratech.ro>; from octavp@isratech.ro on Tue, Oct 24, 2000 at 04:22:27PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 24, 2000 at 04:22:27PM -0400, Nicu Popovici wrote:
> Hello,
> 
> I have the final version of Mips Linux kernel from the CVS site but I do
> not manage to compile it.
> After make menuconfig , make  dep and make CROSS_COMPILE=mips-linux-   I
> get the following error.
[..snip..] 
what versions of gcc/binutils are you using? I'd recommend binutils
2.8.1 + mips-patches & egcs 1.0.3a + mips-patches. If I remember
correntcly they are packaged ready for crosscompiling on oss.
Regards,
 -- Guido
