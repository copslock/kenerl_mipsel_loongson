Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2005 08:34:48 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:8857 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8224894AbVILHe3>; Mon, 12 Sep 2005 08:34:29 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id D55CCC092;
	Mon, 12 Sep 2005 09:34:22 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id 93DDD1BC08A;
	Mon, 12 Sep 2005 09:34:24 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id AA2581A18B4;
	Mon, 12 Sep 2005 09:34:24 +0200 (CEST)
Subject: Re: MIPS SF toolchain
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	David Daney <ddaney@avtrex.com>
Cc:	crossgcc@sources.redhat.com, linux-mips@linux-mips.org
In-Reply-To: <4321A823.8050703@avtrex.com>
References: <1126098584.12696.19.camel@localhost.localdomain>
	 <431F0850.8090804@avtrex.com>
	 <1126168866.25388.11.camel@orionlinux.starfleet.com>
	 <1126179199.25389.20.camel@orionlinux.starfleet.com>
	 <1126182122.25393.27.camel@orionlinux.starfleet.com>
	 <432058C1.80106@avtrex.com>
	 <1126248502.20058.5.camel@localhost.localdomain>
	 <4321A823.8050703@avtrex.com>
Content-Type: multipart/mixed; boundary="=-PxFfBUIefT8W1dpZLbJ+"
Date:	Mon, 12 Sep 2005 09:33:58 +0200
Message-Id: <1126510438.9647.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips


--=-PxFfBUIefT8W1dpZLbJ+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

> Attached is the portions of my patches to glibc-2.3.3 that contain the 
> setjump/longjump hacks.  There are other things in there as well, so you 
> will have to pick and choose as to which parts you want.

Done that :-)

> I did this more as a proof of concept rather than the definitive answer. 
>   There are still some FP instructions being generated but I have not 
> tracked them down yet.

I did. They were in the sysdeps/mips/fpu_control.h
I tested it with busybox and MPlayer and found no SF ins in the
binaries. I run those binaries on kernel which has no FPU emulator.

Versions:
BINUTILS: 2.16.1
GCC:      3.4.4
GLIBC:    2.3.5

Let me know the results, if someone is going to use this patch.

BR,
Matej

--=-PxFfBUIefT8W1dpZLbJ+
Content-Disposition: attachment; filename=glibc-2.3.5-mips-sf.patch.bz2
Content-Type: application/x-bzip; name=glibc-2.3.5-mips-sf.patch.bz2
Content-Transfer-Encoding: base64

H4sIAA0PJEMCA61Wa4/aOBT9nl9xxUwlKCRxCOGRaSukdne0WlUaia72w2plmcQJmcmrsQOD9s/v
dcJkgIbHVAWUJ/fc43OPr/1tFQnImfRWgBdLJrgPWQpyxXdPl1v4wtaRj8eUb+GD76vznK1lwZ8N
L0s+ad2VlLlrmiIrC48Lo+D+ikn1zkxi0ysyIULPM4eEODqZmYkICSHTsbGSSdwDlvpakvlREGFq
zPaVSf4If5Z5/MhT+JCoW+Opvp2XsSyYIaJPIDOIUi8ufY58461WMy6kgCArKv4iCyQEcYZUNE3T
dR3COFp6+tCwDccUW+HzXJhJhAdK4ywNH5Pc8GD3QbaWTiY6GQMZu87YJcQgLx/oE3yv9fv9fUy9
4noGeaeAbhEgE5eMXDL5AXM+B92eDMbQx+ME5nOt5sMUTjWuDdsaAO9N9aLgYSQkL1ALCWsWAxMJ
dDvM6vTuNND6N1GQ+jwAShUbqiShlSQq2HwPD2UcY9W9pwq5ehNhmjxTeB6LY851wdZYmZdMosmt
Uq2zGCNijjljw4fbYEgG8I50wMVvJ+lAl6frf8i/BqVBjhACr3uK2qnw4YVwqwpXIo2mSqTRrBEJ
h3PPpfITkvWyVMii9GTrwERxchQbuD3DwaMY2z4AT3pWFXtrV+r3b3iKrsYqvHJTXO4fjNOpw/xU
7jBXac+6WHCJRqOsfG5sjI6ydfwNCViWO5y4jnPgOOs6Fx8gH7nYcUejVhcPKxcPX1yMwmvoQxGF
r2jQVRfLMgAc56AysXJbwsTT7i6vz0He0+C/y35eyKzgb/CyccoH4oKbkTfSvsrZ4oKzW6BeXW6P
qlbgNC5vBx+/Adw+z3P6BqjRWSj7Leo5FdTxpMH6qPmsCvrw+e5UrTZqzl2TK/dedHUmgyn0ndkA
XdwurGoEV9Wsoj8+pYSCsa+GmdQwl42+EyaIUjT2FsKfa3zYtQLsWu9I3bUUv4/F6UI13e+4TAuc
VvWaG4VICNQEhihAOt9LjjPN31uwZFmkdR9Qc19NyCrfoJn5l9pckJcURymLLDZWv3SxbkHeW7Qt
sGyXWK4za21305lyFB4tu3KU3OZcVbBMlSjYdeo+1mSgElVgUhbRspScUuh2sdiZX11SuviD0l5t
BqXwV6b2UdXehnm4yRLRbjewYoW/Ydj0drCwyYqd3OdMdIPPo5QD/f3hL3r/27fPf3e9TU8xEoki
0BjjwBf4l95R7KItVh7EYnQTjM6JBcdTa/6j54u9543hUIwvPGC4EzwYMgg1BXDFkLgJLPOd4fgz
tvn0B9n37u+0/wEGGQxQAwsAAA==


--=-PxFfBUIefT8W1dpZLbJ+--
