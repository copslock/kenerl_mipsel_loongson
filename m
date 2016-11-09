Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 22:29:12 +0100 (CET)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32822 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993030AbcKIV3Fqzkx1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 22:29:05 +0100
Received: by mail-wm0-f67.google.com with SMTP id u144so31787798wmu.0;
        Wed, 09 Nov 2016 13:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=yxTceWifdZenW8nS8aH83RLJiGszyVhkHZr1ywfu66U=;
        b=gzQdsQARSceoKyQG9X7/nWt98AQ3/aCOHQIWB8nNsSVlpo18zYzoFQCB7MHqx+Kw4H
         FuepTG3TV7rH/OqX+69MtHPGUE6bDM/CB/t2PN+RsR8bywL5XcNaaaQL2VsgG1Vuz/6s
         TwFV5QhgH9hWQtNrTSL5fnb9wmUbXVUCUeJgngj3axzBMmrnBgFIbfSXdMqd3fapCTDX
         Peokf4XIQ0d+I6IXDpupo1y5gZYpG1Fnu66jJ0AuJi1IuCzxLKwR0sHdXxkJeFEiz4nK
         oNmk/kk9NuSItWjxe7livMSX7oEcF16s3WaJhmbvRYRHBbZteXkuklgAeyOQi9da+fjb
         M2Ww==
X-Gm-Message-State: ABUngvdogf9IS/lHN/a5Iy/1EYI2qrvOTqFtig7Fy1odSTfUjZwcFg8FSIhHJysBVkoCzA==
X-Received: by 10.28.209.67 with SMTP id i64mr2662870wmg.48.1478726940533;
        Wed, 09 Nov 2016 13:29:00 -0800 (PST)
Received: from [192.168.0.102] (ip-78-45-88-157.net.upcbroadband.cz. [78.45.88.157])
        by smtp.gmail.com with ESMTPSA id l67sm18546020wmf.0.2016.11.09.13.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2016 13:28:59 -0800 (PST)
Subject: Re: [BACKPORT PATCH 3.10..3.16 1/2] MIPS: KVM: Fix unused variable
 build warning
To:     James Hogan <james.hogan@imgtec.com>, stable@vger.kernel.org
References: <2e791b20c24570339d15118a55e174f5b2d63ac1.1478707766.git-series.james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <dc526766-4588-52df-6cee-f7a6121e3468@suse.cz>
Date:   Wed, 9 Nov 2016 22:28:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <2e791b20c24570339d15118a55e174f5b2d63ac1.1478707766.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 11/09/2016, 05:13 PM, James Hogan wrote:
> From: Nicholas Mc Guire <hofrat@osadl.org>
> 
> commit 5f508c43a7648baa892528922402f1e13f258bd4 upstream.

Both applied now to 3.12, albeit the latter didn't apply cleanly.

thanks,
-- 
js
suse labs
