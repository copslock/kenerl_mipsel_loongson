Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 11:58:43 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:61488 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492041AbZKYGe6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 07:34:58 +0100
Received: by pwi15 with SMTP id 15so4905375pwi.24
        for <multiple recipients>; Tue, 24 Nov 2009 22:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=ib/z1lpHSlBHKEImf/CGIqnlD6UPFXwxJEQmU345zmE=;
        b=CU92qy4nHj1WiIrHS2j7+XHZIAjB5qe87bGoHLAMlKLN/vVHHverrcjZenrp1TryDJ
         GIktbFpm9pMmFtzrlESz26STofBQMAxwi8PwDbHIfH67CDQwXlr9/mclqg1yOEHLFGKA
         PnW0Tx85STCdViwt2eECx88pQdB1XPOLJDr5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=GrYUIUaTqww1vEFCGASmvLzHtiwbxxQham6KFD4RhETq7O3vto/BOLDoiYthY6iowb
         uR5kZV0agS5IdTAnWkT3qzpTwVdft2HSK3Bmrr/YIqLR0u46pLYOohe7XWKmvV10j/uT
         o8cVYm7ghc2o5TS/W95csUtwIil5EeQx3xE84=
MIME-Version: 1.0
Received: by 10.115.133.7 with SMTP id k7mr14680095wan.96.1259130888406; Tue, 
        24 Nov 2009 22:34:48 -0800 (PST)
Date:   Wed, 25 Nov 2009 14:34:48 +0800
Message-ID: <c6ed1ac50911242234p12817b55r1a062d59949308bf@mail.gmail.com>
Subject: how to support more than 512MB RAM for MIPS32 ?
From:   figo zhang <figo1802@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e648f67e54484404792c4115
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25119
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e648f67e54484404792c4115
Content-Type: text/plain; charset=ISO-8859-1

hi all,

I am using 24KEC SOC, i want to support larger more than 512MB RAM. The
mips32 architure  in Kseg0/Kseg1,
such as:
0x8000,0000 ~ 0x92c0,0000  # 300MB for RAM
0x92c0,0000 ~ 0xa000,0000  # 212 for I/O register

so, mips32 only support 300MB memory, i dont how to support more than 512MB
in linux-mips kernel , such as 2GB memory? it is using HIGHMEM strategy
for kernel(ZONE_HIGHMEM)?

Best,
Figo.zhang

--0016e648f67e54484404792c4115
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi all,<br><br>I am using 24KEC SOC, i want to support larger more than 512=
MB RAM. The mips32 architure=A0 in Kseg0/Kseg1,<br>such as:<br>0x8000,0000 =
~ 0x92c0,0000=A0 # 300MB for RAM<br>0x92c0,0000 ~ 0xa000,0000=A0 # 212 for =
I/O register<br>
<br>so, mips32 only support 300MB memory, i dont how to support more than 5=
12MB in linux-mips kernel , such as 2GB memory? it is using HIGHMEM strateg=
y<br>for kernel(ZONE_HIGHMEM)?<br><br>Best,<br>Figo.zhang<br>

--0016e648f67e54484404792c4115--
