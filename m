Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2007 17:09:24 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:62712 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021545AbXCURJT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2007 17:09:19 +0000
Received: from localhost (p8098-ipad02funabasi.chiba.ocn.ne.jp [61.214.26.98])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7DA2B2B3F; Thu, 22 Mar 2007 02:07:58 +0900 (JST)
Date:	Thu, 22 Mar 2007 02:07:56 +0900 (JST)
Message-Id: <20070322.020756.25910272.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	maillist@jg555.com, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: Building 64 bit kernel on Cobalt
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80703190317h80cfd53x4acee55f2c757907@mail.gmail.com>
References: <20070319.150705.100740532.nemoto@toshiba-tops.co.jp>
	<cda58cb80703190308k4e57e194u56dca25b063646b6@mail.gmail.com>
	<cda58cb80703190317h80cfd53x4acee55f2c757907@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 19 Mar 2007 11:17:48 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > > You are using CONFIG_BUILD_ELF64=y and CKSEG0 load address.
> > > This combination does not work.  Please refer these threads:
> > >
> >
> > Thanks Atsushi for sorting this out. It's a bit sad to get these type
> > of information after so many email echanges...
> >
> 
> BTW, how this config has ever worked for a 2.6.19 kernel ? I don't see
> why using __pa() instead of CPHYSADDR() breaks this config...

2.6.19:
	CPHYSADDR(0xffffffff80000000) == 0
	__pa(0xffffffff80000000) == 0xffffffff80000000 - 0x9800000000000000
2.6.20 (CONFIG_BUILD_ELF64=y):
	CPHYSADDR(0xffffffff80000000) == 0
	__pa(0xffffffff80000000) == 0xffffffff80000000 - 0x9800000000000000
2.6.20 (CONFIG_BUILD_ELF64=n):
	CPHYSADDR(0xffffffff80000000) == 0
	__pa(0xffffffff80000000) == 0

The reason is obvious, isn't it? ;)

---
Atsushi Nemoto
