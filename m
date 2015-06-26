Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jun 2015 01:13:28 +0200 (CEST)
Received: from mail-la0-f48.google.com ([209.85.215.48]:36367 "EHLO
        mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008992AbbFZXN1C8bFL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jun 2015 01:13:27 +0200
Received: by lacny3 with SMTP id ny3so71563711lac.3;
        Fri, 26 Jun 2015 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:message-id:to:cc:subject:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=reNL0ASO2UNSQ2a8muX7otmK99Rc5katkNO7rUib/zA=;
        b=rvQKgARLUe+KRryWu81jNeQYW+y4z6xz555RilBpm8fu7IV9//KUTs/KCtXX8CqCIM
         tw/VqqSup4kUrYgaLqskHzn1sszaxPdZYwPKHe2xU+nDLeTHqMzbRzvayi5S3lHoqIy/
         ysjmlMCotS0me8+4Zo7EfZW7KT/jvGDZTIO/sT9HKVS73A06aiglJqLKytrIrwvO3gGC
         sjRSRWTzwrWsSzL2qvORZjPA+dm5hKJKAjk2f4VLimadQuWYt73vJ3uxAR8PlHWrhBpl
         FBZ+ijQEbcHvVlEpral9SpK3vLHA4ChYrbMkagibFpToH7hR9oFI6m2GyS1gweWRkkDi
         VrgA==
X-Received: by 10.152.7.7 with SMTP id f7mr3764884laa.106.1435360401535;
        Fri, 26 Jun 2015 16:13:21 -0700 (PDT)
Received: from rsa.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id h4sm3959169laf.33.2015.06.26.16.13.19
        (version=TLSv1.1 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 16:13:20 -0700 (PDT)
Date:   Sat, 27 Jun 2015 02:13:35 +0300
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <1788792448.20150627021335@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     linux-kernel@vger.kernel.org, Julia.Lawall@lip6.fr,
        rmk+kernel@arm.linux.org.uk, tglx@linutronix.de,
        ralf@linux-mips.org, mingo@kernel.org, hpa@zytor.com,
        wsa@the-dreams.de, linux-tip-commits@vger.kernel.org,
        Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: [tip:irq/urgent] MIPS/pci: Fix race in installing chained IRQ handler
In-Reply-To: <tip-746ad9a7a1fef789a9f579441b4a7b686fa85aa2@git.kernel.org>
References: <tip-746ad9a7a1fef789a9f579441b4a7b686fa85aa2@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Hello Thomas,

Friday, June 26, 2015, 10:48:30 PM, you wrote:
> MIPS/pci: Fix race in installing chained IRQ handler

> Fix a race where a pending interrupt could be received and the handler
> called before the handler's data has been setup, by converting to
> irq_set_chained_handler_and_data().

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Though  it's  nearly impossible to trigger a race here, since SoC boot
up with disabled PCI interrupts.

-- 
Sergey
