Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 12:51:19 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:63679 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1FFKvQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 12:51:16 +0200
Received: by qyk32 with SMTP id 32so830438qyk.15
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3G5+F40d+VgUqD0ENGQDFp+UrjbfeCuiSiO8r6nyVTY=;
        b=a1MKq3Eanq1j5n9AkM6+HjyFmPsvwbKF52uByAj0Hw9CDvCPxP3di+TZflhrOKqH4z
         1SMJMh1ftqOatrpqa3oaNrx2S9MD7ohBg3hPmUnyqDhnPOTtMK0l46k0JoAXYartJARZ
         MV8UzBeLpxhbjk9Rg1yMuJPx4SSV8s8XzwAoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XcPHQH3qqo47aF0ylX7ZAb2ZZKrruvKZEZ+SCht3n/nRIKuygdKEEGOjQY2PxrZu+L
         btkO4OAfuFKenGfR/jtbVpOPzeeSdpIcCb+KqaK00k9wlFSCojB4VUNOc91OtI3DNgRi
         ORXVdvZ1d/RDjDzUiB/PsiPhOkC0Ei6yavb/8=
MIME-Version: 1.0
Received: by 10.229.118.69 with SMTP id u5mr3387550qcq.122.1307357469932; Mon,
 06 Jun 2011 03:51:09 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 03:51:09 -0700 (PDT)
In-Reply-To: <1307356322.28734.11.camel@dev.znau.edu.ua>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-4-git-send-email-hauke@hauke-m.de>
        <BANLkTi=T6xO9q+vOCk5Fu+2J_nUTwX3dcg@mail.gmail.com>
        <1307356322.28734.11.camel@dev.znau.edu.ua>
Date:   Mon, 6 Jun 2011 12:51:09 +0200
Message-ID: <BANLkTimkKFAEfbKaWo81=uyuDS=gjESHAw@mail.gmail.com>
Subject: Re: [RFC][PATCH 03/10] bcma: add embedded bus
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     George Kashperko <george@znau.edu.ua>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, mb@bu3sch.de, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4103

W dniu 6 czerwca 2011 12:32 użytkownik George Kashperko
<george@znau.edu.ua> napisał:
> Hi,
>
>> Hauke,
>>
>> My idea for naming schema was to use:
>> bcma_host_TYPE_*
>>
>> Like:
>> bcma_host_pci_*
>> bcma_host_sdio_*
>>
>> You are using:
>> bcma_host_bcma_*
>>
>> What do you think about changing this to:
>> bcma_host_embedded_*
>> or just some:
>> bcma_host_emb_*
>> ?
>>
>> Does it make more sense to you? I was trying to keep names in bcma
>> really clear, so every first-time-reader can see differences between
>> hosts, host and driver, etc.
>
> how about bcma_host_soc ?

We get then inconsistency with "BCMA_HOSTTYPE_EMBEDDED". I'd like to
1) See something like bcma_host_emb...
xor
2) Use bcma_host_soc_* and BCMA_HOSTTYPE_SOC

-- 
Rafał
