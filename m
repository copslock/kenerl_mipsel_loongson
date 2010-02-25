Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 09:40:22 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:64500 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491997Ab0BYIkS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 09:40:18 +0100
Received: by gye5 with SMTP id 5so516769gye.36
        for <multiple recipients>; Thu, 25 Feb 2010 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Sj3xFY+STfFhX5bvhODvqdO5sFfqrilbU0UFr2hgvFA=;
        b=nlJPYleyr+LT9oFJ66UbRgqrTCsgy1BsJWa5Ui738jdl0WebMOMh5ZFY2qp5f6wGUH
         RkKWe1y6AkRX40AETEtztbmyPu2W3UYfJPBrfjV0DOvmS2daB+JEMtqhUtnYKObMw3OT
         hINHCDyUESyRQJpEM1a5k5pzG7iVbLbS/2mHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=eItI6Nm6p+qsvFkVfKwQgOgBfzzUWotm1Dhpb9JvdsnXqUgx/ST22I/yG4DjXQM1jg
         gT9jxkEFecDjzU/hJKEK9evcgL/kGt7ZAZz14kq9RHbg9+orT9v13BU7mvFZXNHXgIm2
         Vyz7qjYxMpOox8pGiDDu5Kgp7SiJ+hOBEApxk=
Received: by 10.90.38.27 with SMTP id l27mr1224995agl.6.1267087207208;
        Thu, 25 Feb 2010 00:40:07 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm2470438gxk.14.2010.02.25.00.40.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 00:40:06 -0800 (PST)
Date:   Thu, 25 Feb 2010 17:39:56 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, Bjorn Helgaas <bjorn.helgaas@hp.com>,
        linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Reverting old hack
Message-Id: <20100225173956.65cf8fa3.yuasa@linux-mips.org>
In-Reply-To: <20100224164100.GD5130@linux-mips.org>
References: <20100220113134.GA27194@linux-mips.org>
        <1266815257.1959.23.camel@dc7800.home>
        <20100222132830.GA5017@linux-mips.org>
        <201002231601.15136.bjorn.helgaas@hp.com>
        <20100224090333.44a16d0a.yuasa@linux-mips.org>
        <20100224164100.GD5130@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 24 Feb 2010 17:41:00 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Feb 24, 2010 at 09:03:33AM +0900, Yoichi Yuasa wrote:
> 
> > > approach Ben suggested long ago:
> > >     http://marc.info/?l=linux-kernel&m=119733290624544&w=2
> > 
> > It works fine with 2.6.34 queue tree.
> > pci.c change is already committed by Ralf.
> 
> Which I just dropped from queue.  To keep the tree bisectable removal of
> the old hack and adding the fixup should be done in the same patch so I'd
> go for Bjorn's patch.
> 
> There is another somewhat theoretical correctness issue.  Because the
> VIA SuperIO chip only decodes 24 bits of address space but port address
> space currently being configured as 32MB there is the theoretical
> possibility of I/O port addresses that alias with legacy addresses getting
> allocated.
> 
> The complicated solution is to reserve all address range that potencially
> could cause such aliases.  But with the PCI spec limiting port allocations
> for devices to a maximum of 256 bytes 16MB of port address space already is
> way more than one would ever expect to be used so I suggest to just limit
> the port address space to 16MB.
> 
> Could you test the patch below?

It has no problem.

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
00001000-00ffffff : PCI I/O                                                     
  00001000-0000107f : 0000:00:07.0                                              
    00001000-0000107f : tulip                                                   
  00001080-000010ff : 0000:00:0c.0                                              
    00001080-000010ff : tulip                                                   
  00001400-0000141f : 0000:00:09.2                                              
  00001420-0000142f : 0000:00:09.1                                              
    00001420-0000142f : pata_via

Yoichi
