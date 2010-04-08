Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Apr 2010 20:52:12 +0200 (CEST)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:57417 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492185Ab0DHSwH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Apr 2010 20:52:07 +0200
Received: by wwg30 with SMTP id 30so214676wwg.36
        for <multiple recipients>; Thu, 08 Apr 2010 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:received:message-id:subject:from:to:cc
         :content-type;
        bh=WMOagt+mdMx2BoCLSUYAWpfCTmH/VaFZ0bw0bxBmtt4=;
        b=wPwzabRM7q/rNqijTFepyCugYGIDQo08KnqcDJysrykJKDfTLbtSo4iPZi+dRuzpbC
         HrK3X0ih40WNx3c80O0KBm+hIlDdclJKpaYicuDK0Z9YA1Zib232wypATJR7PUKktn7q
         RGhlErHR0pXFHwSGkBwveqcETi9mM53jIvxEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        b=i+6hZfCqQCvwCF3aI8R/HeTwq3Bzhk9N9pJ4ic9xWIMFP5F6PcDMSzSIPsMmVIbWIf
         7tnmu0Bn33U7wIDz+DjQ+WSyY4CXxe1wUv4M1jz0IET9/ZbXIuK+xViK0jPKVumzm2pM
         kM9lRB1V7X9G7FGPLxdqVzFLRMdObeatpMBpQ=
MIME-Version: 1.0
Received: by 10.216.28.11 with HTTP; Thu, 8 Apr 2010 11:52:00 -0700 (PDT)
Date:   Thu, 8 Apr 2010 20:52:00 +0200
X-Google-Sender-Auth: c7a6f56fc1d655d2
Received: by 10.216.91.12 with SMTP id g12mr258131wef.77.1270752720993; Thu, 
        08 Apr 2010 11:52:00 -0700 (PDT)
Message-ID: <s2y10f740e81004081152u53d1520fp812bd2defe886220@mail.gmail.com>
Subject: [PATCH] mips/txx9: Add missing MODULE_ALIAS definitions for txx9 
        platform devices
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

Hi Nemoto-san, Ralf-san,

I need the patch below to enable autoloading of the TXx9 sound driver
on my RBTX4927.
It works very nice as a low-power MPD player.
