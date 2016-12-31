Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Dec 2016 19:43:07 +0100 (CET)
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35713 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992703AbcLaSnAR0cI7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Dec 2016 19:43:00 +0100
Received: by mail-pg0-f68.google.com with SMTP id i5so25732949pgh.2;
        Sat, 31 Dec 2016 10:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cw9f6QuX9sGLECVctJBYCIGltwduDIqfBlitnTbKcLY=;
        b=ureSpNpjAe7d4AYz/rpIOS6r8aB3dPIW09+MMR0pmrV7C+fF9yvAugKh5u8j8KEeWO
         qdT7NK+uga4fsRny2IUCfsYizp1fVW0DeWMig9q4DLHaSQQ0GgQ1qMq9iGbzGYXjWv9t
         hdXPQiIgXBtklbDNGo6OY4MATGJICel5N1fS84cU+vEJ12UiGeWR0vRBuVZk/MC5DHQE
         TzdNi4jS09/dmNmy0mMaVsuqxC8Hvz+KilYXHqgO5Y2C8jnZ/NAOeTKnBYQEzAxR5Rug
         4kwvKczy0U6Fk3Yfkf4Pm40L6zIjZHv/eiKe49mBR64KdjApBt2V8Y5ekHkBe+pEBbn6
         NlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cw9f6QuX9sGLECVctJBYCIGltwduDIqfBlitnTbKcLY=;
        b=LLeugAj/wl4WNUBNtYTBNBhwMj/uVom6EuptyN2UkTsxw/HCU4Pwetwmuq3bFkbdAE
         a0ZRSZ3BTraX/WSAuJIGZ5fu4p81HmX9UTNFbsmQpWwVjpiTRo/UwjvFJ2JX4pLoIbpN
         TXiLoqRIifBhITDsZCGJgoTm8sPJA43r0smQDCjdIB0yhG2m/xV78cOeznPba/iIMNkS
         dH/t0plm77S+kiDMc5BNEEMrkkCN48kWFVkGvR0tegpoBW5d/QkA2sVBCo3NTSO89YfH
         QVgOCuVFulx3+DBAGllHljvuREa8IYFoRKh5CLdxW4d8qR882lJyn4DCOrHvLXa6JOBB
         z20Q==
X-Gm-Message-State: AIkVDXIBcMexAU/cvGkZEWH8LlaLt5+p+sza8PEg6d2aKsXqnADxO9SPppFiPVAxuRKIfQ==
X-Received: by 10.84.167.168 with SMTP id d37mr109954404plb.71.1483209773925;
        Sat, 31 Dec 2016 10:42:53 -0800 (PST)
Received: from [192.168.1.156] (c-73-170-87-240.hsd1.ca.comcast.net. [73.170.87.240])
        by smtp.gmail.com with ESMTPSA id f23sm121255781pff.59.2016.12.31.10.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Dec 2016 10:42:52 -0800 (PST)
Subject: Re: [v2 2/2] MIPS: BMIPS: Add support SPI device nodes
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>
References: <20161230063001.944-1-jaedon.shin@gmail.com>
 <20161230063001.944-3-jaedon.shin@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <09536633-9c81-9621-36af-665369e97a78@gmail.com>
Date:   Sat, 31 Dec 2016 10:42:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161230063001.944-3-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56138
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

Hi Jaedon,

On 12/29/2016 10:30 PM, Jaedon Shin wrote:
> Adds SPI device nodes to BCM7xxx MIPS based SoCs.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---

> +
> +&qspi {
> +	status = "okay";
> +
> +	m25p80@0 {
> +		compatible = "m25p80";
> +		reg = <0>;
> +		spi-max-frequency = <0x2625a00>;

Sorry for not noticing this earlier, can we have the frequency in a
decimal form?

With that fixed, feel free to add:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
