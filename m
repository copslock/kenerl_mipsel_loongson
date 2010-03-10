Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 16:30:47 +0100 (CET)
Received: from mail-pz0-f185.google.com ([209.85.222.185]:33055 "EHLO
        mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492334Ab0CJPan (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Mar 2010 16:30:43 +0100
Received: by pzk15 with SMTP id 15so4676588pzk.21
        for <multiple recipients>; Wed, 10 Mar 2010 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=SQ+lGJkXfLsBokfGNBa8HG9EaBvcmeC0REL3zP7AGOo=;
        b=ieqvcBhObZwTt8k5tQmeQ5H2s2/U8Hm50YZOGVB1jf8t28Vis3wra9c4CBYtpnXR1G
         Pq0OkeEOpiPSAYrA+ILbaNZw8aJI9lvzDtJOT6z7i3nh0DtKsE7zPHQUSUW289GCWu7H
         hOBR9ZN6mEN1U3RGg3hdXjc+v1jQs7ZcqXtdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Em+J66uA+sEgOKw0BIOxRK+riWl+r0CR3tm1ooXjzinzJbFQqwLEjs/U4zTEuXLeXy
         DcJUcYjTP9xLu1Hwz/3wiySfvsTovVE68PZrWY0vDl6hMG2UYMB/daa1AYlqYqWPAnfd
         qGwUPFK8Qzol+wQQjSf3AGce9YLXeAv/5RP0E=
Received: by 10.142.250.19 with SMTP id x19mr522202wfh.23.1268235035282;
        Wed, 10 Mar 2010 07:30:35 -0800 (PST)
Received: from [202.201.12.142] ([202.201.12.142])
        by mx.google.com with ESMTPS id 21sm7513057pzk.4.2010.03.10.07.30.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 07:30:34 -0800 (PST)
Subject: Re: [PATCH 1/3] Loongson-2F: Flush the branch target history such
 as BTB and RAS
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Greg KH <gregkh@suse.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <4B977815.4000703@ru.mvista.com>
References: <cover.1268153722.git.wuzhangjin@gmail.com>
         <d513f16856e499e82f0b4e428c97fe06afb5a426.1268153722.git.wuzhangjin@gmail.com>
         <4B977815.4000703@ru.mvista.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 10 Mar 2010 23:24:04 +0800
Message-ID: <1268234645.19976.1.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Thanks very much for your careful review, will resend a new one later.

Regards,
	Wu Zhangjin

On Wed, 2010-03-10 at 13:44 +0300, Sergei Shtylyov wrote:
[...]
> > diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> > index 3b6da33..b84cfda 100644
> > --- a/arch/mips/include/asm/stackframe.h
> > +++ b/arch/mips/include/asm/stackframe.h
> > @@ -121,6 +121,25 @@
> >  		.endm
> >  #else
> >  		.macro	get_saved_sp	/* Uniprocessor variation */
> > +#ifdef CONFIG_CPU_LOONGSON2F
> > +		/*
> > +		 * Clear BTB(branch target buffer), forbid RAS(row address
> > +		 * strobe)
> 
>    No spaces before the left paren...
> 
> >  to workaround the Out-of-oder Issue in Loongson2F
> > +		 * via it's diagnostic register.
> >   
> 
>    Only "its".
> 
> > +		 */
> > +		move k0, ra
> >   
> 
>    Operands misalined...
> 
> WBR, Sergei
> 
> 
