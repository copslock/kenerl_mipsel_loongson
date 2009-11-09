Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 18:06:36 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.148]:59788 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493299AbZKIRGa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 18:06:30 +0100
Received: by ey-out-1920.google.com with SMTP id 4so181861eyg.52
        for <multiple recipients>; Mon, 09 Nov 2009 09:06:29 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=WSsxOXW9cYNjNCO3auUWu2ENs482Ot6CWHMHGR5QRMQ=;
        b=FfYkuP6ZksEq3j1f4fn/N75DgwYdPXuod43mmPV/JQrUsNowXvpGDXr1Dm8qjWYbtt
         YeEgsYyhdBp+D8ULupDinsWGechuuQKEjnR3ZUA+dnHSz3j1k6Q1N9RNshERsoC7K/Pt
         jUMy7iR00LKbkhRvK+Yc578pIVILqxxdEFf00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=V4oWO/mqa8ZuMhkv40TSM+pib+b1yHszMgcQqXvZmD8E8GA+eu/mlAmI/n4SW36X46
         +LtuVVVJS/CGXbLsEgG2IWGi8/pOS2FhnsGGbXCKWP/NmBWG5qqSNP7a79N2h/xYNP4T
         uz2+UD8aFf7129YJPqWymyLl22TYrTCZtXsd8=
Received: by 10.216.90.208 with SMTP id e58mr2491050wef.57.1257786389699;
        Mon, 09 Nov 2009 09:06:29 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id q9sm9306897gve.0.2009.11.09.09.06.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 09:06:28 -0800 (PST)
Subject: Re: [PATCH v2 0/7] add support for lemote loongson2f machines
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, linux-mips@linux-mips.org
In-Reply-To: <20091109165429.GB15319@linux-mips.org>
References: <cover.1257781987.git.wuzhangjin@gmail.com>
	 <20091109161127.GA15319@linux-mips.org>
	 <1257784608.14315.11.camel@falcon.domain.org>
	 <20091109165429.GB15319@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Tue, 10 Nov 2009 01:06:24 +0800
Message-ID: <1257786384.14315.21.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-11-09 at 17:54 +0100, Ralf Baechle wrote:
> On Tue, Nov 10, 2009 at 12:36:48AM +0800, Wu Zhangjin wrote:
> 
> > > Grant Likely convinced me in Tokyo that this is the way to go.  He intends
> > > to rewrite the FDT code into an easily re-usable library which he estimates
> > > to take a month or two after which I'd like to start using it on MIPS.
> > > This probably also means FDT support for PMON will eventually be needed.
> > > 
> > 
> > Thanks for your pointer, Will take a look at FDT asap.
> > 
> > > Until then of course machtype=<whatever> is a fair solution.
> > > 
> > 
> > are you ready to apply it? then I will push the Cpufreq and Standby
> > support, and really hope we can get a full loongson2f support in the
> > mainline's 33 version ;)
> 
> I had already taken the previous version into the -queue tree.
> 
> What are the changes since -v1?  I've done a few changes myself, mostly
> tweaking the English language bits of the patch, so incremental patches
> would be ideal.
> 

Very few of changes, did you apply the changes in this one?

 [PATCH v2 6/7] [loongson] lemote-2f: add reset support

about this part in arch/mips/loongson/lemote-2f/reset.c, I have removed
the array, and used the "switch...case..." instead.

+void mach_prepare_reboot(void)
+{
+       switch (mips_machtype) {
+       case MACH_LEMOTE_FL2F:
+               fl2f_reboot();
+               break;
+       case MACH_LEMOTE_ML2F7:
+               ml2f_reboot();
+               break;
+       case MACH_LEMOTE_YL2F89:
+               yl2f89_reboot();
+               break;
+       default:
+               break;
+       }
+}
+
+void mach_prepare_shutdown(void)
+{
+       switch (mips_machtype) {
+       case MACH_LEMOTE_FL2F:
+               fl2f_shutdown();
+               break;
+       case MACH_LEMOTE_ML2F7:
+               ml2f_shutdown();
+               break;
+       case MACH_LEMOTE_YL2F89:
+               yl2f89_shutdown();
+               break;
+       default:
+               break;
+       }
+}

and also, I have replaced that f0 by PCI_MSR_CTRL in this one:

[PATCH v2 4/7] [loongson] lemote-2f: add pci support

about this part in arch/mips/pci/ops-loongson2.c:

+#ifdef CONFIG_CS5536
+               /* cs5536_pci_conf_read4/write4() will call
_rdmsr/_wrmsr() to
+                * access the regsters PCI_MSR_ADDR, PCI_MSR_DATA_LO,
+                * PCI_MSR_DATA_HI, which is bigger than PCI_MSR_CTRL,
so, it
+                * will not go this branch, but the others. so, no
calling dead
+                * loop here.
+                */
+               if ((PCI_IDSEL_CS5536 == device) && (reg <
PCI_MSR_CTRL)) {

If it's hard to find them, I will send the increment patches later.

Regards,
	Wu Zhangjin
