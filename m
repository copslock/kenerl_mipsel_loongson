Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jan 2018 01:53:46 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:42413
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbeAFAxjYWd8P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jan 2018 01:53:39 +0100
Received: by mail-qk0-x243.google.com with SMTP id d202so8059804qkc.9;
        Fri, 05 Jan 2018 16:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gYHmLzYDscfAm1bj4bTa5VTyEPkxXkJgh6TEoHS9rpQ=;
        b=qH0KMHOrNPgJjQsAspP280Fn9olPCWI1NuWDh8rOJ5YjvhHCSxSC8TSbmxMRXqApEY
         cuRNNkXHRdS/qNvt8O4M+GjfhE1ez3E9GpUkxykeZFBX7KkcFuPlMMdkXTEcc8JEX8t/
         MiHayRo2+3kZ5YhzZJ0CMzAivxOQ0MRho/Ac0Z23Shqb7CyOuJznqEPgX2HRKdK3xJsw
         gLgc9GE2FZfZN5sxWvmBitTUY59fEsXw4yBx9ZUKLK3gs2OS4hRnVwzZmEuzDAgcJXwZ
         LHiqNbJMSep/+H8Xtgez2nIz0sicdlre3WAjfvTRKUwb8//ozTrf+46dBzvE3oHI5gfT
         BvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gYHmLzYDscfAm1bj4bTa5VTyEPkxXkJgh6TEoHS9rpQ=;
        b=lIv51ryDtk+XrRavTtS3RZkntVZParjA3r+Ldk4RGGMnSjX++/oLyOMHpdcz05MC5U
         jzS8z4BazxIjkoZ1v6vmf1WMMpkfujmEaMwPCnlZOlEMGJsXGcCk3hu4A7LzbkBYk4FF
         aGaBXnJQFmUAv0vSakW3xaVfiZ6zbDbmSLECDEsTzx+ASZb9cmXHnQ/leP7FLUVDviWV
         66T4rNTmSoCmbeeslBVC+SUhlXAvmFG2gfEY39j1eswoTOgUWD1DWrsHrT27+1+dfYu/
         sz8/iVUDZS3MIb0jywTuhLvmnYlGGbXV8IhLCvwSU5tya0rvAOVFhv2ricm6kl+cRZhg
         g5Eg==
X-Gm-Message-State: AKwxytdl5iovVI88NOMGbdFLDbEkOaOL3WW9pnKvnMBC8FwuHIF/52lJ
        r4dOzG5COgIl9LFZgAPfOl8=
X-Google-Smtp-Source: ACJfBov2M6+temhYdTqW2C2G4WKA/Um7J8o8Qk5LWX4LpD4W4NOHkorrm6crausJ2HKcPHZyarh3qg==
X-Received: by 10.233.216.70 with SMTP id u67mr6303751qkf.305.1515200013155;
        Fri, 05 Jan 2018 16:53:33 -0800 (PST)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id q12sm4295094qtk.32.2018.01.05.16.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 16:53:32 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Add James as MIPS co-maintainer
To:     James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <john@phrozen.org>,
        Matt Redfearn <matt.redfearn@mips.com>
References: <20180105213647.28850-1-jhogan@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ddd06175-24e8-7bd5-e938-b817ab4c26d3@gmail.com>
Date:   Fri, 5 Jan 2018 16:53:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180105213647.28850-1-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61949
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

On 01/05/2018 01:36 PM, James Hogan wrote:
> I've been taking on some co-maintainer duties already, so lets make it
> official in the MAINTAINERS file.
> 
> Link: https://lkml.kernel.org/r/33db77a2-32e4-6b2c-d463-9d116ba55623@imgtec.com
> Link: https://lkml.kernel.org/r/20171207110549.GM27409@jhogan-linux.mipstec.com
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: linux-mips@linux-mips.org

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks James!
-- 
Florian
