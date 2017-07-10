Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2017 17:54:38 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:36360
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993423AbdGJPybnsOfg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2017 17:54:31 +0200
Received: by mail-wr0-x244.google.com with SMTP id 77so25802987wrb.3
        for <linux-mips@linux-mips.org>; Mon, 10 Jul 2017 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XVDJnC50w8J4HNmcZ/7GVe/tst1GTDK7Y+EqHDiOpF0=;
        b=Km7JRUiDF2ugEJEvkDCcTZFZw0hkQ9ca1ae+WZ33gU1X5kjDelDc9tw+hWLotsxsm/
         zmmcotNxFGFSmCX4gQDkkWwAuW4HLsl1zGWhMt3dnoXzL70uNsdNHEaEl3TgVHN5oxLC
         EPPGFdT4ccTxs3eNeK59VtLXOzPc0ov8sW+jBa5oMeDT4g0J9nP2/CH8O9fu6pQ6TwYl
         9OzqtxiqPSezLtqjkam9IOPlFbsoYFG3hxL+WeY3uZpqg6KtaFvTKWsOqEyIIe2rkyVd
         fdfhRmp+xw0XVNOIT754XJVVb7o8pzC0tk3EINxQf11wihXLqM5a8cM+cWJLgDEyI+g+
         aHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XVDJnC50w8J4HNmcZ/7GVe/tst1GTDK7Y+EqHDiOpF0=;
        b=nKc01qoa58usUNJMpBWmGdvSFXxuNw7Tc0AokhzkWph+0WHHe6mTgMd3NvpQ39FFXY
         zSnwBpwZ1knEZheOBlKurohEllzjQaIKuWmMfxFoMB31TfYDLanI+oO2zHTxKUpMc5ze
         Xc5YfA5RT7YKHB1+oN4qbOVz8rIk9/3PcufCjU9t/fdV9pwGGPAMaBRbECm6zdJaqeK/
         uqX0gL7WsQSIsERXLb0nlYOHIBwsmLRY9Gtg2vfBtMB6EdXjOUwByvJkM05UpRlOfprF
         H0IDyH+v1ITETodwyA/t+hdrpFNMwhg5PijLT9isuyIrVQ8eSlB6shIZ5Z8Eh1W63XTj
         ZYuQ==
X-Gm-Message-State: AIVw110npzDaqaEPR2tJDiwsPp8gS0A8ylMJy9XKQipMX/jaKcgpLe2k
        BoJqDL25p1cg8Q==
X-Received: by 10.28.172.4 with SMTP id v4mr8622655wme.72.1499702065609;
        Mon, 10 Jul 2017 08:54:25 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id w198sm12540085wme.21.2017.07.10.08.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 08:54:24 -0700 (PDT)
Subject: Re: [PATCH 5/6] irqchip: brcmstb-l2: Abstract register accesses
To:     Doug Berger <opendmb@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:BROADCOM BMIPS MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20170707192016.13001-1-opendmb@gmail.com>
 <20170707192016.13001-6-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7cd8c234-f048-fdc7-6e66-277de550265a@gmail.com>
Date:   Mon, 10 Jul 2017 08:54:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170707192016.13001-6-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59084
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

On 07/07/2017 12:20 PM, Doug Berger wrote:
> Added register block offsets to the brcmstb_l2_intc_data structure
> for the status and mask registers to support reading the active
> interupts in an abstracted way.  It seems like an irq_chip method
> should have been provided for this, but it's not there yet.
> 
> Abstracted the implementation of the handler, suspend, and resume
> functions to not use any hard coded register offsets.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
