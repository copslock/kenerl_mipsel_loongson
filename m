Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f47Kvu922160
	for linux-mips-outgoing; Mon, 7 May 2001 13:57:56 -0700
Received: from myth1.Stanford.EDU (myth1.Stanford.EDU [171.64.15.14])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f47KvqF22156;
	Mon, 7 May 2001 13:57:53 -0700
Received: (from johnd@localhost)
	by myth1.Stanford.EDU (8.11.1/8.11.1) id f47KvlF28559;
	Mon, 7 May 2001 13:57:47 -0700 (PDT)
Date: Mon, 7 May 2001 13:57:47 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: debian-mips <debian-mips@lists.debian.org>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Indy Linux Install problem
In-Reply-To: <20010505150539.D1252@bacchus.dhis.org>
Message-ID: <Pine.GSO.4.31.0105071349350.28169-100000@myth1.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


The base2_2.2.tgz that I got did not have the correct major and minor
nodes on IRIX.  I changed them and it appears to be happy.  All the nodes
seem to be correct when unpacking on a linux box.  Is there a way to at
least have the correct major and minor nodes when it is unpacked on a IRIX
box?

thanks,
john

On Sat, 5 May 2001, Ralf Baechle wrote:

> On Fri, May 04, 2001 at 05:19:47PM -0700, John D. Davis wrote:
>
> > So dev console is one problem.
> >
> > littledipper 13% ls -l dev/console
> > crw-rw-rw-    1 root     sys        0,  0 Jan 24 06:18 dev/console
> >
> > Can I just use mknod and change it to c 5 1 ?
>
> The representation of devices accross NFS is not guaranteed, that is a
> device that has major / minor 5 / 1 on Linux may appear with different
> device numbers when imported/exported via NFS from/to another OS such
> as IRIX or Solaris.  So make sure you unpack the image on a Linux
> machine.
>
>   Ralf
>
