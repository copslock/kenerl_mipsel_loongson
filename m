Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f47I2q016597
	for linux-mips-outgoing; Mon, 7 May 2001 11:02:52 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f47I2lF16590
	for <linux-mips@oss.sgi.com>; Mon, 7 May 2001 11:02:48 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f45I5dH01698;
	Sat, 5 May 2001 15:05:39 -0300
Date: Sat, 5 May 2001 15:05:39 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: "John D. Davis" <johnd@Stanford.EDU>
Cc: Keith M Wesolowski <wesolows@foobazco.org>,
   Bas Benschop <b.benschop@tn.utwente.nl>,
   debian-mips <debian-mips@lists.debian.org>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Indy Linux Install problem
Message-ID: <20010505150539.D1252@bacchus.dhis.org>
References: <20010504170627.A19856@foobazco.org> <Pine.GSO.4.31.0105041713320.16128-100000@myth1.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0105041713320.16128-100000@myth1.Stanford.EDU>; from johnd@Stanford.EDU on Fri, May 04, 2001 at 05:19:47PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 04, 2001 at 05:19:47PM -0700, John D. Davis wrote:

> So dev console is one problem.
> 
> littledipper 13% ls -l dev/console
> crw-rw-rw-    1 root     sys        0,  0 Jan 24 06:18 dev/console
> 
> Can I just use mknod and change it to c 5 1 ?

The representation of devices accross NFS is not guaranteed, that is a
device that has major / minor 5 / 1 on Linux may appear with different
device numbers when imported/exported via NFS from/to another OS such
as IRIX or Solaris.  So make sure you unpack the image on a Linux
machine.

  Ralf
