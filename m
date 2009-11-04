Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 12:04:27 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:45979 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493132AbZKDLEV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 12:04:21 +0100
Received: by pwi11 with SMTP id 11so3205185pwi.24
        for <multiple recipients>; Wed, 04 Nov 2009 03:04:12 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=3pF2SYNc2XCYGPbbl3QnmY0Kh75LZTXK79YZXqTwhWI=;
        b=tiCFrE7iA2LwfA0ppuNoyGBf2OlFPTBDPHwDlhMS3OVT+tAecoMD31LdYap2a2pgwR
         pQszf+3gd+eWAQ65J0nJ+mvcxT0qg9RlvSmIBe6qaY4XZBrOdlE1EO+5uwUy404kdL4y
         g23so0pWTKIsHTGv0HtPiugpHVePbpCgsRY+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=qBsbPrOb+PU2iq/3I8GFPP7bBADL3liZzT3E8wp6ofilvMdYUAeGWy7+OnK/uDrr2X
         eSfRj2EqG8/EjEMrbGNhMtczMbHFDev/ikYcs15NMrcGgBHA9C18BaTq/HFye3dFrhnL
         qGjlcauvC+d1/TmNkNN+0uFvmzZJquP/+O4iE=
Received: by 10.114.252.2 with SMTP id z2mr1759892wah.156.1257332652369;
        Wed, 04 Nov 2009 03:04:12 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm554436pzk.2.2009.11.04.03.04.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 03:04:11 -0800 (PST)
Subject: Re: [PATCH -queue v0 1/6] [loongson] add basic loongson-2f support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
In-Reply-To: <m3iqdqtwgk.fsf@anduin.mandriva.com>
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	 <a1bd2470bc465e505281c761adca8c2287d102b3.1257325319.git.wuzhangjin@gmail.com>
	 <m3iqdqtwgk.fsf@anduin.mandriva.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 04 Nov 2009 19:04:12 +0800
Message-ID: <1257332652.8716.5.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2009-11-04 at 11:28 +0100, Arnaud Patard wrote:
[...]
> > +
> > +config CPU_LOONGSON2F
> > +	bool "Loongson 2F"
> > +	depends on SYS_HAS_CPU_LOONGSON2F
> > +	select CPU_LOONGSON2
> > +	help
> > +	  The Loongson 2F processor implements the MIPS III instruction set
> > +	  with many extensions.
> > +
> > +	  Loongson2F have built-in DDR2 and PCIX controller. The PCIX controller
> > +	  have a similar programming interface with FPGA northbridge used in
> > +	  Loongson2E.
> > +
> 
> Small question : Why don't you restrict to 64bit kernels only ? From
> what I remember from some discussions with ST, trying to use a 32-bit
> kernel on 2f is a nice way to get troubles. It would be better imho to
> forbid such a configuration. As a side effect, this will remove all
> 'defined(CONFIG_64BIT)' parts of your #ifdef tests. 
> 

It's hard to make such a decision ;) Perhaps some guys want to play with
the 32bit version.

Regards,
	Wu Zhangjin
