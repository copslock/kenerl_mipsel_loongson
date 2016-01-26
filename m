Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 00:17:17 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34231 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009298AbcAZXRP7DL6l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 00:17:15 +0100
Received: by mail-pa0-f42.google.com with SMTP id uo6so107047041pac.1;
        Tue, 26 Jan 2016 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=V1u1dO3+m11LJHcr9H2vAXOm2ZiBFsk7hU4S9gFbk64=;
        b=GtawUpwjVvDFA3wLe35N1di7Hwkrj3lffkoQBBSA5Ul6R1T3TMe0XxEPGFzrJCV+yV
         pw9CrAWmx7/wnEQVC3dGfAqas4/OXEfVmEiHccaqEaJU+oAO6HjnfV/w1DxexZUPR4NY
         z3hCyd4awDOHQ4ez3Zf+4KLxRTRKYKoH2VqSOd5a8cB+XMFPl1MlcDvx7oeTZ/vIVZEC
         Fb4t7OH3VjNnG6XcajRMfLfIet23SO/6Hry/b0Fh9gc1w/yQQjycMm8+ClHLkdGQTS2v
         L0Ds8VpOVi0sie8FvkiXRUEZEzr4qNbaedEf3yGMrCOlKafrSxQYJTy5OckKQOHXIhmU
         Lwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=V1u1dO3+m11LJHcr9H2vAXOm2ZiBFsk7hU4S9gFbk64=;
        b=fp21IfljtXDM3N8aS9jqlYe/HiWV9fTWQeLP6cVdykJhGozZNf62dxWuvC010KY9zv
         jN5TlnlRT+wL/UxJiy/ubuFYy7LRqiCe2hy6reC1AEWxLQ7QLRTypLVHmWUwoopkwEAS
         MDuX7qdnyXuN19XEp8xs23q4jIs1GXPTKqAYGuZTilD04CwqBMIhEfbtWopG1a8eP9QX
         u1TOHkpB/j5U4+2KSyxfgbscLS4cwBSt8TA4zNXDaKInJISPbRMIjgjw0F+AyNz1xEhy
         a0L7ziMPWodQ4NNhqpz/bPgiX0uvELTgkabYoVMDk7i8vz/E2jP7LDkrPAkoSbv5F7aX
         YQVw==
X-Gm-Message-State: AG10YOT2CV2XQCb9oIPKbOlRaAc7K23m59HTCZDuEvp78pFEmc/HQLH3u2uZdnB6iRFt2Q==
X-Received: by 10.66.139.166 with SMTP id qz6mr38075925pab.148.1453850229656;
        Tue, 26 Jan 2016 15:17:09 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id e14sm4147471pap.24.2016.01.26.15.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 15:17:08 -0800 (PST)
Message-ID: <56A7FE3F.5090909@gmail.com>
Date:   Tue, 26 Jan 2016 15:16:15 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 2/2] MIPS: dt: Explicitly specify native endian behaviour
 for syscon
References: <1453848410-24949-1-git-send-email-broonie@kernel.org> <1453848410-24949-2-git-send-email-broonie@kernel.org>
In-Reply-To: <1453848410-24949-2-git-send-email-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51442
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

On 26/01/16 14:46, Mark Brown wrote:
> On many MIPS systems the endianness of IP blocks is kept the same as
> that of the CPU by the hardware.  This includes the system controllers
> on these systems which are controlled via syscon which uses the regmap
> API which used readl() and writel() to interact with the hardware,
> meaning that all writes are converted to little endian when writing to
> the hardware.  This caused a bad interaction with the regmap core in big
> endian mode since it was not aware of the byte swapping and so ended up
> performing little endian writes.
> 
> Unfortunately when this issue was noticed it was addressed by updating
> the DT for the affected devices to specify them as little endian.  This
> happened to work since it resulted in two endianness swaps which
> cancelled each other out and gave little endian behaviour but meant that
> the DT was clearly not accurately describing the hardware.
> 
> The intention of commit 29bb45f25ff305 (regmap-mmio: Use native
> endianness for read/write) was to fix this by making regmap default to
> native endianness but this breaks most other MMIO users where the
> hardware has a fixed endianness and the implementation uses the __raw
> accessors which are not intended to be used outside of architecture
> code.  Instead use the newly added native-endian DT property to say
> exactly what we want for these systems.
> 
> Fixes: 29bb45f25ff305 (regmap-mmio: Use native endianness for read/write)
> Reported-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> Posted for review only, this will interact with some other patches
> fixing the implementation of regmap-mmio and will probably need to be
> merged along with them.
> 
>  arch/mips/boot/dts/brcm/bcm6328.dtsi | 1 +

v4.5-rc1 now contains an arch/mips/boot/dts/brcm/bcm6368.dtsi which
copied the 6328.dtsi and therefore needs this hunk to be added to your
patch series:

diff --git a/arch/mips/boot/dts/brcm/bcm6368.dtsi
b/arch/mips/boot/dts/brcm/bcm6368.dtsi
index 9c8d3fe28b31..1f6b9b5cddb4 100644
--- a/arch/mips/boot/dts/brcm/bcm6368.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
@@ -54,7 +54,7 @@
                periph_cntl: syscon@10000000 {
                        compatible = "syscon";
                        reg = <0x10000000 0x14>;
-                       little-endian;
+                       native-endian;
                };

                reboot: syscon-reboot@10000008 {
-- 
Florian
