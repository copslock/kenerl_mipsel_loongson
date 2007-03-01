Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2007 09:40:25 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.238]:64617 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039230AbXCAJkU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Mar 2007 09:40:20 +0000
Received: by qb-out-0506.google.com with SMTP id e12so331123qba
        for <linux-mips@linux-mips.org>; Thu, 01 Mar 2007 01:39:18 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qxorT7Qdq/auhwfhrNAmnMiemK6JWTnRASDei26Lsa2pF3M3NBTDhE7lBLdFmUyksaRjPaGVNztmEMi+VQel7iBnAXC/xlNeAJPGDLRTv7xZ7+y2RXwWrdPC0P/5rHmVhfdsH57cUUc2DXeB1LpMUkXvMrc4JlqNe+NmwizyIq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YtGWX43mxixUhBLw6pNj1dli56pys95vfDucLR27hvP9aaM4Tz9OBrQZHB8ellWeKS85azYSM3PX7W4xIYZY4qz5xVqy0hphsiYBbED8Lt1Ot4s8gQELl+vuMb2FdILl16Ivb/ARKE4vCsKz9JHpk/xCuQ7SeWZJp8DgQhzj5jI=
Received: by 10.114.13.1 with SMTP id 1mr86193wam.1172741948570;
        Thu, 01 Mar 2007 01:39:08 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 1 Mar 2007 01:39:08 -0800 (PST)
Message-ID: <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
Date:	Thu, 1 Mar 2007 10:39:08 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	Kumba <kumba@gentoo.org>
Subject: Re: IP32 prom crashes due to __pa() funkiness
Cc:	"Linux MIPS List" <linux-mips@linux-mips.org>
In-Reply-To: <45D8B070.7070405@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45D8B070.7070405@gentoo.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Kumba wrote:
>
> Initially, booting a straight git checkout on an IP32 will cause it to
> prom crash, usually somewhere in between init_bootmem() and
> init_bootmem_core().  I bisected git to trace this back to one of the
> inital __pa() introduction patches from commit d4df6d4 (get ride of
> CPHYSADDR()).  It actually appears that the actual commit that broke
> things was 620a480 (Make __pa() aware of XKPHYS/CKSEG0 address mix for
> 64 bit kernels).
>
> The [short-term] fix highlighted by Ilya is to make __pa()
> unconditionally be defined to "((unsigned long)(x) < CKSEG0 ?
> PAGE_OFFSET : CKSEG0)"; Discovered by building IP32 with
> CONFIG_BUILD_ELF64=n.
>

Well, it means that you previously used CONFIG_BUILD_ELF64=y (this
implied that PAGE_OFFSET is in XKPHYS) whereas your kernel has CKSEG
load address (symbols need PAGE_OFFSET in CKSEG for address
translation).

So the question is why can't you use CONFIG_BUILD_ELF64=n (and
reagarding the current definition of CONFIG_BUILD_ELF64).

> Normally, this shouldn't be possible, as CONFIG_BUILD_ELF64=n was
> originally only allowed by using the old o64 hack, which has
> subsequently died and been replaced with the newer -msym32 form.  As far
> as I know, CONFIG_BUILD_ELF64 is apparently supposed to be removed at
> some point in the future, since I believe it existed only for quirky

It makes me think that I posted a patch for that a couple of weeks ago:

http://marc.theaimsgroup.com/?l=linux-mips&m=117154480225936&w=2
http://marc.theaimsgroup.com/?l=linux-mips&m=117154480126802&w=2
http://marc.theaimsgroup.com/?l=linux-mips&m=117154587014827&w=2

Basically this patch removes CONFIG_BUILD_ELF64 and makes Kbuild to use
'-msym32' switch if you really need it. Kbuild makes its choice according
the load address of your kernel image.

Could you give it a try ? This patch was based on 2.6.20 but it should
apply fine on a 2.6.21-rc[12].
-- 
               Franck
