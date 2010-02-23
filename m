Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 01:51:22 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:63000 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492343Ab0BWAvO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2010 01:51:14 +0100
Received: by bwz7 with SMTP id 7so2124599bwz.24
        for <multiple recipients>; Mon, 22 Feb 2010 16:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=bck8WG4BGeouzKr2DbFalIksZnp+XuVaH9jZTD6uJaA=;
        b=xohag6O6tPJS6ITroAofMfRH6yxmVlpBtE5i6e9aJr9ec38XQV7rxK76xqH7idIwYe
         oFMsNSDcLjf0cNblh9lfoUJ+XppZaPBg0RMAat0XgE9f97YDWVnNJjEpT4rhdO377WKa
         JbDFE47cvTpjrTifsSAnIfRo97RTmdm+wjzBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ObvMbhNPx4CfgRgXoVUpsHBxaXAQ1GoHpcT7nfdMhsj+1lyEE8xd022gmjCLO1a6dG
         95pXfO0GPJqGMdXLwHV0KaIL7Enj91k5kTmcDvv+tCWJvVUE5bx57ZOMXuSxk3ql1Bxm
         bv0qzSxGRae+SVlsJNq9Js9/RiCHi7qCgxDTI=
Received: by 10.204.49.68 with SMTP id u4mr889716bkf.57.1266886265645;
        Mon, 22 Feb 2010 16:51:05 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm1462801bwz.8.2010.02.22.16.51.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 16:51:04 -0800 (PST)
Date:   Tue, 23 Feb 2010 09:50:51 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:     yuasa@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: Reverting old hack
Message-Id: <20100223095051.26a5049b.yuasa@linux-mips.org>
In-Reply-To: <201002221715.24674.bjorn.helgaas@hp.com>
References: <20100220113134.GA27194@linux-mips.org>
        <201002221355.28939.bjorn.helgaas@hp.com>
        <20100223085143.aeb1fa53.yuasa@linux-mips.org>
        <201002221715.24674.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 22 Feb 2010 17:15:24 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Monday 22 February 2010 04:51:43 pm Yoichi Yuasa wrote:
> > Hi Bjorn,
> > 
> > On Mon, 22 Feb 2010 13:55:28 -0700
> > Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > 
> > > On Sunday 21 February 2010 12:45:31 am Yoichi Yuasa wrote:
> > > > > I'd like to understand the PCI architecture of Cobalt better.  Would you
> > > > > mind turning on CONFIG_PCI_DEBUG and posting the dmesg log?
> > > > 
> > > > If you want to know what happen, you can see my old e-mail. 
> > > > 
> > > > http://marc.info/?l=linux-kernel&m=118792430424186&w=2
> > > 
> > > There's not much detail there.  It would save me a lot of time if
> > > you could collect the complete dmesg log, /proc/iomem, and /proc/ioports.
> > 
> > It cannot boot without old hack.
> 
> I know; I meant that the information from a kernel with the old
> hack would be useful.  But I think I'm starting to understand anyway.
> 
> The Linux I/O port number space is defined here:
> 
>     static struct resource cobalt_io_resource = {
>         .start  = 0x1000,
>         .end    = GT_DEF_PCI0_IO_SIZE - 1,  /* 0x1ffffff */
> 
> [As an aside, I'm not sure 0x1000 is the correct start -- for example,
> I think Linux I/O port 0x1f0 is forwarded by the host bridge.]

This is the space(0x0-0xfff) for the fixed address devices(PIC, RTC, DMA(just reserved)...). 

$ cat /proc/ioports                                                      
00000000-0000001f : reserved                                                    
00000020-00000021 : pic1                                                        
00000060-0000006f : reserved                                                    
00000070-00000077 : rtc_cmos                                                    
  00000070-00000077 : rtc0                                                      
00000080-0000008f : reserved                                                    
000000a0-000000a1 : pic2                                                        
000000c0-000000df : reserved                                                    
00000170-00000177 : pata_via                                                    
000001f0-000001f7 : pata_via                                                    
00000376-00000376 : pata_via                                                    
000003f6-000003f6 : pata_via                                                    
00001000-01ffffff : PCI I/O                                                     
  00001000-0000107f : 0000:00:07.0                                              
    00001000-0000107f : tulip                                                   
  00001080-000010ff : 0000:00:0c.0                                              
    00001080-000010ff : tulip                                                   
  00001400-0000141f : 0000:00:09.2                                              
  00001420-0000142f : 0000:00:09.1                                              
    00001420-0000142f : pata_via
 
> The corresponding PCI I/O port numbers are determined by the PCI
> I/O decoder address, so I agree that we need the io_offset to convert
> between the Linux port numbers and ports that appear on the PCI bus.
> 
> I think the IDE device is a problem because pci_setup_device() fills
> in legacy resources with ports 0x1f0-0x1f7, etc.  We expect those
> resources to contain PCI bus addresses at this point, but we could
> never see those addresses on the Cobalt PCI bus (we would only see
> things in the range 0x10000000-0x11ffffff).
> 
> When we convert 0x1f0 with pcibios_bus_to_resource() (or with
> pcibios_fixup_device_resources() without the IORESOURCE_PCI_FIXED
> hack), we get 0x1f0 + 0xf0000000 == 0xf00001f0, when we want 0x1f0
> instead.
> 
> > pata_via 0000:00:09.1: BAR 0: can't reserve [io  0xf00001f0-0xf00001f7]
> 
> I still don't know the best way to fix this, but does this make sense
> so far?

That makes sense.

Yoichi
