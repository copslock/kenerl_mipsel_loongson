Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 15:25:47 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.201]:10817 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133549AbWAZPZ3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 15:25:29 +0000
Received: by zproxy.gmail.com with SMTP id l8so388174nzf
        for <linux-mips@linux-mips.org>; Thu, 26 Jan 2006 07:29:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IgZfLke8eXhPKTX5c+oqkdE497K6MwQ5uhqEusRXu7hukn/CU0ldVHcMnsweS84auPrmOV0Y/DCx4yoe2J10yaBA7WiH8wFNZqGaJVdnD4ACtu11GFj0ClcXG4OiDON+htsglITF85UgKmW57lf/vbYGE0T7pob0v4lU5goZ8Tg=
Received: by 10.37.13.2 with SMTP id q2mr1550055nzi;
        Thu, 26 Jan 2006 07:29:59 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 26 Jan 2006 07:29:58 -0800 (PST)
Message-ID: <cda58cb80601260729y69ba67ecq@mail.gmail.com>
Date:	Thu, 26 Jan 2006 16:29:58 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	linux-mips@linux-mips.org
In-Reply-To: <005101c6228c$6ebfb0a0$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <cda58cb80601250534r5f464fd1v@mail.gmail.com>
	 <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org>
	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
	 <20060125150404.GF3454@linux-mips.org>
	 <cda58cb80601251003m6ba4379w@mail.gmail.com>
	 <43D7C050.5090607@mips.com>
	 <cda58cb80601260702wf781e70l@mail.gmail.com>
	 <005101c6228c$6ebfb0a0$10eca8c0@grendel>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/26, Kevin D. Kissell <kevink@mips.com>:
> Could you please post your mipsel-linux-gcc -v output?   It might help.

sure,

Reading specs from /usr/lib/gcc/mipsel-linux/3.4.4/specs
Configured with:
/var/tmp/releasetool-rpm.tmp/bank-20051114-1545/B-i386-linux-rpm/rpmbuild/BUILD/mipssde-6.03.01/configure
--prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info
--disable-gdbtk --enable-languages=c
--with-local-prefix=/mipsel-linux/local --disable-multilib
--disable-shared --enable-static --disable-threads
--target=mipsel-linux --host=i386-linux --build=i386-linux
Thread model: single
gcc version 3.4.4 mipssde-6.03.01-20051114

> I've never tried building Linux with any of the Sc/Sd/SmartMIPS options,
> so I really don't know what you could be experiencing.  One thought that
> comes to mind is that the -march=4ksd option may be treated as a hint to
> generate compact code (for smart cards) in a way that -march=mips32r2

Yes, that's why I tried to pass -mips16e option.

> is not.  I'll ask around...
>

Thanks
--
               Franck
