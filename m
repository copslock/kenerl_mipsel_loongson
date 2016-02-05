Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 14:32:16 +0100 (CET)
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34439 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010502AbcBENcOVj4cO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 14:32:14 +0100
Received: by mail-lf0-f54.google.com with SMTP id j78so57188943lfb.1
        for <linux-mips@linux-mips.org>; Fri, 05 Feb 2016 05:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=0hS312N3E5DF5eDQtuHwD9DBPQZKzdCcmzs20zfYAt0=;
        b=bT35sCr3sc6Y2+htfhaBD86shQ72aaNcwHY3Vn8hAGS6yOAYyGNmp5kDjYuoQi6DYG
         JwprPvjrZIP2jR0/CfBXOauNhSt5aURX3XIOBLa8xlBtuZ6sev/kYnh4Xs6rrppVMo8+
         IhQ1vbV5PaHFRKEAiBjP218SkNtRzVJeNATzasQYgX5AQS+qlXZuqV3q0Szf05PVKUn9
         cCLMtNF3SwpzaUFyOClopllhYUGMZ3doSYew18RRpG4nym4Zcfl+uptzzV+W/lvAPt3V
         1Tu9LFfCmZrhC04vsHZqeikdaQnGotkRrqU3lgaNd13smVkcjl5BEqm/1jTWb9FbhbLZ
         0CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0hS312N3E5DF5eDQtuHwD9DBPQZKzdCcmzs20zfYAt0=;
        b=bVG66tMY9BRKp/K3peB+HIhjRSoUBYyVyAvBnKFtMa3f0pnXOz5RVjAs/VTSVxpIQz
         ZvgHPOfbIL5EJiAzLPOAJifKeCS38/1IQPBOR5spNYFPtZfFfDUi0NY2K93de8r4Rw0W
         KN6rnwfdY2Pi1qOUMek9vy9RpAi26ncFp2mKLGiGMT8Ft4FYL1aMRK91wZ+8rQfoXDZi
         YTCKskFm1mY/qZd+AcrvNsMQwjWuESp+UbJVhkGcC2Kb7jmmXL1jAub2j7WFW1o0lTVj
         ImliysZ968Ln/I4J/giMidgen8C7UiZWwOAKjitV6TW24qKNyOLVxhhnd1/MYh9m1TAc
         5oLw==
X-Gm-Message-State: AG10YOQrx8JZDiWWFg4JkZlRXSbKLMldagQ6U6NssuruTR/Tn80Mj/FCxegsTG4C2bmYng==
X-Received: by 10.25.169.134 with SMTP id s128mr6068588lfe.154.1454679128745;
        Fri, 05 Feb 2016 05:32:08 -0800 (PST)
Received: from [192.168.4.126] ([31.173.81.62])
        by smtp.gmail.com with ESMTPSA id jr10sm2251041lbc.42.2016.02.05.05.32.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 05:32:07 -0800 (PST)
Subject: Re: [PATCH 1/2] dt/bindings: Add bindings for the PIC32 SPI
 peripheral
To:     Purna Chandra Mandal <purna.mandal@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
References: <1454366701-10847-1-git-send-email-joshua.henderson@microchip.com>
 <56B08EEB.3050808@cogentembedded.com> <56B42E4C.8040201@microchip.com>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56B4A457.7050807@cogentembedded.com>
Date:   Fri, 5 Feb 2016 16:32:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <56B42E4C.8040201@microchip.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51810
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

On 2/5/2016 8:08 AM, Purna Chandra Mandal wrote:

>>> From: Purna Chandra Mandal <purna.mandal@microchip.com>
>>> Document the devicetree bindings for the SPI peripheral found
>>> on Microchip PIC32 class devices.
>>> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
>>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>>> ---
>>>    .../bindings/spi/microchip,spi-pic32.txt           |   44 ++++++++++++++++++++
>>>    1 file changed, 44 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
>>> diff --git a/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
>>> new file mode 100644
>>> index 0000000..a555618
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
>>> @@ -0,0 +1,44 @@
>>> +* Microchip PIC32 SPI device

[...]

>>> +Example:
>>> +
>>> +    spi1:spi@0x1f821000 {
>> Please insert spaces after colon.

> ack

    And please drop "0x" from the <unit-address> part of the name.

MBR, Sergei
