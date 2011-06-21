Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 17:01:30 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:33610 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491158Ab1FUPBY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2011 17:01:24 +0200
Received: by wyf23 with SMTP id 23so3928274wyf.36
        for <multiple recipients>; Tue, 21 Jun 2011 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=88CZVwAsG1pudZvPwHYphzWA84dL+QMXfI8CwuCkQOc=;
        b=gdyRY7bs7FFYOqmCqxXBiHPEBr78WwrnBSUq5e1BDQl2RYGkJz+CGKGfQCnUPwqfXY
         njBPxtx1IJEd2JZ2eK2Q+2sXTD/NmiKvvoSKGMogLuSWhxYY1TH9kDs9yRUaByVfiFi7
         R3kHjmZb1Dfen9gEHsPs4Nx5IgvsfutQo4new=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=jkRvx3PVq4NTDaeBp9VptqsiIP5Ur6gXU6W3iteG2V4RSKtKTKRkkLa22OolGGQ17w
         n5hE62VhYaugNfY+qx6hYkiQys5ihRgyEG7FxCunL295L/Rs/Xcjt7PIIaB0+424pxwe
         aHo7wij0JjeUvsuf4Ku55gw1KGFuFuTx/DLk0=
Received: by 10.216.232.4 with SMTP id m4mr245182weq.87.1308668479305;
        Tue, 21 Jun 2011 08:01:19 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id z22sm3524191weq.26.2011.06.21.08.01.17
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 08:01:18 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Section mismatches in mtx1_defconfig
Date:   Tue, 21 Jun 2011 17:05:32 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips@linux-mips.org
References: <20110621145942.GA14197@linux-mips.org>
In-Reply-To: <20110621145942.GA14197@linux-mips.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106211705.32449.florian@openwrt.org>
X-archive-position: 30475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17243

Hello Ralf,

On Tuesday 21 June 2011 16:59:42 Ralf Baechle wrote:
> WARNING: drivers/watchdog/built-in.o(.data+0x24): Section mismatch in
> reference from the variable mtx1_wdt to the function
> .devinit.text:mtx1_wdt_probe() The variable mtx1_wdt references
> the function __devinit mtx1_wdt_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> WARNING: drivers/watchdog/built-in.o(.data+0x28): Section mismatch in
> reference from the variable mtx1_wdt to the function
> .devexit.text:mtx1_wdt_remove() The variable mtx1_wdt references
> the function __devexit mtx1_wdt_remove()
> If the reference is valid then annotate the
> variable with __exit* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> WARNING: drivers/built-in.o(.data+0x4ec4): Section mismatch in reference
> from the variable mtx1_wdt to the function .devinit.text:mtx1_wdt_probe()
> The variable mtx1_wdt references
> the function __devinit mtx1_wdt_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> WARNING: drivers/built-in.o(.data+0x4ec8): Section mismatch in reference
> from the variable mtx1_wdt to the function .devexit.text:mtx1_wdt_remove()
> The variable mtx1_wdt references
> the function __devexit mtx1_wdt_remove()
> If the reference is valid then annotate the
> variable with __exit* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Fixed with [PATCH 4/5 v3] WATCHDOG: mtx1-wdt: fix section mismatch
--
Florian
