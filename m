Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6B8QX428334
	for linux-mips-outgoing; Wed, 11 Jul 2001 01:26:33 -0700
Received: from t111.niisi.ras.ru (IDENT:root@t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6B8QUV28329
	for <linux-mips@oss.sgi.com>; Wed, 11 Jul 2001 01:26:30 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id MAA09915;
	Wed, 11 Jul 2001 12:26:53 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id MAA00516; Wed, 11 Jul 2001 12:25:26 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id MAA03741; Wed, 11 Jul 2001 12:23:27 +0400 (MSD)
Message-ID: <3B4C114D.8ECC3997@niisi.msk.ru>
Date: Wed, 11 Jul 2001 12:41:49 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Marc Karasek <marc_karasek@ivivity.com>
CC: "H . J . Lu" <hjl@lucon.org>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: MIPS Cross Compiler Tools
References: <25369470B6F0D41194820002B328BDD27D22@ATLOPS> 
		<20010710094627.D19026@lucon.org> <994784701.9191.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Marc Karasek wrote:
> 
> This is for an embedded platform, with no harddrive.  So I will need to
> use things like busybox, etc.  I just need the headers & libs.  So far I
> have only been able to find glibc-2.2.2 from deb in an rpm format.
> Could not get this to install in /usr/local/mips-linux/...  properly.  I
> guess what I am really looking for is a tgz file of the libs/headers.

I've got cross mipseb libc as rpm for a long time. Sure, it's installed
in /usr/mips-linux and has noarch format. The SPEC file just picks up
mips.rpm and builds noarch with /usr/mips-linux as root. Unfortunately,
I haven't a place where I may upload rpm for public access. If it's what
you need I may send the spec file by request.

Regards,
Gleb.
