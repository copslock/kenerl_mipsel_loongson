Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Sep 2004 13:48:06 +0100 (BST)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:38155 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8224986AbUIOMsB>; Wed, 15 Sep 2004 13:48:01 +0100
Received: from SNaIlmail.Peter (217.249.213.74)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Wed, 15 Sep 2004 14:45:42 +0200
Received: from indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id i8FCjDEK000569;
	Wed, 15 Sep 2004 14:45:15 +0200
Received: from localhost (pf@localhost)
	by indigo2.Peter (8.8.7/8.8.7/Linux 2.4.22 IP28) with SMTP id OAA00340;
	Wed, 15 Sep 2004 14:37:18 GMT
Date: Wed, 15 Sep 2004 14:37:18 +0000 (GMT)
From: Peter Fuerst <pf@net.alphadv.de>
To: Florian Lohoff <flo@rfc822.org>
cc: linux-mips@linux-mips.org
Subject: Re: gcc 2.95 patch for IP28
In-Reply-To: <20040914120347.GA12570@paradigm.rfc822.org>
Message-ID: <Pine.LNX.3.96.1040915143518.335A-100000@indigo2.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hi !

> I could build all the stuff.

Hopefully with the updated gcc-patch from Sep 8th, which takes .reorder/
.noreorder settings into account, and seems to do the right thing:
meanwhile i build the kernels only on the I2 itself, and the 2.4-kernel
works flawlessly (as far as i can see).

> the I looks like "INIT:". I cant explain the "ve" which ...

This is most probably "INIT: version..." (Saw "Ive" last in June ;-)

> I see the mentioned problem about 2.6 grinding to a halt too...

Recently i traced this a bit further: from /sbin/init over sys32_execve,
open_exec,... finally an infinite loop in __d_lookup (dcache.c) showed up.
After changing the `hlist_for_each..' macros and local changes it looks like
we get over this place now.  Now, the last output i see, says that a syscall
4085 (__NR_readlink) is started (not the first 4085), some `execve's and
`open's later.
When the frustration has faded, i shall go on tracing.
The strange thing about the halt is, that it happens at an architecture-
independent place and not yet happened on other machines.


with kind regards

pf


On Tue, 14 Sep 2004, Florian Lohoff wrote:

> Date: Tue, 14 Sep 2004 14:03:47 +0200
> From: Florian Lohoff <flo@rfc822.org>
> To: Peter Fuerst <pf@net.alphadv.de>
> Cc: linux-mips@linux-mips.org
> Subject: Re: gcc 2.95 patch for IP28
> 
> 
> Hi Peter,
> 
> On Thu, Sep 02, 2004 at 04:11:25AM +0200, Peter Fuerst wrote:
> > Hello !
> > A patch to gcc 2.95.4 to make it insert the necessary cache barriers
> > in (kernel-)code for SGI Indigo2 R10k (IP28) is available at
> > http://home.alphastar.de/fuerst/download.html
> 
> I could build all the stuff.
> 
> I see the mentioned problem about 2.6 grinding to a halt too. Also i
> have problems getting output on the serial console. its compiled in and
> i see all kernel messages. Once into userspace i only see error messages
> like this:
> 
> [...]
> NET: Registered protocol family 2
> IP: routing cache hash table of 1024 buckets, 16Kbytes
> TCP: Hash tables configured (established 8192 bind 8192)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Sending BOOTP requests . OK
> IP-Config: Got BOOTP answer from 195.71.97.193, my address is 195.71.97.214
> IP-Config: Complete:
>       device=eth0, addr=195.71.97.214, mask=255.255.255.224, gw=195.71.97.193,
>      host=195.71.97.214, domain=home.rfc822.org, nis-domain=(none),
>      bootserver=195.71.97.193, rootserver=195.71.97.193, rootpath=/data/nfsroot/mips
> Looking up port of RPC 100003/2 on 195.71.97.193
> Looking up port of RPC 100005/1 on 195.71.97.193
> VFS: Mounted root (nfs filesystem) readonly.
> Freeing unused kernel memory: 148k freed
> Ivemount: wrong fs type, bad option, bad superblock on tmpfs,
>        or
> 
> the I looks like "INIT:". I cant explain the "ve" which comes some seconds
> 
> Flo
> -- 
> Florian Lohoff                  flo@rfc822.org             +49-171-2280134
>                         Heisenberg may have been here.
> 
