Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53A8tnC026331
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 3 Jun 2002 03:08:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g53A8tQV026330
	for linux-mips-outgoing; Mon, 3 Jun 2002 03:08:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g53A8pnC026327
	for <linux-mips@oss.sgi.com>; Mon, 3 Jun 2002 03:08:51 -0700
Received: from aihana.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id DAA05135
	for <linux-mips@oss.sgi.com>; Mon, 3 Jun 2002 03:09:04 -0700
Date: Mon, 03 Jun 2002 19:09:18 +0900
Message-ID: <m3d6v8znap.wl@aihana>
From: Takeshi AIHANA <takeshi_aihana@montavista.co.jp>
To: linux-mips@oss.sgi.com
Subject: Re: (Re-Send) shmctl() returns corrupt value on pb1000.
In-Reply-To: <20020531.112847.74756483.nemoto@toshiba-tops.co.jp>
References: <1022757017.1045.47.camel@aihana>
	<20020530.211902.102583216.nemoto@toshiba-tops.co.jp>
	<1022763778.1046.71.camel@aihana>
	<20020531.112847.74756483.nemoto@toshiba-tops.co.jp>
User-Agent: Wanderlust/2.8.1 (Something) SEMI/1.14.3 (Ushinoya) FLIM/1.14.3
 (=?ISO-8859-1?Q?Unebigory=F2mae?=) APEL/10.3 MULE XEmacs/21.1 (patch 14)
 (Cuyahoga Valley) (i386-redhat-linux)
Organization: MontaVista Software Japan
MIME-Version: 1.0 (generated by SEMI 1.14.3 - "Ushinoya")
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hello,

At Fri, 31 May 2002 11:28:47 +0900 (JST),
Atsushi Nemoto wrote:
> takeshi_aihana> Is there any inconsistents on those conditions?
> 
> AFAIK, Yes.  For example, look struct ipc_perm in bits/ipc.h and
> struct ipc64_perm in asm-mips/ipcbuf.h (not struct ipc_perm in
> linux/ipc.h which is obsolete).

I did to check both bits/shm.h (glibc-2.2.3), bits/shm.h (glibc-2.2.4) and asm-mips/shmbuf.h
for calling shmctl();
There are any differences 'struct shmid_ds' between glibc-2.2.3 and 2.2.4 that I saw.
However, I do not think those diffs are caused this problem.
Because the 'shm_segsz` which a member of this will be allocated on same location even if the follows members
behind 'shm_segsz' are changed; i.e. it will have same value as 'shm_segsz' on both different structure.
Is this right?

> If you can.  Please do not forget rebuilding all applications which
> including these headers.  If you want to stay in 2.2.3, you will have
> to modify your kernel headers according to the libc headers.

I understood. It might to solve this problem as the most simple way.

Thank you for your advice.
Regards.

---
(TAKESHI - MontaVista Software)
