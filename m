Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 16:56:32 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.153]:13712 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491790Ab0FBO40 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 16:56:26 +0200
Received: by fg-out-1718.google.com with SMTP id 16so1312769fgg.6
        for <linux-mips@linux-mips.org>; Wed, 02 Jun 2010 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=JsQ5MYAzDQKFv7L0/obW/H1daf+/4W88pF0t/BKdJ54=;
        b=YyLXHqQRCEWANcut4lYdkrLChzT/0zpTtkMmM25idv7uBPkfPQmqzcUQJQ6th1f1+W
         nuEwv/dg6saWMwGzrVEMA2fxJ2O4mHlG2FSjb0MzSW2V67taJuGMHmZZUTvIyKuNId39
         eThakSykcTu/bkRkFZcYlR8+cLvpdr+y8nrMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=G7udwPCWYXzWAuRi07/7gKYFnEveEAL9SenVIx14p7xf9GjOBeWsA0aHgYI0EFBHQu
         WeHu8RBd79ZuMFWk7c6mE8Tqc8G/QaZcIbMFlcneyWWCDTTe4/cTVbncc/TbofeOu4Ny
         7pSQuLvedUffT4vaaLAIFIb5aX2wKckvd5QNU=
Received: by 10.87.45.15 with SMTP id x15mr13736628fgj.42.1275490583886;
        Wed, 02 Jun 2010 07:56:23 -0700 (PDT)
Received: from [192.168.2.50] (host-83.2.142.85.tvksmp.pl [83.2.142.85])
        by mx.google.com with ESMTPS id 4sm121508fgg.27.2010.06.02.07.56.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 07:56:23 -0700 (PDT)
Message-ID: <4C067116.9000907@gmail.com>
Date:   Wed, 02 Jun 2010 16:56:22 +0200
From:   =?UTF-8?B?SXJlbmV1c3ogU3pjemXFm25pYWs=?= 
        <irek.szczesniak@gmail.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     linux-mips@linux-mips.org
Subject: Re: MIPS 24Kc
References: <4C055A60.3000203@gmail.com> <201006012144.43447.florian@openwrt.org>
In-Reply-To: <201006012144.43447.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 27004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: irek.szczesniak@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1407

Hi,

> I would recommend checking OpenWr's ar71xx port[1] which supports RB433.
> 
> [1]: https://dev.openwrt.org/browser/trunk/target/linux/ar71xx

Thanks for the information.   A few weeks ago I downloaded the most 
recent Kamikaze release (8.09.2), and I didn't get the option of KGDB 
for ar71xx, and so I didn't use it.  But now that I checked out the 
trunk, that you point out, I was able to built OpenWRT with the KGDB 
support!  That's cool!


Best,
Irek

-- 
Ireneusz (Irek) Szczesniak
http://www.irkos.org
