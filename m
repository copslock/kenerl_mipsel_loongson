Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Nov 2017 04:32:25 +0100 (CET)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:36148
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbdKUDcOZ5O3T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Nov 2017 04:32:14 +0100
Received: by mail-pg0-x243.google.com with SMTP id k190so4423787pga.3;
        Mon, 20 Nov 2017 19:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cmDJpWAl5dA/sejKMUjeM37sbvGwBsP7avcpOKULlJc=;
        b=T6zFvPAcd7xGP/1M197oq1FsoBrLSMo+o3mfqTPMrWsX0KMUU3kUgsfwsaqE2M2a2w
         yBn43yOVWpOWhmwOP6Jw8q3943D0Wi4KdoaCjU82yIUG7McBrhNCpst3Z5Zqf3Op0KE9
         n6t2kF9kOXcryNBMUlS6lzLWyertL91Wcpw0KwgIrHhYK/FhHhvCkAtDvaZhW133mxdC
         NXbszC0jQiXGhq0oxfpwcwU9AZO3NJsV86Tgp0R/yCqQ4e/yAIoKdAxeSiMYKLbjaM7f
         qQFSGWupQDc4ciirKhPmChpHE0HKiFUyHSo9OfP5s868LoaZS6coB4rSz9d5X4Phmk45
         BilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cmDJpWAl5dA/sejKMUjeM37sbvGwBsP7avcpOKULlJc=;
        b=ILH9sKcxKQdrAV1pcNa5Kn7c5rkCh/6B5lTJKAW50pHh7PQ+rBFe4UgJ/UV3d8yfJJ
         c7fyu6fmbIX4uOkIFqSP7AaUOrt0LdTeTW5M/8GIPJ2dR2JyFIhOAysbZzQVR9v2MQNx
         6wL8nHBCVOtlGd+6RoeChGgsy1tVst5nHAa8EpyLRzkzCpgcvjm1WTI553anDUkx7P0r
         REtQPYNVq4gx3Q6LfZTKPsoi5S4vous/gHHNE9zuOVqigD3P34d6Y5kUZfO/f+MXb2am
         jqcS+tOBLPlKKISUf5t6WomdwCWEQ1MuHcS6z8LCCNZTgZcXfD1YxW4HVuN2gzukxOuA
         3r+w==
X-Gm-Message-State: AJaThX6bIZHn2MsQNeBFhVlcpCsxehAwDy+fAnu2gyu7EC/CqUsk/KgS
        0T2wVZb2xcEjulnGZa5F+XCCNg==
X-Google-Smtp-Source: AGs4zMYjznLrC8F2VIr3C/QLWtRoEwDbMhP0L3UEbxHVcvLjvUxQwqhgQIpvC4Osrx4E31IkHm4mjw==
X-Received: by 10.84.141.36 with SMTP id 33mr16077122plu.247.1511235127454;
        Mon, 20 Nov 2017 19:32:07 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h75sm9031664pfj.68.2017.11.20.19.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 19:32:06 -0800 (PST)
Subject: Re: [PATCH] MIPS: Fix CPS SMP NS16550 UART defaults
To:     James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-kernel@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
References: <5e88e3d4-3c4b-b5eb-0b32-d0c0902e14c2@roeck-us.net>
 <20171121000240.4058-1-james.hogan@mips.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <286daa85-6bae-939a-a2a4-53ec08b7c340@roeck-us.net>
Date:   Mon, 20 Nov 2017 19:32:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171121000240.4058-1-james.hogan@mips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 11/20/2017 04:02 PM, James Hogan wrote:
> From: James Hogan <jhogan@kernel.org>
> 
> The MIPS_CPS_NS16550_BASE and MIPS_CPS_NS16550_SHIFT options have no
> defaults for non-Malta platforms which select SYS_SUPPORTS_MIPS_CPS
> (i.e. the pistachio and generic platforms). This is problematic for
> automated allyesconfig and allmodconfig builds based on these platforms,
> since make silentoldconfig tries to ask the user for values, and
> especially since v4.15 where the default platform was switched to
> generic.
> 
> Default these options to 0 and arrange for MIPS_CPS_NS16550 to be no
> when using that default base address, so that the option only has an
> effect when the default is provided (i.e. Malta) or when a value is
> provided by the user.
> 
> Fixes: 609cf6f2291a ("MIPS: CPS: Early debug using an ns16550-compatible UART")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-mips@linux-mips.org
> ---
> Guenter: I'm guessing this is the problem you're referring to.

Yes.

Tested-by: Guenter Roeck <linux@roeck-us.net>

mips:allmodconfig still fails to build with this patch applied, but elsewhere.

In file included from /opt/buildbot/slave/hwmon-testing/build/include/linux/bcma/bcma.h:10:0,
                  from /opt/buildbot/slave/hwmon-testing/build/drivers/bcma/bcma_private.h:9,
                  from /opt/buildbot/slave/hwmon-testing/build/drivers/bcma/main.c:8:
/opt/buildbot/slave/hwmon-testing/build/include/linux/bcma/bcma_driver_pci.h:218:24: error: field 'pci_controller' has incomplete type

Guenter
