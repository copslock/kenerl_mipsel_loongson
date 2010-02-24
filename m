Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 01:03:58 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:54102 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492438Ab0BXADy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2010 01:03:54 +0100
Received: by bwz7 with SMTP id 7so3032891bwz.24
        for <multiple recipients>; Tue, 23 Feb 2010 16:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=OmZo8JnSKNUeGOCHyJ8UxMom9XpJVKdiTvgLKGRbCPY=;
        b=WJBNqWCI2EWtQogsNATKE8AAsrQg7aoz6rAB/ZugI4bPFLhSWd5q651T6TUckK4/9w
         BTvU6+/6H3KxSmApDyut6T/OfBSFFOIdYfCwcUdd/tyYUyQdhx7s+a2NzbmMfTUmDt+Q
         x+5bH4pKms/fgudFIX+AJl0lq9/UFz7a1uHJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=P2YQH/pA9GaWliaVZ63X+InB2PKqttADL4k4/v4rpXy0AewAXX7laikOiH6PIqm9Ly
         Wh15/a1ym8WIbAd1/XFc5zEBxNHSuI8KJgzcnIGdoMbXz0S3VCMB6oXTT+nuTHabua3J
         hBtXMHZvRLzPZO/m1pzEbl+hYJHR+xdpgncuk=
Received: by 10.204.143.130 with SMTP id v2mr2205454bku.7.1266969828803;
        Tue, 23 Feb 2010 16:03:48 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm2262088bwz.12.2010.02.23.16.03.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 16:03:47 -0800 (PST)
Date:   Wed, 24 Feb 2010 09:03:33 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:     yuasa@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Reverting old hack
Message-Id: <20100224090333.44a16d0a.yuasa@linux-mips.org>
In-Reply-To: <201002231601.15136.bjorn.helgaas@hp.com>
References: <20100220113134.GA27194@linux-mips.org>
        <1266815257.1959.23.camel@dc7800.home>
        <20100222132830.GA5017@linux-mips.org>
        <201002231601.15136.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 23 Feb 2010 16:01:14 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Monday 22 February 2010 06:28:30 am Ralf Baechle wrote:
> > It's a while since I last looked into this but here's how things afair
> > are working on a MIPS-based Cobalt system.
> > 
> > The system is based on a MIPS processor and a GT-64111 system controller.
> > Addresses within a certain CPU address range are passed to the PCI bus as
> > I/O cycles without address cycles.  Since memory is starting at CPU address
> > zero (and has to because of the processors used), that address window has
> > to get mapped somewhere else.  So a CPU access to some virtual address gets
> > translated to physical address 0xf00001f0.  The GT-64111 passes this to the
> > PCI bus as I/O port address 0xf00001f0.  Finally the VT82C586 chip which
> > only decodes the low 16 bits drops treats this as an I/O port space address
> > 0x1f0.
> 
> Yoichi, can you try the patch below?  I think this is basically the
> approach Ben suggested long ago:
>     http://marc.info/?l=linux-kernel&m=119733290624544&w=2

It works fine with 2.6.34 queue tree.
pci.c change is already committed by Ralf.

Thanks,

Yoichi
