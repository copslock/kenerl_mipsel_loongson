Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2004 18:45:59 +0100 (BST)
Received: from web81008.mail.yahoo.com ([IPv6:::ffff:206.190.37.153]:19838
	"HELO web81008.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225361AbUJORpx>; Fri, 15 Oct 2004 18:45:53 +0100
Message-ID: <20041015174542.20487.qmail@web81008.mail.yahoo.com>
Received: from [216.98.102.225] by web81008.mail.yahoo.com via HTTP; Fri, 15 Oct 2004 10:45:42 PDT
X-RocketYMMF: pvpopov@pacbell.net
Date: Fri, 15 Oct 2004 10:45:42 -0700 (PDT)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: Is there any means to use Cramfs and JFFS2 images as root disks?
To: =?ISO-8859-1?Q?"=AAL=AB=D8=A6w"?= <Mickey@turtle.ee.ncku.edu.tw>, linux-mips@linux-mips.org
In-Reply-To: <002f01c4b2dc$cd1262e0$7101a8c0@dinosaur>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


--- ªL«Ø¦w <Mickey@turtle.ee.ncku.edu.tw> wrote:

> 
> Hello,
> I had successfully booted up Linux with an NFS root.
> Trying to boot up Linux with Cramfs and JFFS2 roots,
> I am wondering how to
> pass parameters to Kernel.
> I found that on some bootloaders, parameters are
> like these:
>     rootfstype = jffs2 root=/dev/mtdblock3
> 
> But YAMON doesn't seem to support MTD BLOCK.
> Therefore, how do I tell Kernel where the root image
> is on YAMON?

Yamon or any other bootloader doesn't have to support
jffs2 or cramfs. All it needs to do is pass the
parameters to the kernel.  Your parameters above are
incorrect. rootfstype=jffs2 will not be recognized.
The /dev/mtdblock3 is fine, assuming that you really
do have a jffs2 fs there. Then, assuming that the
kernel has jffs2 statically compiled in, it will
recognize the FS and mount it.

Pete
