Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 06:27:22 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:39124 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491846AbZJ2F1P (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 06:27:15 +0100
Received: by pxi26 with SMTP id 26so1062263pxi.22
        for <multiple recipients>; Wed, 28 Oct 2009 22:27:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=3EQlFBhYeN0s0qv05srbDXZDFH/jqSRCUTRBOoUGiso=;
        b=a5vPk310JAXe6TE/MM7DkGjaM67K8xQsoAaBF9u+gKq5i3fcUsht3GpyzmHZqDi6Xq
         neebEp7gRHSLyhvKu90entwqAlDrLZIAV8+mK51zM+m55t++JBd/4IIQzwOizzW1ckW/
         No5FfULICDHEhNZcElOFwRc2luZNFfzprrnXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=XnxYqKkQbNGlIr3lf8LSg+lBxuGaM2+dq9yidkZGh4+mXCHE2mbYxqM7T5IoXM4N1I
         l4YqY1M01sIl8zSYACInoKU6FcBShwg7u/mQ9PC+8yQDSNE3gAFF1v1vLHyutKUKVCGA
         wNc1ccnZ5+czcVphMeHl06HoI0znvHC8WfnB4=
Received: by 10.114.253.14 with SMTP id a14mr5119349wai.160.1256794028644;
        Wed, 28 Oct 2009 22:27:08 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm168316pzk.4.2009.10.28.22.27.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 22:27:07 -0700 (PDT)
Subject: Re: [PATCH -sfr.git] MIPS: zboot: indent the nop instruction in
 delay slot
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Robert Richter <robert.richter@amd.com>, chenj@lemote.com
In-Reply-To: <alpine.LFD.2.00.0910290306490.9323@eddie.linux-mips.org>
References: <1256782252-2240-1-git-send-email-wuzhangjin@gmail.com>
	 <alpine.LFD.2.00.0910290306490.9323@eddie.linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 29 Oct 2009 13:26:57 +0800
Message-Id: <1256794017.6448.22.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 2009-10-29 at 03:12 +0000, Maciej W. Rozycki wrote:
> On Thu, 29 Oct 2009, Wu Zhangjin wrote:
> 
> > diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
> > index e23f25e..29080f4 100644
> > --- a/arch/mips/boot/compressed/head.S
> > +++ b/arch/mips/boot/compressed/head.S
> > @@ -38,7 +38,7 @@ start:
> >  	PTR_LA	ra, 2f
> >  	PTR_LA	k0, decompress_kernel
> >  	jr	k0
> > -	nop
> > +	 nop
> >  2:
> >  	move	a0, s0
> >  	move	a1, s1
> > @@ -46,7 +46,7 @@ start:
> >  	move	a3, s3
> >  	PTR_LI	k0, KERNEL_ENTRY
> >  	jr	k0
> > -	nop
> > +	 nop
> >  3:
> >  	b 3b

need to add one nop here.

> >  	END(start)
> 
>  This piece of code looks unsafe to me.  I'm not sure which tree this is 
> against and certainly I don't have a local copy of the file,

This is against the of mips-for-linux-next branh of Ralf's
http://www.linux-mips.org/git?p=upstream-sfr.git;a=summary

>  but based on 
> the manual delay slot scheduling this is built with .set noreorder in 
> effect

Yes, there is exactly a ".set noreorder" there:

arch/mips/boot/compressed/head.S:
[...]
 17 
 18         .set noreorder
 19         .cprestore
 20         LEAF(start)
 21 start:
 22         /* Save boot rom start args */
 23         move    s0, a0
 24         move    s1, a1
 25         move    s2, a2
 26         move    s3, a3
 27 
 28         /* Clear BSS */
[...]

>  and as such the function lacks a delay slot fill for the trailing 
> branch (which is also ill-formatted).

A new version will be sent out, thanks!

Regards,
	Wu Zhangjin
