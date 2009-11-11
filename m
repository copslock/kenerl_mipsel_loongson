Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 16:33:11 +0100 (CET)
Received: from gv-out-0910.google.com ([216.239.58.187]:62123 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492883AbZKKPdE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 16:33:04 +0100
Received: by gv-out-0910.google.com with SMTP id e6so85867gvc.2
        for <multiple recipients>; Wed, 11 Nov 2009 07:33:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=/0WSUjTt4fuWYGz4r172lsqa7g8eP5NanKUe056Jl+w=;
        b=tr9Y9vcidergQki9gHDgLBeJHtiAmZBlG14werrpm8SR2tFydOF+G1pzWbcwMx3+V+
         109/0u9grsJN9HzsczqpbMDP+PmSlqzaO/Vzrkrk5CNIGUcFZjxHWdurO1VLJ2j/FdqM
         trpZ7QEVLMZflfpSWsIByr9UcuXsJs45EcBi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=UZALaTmYQSaYbcH5IJ/NlFZaFAv1MVcZIpe0fPrtsyg4UZFqrX4hptD+Y9D6oD4Dyw
         uURJJEwiYs4X9aB0blpadOFasKXxmncE2nkPVzj9xNfuGIaBrVxRvs/Lz0u9FnbL0Jqy
         3XL1EMEulr3/z2hqxEWHcVcdaRzcXEYa+QlEs=
Received: by 10.216.89.149 with SMTP id c21mr500425wef.224.1257953583297;
        Wed, 11 Nov 2009 07:33:03 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id u14sm5387082gvf.18.2009.11.11.07.32.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 07:33:01 -0800 (PST)
Subject: Re: [PATCH -queue 1/2] [loongson] 2f: add suspend support framework
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Pavel Machek <pavel@ucw.cz>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	yanh@lemote.com, huhb@lemote.com, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-pm@lists.linux-foundation.org
In-Reply-To: <20091111103304.GB26423@elf.ucw.cz>
References: <cover.1257922151.git.wuzhangjin@gmail.com>
	 <1257922625.2922.97.camel@falcon.domain.org>
	 <20091111103304.GB26423@elf.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 11 Nov 2009 23:32:56 +0800
Message-ID: <1257953576.7308.27.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2009-11-11 at 11:33 +0100, Pavel Machek wrote:
> On Wed 2009-11-11 14:57:05, Wu Zhangjin wrote:
> > (Add CC to Rafael J. Wysocki, Len Brown and Pavel Machek)
> > 
> > This patch add basic suspend support for loongson2f family machines,
> > loongson2f have a specific feature: when we set it's frequency to ZERO,
> > it will go into a wait mode, and then can be waked up by the external
> > interrupt. so, if we setup suitable interrupts before putting it into
> > wait mode, we will be able wake it up whenever we want via sending the
> > relative interrupts to it.
> > 
> > These interrupts are board-specific, Yeeloong2F use the keyboard
> > interrupt and SCI interrupt, but LingLoong and Fuloong2F use the
> > interrupts connected to the processors directly. and BTW: some old
> > LingLoong and FuLoong2F have no such interrupts connected, so, there is
> > no way to wake them up from suspend mode. and therefore, please do not
> > enable the kernel support for them.
> > 
> > The board-specific support will be added in the coming patches.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Comments are slighlty "interesting", but otherwise it looks ok.
> 
> > +	/* stop all perf counters */
> > +	stop_perf_counters();
> 
> This is not exactly useful comment, right?
> 
 
Will remove it later ;) the same to the following two.

> > +	/* mach specific suspend */
> > +	mach_suspend();
> ...
> > +	/* mach specific resume */
> > +	mach_resume();
> 
> 
> It is probably ok, but you may want to avoid them in future.
> 
> ACK.
> 									Pavel
> 

Thanks!
	Wu Zhangjin
