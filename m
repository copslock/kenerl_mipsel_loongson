Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2007 03:58:54 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.181]:39736 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024767AbXKUD6p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Nov 2007 03:58:45 +0000
Received: by wa-out-1112.google.com with SMTP id m16so2629546waf
        for <linux-mips@linux-mips.org>; Tue, 20 Nov 2007 19:58:32 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O+nUE8QUxPfgIN8hH6BJhfnLyDSYLLUhCt8arwODF9o=;
        b=JNZPuRvstc7OmGtV/DS0HMkMmakkU7kN4CcrRrvGzIGVjFolXyQAlf8cBLHUspzsYzlXDD7ye9XEUR1TBeBlUPVkVA37VsT7BRLN3+/w10Idnl0KY3/nIyKYWDV+U54+sVan64U+/F64IQWmK515HePnlh55VKwVOHIoVClRgSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zqxa1NCogHrRc25eFSUG6TEwYIJgmbDN5UBgbNvjlEXKrWu9Fw4UpusaMisVxQBLwC2RqafXs2UzCVqqBFllY3v+zGewZQemdKOPtPwsmd7mo2ONnMdtnFpiLv1hHRqnXcPikBAUldIZHv6DwbZZMf/dE6OzrIOVtgURkKaQw7o=
Received: by 10.114.177.1 with SMTP id z1mr615336wae.1195617512856;
        Tue, 20 Nov 2007 19:58:32 -0800 (PST)
Received: by 10.114.168.15 with HTTP; Tue, 20 Nov 2007 19:58:32 -0800 (PST)
Message-ID: <50c9a2250711201958j5b825f9p5b56f841813fa788@mail.gmail.com>
Date:	Wed, 21 Nov 2007 11:58:32 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: how to use memory before kernel load address?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20071120130451.GI11996@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <50c9a2250711191706g40744ab2w2027124c4bc8dbbb@mail.gmail.com>
	 <20071120130451.GI11996@networkno.de>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 11/20/07, Thiemo Seufer <ths@networkno.de> wrote:
> zhuzhenhua wrote:
> > hello,all
> >           i want to place my kernel loadaddr=0x81008000 and set
> > EBASE=0x81000000, it workes.
> >          but there is still some memory usable before 0x81000000, for
> > example from 0x80100000 ~ 0x80200000
>
> The obvious thing to do seems to set LOARADDR to 0x80208000.
>
> >          i have try to pass param as mem=1M@1M mem=16M@16M  to the kernel,
> > it seems only take the 0x8000000 ~ kernel_end as reserved.
> >          is there any other options to set the memory useable? ( my kernel
> > version is 2.6.14)
> >          thanks for any hints
>
> AFAIR the kernel assumes to occupy the lowest addresses of the usable RAM.
>
>
> Thiemo
>

i have resolve it, by modify as follow:

in arch/mips/kernel/setup.c

static inline void bootmem_init(void)
.....
	if (curr_pfn < start_pfn)                    // just change the judgement
			curr_pfn = start_pfn;
                 ....
		/* Register lowmem ranges */
		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));

thanks all.

zzh
