Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Mar 2018 02:31:59 +0100 (CET)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:37723
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993890AbeCKBbxPEeqF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Mar 2018 02:31:53 +0100
Received: by mail-pg0-x241.google.com with SMTP id y26so5064518pgv.4
        for <linux-mips@linux-mips.org>; Sat, 10 Mar 2018 17:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=otq/DNIP89KIz9LyyC6JDuCbtoU08ad5YDF4iCIgde0=;
        b=PS/AE2l4qsai8hnT6UYiG/p/Qy6coTC0HZhr0wMbKySyguTi2aVVowChn8gvIWuCTw
         Z9hqN4ghb80PpnxwWRbmkSpbL8ZVgVk2vLgwaj6Bs262++jKcUVyhYi0Se6pJLur/kV0
         lOhGr9ZqaAX1QET8uV6qPc30Zm4tJniSKIPgR2YB1dMyuhbU0Ag4DVdm86Ghq8e8NV0b
         qGCtLP3Gs/3oYsE+JHRACn6j/9Jb2ZaHIsNW7yeXGIMLQ7kTFM2woeCJgU4ie1fZ0K7T
         V0qPPkET+O2Rc2i+SAyapd9/LO8Lvckpy5JsU9nZ6lqLTz5L+HsBrpGMCwoq1kbGhU6z
         sLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=otq/DNIP89KIz9LyyC6JDuCbtoU08ad5YDF4iCIgde0=;
        b=Wpf+myUy+eZh1+SrQPTvKCkbB2639V58uUOXMZGNdd3bcorae9RsKtyZxrDC22fBX7
         PAeT1bgjwJENfpSBgwb6uSUQbWeXBklMfIjq+hxVoJVUxKkUyNi0cvAbGOZrzm9N9OIJ
         cmvMDAEioAzwAF3poh8t3nscs8JgnHsLMtk4jNPs8ZpI1kq0jW1DsdhhZE92yaTwVWH2
         oVuWxQ9mUb/kOPtbMhHiRCcCYcAdUiPO6ansOHQlptO2ax8PqCVMfhcP+azI4fqLHos2
         5UvrE0mOFT08X8E31YxnG5wymSU8otgWkXGluUn8ge+M92rpjH4SyLP/JG19xp96MSn8
         fI3A==
X-Gm-Message-State: AElRT7HRtN++ZJ+NRiuyjNbwIlgyTw8IaWaBdjJbh+hZaPxPGug4ci0B
        /DvQq3PHC6vzvF3xFLMjGifcn9zTID+SYjEd9ywrBg==
X-Google-Smtp-Source: AG47ELuBhc8CmaELH5vSdRah9A7uvqQUq61LRK0zgEIEFxladhFR2faRvGFANYU4ICMLPSDMZ9Crlg/or+wRsw5NzLQ=
X-Received: by 10.101.86.138 with SMTP id v10mr2851560pgs.353.1520731905802;
 Sat, 10 Mar 2018 17:31:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.149.10 with HTTP; Sat, 10 Mar 2018 17:31:45 -0800 (PST)
In-Reply-To: <20180309231351.GJ24558@saruman>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <20180309151219.18723-12-ezequiel@vanguardiasur.com.ar> <20180309231351.GJ24558@saruman>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 10 Mar 2018 22:31:45 -0300
Message-ID: <CAAEAJfBxbApf=W1PfhWFbXpNSYypkkxkLu+WmHmFN3_sbqOXDQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] MIPS: dts: jz4780: Add DMA controller node to the devicetree
To:     James Hogan <jhogan@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

On 9 March 2018 at 20:13, James Hogan <jhogan@kernel.org> wrote:
> On Fri, Mar 09, 2018 at 12:12:16PM -0300, Ezequiel Garcia wrote:
>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> ...
>> +     dma: dma@13420000 {
>> +             compatible = "ingenic,jz4780-dma";
>> +             reg = <0x13420000 0x10000>;
>> +             #dma-cells = <2>;
>> +
>> +             interrupt-parent = <&intc>;
>> +             interrupts = <10>;
>> +
>> +             clocks = <&cgu JZ4780_CLK_PDMA>;
>> +
>> +             status = "disabled";
>> +     };
>
> Is there any point in disabling the DMAC by default? I thought that was
> mainly used for peripheral devices which might not be brought out of the
> SoC on all boards.
>

Oh, yes, you are right. I'll fix that.

Thanks,
-- 
Ezequiel García, VanguardiaSur
www.vanguardiasur.com.ar
