Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jun 2017 08:44:15 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:33963
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990686AbdFDGoIWDYbQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 4 Jun 2017 08:44:08 +0200
Received: by mail-wm0-x241.google.com with SMTP id 70so453521wme.1
        for <linux-mips@linux-mips.org>; Sat, 03 Jun 2017 23:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=sender:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=F+yGtBUaH0bPYaZtu9f9hX7T/1b/iP4IKkW0DSiXrhE=;
        b=mfryyBYMd94OcM2iHUFb51/ccyDf+yd66AfbyDK5V77nyMEhEU8eIxfjeC9CldJ1lV
         GjXQgxD71VsOcJ5u6rVmpHagVJplbJ5fHPdpQATmlbyii/xhdJulAhmHpUAat3V6Nrzo
         0ByYT/tGa2GuDNcCx5OBS33dr2SEwri50ABfaG2jZaqJNtYH5WF7Zn85Ibcg5CbVLu5d
         XoF+2zf+CmFA52n0iQHCXda3guDS1N/G1dEnIYONCderNapLHRmqM684b6ARI2p8UzLm
         qpOCJshYBJO6gvZsNG7Q+y42wecjX5Jj7ZvELPaQhAOqysjhGgRDeSFnFVJp7zbpPuXC
         E+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=F+yGtBUaH0bPYaZtu9f9hX7T/1b/iP4IKkW0DSiXrhE=;
        b=G4gyCyvgnljWHOZF1oBlgkWXTAKxlyFhq6yZQF4hkkW33EnVaXdjVckD58abHCqezL
         zbZhJGeUIuOaKAdevv91X6sLBAVZmt79VDmOLvgAwFisUZBahqBRd6KF6+h/5sZA3E66
         xQH/XU6aGttn83+vsE4K3w1Pl+Mh70OckPOKdH4MImmUPs0m6oHerbIhoXTgcysVS3su
         D2gV5IJoC23JzjvHMEoesIQttvJosyEdwep7C71gB+PQExZMc475vGSjEIAK9pdWImi4
         8iTrU4KdeGMyGmxUGbr7TbrK9bluRHsVea8rizWUAY3aWT8XWRpYLV+PMzLst2rwU4Bq
         Z7Ow==
X-Gm-Message-State: AODbwcC9Qy8gDwBBo1r/WY2icsF5aNsBh6Y2UDyS8kwu8Jey/Q1NZ0ad
        uUs6H2kSNGCi0NF1z20=
X-Received: by 10.28.209.141 with SMTP id i135mr3929245wmg.123.1496558642652;
        Sat, 03 Jun 2017 23:44:02 -0700 (PDT)
Received: from android-f8911984c6e3e13 (jahogan.plus.com. [212.159.75.221])
        by smtp.gmail.com with ESMTPSA id g3sm913397wrd.11.2017.06.03.23.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jun 2017 23:44:01 -0700 (PDT)
Date:   Sun, 04 Jun 2017 07:44:02 +0100
In-Reply-To: <81bca3a5-88dc-d6af-9c6a-3e17d9a8bda5@longlandclan.id.au>
References: <996c275d-d969-508e-6b4e-bef22d8e7385@longlandclan.id.au> <alpine.DEB.2.00.1706031310470.2590@tp.orcam.me.uk> <81bca3a5-88dc-d6af-9c6a-3e17d9a8bda5@longlandclan.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: QEMU Malta emulation using I6400: runaway loop modprobe binfmt-464c
To:     linux-mips@linux-mips.org,
        Stuart Longland <stuartl@longlandclan.id.au>,
        "Maciej W. Rozycki" <macro@imgtec.com>
From:   James Hogan <james.hogan@imgtec.com>
Message-ID: <B0501081-3292-48D8-ACFF-043C3BA87D8C@imgtec.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 3 June 2017 23:26:00 BST, Stuart Longland <stuartl@longlandclan.id.au> wrote:
>Hi Maciej,
>
>On 03/06/17 22:43, Maciej W. Rozycki wrote:
>> On Sat, 3 Jun 2017, Stuart Longland wrote:
>>> Now, on a single-processor MIPS64r2 VM, this same root filesystem
>works.
>>>  It won't work though for a 8-core I6400 system.  If I try to run a
>SMP
>>> MIPS64r2 VM, I get "unable to proceed without a CM", so clearly
>there is
>>> a feature in the I6400 that doesn't exist in the MIPS64r2.
>> 
>>  Your userland likely requires the legacy NaN encoding (as specified
>by 
>> the IEEE 754-1985 floating point standard) whereas I6400 hardware
>only 
>> supports the 2008 NaN encoding (as specified by the IEEE 754-2008
>floating 
>> point standard), as per the R6 architecture requirement.  These
>encodings 
>> are incompatible with each other and all binaries are annotated in
>their 
>> ELF header as to which is required; use `readelf -h' and check
>`Flags:' 
>> for the presence of `nan2008' among the features reported.
>
>Ahh, quite possible.  I just compiled for MIPS III, not sure if that
>supports this alternate NaN encoding. 

Also, i6400 is mips64r6, which is not fully binary compatible with r5 and older. you could build an r6 userland (which i think implies nan2008), or else double check you've enabled r2 emulation on r6 in your kernel configuration (which will be slower but should still work).

>The ultimate target for this is
>Loongson 2F which probably uses the old encoding.

indeed. i think nan2008 is optional in r5, required in r6.

--
James Hogan
