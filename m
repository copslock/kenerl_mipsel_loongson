Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 21:44:58 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:50992 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492508Ab0FATox convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Jun 2010 21:44:53 +0200
Received: by wyj26 with SMTP id 26so1272781wyj.36
        for <linux-mips@linux-mips.org>; Tue, 01 Jun 2010 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=QgRkPKtOnZOhaNa/qGtNpz0QmojOzAyxCA0jCOBunMw=;
        b=BEZU/3qUrJptO+nT+9OVinHbP14z7kPKLGVMB4dlAAvfo5+j3p2Q33Q6gDFJdS4bUL
         SEZwz8PtoSPrdMUxTy4yYBBJIxnKY0DB355dmYfHUhytVwSEnAqSMH2nsFKEQkt/T4eo
         OgZGDuasrS5BVM9zjzPlvEH+sU5TGcjiAsZaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=VN9bVrY0KLOCkW4NwlPSCt99nrAn3u76g9mEXFU1k6uTRNJ5kmWa/abDaRwG5B9ivU
         C4ONy2MsPJsukdxo+p8wJwqIzU0UZ7T5rjpg7les86fSuYIm0CmtI9U7aCAVCEl8xVEf
         UjJiqhOqNtewqL0BqADkcTkBNp5xmUrVRCBdM=
Received: by 10.227.127.148 with SMTP id g20mr6566714wbs.192.1275421483932;
        Tue, 01 Jun 2010 12:44:43 -0700 (PDT)
Received: from lenovo.localnet (208.59.76-86.rev.gaoland.net [86.76.59.208])
        by mx.google.com with ESMTPS id l23sm52257313wbb.8.2010.06.01.12.44.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 12:44:43 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     Ireneusz =?utf-8?q?Szcze=C5=9Bniak?= <irek.szczesniak@gmail.com>
Subject: Re: MIPS 24Kc
Date:   Tue, 1 Jun 2010 21:44:42 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.34-1-686; KDE/4.4.3; i686; ; )
Cc:     linux-mips@linux-mips.org
References: <4C055A60.3000203@gmail.com>
In-Reply-To: <4C055A60.3000203@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201006012144.43447.florian@openwrt.org>
X-archive-position: 26972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 661

Hi,

Le mardi 1 juin 2010 21:07:12, Ireneusz Szcześniak a écrit :
> Hi,
> 
> I'm writing to inquire about the status of the support for MIPS 24Kc.
> 
> I have a RouterBOARD 433 that has the Atheros AR7130 processor with
> the MIPS 24Kc core.  I would like to compile my kernel with the KGDB
> enabled, so that I can debug the kernel on the live hardware.

I would recommend checking OpenWr's ar71xx port[1] which supports RB433.

[1]: https://dev.openwrt.org/browser/trunk/target/linux/ar71xx
--
Florian
