Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 15:23:55 +0200 (CEST)
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36971 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992544AbcHINXsY3H4U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 15:23:48 +0200
Received: by mail-wm0-f41.google.com with SMTP id i5so35057258wmg.0
        for <linux-mips@linux-mips.org>; Tue, 09 Aug 2016 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Fa1TG3PT+LLpwF+ftTOGNODHHQdOyYlQ9DrozCjBv9o=;
        b=nznJ73K948tsLb3smiBune2R5iSyVMq5tjxkdSz9iyhzSwdxhrNCVTz36FxO0RqSRb
         KDs7HnTACrerDjgy1NqI7H4ylVe6h5LYNGgrRdG3Egj70k5mrseFz/rAuZ5NXUb7CK+3
         4Jcbme9QRlvO57n0BtAVswL/a/Po+ZeSBqtw8LpvKsqqIvqTUnfqdh5HEhkdPBlu6tbd
         BYJt9eHfCYHTJs6mYMXY4EXZajftfhCQzS2WSHr/QwhGc0RoyXoPKpl51/eRq4Y6Mx8U
         Rd5iCFAq8dBFTHKm+y1OLXvN0zquCg7Oa0aI0T2TT96BjbsLIu5BF1sqWPLe+S+UM/wN
         YdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=Fa1TG3PT+LLpwF+ftTOGNODHHQdOyYlQ9DrozCjBv9o=;
        b=XdsHuHnDClQ6UK8WSrl9R5QmmH8s7NMNwA1RB8cZwaU7788bfRqc10swOgN8OibYGu
         xXj8Qnm9ZtBXCTwBbuMSOPktXhMrml6zpTuhurwbn5zmTiLiQrVlg8IdVaH6cBOmiFBs
         fe9QCTPt4217MZ0yUMN1OSolT+sK6B97eMjTpLf7mC4bhAWlsqbu1q+5H2PYuQeomLrR
         KRJjqVgx5p82lP6i66Khr+hhdH0sHCy9oafSFhxEjHOzdIHcQS9zzgr95rcgEic7zPMu
         rRDhoRo+n7/twD+in1xtDXaNXKxhx4eXoBFHsXEFx7DbxLRx344/3IEqXe7yTy4+7oQf
         c/TQ==
X-Gm-Message-State: AEkoousTy4ipuFOS9Oa+RMj1SEcM1hwFi7pbMuGQrFnx3F/SH7fNns4cR9CnX+TwhYhfIg==
X-Received: by 10.25.169.147 with SMTP id s141mr26001603lfe.203.1470749022903;
        Tue, 09 Aug 2016 06:23:42 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.6])
        by smtp.gmail.com with ESMTPSA id 142sm6652203ljf.9.2016.08.09.06.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2016 06:23:41 -0700 (PDT)
Subject: Re: [PATCH 09/20] SEAD3: Probe parallel flash via DT
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
 <20160809123546.10190-10-paul.burton@imgtec.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <5bc9f3b2-e37b-1d07-730b-972e19d83b06@cogentembedded.com>
Date:   Tue, 9 Aug 2016 16:23:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160809123546.10190-10-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 08/09/2016 03:35 PM, Paul Burton wrote:

> Probe the system parallel flash using device tree rather than platform
> code, in order to reduce the amount of the latter.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>  arch/mips/boot/dts/mti/sead3.dts     | 17 +++++++++++++++++
>  arch/mips/mti-sead3/sead3-platform.c | 37 ------------------------------------
>  2 files changed, 17 insertions(+), 37 deletions(-)
>
> diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
> index 66f7947..7799826 100644
> --- a/arch/mips/boot/dts/mti/sead3.dts
> +++ b/arch/mips/boot/dts/mti/sead3.dts
> @@ -67,6 +67,23 @@
>  		interrupts = <0>; /* GIC 0 or CPU 6 */
>  	};
>
> +	pflash@1c000000 {

    What's "pflash"? I'd suggest to just name the ndoe "flash@..." to be more 
in line with ePAPR.

> +		compatible = "intel,28f128j3", "cfi-flash";
> +		reg = <0x1c000000 0x2000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		user-fs@0 {
> +			label = "User FS";
> +			reg = <0x0 0x1fc0000>;
> +		};
> +
> +		board-config@3e0000 {
> +			label = "Board Config";
> +			reg = <0x1fc0000 0x40000>;
> +		};

    Doesn't MTD code complain that the partitions are not subnodes of a 
"partitions" node?
It's the preferred way now...

> +	};
> +
>  	/* UART connected to FTDI & miniUSB socket */
>  	uart0: uart@1f000900 {
>  		compatible = "ns16550a";
[...]

MBR, Sergei
