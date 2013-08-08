Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 20:41:29 +0200 (CEST)
Received: from mail-by2lp0238.outbound.protection.outlook.com ([207.46.163.238]:49330
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824816Ab3HHSlIDEZxP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 20:41:08 +0200
Received: from BL2PRD0712HT001.namprd07.prod.outlook.com (10.255.236.34) by
 BLUPR07MB162.namprd07.prod.outlook.com (10.242.200.154) with Microsoft SMTP
 Server (TLS) id 15.0.731.12; Thu, 8 Aug 2013 18:40:59 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.34) with Microsoft SMTP Server (TLS) id 14.16.341.1; Thu, 8 Aug
 2013 18:40:59 +0000
Message-ID: <5203E639.6010100@caviumnetworks.com>
Date:   Thu, 8 Aug 2013 11:40:57 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Discard .eh_frame sections in linker script.
References: <1375987013-3599-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1375987013-3599-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 093290AD39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(51704005)(24454002)(377454003)(479174003)(199002)(189002)(65806001)(80022001)(66066001)(56816003)(74706001)(54316002)(53416003)(77096001)(47776003)(56776001)(65956001)(33656001)(31966008)(50466002)(47446002)(74502001)(63696002)(16406001)(76786001)(80316001)(4396001)(19580395003)(23756003)(77982001)(59896001)(69226001)(50986001)(80976001)(76796001)(47736001)(49866001)(83322001)(74366001)(47976001)(46102001)(19580405001)(81342001)(83072001)(74876001)(74662001)(64126003)(81542001)(53806001)(76482001)(54356001)(59766001)(36756003)(51856001)(81686001)(79102001)(142923001);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB162;H:BL2PRD0712HT001.namprd07.prod.outlook.com;CLIP:64.2.3.195;RD:InfoNoRecords;A:1;MX:1;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 08/08/2013 11:36 AM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> Some toolchains (including Cavimu OCTEON SDK) are emitting .eh_frame

... Obvious spelling error  ^^^^^^^

I will fix it and resend.

> sections by default.  Discard them as they are useless in the kernel.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>   arch/mips/kernel/vmlinux.lds.S | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> index 05826d2..3b46f7c 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -179,5 +179,6 @@ SECTIONS
>   		*(.options)
>   		*(.pdr)
>   		*(.reginfo)
> +		*(.eh_frame)
>   	}
>   }
>
