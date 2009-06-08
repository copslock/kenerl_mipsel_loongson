Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 17:38:59 +0100 (WEST)
Received: from sitar.i-cable.com ([203.83.115.100]:37148 "HELO
	sitar.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20021722AbZFHQix (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2009 17:38:53 +0100
Received: (qmail 3485 invoked by uid 508); 8 Jun 2009 16:38:44 -0000
Received: from 203.83.114.122 by sitar (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/8786.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.095057 secs); 08 Jun 2009 16:38:44 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 8 Jun 2009 16:38:43 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n58GcTaa018289;
	Tue, 9 Jun 2009 00:38:29 +0800 (CST)
Date:	Tue, 9 Jun 2009 00:38:22 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-PATCH-v3 00/25] loongson-based machines support
Message-ID: <20090608163821.GC16785@adriano.hkcable.com.hk>
Mail-Followup-To: wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Wu Zhangjin <wuzj@lemote.com>,
	Yan Hua <yanh@lemote.com>, Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>, Erwan Lerale <erwan@thiscow.com>
References: <cover.1244119295.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <cover.1244119295.git.wuzj@lemote.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

First of all, sorry for late comment and thanks to Zhangjin for the great w=
ork.

However, I have some suggestions.

On 20:58 Thu 04 Jun     , wuzhangjin@gmail.com wrote:
> Wu Zhangjin (25):
>   add vmlinux.32 in .gitignore
>   fix-warning: incompatible argument type of pci_fixup_irqs
>   fix-warning: incompatible argument type of virt_to_phys

I think these 3 patch could be submitted separately, since they are not qui=
te
related to Loongson.

>   change the naming methods

In this patch, I found function get_system_type() still returns wrong name,
"lemote-fulong". In later patches, I found this string was changed to a mac=
ro,
MACH_NAME. Then, the function becomes more complicated and/or sophisticated,
because of the addition of machname array.

I don't know if this is an established or widely accepted policy, but
intuitively, at the very least IMHO, a series of patches should only provide
one correct implementation of a particular function, not provide one wrong
function then override it with a correct one.

If I were you, I would do a 'git reset' first.
Then 'git add' and/or 'git rm' some files which contain similar changes.
Then 'git commit'.
Repeat the last two steps, until all the changes have been committed.

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkotPn0ACgkQvFHICB5OKXOCxQCdECSuJgjGezSTwiRM21ZvTsIy
hLgAn3v1NcLZnmiqK1tqc5rUPsZ78w66
=dvQT
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
