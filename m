Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 08:28:26 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.239]:42140 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038898AbXBMI2W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 08:28:22 +0000
Received: by qb-out-0506.google.com with SMTP id e12so714720qba
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 00:27:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H2he077f/C63Emob5alCc2T3DWI4iycOEKTca4rNVrq1qi4dMFNHyGkt41B4vTw9YsoWQ/cLi9xxvVvVHSeYCExs7jX6apBMEWBqlaPrNkVenAptqWoBW9g3pfcpY7wtcZqf5F31RHDkM6s+KUGCHevNrFZRTc6dT4milY/B8Ds=
Received: by 10.115.47.1 with SMTP id z1mr7469474waj.1171355240847;
        Tue, 13 Feb 2007 00:27:20 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Tue, 13 Feb 2007 00:27:20 -0800 (PST)
Message-ID: <cda58cb80702130027o1ebec149ib25090881f7ac6a1@mail.gmail.com>
Date:	Tue, 13 Feb 2007 09:27:20 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: struct sigcontext for N32 userland
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070213.005113.89067116.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070213.005113.89067116.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/12/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> If N32 userland refers asm-mips/sigcontext.h, struct sigcontext cause
> some troubles.
>
> #if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
>
> struct sigcontext {
>         unsigned long   sc_regs[32];
> ...
>
>
> The kernel use 64-bit for sc_regs[0], and both N32/N64 userland
> expects it was 64-bit.  But size of 'long' on N32 is actually 32-bit.
> So this definition make some confusion.
>
> glibc has its own sigcontext.h and it uses 'unsigned long long' for
> sc_regs, so no real problem with glibc.
>

Just out of curiosity, for what purpose does the glibc use sigcontext ?


-- 
               Franck
