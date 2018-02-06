Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2018 21:10:11 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:32873
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991534AbeBFUKEIEhJO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Feb 2018 21:10:04 +0100
Received: by mail-qt0-x243.google.com with SMTP id d8so3997393qtm.0;
        Tue, 06 Feb 2018 12:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PSRCp3FThBwEKeZsZVrOcuBBygqfu+w49bm1Cdv0mNQ=;
        b=ol/KMsni3FS9JTN7FZj75U0Ki6V2nIht/GyJ4wp++WUBAzShjMBen8FIFQHnDVW1iu
         L1cDbSHn7iCp+wp3QMxweK6GvmgVnae+M3dC1AA8lyZq/0COK9znafj5H7ezTHmUCST+
         f1WRalJsYnU0X3DS23eKeJaJT0meOOGmYO8WiIeIeGi8dSQnmzZEeD4bhP2x4iHg2JJO
         BeRZHoNvUt4mHCq+vq0QUP91JbPHWl2Gc6/2XoRolpLMNrCIlUN9LFDIXLVTtdBhV+JZ
         nfSzaKFhHf4Ovork8DUkfKeUD6YgTmxcXxCHWKHem7l1krlFCnqstdzFskyk4xG7BceM
         xPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PSRCp3FThBwEKeZsZVrOcuBBygqfu+w49bm1Cdv0mNQ=;
        b=BwfK/NbXSA0PXdrDGKjrzHXDZ1hdXzFxMVQlWfOT1VP0dXwpcMbGXIC7TDJZjZ1Ink
         xOzLDtvpRZWj87AH2IShGZfZH5960FoIHLNOwaBvz+7aDnoNskNjd+mItYs0JwUrKzPw
         tADeBTWHkQISn14uX7FoaH8beqxa+rFIPTfvBy7eX64F0a6cFKGEYKgKf0NsZwVkZ9aR
         m4ehZtWO9C72qBXHdK18K7t6bBN7RvGORU4XtqibOQAEUpfH5iKcLPQFk8Kal4XftTb5
         M5k7LjeXfjAgdtHxxWMEyVg3AkDibzNo89M5igsAz+dW8CFDx2aohHDga06TMh0iAGac
         wCiw==
X-Gm-Message-State: APf1xPDcazHjQzAUb5W0JwkOGtIInOpeBdHtdXB1Y6uaykYnYo61t73I
        xzrjeLkKFIjdJxZMQ/vv2ilq2zUa
X-Google-Smtp-Source: AH8x224DgrsDGT1Ol+CY/LfR0/EeM1UzCqCCTjGb3NUWc4CDrki3+Lw5rWj/+mzm39+1DyZF7qZV6w==
X-Received: by 10.237.32.68 with SMTP id 62mr5638925qta.340.1517947797105;
        Tue, 06 Feb 2018 12:09:57 -0800 (PST)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id b22sm8549158qta.25.2018.02.06.12.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2018 12:09:55 -0800 (PST)
Subject: Re: [PATCH] MIPS: BMIPS: Fix section mismatch warning
To:     James Hogan <jhogan@kernel.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
References: <20180206031321.34599-1-jaedon.shin@gmail.com>
 <20180206173525.GE8479@saruman>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8e34b651-165e-5a07-2764-337cbe7b9ffb@gmail.com>
Date:   Tue, 6 Feb 2018 12:09:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206173525.GE8479@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 02/06/2018 09:35 AM, James Hogan wrote:
> On Tue, Feb 06, 2018 at 12:13:21PM +0900, Jaedon Shin wrote:
>> Remove the __init annotation from bmips_cpu_setup() to avoid the
>> following warning.
>>
>> WARNING: vmlinux.o(.text+0x35c950): Section mismatch in reference from the function brcmstb_pm_s3() to the function .init.text:bmips_cpu_setup()
>> The function brcmstb_pm_s3() references
>> the function __init bmips_cpu_setup().
>> This is often because brcmstb_pm_s3 lacks a __init
>> annotation or the annotation of bmips_cpu_setup is wrong.
>>
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> 
> Reviewed-by: James Hogan <jhogan@kernel.org>
> 
> Should CONFIG_BRCMSTB_PM=y be in any of the bmips defconfigs to get some
> build coverage of this?

That would be a good idea, Jaedon, do you want to submit a patch doing
that or should I?

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
