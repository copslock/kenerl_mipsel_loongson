Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7AJwXf23885
	for linux-mips-outgoing; Fri, 10 Aug 2001 12:58:33 -0700
Received: from gateway.total-knowledge.com (c1213523-b.smateo1.sfba.home.com [24.1.66.97])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7AJwVV23879
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 12:58:31 -0700
Received: (qmail 14200 invoked by uid 502); 10 Aug 2001 19:58:30 -0000
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ilya Volynets <ilya@theIlya.com>
Reply-To: ilya@theIlya.com
Organization: Total knowledge
To: Hartvig Ekner <hartvige@mips.com>, ilya@theIlya.com,
   linux-mips@oss.sgi.com
Subject: Re: about mips IDE DMA disk problem
Date: Fri, 10 Aug 2001 12:58:27 -0700
X-Mailer: KMail [version 1.2]
References: <200108101841.UAA01339@copsun17.mips.com>
In-Reply-To: <200108101841.UAA01339@copsun17.mips.com>
MIME-Version: 1.0
Message-Id: <01081012582704.07543@gateway>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

MIPS web site still lists 2.2.12 kernel as official one coming from
MIPS (http://www.mips.com/devTools/catalog_2001/Linux.html)
which is probably the reason everyone else is trying to port
that one. That's all I was saying. Probably this should have been
sent to web master.
On Friday 10 August 2001 11:41, Hartvig Ekner wrote:
> Hi,
>
> Ilya Volynets writes:
> > > They're well aware of that - and working on 2.4
> >
> > Great! 'cause questions related to 2.2.12 kernel are becoming FAQ.
>
> You can already find 2.4 kernels on ftp.mips.com:
>
> ftp> pwd
> 257 "/pub/linux/mips/kernel/2.4" is current directory.
> ftp> ls -R
> 227 Entering Passive Mode (206,31,31,227,157,126)
> 150 Opening ASCII mode data connection for /bin/ls.
> total 4
> -rw-r--r--   1 9618     40           1613 Jul  6 04:41 README
> drwxr-xr-x   2 9618     40            512 Jul  6 05:26 images
> drwxr-xr-x   2 9618     40            512 Jul  6 05:27 src
>
> images:
> total 8720
> -rw-r--r--   1 9618     40        1103571 Mar 30 05:23
> vmlinux-2.4.1.atlas.eb-01.00.srec.gz -rw-r--r--   1 9618     40       
> 1129920 Mar 30 05:23 vmlinux-2.4.1.atlas.el-01.00.srec.gz -rw-r--r--   1
> 9618     40        1061736 Mar 30 05:23
> vmlinux-2.4.1.malta.eb-01.00.srec.gz -rw-r--r--   1 9618     40       
> 1093062 Mar 30 05:23 vmlinux-2.4.1.malta.el-01.00.srec.gz -rw-r--r--   1
> 9618     40        1116378 Jul  6 04:35
> vmlinux-2.4.3.atlas.eb-01.00.srec.gz -rw-r--r--   1 9618     40       
> 1144798 Jul  6 04:35 vmlinux-2.4.3.atlas.el-01.00.srec.gz -rw-r--r--   1
> 9618     40        1075193 Jul  6 04:35
> vmlinux-2.4.3.malta.eb-01.00.srec.gz -rw-r--r--   1 9618     40       
> 1107586 Jul  6 04:35 vmlinux-2.4.3.malta.el-01.00.srec.gz
>
> src:
> total 50200
> -rw-r--r--   1 9618     40       25100716 Mar 30 05:24
> linux-2.4.1.mips-src-01.00.tar.gz -rw-r--r--   1 9618     40       26239788
> Jul  6 04:35 linux-2.4.3.mips-src-01.00.tar.gz 226 Transfer complete.
> ftp>
>
> /Hartvig
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjt0POYACgkQtKh84cA8u2mXdACfV5qmuHKMuToSz5AwH+nAt8a2
CyUAnjdm1jtPtDaSNy13tXRNytvBpDMH
=gazA
-----END PGP SIGNATURE-----
