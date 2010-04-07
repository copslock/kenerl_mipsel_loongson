Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 15:04:15 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:50442 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491181Ab0DGNEL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 15:04:11 +0200
Received: by pzk16 with SMTP id 16so871892pzk.22
        for <multiple recipients>; Wed, 07 Apr 2010 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=1XSstEOTL5ZwyO3JzhtBCUDx32Xs8wDMQ7JEBVH1HHc=;
        b=eeDiLrBEUMAkcw65df2vw5oiwJWt1XA4JeAfok/VEzlo7kknZfPKKl+ZvCYfsAmL5J
         rNOoU2w59SRMoV+Ls/jeaoXVBmwJnaQ+g0Nk4BYayhmmow5uXZo73qf+dxMKraJjM8bG
         nVIaTl0GLsqbJGPwd2L//VKGzJapUbtCetW+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=cHQxmlViF1XjQN3y8kmkuBtvjkd+CAce9x/Y1CSrZQY8tZWTEOxO/CgdRqYQ9S0LV8
         Y89BdxlGvgx0qJdeTFtV4RCnJaaEQqgvwrkm7SM7NpqdXQNLAN1MlvkOs0A+h5UZVKgv
         j5wP8L6lrv2H0RurrOB+4DyAjkUL5vaIpLw1o=
Received: by 10.140.55.12 with SMTP id d12mr7188491rva.208.1270645443505;
        Wed, 07 Apr 2010 06:04:03 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm1373651pzk.9.2010.04.07.06.03.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 06:04:01 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] Loongson-2F: Fixup of problems introduced by
 -mfix-loongson2f-jump of binutils 2.20.1
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>
In-Reply-To: <20100317150207.GB4554@linux-mips.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
         <169f2daa3d623fe56c5b0be30feeda10bc79a478.1268453720.git.wuzhangjin@gmail.com>
         <20100317150207.GB4554@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 07 Apr 2010 20:57:03 +0800
Message-ID: <1270645023.22802.2.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-03-17 at 16:02 +0100, Ralf Baechle wrote:
> On Sat, Mar 13, 2010 at 12:34:17PM +0800, Wu Zhangjin wrote:
> 
> > -	/* reboot via jumping to boot base address */
> > +	/* reboot via jumping to boot base address
> > +	 *
> > +	 * ".set noat" and ".set at" are used to ensure the address not break
> > +	 * by the -mfix-loongson2f-jump option provided by binutils 2.20.1 (or
> > +	 * higher version) which try to change the jumping address to "addr &
> > +	 * 0xcfffffff" via the at($1) register, this is totally wrong for
> > +	 * 0xbfc00000 (LOONGSON_BOOT_BASE).
> > +	 */
> > +	__asm__ __volatile__(".set noat\n");
> >  	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
> > +	__asm__ __volatile__(".set at\n");
> 
> Ouch.  This is fragile and totally puts the kernels fate at the mercy of
> gcc and the ioremap_nocache() implementation.  GCC might emit a .set noat
> at any time.  Something like
> 
> void loongson_restart(char *command)
> {
> 	void (*func)(void);
> 
> 	/* do preparation for reboot */
> 	mach_prepare_reboot();
> 
> 	/* reboot via jumping to boot base address */
> 	func = (void *) ioremap_nocache(LOONGSON_BOOT_BASE, 4);
> 
> 	__asm__ __volatile__(
> 	"	.set	noat						\n"
> 	"	jr	%[func]						\n"
> 	"	.set	at						\n"
> 	: /* No outputs */
> 	: [func] "r" (func));
> }
> 
> should be safe against -mfix-loongson2f-jump I think.

Thanks very much, will apply it in the revision of this patch.

Regards,
	Wu Zhangjin
