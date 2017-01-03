Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jan 2017 09:37:12 +0100 (CET)
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36725 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990518AbdACIhFtGpYC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jan 2017 09:37:05 +0100
Received: by mail-pg0-f66.google.com with SMTP id n5so32892728pgh.3;
        Tue, 03 Jan 2017 00:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yGt7aYRtQWPNvqzAPbV1RrZvoGbUV1inKM0/1wxVuvE=;
        b=oigu0at8Ko9IVuOIc4PTYmP9ax7Iu1E6h5vFAaz4bisX2ZaNqsPqVsDPFqODt4DRzB
         jmmpyGeVmc0tvzThGRsVoanzWv9IAQiR4c5aK64DD+Vt7hQjivfMsBI0ZvWd3I5SCNUa
         cC8M7VWm75VXQaoEsyAkgNv5ZuNfDoJk+uR1NKJvBoHVPVI88zhag5xmECLRMwrPHtcv
         m2/tG1VFgfoLclsqrDD2nHrx8KmiW1zjFWobxFdTJS30jBw8rrjOEXjgV4TyR45BRLIK
         V7OTcbjGyHhog2t/IeeWeACP+hgYoYhhIRCcqN0iH0vZeY8mcWYxAAcVwid4Loiayun4
         Sk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yGt7aYRtQWPNvqzAPbV1RrZvoGbUV1inKM0/1wxVuvE=;
        b=OfOPZRQ/rmsUvsN/iAxWc/xWkvu/P0xL2P1PetAAvzEEcWEM410OffjuNwBMVIAGry
         kBP3xLaNLwU746Oc5FBmsHtsOk0K1PTyCY4V7qfwU/Y1xkyAKQsZqYQkDEX036+gR5QS
         qEIUphXzOmPfbYr7cKdiWKL22XTJh+9oV7qBuXOxJMtyGO10+brJhcncVRiIluvrV/yI
         0xWi2hA+tEnlndm6mg0QUIlqE7n6GjB+chEzbvHPG/CFHVd3Gz71g+IikZcXxA6YnaZI
         mKSHWVnJv6tgxjh7qeLfFYVHAQiQ4sE2i3JOSWcOYc7wKeMe/6jYcR5r9pqySjcXhmi0
         sRvg==
X-Gm-Message-State: AIkVDXLeyFTHdHbLabAj3W5pMrd+5LLttRgeAJlsqVZL8KnOA4mVSYF0/NYNQb/ymHyr6g==
X-Received: by 10.99.171.65 with SMTP id k1mr113535620pgp.87.1483432618972;
        Tue, 03 Jan 2017 00:36:58 -0800 (PST)
Received: from [192.168.10.100] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 72sm137946728pfw.37.2017.01.03.00.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2017 00:36:58 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [v2 2/2] MIPS: BMIPS: Add support SPI device nodes
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <09536633-9c81-9621-36af-665369e97a78@gmail.com>
Date:   Tue, 3 Jan 2017 17:36:54 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <980BB972-94D0-4466-A888-3B65FBC5C851@gmail.com>
References: <20161230063001.944-1-jaedon.shin@gmail.com>
 <20161230063001.944-3-jaedon.shin@gmail.com>
 <09536633-9c81-9621-36af-665369e97a78@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3259)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi Florian,

> On 1 Jan 2017, at 3:42 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> Hi Jaedon,
> 
> On 12/29/2016 10:30 PM, Jaedon Shin wrote:
>> Adds SPI device nodes to BCM7xxx MIPS based SoCs.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
> 
>> +
>> +&qspi {
>> +	status = "okay";
>> +
>> +	m25p80@0 {
>> +		compatible = "m25p80";
>> +		reg = <0>;
>> +		spi-max-frequency = <0x2625a00>;
> 
> Sorry for not noticing this earlier, can we have the frequency in a
> decimal form?

I will change to "spi-max-frequency = <40000000>" in v3.

Thanks,
Jaedon

> 
> With that fixed, feel free to add:
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Thanks!
> -- 
> Florian
