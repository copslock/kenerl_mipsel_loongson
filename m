Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 May 2005 20:56:49 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.205]:12535 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225545AbVECT4d> convert rfc822-to-8bit;
	Tue, 3 May 2005 20:56:33 +0100
Received: by wproxy.gmail.com with SMTP id 57so1479696wri
        for <linux-mips@linux-mips.org>; Tue, 03 May 2005 12:56:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AtOphbTiY4GLwc0k0An1g+3tUFZqDVzouK1Tzlwo9xpoK7tiIbcqBuB6TkOZ0lICpkNXfkF1P1amcB3oDw2NXCOXiJooCpMiaook71hmJY96oL6yd5NbGt2v2b8vkTuyYyKgDrRnGt/VoEMmY1bPfn3/cjcUgOfF5Dl+Zcfytt4=
Received: by 10.54.122.12 with SMTP id u12mr629858wrc;
        Tue, 03 May 2005 12:56:26 -0700 (PDT)
Received: by 10.54.38.20 with HTTP; Tue, 3 May 2005 12:56:26 -0700 (PDT)
Message-ID: <e02bc66105050312564d0dacdb@mail.gmail.com>
Date:	Tue, 3 May 2005 21:56:26 +0200
From:	Sergio Ruiz <quekio@gmail.com>
Reply-To: Sergio Ruiz <quekio@gmail.com>
To:	linux-mips@linux-mips.org
Subject: How to the the physical addresses under linux (au1500)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <quekio@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quekio@gmail.com
Precedence: bulk
X-list: linux-mips

I am trying to program  the DMA (with the ac97) in assembler using a
linux kernel module for mips teaching purposes.
The problem is that I need to get the physical address of the pointer
to the buffer to transfer to the AC97.
Looking at the kernel source code, I found that I can get the physical
address subtracting 0x8000000, but It doesnt seem to work.

Any idea?

Thanks,

Sergio
