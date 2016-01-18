Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 07:52:02 +0100 (CET)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33876 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010233AbcARGwA7YI8P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 07:52:00 +0100
Received: by mail-oi0-f67.google.com with SMTP id x140so11927167oif.1;
        Sun, 17 Jan 2016 22:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to
         :message-id;
        bh=XgOUs8uieJFZJg69sIALIvKKA/C5RotFCVCVYuBAPig=;
        b=evPQ8jw5aqunVi4n3FzSin07mMMIWaLZXN1jaVxHcxmNCfPbAdGct0dt4HU2qenGqv
         lVJkPPrWETmzMztq4VOrq/x1f4+bzrkQpt4M0cTW8YLInPwtqWfu2aTt1JrWNl+YBXS+
         7LcvVlEqBpjgN+4ExWr6KgnH28OMLxieaZxxxvDKYKlgzt45S58Q6t7WBgSM/2qTRCAM
         nyeI9jZezUz8gHj2D6fK/dMaPkuIOTKUIEhzhYB9AFLZzNPYVNnpVOhGikPi3qeQsTxk
         p+BOS3kRB0d6uxrijdnnUPUKOcEQQfUd8wjq9FDRuQnno1hoHycJLDNLew3w+OIkI9x+
         /T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to
         :message-id;
        bh=XgOUs8uieJFZJg69sIALIvKKA/C5RotFCVCVYuBAPig=;
        b=V83dIT0+jh0qDxmkIyNuW4DgMC6UrntsnT8POVRvlMfVeagixtsP9sO45YXpLJ579S
         Kj+ODQAZDZ37f7rVz3xAbT8lDRz/4boyLssB/nMV1Qaym81XIWFdgzqVqo08RfdD8DtD
         W79GxCldUnEk4agAh/6es3YxF0ERbCX8lDIb04DZQTu6vQtFG0IihEC3/DbVdp7oB3v1
         4IT/mr2+R/CnxJI03xamkFS9UJfQn+7j//QbLPbleym7vvJhgI9DVMUTQBPoGqrI6+pT
         yevR1V8kFGX6tUoRR2/vJFBxlyI+MepGGNlcZnpjMIuKRvq4l4zQjL7RDNI+Uw4zJiJJ
         DRUg==
X-Gm-Message-State: ALoCoQkV3D8qJikP+OXji1GjW/CJJGu0CKu3rVHBuY71CRJkknxpLTQVRJP9ZKkduLAghJYgyYIFKc1WOUAFttTOW8DXJRKXRA==
X-Received: by 10.202.104.35 with SMTP id d35mr17038419oic.128.1453099915297;
        Sun, 17 Jan 2016 22:51:55 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:903:9f9b:ce2a:20c0? ([2001:470:d:73f:903:9f9b:ce2a:20c0])
        by smtp.gmail.com with ESMTPSA id rh8sm11709636oeb.14.2016.01.17.22.51.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Jan 2016 22:51:54 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <1453030101-14794-2-git-send-email-noltari@gmail.com>
References: <1453030101-14794-2-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/2] bmips: add device tree example for BCM6358
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Sun, 17 Jan 2016 22:51:47 -0800
To:     =?ISO-8859-1?Q?=C1lvaro_Fern=E1ndez_Rojas?= <noltari@gmail.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jogo@openwrt.org, cernekee@gmail.com
Message-ID: <EBF05609-1E92-413A-B466-995AD821FB02@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51189
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

On January 17, 2016 3:28:21 AM PST, "Álvaro Fernández Rojas" <noltari@gmail.com> wrote:
>This adds a device tree example for SFR Neufbox4 (Sercomm version),
>which
>also serves as a real example for brcm,bcm6358-leds.
>
>Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

-- 
Florian
