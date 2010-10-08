Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 12:38:15 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:39552 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491132Ab0JHKiM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 12:38:12 +0200
Received: by ewy9 with SMTP id 9so484346ewy.36
        for <multiple recipients>; Fri, 08 Oct 2010 03:38:09 -0700 (PDT)
Received: by 10.213.54.140 with SMTP id q12mr2369321ebg.71.1286534288946;
        Fri, 08 Oct 2010 03:38:08 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-76-106-32.pppoe.mtu-net.ru [91.76.106.32])
        by mx.google.com with ESMTPS id v59sm5146098eeh.10.2010.10.08.03.38.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 03:38:07 -0700 (PDT)
Message-ID: <4CAEF427.9030608@mvista.com>
Date:   Fri, 08 Oct 2010 14:36:23 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 08/14] MIPS: Octeon: Scale Octeon2 clocks in  octeon_init_cvmcount()
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com> <1286492633-26885-9-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1286492633-26885-9-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 08-10-2010 3:03, David Daney wrote:

> The per-CPU clocks are synchronized from IPD_CLK_COUNT, on cn63XX it
> must be scaled by the clock frequency ratio.

> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
[...]

> diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
> index b6847c8..c85a681 100644
> --- a/arch/mips/cavium-octeon/csrc-octeon.c
> +++ b/arch/mips/cavium-octeon/csrc-octeon.c
[...]
> @@ -33,8 +49,20 @@ void octeon_init_cvmcount(void)
>   	 * Loop several times so we are executing from the cache,
>   	 * which should give more deterministic timing.
>   	 */
> -	while (loops--)
> -		write_c0_cvmcount(cvmx_read_csr(CVMX_IPD_CLK_COUNT));
> +	while (loops--) {
> +		u64 ipd_clk_count = cvmx_read_csr(CVMX_IPD_CLK_COUNT);
> +		if (rdiv != 0) {
> +			ipd_clk_count = ipd_clk_count * rdiv;

    Why not:

			ipd_clk_count *= rdiv;

WBR, Sergei
