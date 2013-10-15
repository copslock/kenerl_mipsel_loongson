Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2013 14:10:42 +0200 (CEST)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:48655 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823088Ab3JOMKjhMdyh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Oct 2013 14:10:39 +0200
Received: by mail-lb0-f170.google.com with SMTP id w7so6873665lbi.29
        for <linux-mips@linux-mips.org>; Tue, 15 Oct 2013 05:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VuXciUzqyS71307vbOpKcVpEuOM+TZe4h0cq1WO4Tww=;
        b=FF48Uuq5tbICPeLNXCbEvhRJUPBAaaQUiXd+ZC79zyzewd6RezORYMwKtMYfSR33F3
         0L/eS7JfL639zW6l4MFouGnzQvfj5MU5UozfJrsc6DK1MnA9UCtUzZzCXPGIxLyQbQZ1
         bji+ZKrF/zeosoO046f/xurIHnkkWoPUw1a1wY/nFPKULcVLAp31cspGtVWFffOm1HVf
         wqt9j9rYKw/bZeFEVy8y3LS6bBkzjOl6gaiTPAhmAySTeu305bAa0tLw8TdIuRgFo5pt
         DDMRPeeqXrpzErnyWO7Mw6ql7VwMSpqMA9I3dm6Ttb8C21ssxicODA43uTZHvqdGEIcf
         WK8A==
X-Gm-Message-State: ALoCoQlkvvPNam0LYbyBxGyAfa8omyWtT5z9uwaU08q3rtNmVaTcUQG2K94dc6i56pCbq/R3yHEz
X-Received: by 10.152.120.5 with SMTP id ky5mr35768573lab.18.1381839033901;
        Tue, 15 Oct 2013 05:10:33 -0700 (PDT)
Received: from [192.168.2.4] (ppp83-237-56-125.pppoe.mtu-net.ru. [83.237.56.125])
        by mx.google.com with ESMTPSA id pw4sm47283870lbb.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 05:10:33 -0700 (PDT)
Message-ID: <525D307A.9060403@cogentembedded.com>
Date:   Tue, 15 Oct 2013 16:09:30 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 06/18] MIPS: Netlogic: Get coremask from FUSE register
References: <1381756874-22616-1-git-send-email-jchandra@broadcom.com> <1381756874-22616-7-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1381756874-22616-7-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38343
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

On 14-10-2013 17:21, Jayachandran C wrote:

> Use the FUSE register to get the list of active cores in the CPU
> instead of using the CPU reset register, this is the recommended
> method.

> Also add code to mask the coremask with the default number of cores
> for each processor series.

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>   arch/mips/netlogic/xlp/wakeup.c |   31 ++++++++++++++++++++++++++-----
>   1 file changed, 26 insertions(+), 5 deletions(-)

> diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
> index 682d563..1011577 100644
> --- a/arch/mips/netlogic/xlp/wakeup.c
> +++ b/arch/mips/netlogic/xlp/wakeup.c
[...]
> @@ -111,12 +111,33 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
>   		if (n != 0)
>   			nlm_node_init(n);
>   		nodep = nlm_get_node(n);
> -		syscoremask = nlm_read_sys_reg(nodep->sysbase, SYS_CPU_RESET);
> +
> +		fusemask = nlm_read_sys_reg(nodep->sysbase,
> +					SYS_EFUSE_DEVICE_CFG_STATUS0);
> +		switch (read_c0_prid() & 0xff00) {
> +		case PRID_IMP_NETLOGIC_XLP3XX:
> +			mask = 0xf;
> +			break;
> +		case PRID_IMP_NETLOGIC_XLP2XX:
> +			mask = 0x3;
> +			break;
> +		case PRID_IMP_NETLOGIC_XLP8XX:
> +			mask = 0xff;
> +			break;
> +		default:
> +			mask = 0xff;
> +			break;

    Why not merge the last 2 cases?

> +		}

WBR, Sergei
