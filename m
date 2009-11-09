Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 17:37:20 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:59034 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493278AbZKIQhN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 17:37:13 +0100
Received: by ewy12 with SMTP id 12so3439636ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 08:37:07 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=4rFICSX3Hp9xYSh4y0CqMMp1kB32fCDz+cDu1BZXO7g=;
        b=wSufAEC/JY9hfLucpEejtAdBLNBIcZE5KfjYWRv6Z1c7eDpnrhzrHyJ6NcuGlEzIn4
         zAS2zjvESTudz1IAPJlvIu0NmTaBcZ4fgrq6zMXk7p3wTsNgag25C57fTl9FcEjeOT9S
         N5vqXgG0UbhalMAbaL3ESwWct/r1qMxadBD2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ZDwVGPuM4TM8aUfbap2aZfOtkFP8FI/LIy6mpAdFak7pDFYbz4zGTx8fjuvRMOwysm
         H2VVXJ3ShTUcEvMdC6dHGUwENkzT5K2Oc4lreqqqKV07yavIvgRl3RGq+UfPitfX4PaR
         XhRU19UmnEclwsAYODx3DcB1Xc+OQ+3OZwYFo=
Received: by 10.216.93.81 with SMTP id k59mr2486876wef.169.1257784627254;
        Mon, 09 Nov 2009 08:37:07 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id p10sm9224765gvf.29.2009.11.09.08.37.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 08:37:06 -0800 (PST)
Subject: Re: [PATCH v2 0/7] add support for lemote loongson2f machines
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, linux-mips@linux-mips.org
In-Reply-To: <20091109161127.GA15319@linux-mips.org>
References: <cover.1257781987.git.wuzhangjin@gmail.com>
	 <20091109161127.GA15319@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Tue, 10 Nov 2009 00:36:48 +0800
Message-ID: <1257784608.14315.11.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-11-09 at 17:11 +0100, Ralf Baechle wrote:
> On Tue, Nov 10, 2009 at 12:05:21AM +0800, Wu Zhangjin wrote:
> 
> > for example, if you pass "machtype=8.9" to kernel when booting, it will run
> > well on yeeloong netbook. the default machtype is 2f-box, so, you can run the
> > kernel on fuloong2f directly. In the future, we will pass the machtype argument
> > by PMON directly, and then the linux distributions will only need to build one
> > kernel image, and will make it work on all of lemote loongson2f family
> > machines.
> 
> A more general solution to this sort of problem is the flattened device tree.
> Grant Likely convinced me in Tokyo that this is the way to go.  He intends
> to rewrite the FDT code into an easily re-usable library which he estimates
> to take a month or two after which I'd like to start using it on MIPS.
> This probably also means FDT support for PMON will eventually be needed.
> 

Thanks for your pointer, Will take a look at FDT asap.

> Until then of course machtype=<whatever> is a fair solution.
> 

are you ready to apply it? then I will push the Cpufreq and Standby
support, and really hope we can get a full loongson2f support in the
mainline's 33 version ;)

Thanks & Regards,
	Wu Zhangjin
