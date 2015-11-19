Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2015 12:23:13 +0100 (CET)
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35066 "EHLO
        mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012757AbbKSLXKdfcJD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2015 12:23:10 +0100
Received: by lbbsy6 with SMTP id sy6so41449972lbb.2
        for <linux-mips@linux-mips.org>; Thu, 19 Nov 2015 03:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=JOKOrEFIUY11BdghZifwSM5rRLA0Y3Hkamc7jOMhnak=;
        b=gRk3RjUV1kLmgYyoPg6HrakI5aW5bDABlOpTTbxTSkUSVKh+/dgIKqPIorDxzqPmaX
         54GpylSHpFNIpVs1X2a7glKGjg2VgmaH65jYIYC2RwVeJJ+zc2x7bbfOahn77ICFNVUV
         SF6M+lfZosonOYwz545CY3RDhfjr2rBmKLv0WLXRub5up7r2pcu5vjWn+MorhWNMIK21
         bbrmSCUJxnfb0J+VRtGDeRq07z9uopKg7vxzxwwXXIVZ91vNAcDpa8RFiDTK4J1UQm+S
         p19QVIlFzpNW8TDOrNsBFclTy/NIkKXIOLdyoe+MOAW8d0WnIXSwGQzmrVSXi4F7KULl
         QxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=JOKOrEFIUY11BdghZifwSM5rRLA0Y3Hkamc7jOMhnak=;
        b=nIqz9AbsbPTbFSsrFd7uXXvoY+slo8SKlQOY2B+wuIu+DWw0eAMJMN8TSge/S4n5yi
         ICInn+Xjqt+mwWSAs81xCOVX89J1q14//xtXCBBQddBZgCudvOja/gGmgx/03LbRaGJB
         uKLvw82H6zYhlcq0mGK3TFYWDZerAYfFFdndzdTjlpD88tgWT9KeLYNnW+L4+oe6r2in
         6k0OciE93J7/IVDQEsH1aAQv+MXKc50WCeGVOpvOjIqffv60/373jw5KPj+kyadwmI/c
         NMd6TwVGK/BZTrM11TichoIyS7fTOlrlc+f00jk8WPJFIhNAWvuboBDufEDEkdS0orRt
         wMaQ==
X-Gm-Message-State: ALoCoQlfG0Wgwz43B9iJYjbIqI4+XlfyzD6D/kil7smqosXieNHMaVpIq/6nLkqb84i2WD+O/wot
X-Received: by 10.112.126.42 with SMTP id mv10mr3041155lbb.98.1447932184775;
        Thu, 19 Nov 2015 03:23:04 -0800 (PST)
Received: from [192.168.4.126] ([31.173.80.109])
        by smtp.gmail.com with ESMTPSA id zc2sm1117945lbb.40.2015.11.19.03.23.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2015 03:23:03 -0800 (PST)
Subject: Re: [PATCH 2/7] MIPS: BMIPS: remove wrong sata properties
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
References: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
 <1447900493-1167-3-git-send-email-jaedon.shin@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <564DB116.5020809@cogentembedded.com>
Date:   Thu, 19 Nov 2015 14:23:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1447900493-1167-3-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 11/19/2015 5:34 AM, Jaedon Shin wrote:

> The brcm,broken-{ncq,phy} properties are not used anywhere in device
> tree, and the sata driver for BMIPS_GENERIC is not used it too.

    SATA. Using.

> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

[...]

MBR, Sergei
