Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UD2onC002865
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 06:02:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UD2oUb002864
	for linux-mips-outgoing; Thu, 30 May 2002 06:02:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UD2jnC002840
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 06:02:45 -0700
Received: from aihana (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id GAA22734
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 06:02:59 -0700
Subject: Re: (Re-Send) shmctl() returns corrupt value on pb1000.
From: Takeshi Aihana <takeshi_aihana@montavista.co.jp>
To: linux-mips@oss.sgi.com
In-Reply-To: <20020530.211902.102583216.nemoto@toshiba-tops.co.jp>
References: <1022757017.1045.47.camel@aihana> 
	<20020530.211902.102583216.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution/1.0.5-build 20020511 
Date: 30 May 2002 22:02:57 +0900
Message-Id: <1022763778.1046.71.camel@aihana>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

> >>>>> On 30 May 2002 20:10:16 +0900, Takeshi Aihana <takeshi_aihana@montavista.co.jp> said:
> takeshi_aihana> I have a problem now about return the segment size of
> takeshi_aihana> shared memory from shmctl() func.
> 
> What version of libc are you using?  It seems your kernel headers and
> libc headers are inconsistent.

(A) The version of glibc on x86 is 2.2.4/kernel-2.4.9.
(B) The version of glibc on pb1000 is 2.2.3/kernel-2.4.17.

Is there any inconsistents on those conditions?
Should be update to 2.2.4 on pb1000?

> Please look structures in libc's /usr/include/bits/{ipc,sem,shm,msg}.h
> and kernel's include/asm-mips/{ipc,sem,shm,msg}buf.h carefully.

OK. I will do carefully. 
It looks like to not any diffs I should observe on both files, now.

Thank you for your help.

---
(TAKESHI - MontaVista Software Japan)
