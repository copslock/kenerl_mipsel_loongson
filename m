Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g17ArMH19676
	for linux-mips-outgoing; Thu, 7 Feb 2002 02:53:22 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g17ArGA19673;
	Thu, 7 Feb 2002 02:53:17 -0800
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g17Ar8a04663;
	Thu, 7 Feb 2002 11:53:08 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.1/8.12.1/Debian -5) with ESMTP id g17Ar247002552;
	Thu, 7 Feb 2002 11:53:03 +0100
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.34 #1 (Debian))
	id 16YWGa-0000oD-00; Wed, 06 Feb 2002 18:53:56 +0100
Date: Wed, 6 Feb 2002 18:53:56 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Kunihiko IMAI <kimai@laser5.co.jp>
cc: Ralf Baechle <ralf@oss.sgi.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: One bug fixed, another found?
In-Reply-To: <m3u1suzou6.wl@bak.d2.dion.ne.jp>
Message-ID: <Pine.LNX.4.21.0202061834540.2040-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 6 Feb 2002, Kunihiko IMAI wrote:

> Today I compiled kernel with __wake_up_common not inline function, and
> got same result.  And also made kgdb version.  I found that the line
> 	p = curr->task;
> made the memory violation.

If you're using binutils 2.9.5, upgrade to a newer version or use the
workaround I've posted about one month ago to this list
(Subject: binutils workaround), this should fix your bug.

Actually list_for_each fails to detect the end of the q->task_list as it
is not properly initialized by binutils. This happens when kswapd wakes
up, it calls wake_up on the kwapd_wait wait queue which is a global
variable initialized at compile time (mm/vmscan.c).

Ralf, could you forbid compiling with this version of binutils, as I've
already answered 3 times to the same bug :)
gcc < 2.91 seem to be alread forbidden in init.c ...

regards,
Vivien.
