Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 20:39:05 +0100 (BST)
Received: from [IPv6:::ffff:195.197.172.116] ([IPv6:::ffff:195.197.172.116]:46827
	"EHLO gw02.mail.saunalahti.fi") by linux-mips.org with ESMTP
	id <S8224990AbUHRTjA>; Wed, 18 Aug 2004 20:39:00 +0100
Received: from tori.tal.org (tori.tal.org [195.16.220.82])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 612D417D44;
	Wed, 18 Aug 2004 22:38:48 +0300 (EEST)
Date: Wed, 18 Aug 2004 22:41:09 +0300 (EEST)
From: Kaj-Michael Lang <milang@tal.org>
To: Maxim Zaitsev <zaitsev@ukl.uni-freiburg.de>
Cc: linux-mips@linux-mips.org
Subject: Re: O2 arcboot 32-bit kernel boot fix
In-Reply-To: <200408181752.35073.zaitsev@ukl.uni-freiburg.de>
Message-ID: <Pine.LNX.4.58.0408182240280.12942@tori.tal.org>
References: <001401c483b8$51d289f0$54dc10c3@amos> <003901c48530$577b4f80$54dc10c3@amos>
 <200408181646.53698.maksik@gmx.co.uk> <200408181752.35073.zaitsev@ukl.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

On Wed, 18 Aug 2004, Maxim Zaitsev wrote:

> Ha!!! It works!!! Well, only 32-bit kernels work, but anyways, sorry for
> trouble. I must have tested it before bothering you with stupid questions...
>
> With regard to booting a 64-bit kernel it all looks OK, loading works and what
> I see in the end is:

Don't use vmlinux.64, use plain vmlinux.. that works for me.

-- 
Kaj-Michael Lang, Turku, Finland
milang@tal.org http://www.tal.org
