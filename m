Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 May 2010 11:12:02 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:62355 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490993Ab0E3JL7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 May 2010 11:11:59 +0200
Received: by pwi2 with SMTP id 2so1259799pwi.36
        for <multiple recipients>; Sun, 30 May 2010 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=uzBTgsbAsfxIyobaOsQDOm9Iq+lhTwUzb5EcNn4PdFg=;
        b=kCI6XRzRpgi7zyJSC/hZ9GD0qcSqlKUZ6MlkwJzVX6OI/AJWmNImleYuMX5eTtHrqh
         cFNCqGF7/y7k0BaXn0+gh2w5+xJyIB6jqssm3TLr9c6X3lQRw9V3C5HsFRJlPC7RZAhJ
         DHUvsU7OU86DYHf6xWSitmFwC7aqGUD9V7vsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=lnZR6dPFcKWvVNvfQCkJxdXL/TM1MBvX5X4MrEfuuMEjW9V/IPDMhRgiOMA7otst7E
         W55c/uPxBPpdM8ZaTq9VqhH4zXjLmNn5ldnvEW58F3a5wGo6QRg+T1wTETb55ExBea6f
         notBDONJlYgA1Z53PxLu5uQ/D8k6iP2lSTO/c=
Received: by 10.115.38.6 with SMTP id q6mr2223516waj.207.1275210711308;
        Sun, 30 May 2010 02:11:51 -0700 (PDT)
Received: from [192.168.2.226] ([202.201.14.140])
        by mx.google.com with ESMTPS id c14sm37863022waa.13.2010.05.30.02.11.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 02:11:50 -0700 (PDT)
Subject: Re: [PATCH] mips: refactor arch/mips/boot/Makefile
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20100530052304.GA1528@merkur.ravnborg.org>
References: <20100529195752.GA19568@merkur.ravnborg.org>
         <1275189085.4258.12.camel@localhost>
         <20100530052304.GA1528@merkur.ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sun, 30 May 2010 17:11:45 +0800
Message-ID: <1275210705.4258.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Sam & Ralf

On Sun, 2010-05-30 at 07:23 +0200, Sam Ravnborg wrote:
[...]
> > Could you please apply the similar modification to
> > arch/mips/boot/compressed/Makefile? thanks!
> 
> I am working on it.
> I will post a full (albeit) small serie of patches
> later today. It will replace the patches I sent yesterday.

I have rewritten the calculation of the VMLINUZ_LOAD_ADDRESS in C and
removed the suffix_* related parts and plan to send them out later.

To avoid my patches conflict with yours, I will wait for yours ;)

Best Regards,
	Wu Zhangjin
