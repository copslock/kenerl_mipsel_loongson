Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 12:03:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54950 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028500AbcEMKDSGiSEP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 12:03:18 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 0D4BEB9CCE0C2;
        Fri, 13 May 2016 11:03:09 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 13 May 2016 11:03:12 +0100
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 13 May
 2016 11:03:11 +0100
Subject: Re: [PATCH] MIPS: tools: Ignore relocation tool
To:     Florian Fainelli <f.fainelli@gmail.com>,
        <linux-mips@linux-mips.org>
References: <1462994177-6460-1-git-send-email-f.fainelli@gmail.com>
CC:     <ralf@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <5735A65F.8080006@imgtec.com>
Date:   Fri, 13 May 2016 11:03:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1462994177-6460-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Good spot Florian.

Acked-by: Matt Redfearn <matt.redfearn@imgtec.com>

On 11/05/16 20:16, Florian Fainelli wrote:
> Add a .gitignore ignoring arch/mips/boot/tools/relocs.
>
> Fixes: 5f552da15721 ("MIPS: tools: Add relocs tool")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   arch/mips/boot/tools/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 arch/mips/boot/tools/.gitignore
>
> diff --git a/arch/mips/boot/tools/.gitignore b/arch/mips/boot/tools/.gitignore
> new file mode 100644
> index 000000000000..be0ed065249b
> --- /dev/null
> +++ b/arch/mips/boot/tools/.gitignore
> @@ -0,0 +1 @@
> +relocs
