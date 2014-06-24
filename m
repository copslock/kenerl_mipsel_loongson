Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 13:31:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44983 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860427AbaFXKNltaEyG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 12:13:41 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6FA76FA5B3375;
        Tue, 24 Jun 2014 11:13:32 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 24 Jun
 2014 11:13:34 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 24 Jun 2014 11:13:34 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 24 Jun
 2014 11:13:33 +0100
Message-ID: <53A94F4D.10605@imgtec.com>
Date:   Tue, 24 Jun 2014 11:13:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Daniel Walter <dwalter@google.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arch/mips rb532: replace mac_addr parsing
References: <20140624084540.GA22930@google.com>
In-Reply-To: <20140624084540.GA22930@google.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Daniel,

On 24/06/14 09:45, Daniel Walter wrote:
> @@ -333,7 +311,13 @@ static int __init plat_setup_devices(void)
>  static int __init setup_kmac(char *s)
>  {
>  	printk(KERN_INFO "korina mac = %s\n", s);
> -	parse_mac_addr(s);
> +	sscanf(s, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
> +			&korina_dev0_data.mac[0],
> +			&korina_dev0_data.mac[1],
> +			&korina_dev0_data.mac[2],
> +			&korina_dev0_data.mac[3],
> +			&korina_dev0_data.mac[4],
> +			&korina_dev0_data.mac[5]);

Does it make sense to go one better and use mac_pton() for this?

Cheers
James
