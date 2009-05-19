Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 10:14:01 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.243]:61850 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023561AbZESJNy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2009 10:13:54 +0100
Received: by rv-out-0708.google.com with SMTP id k29so1863500rvb.24
        for <multiple recipients>; Tue, 19 May 2009 02:13:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=pPFrrClb3w/Y958uIU8G6f5BwGtbbMyPV4oX+hQUv9Y=;
        b=dwqF/kwxwF6la5dam56w6qt4OdW4XDWiXukGwQWpl7F7b3XA60JONQOLVWbsx6j0U4
         +mgjKZP74qrXLz7czS56fk4ZGTenkLweG00jzt8BdKJn7A0+XcolALxlFTPA3GlKP38y
         6Y07zP84houE20BQNSDR3JpmwDwt1/+s+c2NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Zi1SqGenq0Z7EMCZDx7gPod4PfAdZzQ/Uk2Am0rfLCP/x1Kni9HtAoiYTN/q2GKGOf
         HYkgI2RZRe2aHOv+TSS29+zKQfh1Xe/BYNj+kcxYVjjlFTJDPMR9wmTivn+lAPWnNpMc
         I30fQ3JBkP+/lmf9Ianhe6MnQDUs7F9vgvcYY=
Received: by 10.141.176.4 with SMTP id d4mr2807964rvp.109.1242724431799;
        Tue, 19 May 2009 02:13:51 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id k41sm16133296rvb.37.2009.05.19.02.13.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 May 2009 02:13:50 -0700 (PDT)
Subject: Re: [PATCH 01/30] Fix warning: incompatible argument type of
 pci_fixup_irqs
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <20090518063510.GA8917@adriano.hkcable.com.hk>
References: <1242424728.10164.140.camel@falcon>
	 <20090518063510.GA8917@adriano.hkcable.com.hk>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Tue, 19 May 2009 17:13:31 +0800
Message-Id: <1242724411.18816.16.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-05-18 at 14:35 +0800, Zhang Le wrote:
> On 05:58 Sat 16 May     , Wu Zhangjin wrote:
> > >From 1e6360e89b239699ef1f5344e1d3a5c0b3c5bef1 Mon Sep 17 00:00:00 2001
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > Date: Tue, 12 May 2009 10:33:37 +0800
> > Subject: [PATCH 01/30] Fix warning: incompatible argument type of
> > pci_fixup_irqs
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=utf-8
> > Content-Transfer-Encoding: 8bit
> 
> I don't know how you mailed these patches.
> But it seems to me that you copy'n'pasted the format-patch'ed patch into the
> text editor of your mailer.
> 
> If this is the case, please don't do this. Please use 'git send-email'.

thanks very much for your reply :-)

-----------------

hi, all

I am checking the posted patchset with the support of
scripts/checkpatch.pl, and have cleaned up the cs55536 support of
fuloong2f/yeeloong2f a lot.

the new patchset will come one day or two later(will be sent out via
'git send-email'), so, please ignore the posted patchset, I am very
sorry for sending the awful patchset to you.

thanks,
Wu Zhangjin
