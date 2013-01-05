Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2013 13:49:45 +0100 (CET)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:49784 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab3AEMtolLRsu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jan 2013 13:49:44 +0100
Received: by mail-wg0-f49.google.com with SMTP id 15so7962565wgd.28
        for <multiple recipients>; Sat, 05 Jan 2013 04:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:organization
         :user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type;
        bh=DXshXF46SqE7eUI5iGfj9egc/93oOpJwlfULEQcDr/A=;
        b=cuz1LuCgs+CVpa9dPmFGi6ExaDZuWaoh8iBB+ac5KIghw1JH77FHV4eC696W3mys2b
         XJXeTNOM+alAp4pA3Nei6XhuUgrQD2T8TziLuMPyy39APOOGBTyFU7Ya/S0kywaLj2xr
         khpNYXXPzFeqlyQOzOtawp9EKNrMvjayr+gLWSi/pfbINMnUHmAmjnBE+EbC7o/SjqpE
         bnoUtl+Dw9NLVQWksNM0mA5d2anRGi0ExDP8A+jlcAYCQbT1dUlohtqcAY8CX0Y+UbbB
         kCBNppglbymyRhqgLNKGbw/wtlxii3TpvUxO0+p507F1+wRZhTsl14zeDk1sZIR6XTaj
         r9dQ==
X-Received: by 10.194.76.165 with SMTP id l5mr87953451wjw.14.1357390179132;
        Sat, 05 Jan 2013 04:49:39 -0800 (PST)
Received: from bender.localnet ([2a01:e35:2f70:4010:a1f8:aa2f:bb07:776a])
        by mx.google.com with ESMTPS id t17sm3539655wiv.6.2013.01.05.04.49.38
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 04:49:38 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: Re: [PATCH v3] MIPS: dsp: Add assembler support for DSP ASEs.
Date:   Sat, 05 Jan 2013 13:49:35 +0100
Message-ID: <28281784.2mN2Dnoq8K@bender>
Organization: OpenWrt
User-Agent: KMail/4.9.3 (Linux/3.5.0-21-generic; KDE/4.9.3; x86_64; ; )
In-Reply-To: <1357243312-23070-1-git-send-email-sjhill@mips.com>
References: <1357243312-23070-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 35380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thursday 03 January 2013 14:01:52 Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Newer toolchains support the DSP and DSP Rev2 instructions. This patch
> performs a check for that support and adds compiler and assembler
> flags for only the files that need use those instructions.
> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

Acked-by: Florian Fainelli <florian@openwrt.org>

Thanks Steven!
-- 
Florian
