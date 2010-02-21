Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Feb 2010 08:45:55 +0100 (CET)
Received: from mail-yx0-f194.google.com ([209.85.210.194]:34714 "EHLO
        mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491074Ab0BUHpu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Feb 2010 08:45:50 +0100
Received: by yxe32 with SMTP id 32so2542800yxe.0
        for <multiple recipients>; Sat, 20 Feb 2010 23:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=GXW0uUf3/JA0Ta7VDJtNFaCOlDD2uDzAWJIRKzyIyzs=;
        b=pc7yv3EIQ3ZRU6FSA30XwCh+szoFYbbLYZqYdgqPu27qOdak67oWHS3XIA5bjGkF1Y
         MuhCjz7Joj0ERLp/fYJbSMFx/dyq5gFrfiZcwMGFp5R6apRV1th9hB7h3H6gDlHsrPxO
         F3MeMVS9LNsoTVSiGC/ym1l/jgXq15yg0IsOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=CjYhaPSHc6xjqTjESOxhpeQaez74Y9GeE0FAeshLTRX7TR95qBe2g9xFAg4kj2cfVL
         WV/SPURvH0zwx1E+0QEwoiQtfkb+WeWz8HCN9ltcD4N45Ar3mvI8y1d2hzImcjOAQRXe
         3EXyXgQmoOP6jcUP4hRbvbeat6yqQ5eiFOS+k=
Received: by 10.101.207.28 with SMTP id j28mr3551106anq.193.1266738343080;
        Sat, 20 Feb 2010 23:45:43 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 16sm1933122gxk.13.2010.02.20.23.45.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 23:45:42 -0800 (PST)
Date:   Sun, 21 Feb 2010 16:45:31 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:     yuasa@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: Reverting old hack
Message-Id: <20100221164531.382b3785.yuasa@linux-mips.org>
In-Reply-To: <1266677869.1320.8.camel@dc7800.home>
References: <20100220113134.GA27194@linux-mips.org>
        <20100220211805.6a33e9e2.yuasa@linux-mips.org>
        <1266677869.1320.8.camel@dc7800.home>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Bjorn,

On Sat, 20 Feb 2010 07:57:49 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Sat, 2010-02-20 at 21:18 +0900, Yoichi Yuasa wrote:
> > Hi Ralf,
> > 
> > On Sat, 20 Feb 2010 12:31:34 +0100
> > Ralf Baechle <ralf@linux-mips.org> wrote:
> > 
> > > Below 9f7670e4ddd940d95e48997c2da51614e5fde2cf, an old hack which I
> > > committed in December '07 I think mostly for Cobalt machines.  This is
> > > now getting in the way - in fact the whole loop in
> > > pcibios_fixup_device_resources() may have to go.  So I wonder if this
> > > old hack is still necessary.  Only testing can answer so I'm going to
> > > put a patch to revert this into the -queue tree for 2.6.34.
> > 
> > It is still necessary for Cobalt.
> > I got the following IDE resource errors.
> > 
> > pata_via 0000:00:09.1: BAR 0: can't reserve [io  0xf00001f0-0xf00001f7]         
> > pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)      
> > pata_via 0000:00:09.1: BAR 2: can't reserve [io  0xf0000170-0xf0000177]         
> > pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)      
> > pata_via 0000:00:09.1: no available native port 
> 
> Thanks for trying that out.
> 
> I'd like to understand the PCI architecture of Cobalt better.  Would you
> mind turning on CONFIG_PCI_DEBUG and posting the dmesg log?

If you want to know what happen, you can see my old e-mail. 

http://marc.info/?l=linux-kernel&m=118792430424186&w=2

> The purpose of IORESOURCE_PCI_FIXED is to say that we shouldn't reassign
> the device resources.  But the pcibios_fixup_device_resources() loop
> isn't *moving* devices, it's merely converting PCI bus addresses to CPU
> addresses.  So I suspect that the IORESOURCE_PCI_FIXED test there is
> merely covering up another bug.

Please look at the following e-mail why this fix was not applied. 

http://marc.info/?l=linux-kernel&m=119690002215135&w=2
 
> For example, maybe 00:09.1 is an internal device that's behind a
> different host bridge that does no address conversion, or maybe the host
> bridge just handles that device specially.  If something like that is
> happening, pcibios_bus_to_resource() should be broken for that device,
> and fixing that should allow us to remove the IORESOURCE_PCI_FIXED test.

Yoichi
