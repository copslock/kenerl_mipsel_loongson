Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 03:07:44 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:35525
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992221AbdBHCHbUxFC2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 03:07:31 +0100
Received: by mail-qt0-x241.google.com with SMTP id s58so21532479qtc.2;
        Tue, 07 Feb 2017 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=O1xMhZTVR6Xmghd1x2zaZLBD1WXer2IbYlQtTnLzLjo=;
        b=HOcnjgBOQDnm0tGLJYqL/UfgrRiTcxw8zW+4vPmwtlC7QB+yN0JVRTqlH6VQ9NG22z
         qPil+Dfi5DPo/hAFPJg+kXqzV9Wg0wlsuuOWW3XSPrI56SCkBo0B1d77veIpIzC1gsqi
         bgVdfvnD1gLus3pC4zhzDIQXlvR1GimpxpKB2TcK0w2cKJe+SkyYJzbE49PJmZ5JbAmj
         BMh7FX4rBwVia6qOArfWpxBfskYkgc9IVYVVAsJlJd14rWnc7JMG8oYY6RUV91cd4x3I
         OLDyeZ/uUBPxa+54tSUlX6JXI3d+40JD7MSvxhXGoAZwjWxoX0NXWnXZiDrh42nws85R
         Xh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=O1xMhZTVR6Xmghd1x2zaZLBD1WXer2IbYlQtTnLzLjo=;
        b=tWsdmx6Dxo0fKbvsNC/1DsdIn5oIG/D7A+2vcqL92Zi43u9z4FZy59cjbYHn3BKXJZ
         aS+LZUNiOeTE5HUcQAjftFx37rSaNINPDVrorWvhXQJ5eIiUPgT86LPA45iKxYiEXedF
         uZcjnMaQswuyThCJ8Vf85wwPK/HEhULXhCKBzCRHPj5Bo8OUZigI5h9LdvOvszzbLvEG
         xdXvVM9OAkurGxcpKhwA2EDA6AGWDBvTetmS/XNsDylOSe7KOGTqXDksHAJEANxk7Ujj
         rGdEdmxS0pPgMzMWzrNfw4C3S6eC6QDOEc/ul5cVZMyJrVp+obz/zg9GXsUW6QdWJlWd
         B77w==
X-Gm-Message-State: AMke39mZVgqMX0jUans6PfBrebFFM9fQmO3S92jl5Ww3y4zwFmAiYNlBRIZ7YrQvpAna/Q==
X-Received: by 10.200.3.103 with SMTP id w39mr17242354qtg.181.1486519645700;
        Tue, 07 Feb 2017 18:07:25 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id q145sm4985042qke.37.2017.02.07.18.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 18:07:25 -0800 (PST)
Subject: Re: [PATCH v3 3/4] cpufreq: bmips-cpufreq: CPUfreq driver for
 Broadcom's BMIPS SoCs
To:     Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20170207215856.8999-1-code@mmayer.net>
 <20170207215856.8999-4-code@mmayer.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ffce8d46-0f9c-5145-82ef-a62920b55f0e@gmail.com>
Date:   Tue, 7 Feb 2017 18:07:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170207215856.8999-4-code@mmayer.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56728
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

On 02/07/2017 01:58 PM, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add the MIPS CPUfreq driver. This driver currently supports CPUfreq on
> BMIPS5xxx-based SoCs.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
