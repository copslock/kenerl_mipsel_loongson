Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 05:07:09 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35149 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010627AbbEMDHH5tG20 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 May 2015 05:07:07 +0200
Received: by iebpz10 with SMTP id pz10so20461910ieb.2
        for <linux-mips@linux-mips.org>; Tue, 12 May 2015 20:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=h//vrthCdpUN3Kr3vg43PYDkYjSlXltemG6z6VG/DFk=;
        b=UBoEDESvCLyT76CXHfr7rsWlB7Q/X6IY+y8dm7uO+ivUlnbsTfrSbwMnxMPXbxqpgp
         JZGWwGrdg2fMPS+Dh497yqLJUyxlJs6zFu68b9nMxymBzw1B7BIISpwvWkodIInfCETE
         LHRuWjp1FoK+X61DHLmd5+7X1BIw+MJkv53spYEqnHxahf6pa/v6os37c/swKcEfMrBs
         fQclDX+ijnOEfiCeQolPH6ae549WVExzqXO98uZl37fAxcFjZU+lA8cM1I4o+2WELIzj
         Yi68UW4DlarnkuV7KUYfhOTqJkfZmbV8OvCEn0QThg0y+saguzdYHS6c+rVDvjez7iOG
         QStg==
X-Gm-Message-State: ALoCoQkIbI1S46c/mSL8a+WmXWklAwS2epLJHWlIJ5YtUWU2tlz0mRkDo41WhEsY+KNRY26UNtHT
X-Received: by 10.50.30.9 with SMTP id o9mr7806615igh.23.1431486424454;
        Tue, 12 May 2015 20:07:04 -0700 (PDT)
Received: from localhost (pool-71-119-96-202.lsanca.fios.verizon.net. [71.119.96.202])
        by mx.google.com with ESMTPSA id w4sm2640156igl.22.2015.05.12.20.07.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 20:07:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
From:   Michael Turquette <mturquette@linaro.org>
In-Reply-To: <1429881457-16016-29-git-send-email-paul.burton@imgtec.com>
Cc:     "Paul Burton" <paul.burton@imgtec.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Stephen Boyd" <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
 <1429881457-16016-29-git-send-email-paul.burton@imgtec.com>
Message-ID: <20150513030652.20636.98939@quantum>
User-Agent: alot/0.3.5
Subject: Re: [PATCH v4 28/37] MIPS,
 clk: move jz4740 UDC auto suspend functions to jz4740-cgu
Date:   Tue, 12 May 2015 20:06:52 -0700
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@linaro.org
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

Hi Paul,

Quoting Paul Burton (2015-04-24 06:17:28)
> -void jz4740_clock_udc_disable_auto_suspend(void)
> -{
> -       jz_clk_reg_clear_bits(JZ_REG_CLOCK_GATE, JZ_CLOCK_GATE_UDC);
> -}
> -EXPORT_SYMBOL_GPL(jz4740_clock_udc_disable_auto_suspend);
> -
> -void jz4740_clock_udc_enable_auto_suspend(void)
> -{
> -       jz_clk_reg_set_bits(JZ_REG_CLOCK_GATE, JZ_CLOCK_GATE_UDC);
> -}
> -EXPORT_SYMBOL_GPL(jz4740_clock_udc_enable_auto_suspend);

I couldn't find a caller for these functions. Where and how are they
used?

Thanks,
Mike
