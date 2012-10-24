Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2012 19:43:35 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:50565 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823030Ab2JXRnejXart (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2012 19:43:34 +0200
Received: by mail-wg0-f43.google.com with SMTP id dq11so555110wgb.24
        for <multiple recipients>; Wed, 24 Oct 2012 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=B49uMJpUFJNYkYlc4nUYaWHZ9xuDh3kjNlZzciwV80g=;
        b=EO6dlKgx3poV8r/1W1nvrad1o5F2SAD0waLSqQAjjSAjLJR/Ulr1SVxLDbNECJglzK
         YANYEvoueki6rMRGYdGHNJdaOy+8p+1cXesnFsyFj8BMmG2gSdUtrk1DPEiWSLVY166P
         BWEqVydlK45RF4qJTqfs16KMPUmcSEauVNvy217824m6JT57pHsTk/9qesfCGVMp1ROG
         V5x8+akJzjEJ1IBpoI3jueL59HB9ezlRKR2c3jqI1pKPC4FWQXQ4FeVXepzPkSC9t2ZL
         x1+6JgElc5S074AqFOIJBDaIgmoYhQLc1ix43C7ArJWA0To6d//eHcnYxWAfmCdLj0y+
         UbSg==
Received: by 10.216.193.65 with SMTP id j43mr9438947wen.141.1351100608951;
        Wed, 24 Oct 2012 10:43:28 -0700 (PDT)
Received: from bender.localnet ([2a01:e35:2f70:4010:bcd3:247f:3658:db28])
        by mx.google.com with ESMTPS id cu1sm5402930wib.6.2012.10.24.10.43.26
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Oct 2012 10:43:27 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 11/13] MIPS: JZ4750D: Add Kbuild files
Date:   Wed, 24 Oct 2012 19:43:25 +0200
Message-ID: <6315819.WnqMkxcSqV@bender>
Organization: OpenWrt
User-Agent: KMail/4.8.5 (Linux/3.2.0-32-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <4796718.WhuB0k6pfC@hyperion>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com> <1351014241-3207-12-git-send-email-antonynpavlov@gmail.com> <4796718.WhuB0k6pfC@hyperion>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34771
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

On Wednesday 24 October 2012 18:16:35 Maarten ter Huurne wrote:
> On Tuesday 23 October 2012 21:43:59 Antony Pavlov wrote:
> > Add the Kbuild files for the JZ4750D architecture and adds JZ4750D support
> > to the MIPS Kbuild files.
> [snip]
> > diff --git a/arch/mips/jz4750d/Platform b/arch/mips/jz4750d/Platform
> > new file mode 100644
> > index 0000000..2e4e050
> > --- /dev/null
> > +++ b/arch/mips/jz4750d/Platform
> > @@ -0,0 +1,3 @@
> > +platform-$(CONFIG_MACH_JZ4750D)	+= jz4750d/
> > +cflags-$(CONFIG_MACH_JZ4750D)	+=
> > -I$(srctree)/arch/mips/include/asm/mach-jz4750d
> > +load-$(CONFIG_MACH_JZ4750D)	+= 0xffffffff80010000
> 
> What is the purpose of padding the load address to 64 bits?
> 
> The reason I'm asking is that we encountered a bug with that when creating a 
> u-boot image on a 32-bit host machine: the mkimage tool will only parse the 
> first 8 hex digits and then inserts the wrong load address into the uImage.

AFAIR u-boot's mkimage expects 32-bits quantities as a load address, so I would
not be surprised that using this line as-is as an input parameter to mkimage
does not give yout the expected result.
-- 
Florian
