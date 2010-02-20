Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2010 13:18:29 +0100 (CET)
Received: from mail-yx0-f193.google.com ([209.85.210.193]:54246 "EHLO
        mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492127Ab0BTMSY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Feb 2010 13:18:24 +0100
Received: by yxe31 with SMTP id 31so1007447yxe.21
        for <multiple recipients>; Sat, 20 Feb 2010 04:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=EXlb4DFlbKNM3wcdVWdVPerT7abKnVz0eXNYVeNpRtY=;
        b=Yap7fbyFi8QGJXw70Dzn7hWrD5BIiB36AWzWrcAZrYg30OlIeSYk8vKrxe+iAPp+YS
         UiifQc21ogdy8BhZIxZHDPEBXOAqzzlr5xyb6iTG8FN7HucyHbLuVhXYd84DRR9EkZMx
         1QJFKf4mZRN45gG3wxQMYqBSCIzL6IWbYEfNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=JuwztLSRRbGfZO9DIRZrkRCReEnsKTdmtbbQt9EeRWRgUPy/O/G5h5ZG9nehuHg/6B
         V3dY5FSkpS7aKBw86Xxxxr7g5kY0pTy9nZSebX4am8gpZGe4sEUZl54qq+oDpA4z9TbR
         slA6+2SV6pAOoBqsoOpHnpOpaxkuOZ0U/8x3w=
Received: by 10.100.222.5 with SMTP id u5mr6873819ang.247.1266668297636;
        Sat, 20 Feb 2010 04:18:17 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm971072gxk.8.2010.02.20.04.18.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 04:18:16 -0800 (PST)
Date:   Sat, 20 Feb 2010 21:18:05 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org,
        Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Reverting old hack
Message-Id: <20100220211805.6a33e9e2.yuasa@linux-mips.org>
In-Reply-To: <20100220113134.GA27194@linux-mips.org>
References: <20100220113134.GA27194@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Sat, 20 Feb 2010 12:31:34 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> Below 9f7670e4ddd940d95e48997c2da51614e5fde2cf, an old hack which I
> committed in December '07 I think mostly for Cobalt machines.  This is
> now getting in the way - in fact the whole loop in
> pcibios_fixup_device_resources() may have to go.  So I wonder if this
> old hack is still necessary.  Only testing can answer so I'm going to
> put a patch to revert this into the -queue tree for 2.6.34.

It is still necessary for Cobalt.
I got the following IDE resource errors.

pata_via 0000:00:09.1: BAR 0: can't reserve [io  0xf00001f0-0xf00001f7]         
pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)      
pata_via 0000:00:09.1: BAR 2: can't reserve [io  0xf0000170-0xf0000177]         
pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)      
pata_via 0000:00:09.1: no available native port 

Yoichi
