Received:  by oss.sgi.com id <S554375AbRB0RvM>;
	Tue, 27 Feb 2001 09:51:12 -0800
Received: from u-53-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.53]:48371
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S554372AbRB0RvB>; Tue, 27 Feb 2001 09:51:01 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1RHo4201646;
	Tue, 27 Feb 2001 18:50:04 +0100
Date:   Tue, 27 Feb 2001 18:50:04 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Fabrice Bellard <bellard@email.enst.fr>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Serious bug in uaccess.h
Message-ID: <20010227185004.C963@bacchus.dhis.org>
References: <Pine.GSO.4.02.10102271534030.22188-100000@donjuan.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.02.10102271534030.22188-100000@donjuan.enst.fr>; from bellard@email.enst.fr on Tue, Feb 27, 2001 at 03:40:11PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Feb 27, 2001 at 03:40:11PM +0100, Fabrice Bellard wrote:

> #define copy_from_user(to,from,n) ({ \
> 	register void *__cu_to asm("$4"); \
> 	register const void *__cu_from asm("$5"); \
> 	register long __cu_len asm("$6"); \
> 	\
> 	__cu_to = (to); \
> 	__cu_from = (from); \
> 	__cu_len = (n); \
> 	if (access_ok(VERIFY_READ, __cu_from, __cu_len)) \
> 		__asm__ __volatile__( \
> 			".set\tnoreorder\n\t" \
> 			__MODULE_JAL(__copy_user) \
> ...
> 
> But I am not sure that it is always correct. Any idea ?

While this should be correct - it was my original attempt also - it was
misscompiled by whatever C compiler I was using at that time.  If
egcs 1.1.2 and gcc 2.95 both compile this construct right now then I'd
say go for it.

  Ralf
