Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2018 00:24:41 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33271 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993339AbeFLWYeN0oVH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2018 00:24:34 +0200
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so271157pfi.0;
        Tue, 12 Jun 2018 15:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J9IvU1cX1LPBQyS4HNvbWY1dc6IN6lPqYJsKAqWSv+4=;
        b=FpxuKyTxVpOzc+eYmcKFOD/OQtfANfU1snjNPT+qLwwciWcoRA7uDnr+YT1AAqoTgl
         PGOlfuNd8mpFHVev2JXTGX5kqal4vjPrRZ5s50dKmoVGbYVlHEA40T8ksqTBG1TqPF/q
         IEIjgb9ytwTlTS1i2fsB2tdmBSCzW4FEkGiGv7BNsJNMdUFfmEfdTFk+6xKoNPySPsxt
         erAvPFa51prQd2Oy6Cdi4SJQAPd5oJyGqdiINHqLRWzsR52nKDIDIdOqSWOYS2RA4TbO
         Zfrg5Tp6ayWLtdHIEUT4zVq2KAACq1oSaU9s1tXf4qiPW0NDm2inM+gd6JhoSbZZWmtI
         mVoA==
X-Gm-Message-State: APt69E1abH0Sd9DkGc2G1IfylA7AZbLno4g4Adqb4nabhVUFyuONOEH2
        0R6RxIgUFMpEaMZd8AbWbw==
X-Google-Smtp-Source: ADUXVKKw/kgMcb9uEw33ozCvkfkt43vl+oiIIbms0Mxdyl71WZIv+fUJKHV+hH0J0087r2+Ig1auEQ==
X-Received: by 2002:a63:7211:: with SMTP id n17-v6mr1815539pgc.94.1528842267392;
        Tue, 12 Jun 2018 15:24:27 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id v26-v6sm1308471pfe.13.2018.06.12.15.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:24:26 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:24:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com, linux-mips@linux-mips.org,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/7] MIPS: dts: Add aliases node for lantiq danube serial
Message-ID: <20180612222424.GA2197@rob-hp-laptop>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-2-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612054034.4969-2-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Tue, Jun 12, 2018 at 01:40:28PM +0800, Songjun Wu wrote:
> Previous implementation uses a hard-coded register value to check if
> the current serial entity is the console entity.
> Now the lantiq serial driver uses the aliases for the index of the
> serial port.
> The lantiq danube serial dts are updated with aliases to support this.
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
> 
>  arch/mips/boot/dts/lantiq/danube.dtsi | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
> index 2dd950181f8a..7a9e15da6bd0 100644
> --- a/arch/mips/boot/dts/lantiq/danube.dtsi
> +++ b/arch/mips/boot/dts/lantiq/danube.dtsi
> @@ -4,6 +4,10 @@
>  	#size-cells = <1>;
>  	compatible = "lantiq,xway", "lantiq,danube";
>  
> +	aliases {
> +		serial0 = &asc1;
> +	};
> +
>  	cpus {
>  		cpu@0 {
>  			compatible = "mips,mips24Kc";
> @@ -74,7 +78,7 @@
>  			reg = <0xE100A00 0x100>;
>  		};
>  
> -		serial@E100C00 {
> +		asc1: serial@E100C00 {

Fix this to be lower case hex while you are at it.

>  			compatible = "lantiq,asc";
>  			reg = <0xE100C00 0x400>;
>  			interrupt-parent = <&icu0>;
> -- 
> 2.11.0
> 
