Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 16:21:32 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.184]:9332 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037551AbXCEQV1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 16:21:27 +0000
Received: by mu-out-0910.google.com with SMTP id w1so1638341mue
        for <linux-mips@linux-mips.org>; Mon, 05 Mar 2007 08:21:26 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uYO8OqreABaEP948N2RCp40TZUvnGhw3EnCIdSDszLyDAp5wVv11Fwj64HXGbR6ddZhROsu8c6QJGldzGLCtEAEmoOU0f3uLX7E7M9NB82r8tBON1ccITPKnDlBQDjq2G/BulRyweFWmOmAoot8+juWrIgXjbuEjmZ+zq6FAusQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PBOXlg2b02xbLIH1hIs44zXSBPQNZyLk0eozr3oRxOfYMJK0kVBCuiVOj+se7oZ02wB0FdotKTDM2TpIzZylQVKtAuMgTee+DhPUMYjMsy2qfKgJbdl10ldRqADEiuqD5UiJPG22T40CHcVavrMdhpPD8uv+X752pInKSw1Y2qs=
Received: by 10.82.177.3 with SMTP id z3mr5306226bue.1173111685885;
        Mon, 05 Mar 2007 08:21:25 -0800 (PST)
Received: by 10.82.178.13 with HTTP; Mon, 5 Mar 2007 08:21:25 -0800 (PST)
Message-ID: <b115cb5f0703050821v50667580oa8dfa26412c05b08@mail.gmail.com>
Date:	Mon, 5 Mar 2007 21:51:25 +0530
From:	"Rajat Jain" <rajat.noida.india@gmail.com>
To:	"Alexander Sirotkin" <demiourgos@gmail.com>
Subject: Re: 0 function size
Cc:	linux-mips@linux-mips.org
In-Reply-To: <c4357ccd0703050619r6b5a7452j6b582687bf1794d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c4357ccd0703050619r6b5a7452j6b582687bf1794d3@mail.gmail.com>
Return-Path: <rajat.noida.india@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rajat.noida.india@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/5/07, Alexander Sirotkin <demiourgos@gmail.com> wrote:
> I'm trying to see the function sizes for some object file compiled for
> MIPS. On x86 one can use objdump  or readelf to see the sizes, however
> for same weird reason on MIPS these routines show 0 for all functions.
>
> Any idea what I'm missing ?
>

Are you using a native compiler or a cross compiler?

If you are using a cross compiler, then you need to use the "cross
compiler" version of objdump / readelf  utilities as well. For
instance if you are using mips-linux-gcc to compile, then you need
mips-linux-readelf / mips-linux-objdump etc.

Thanks,

Rajat
