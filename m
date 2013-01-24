Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 12:52:38 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53307 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832212Ab3AXLwgiI3cH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2013 12:52:36 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 3974725BA8E;
        Thu, 24 Jan 2013 12:52:31 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5211eHkCGz4V; Thu, 24 Jan 2013 12:52:31 +0100 (CET)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPSA id E785D25BA8D;
        Thu, 24 Jan 2013 12:52:30 +0100 (CET)
Message-ID: <5101208B.40006@openwrt.org>
Date:   Thu, 24 Jan 2013 12:52:43 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 05/11] MIPS: ralink: adds prom and cmdline code
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-6-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 130124-0, 2013.01.24), Outbound message
X-Antivirus-Status: Clean
X-archive-position: 35533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi John,

> Add minimal code to handle commandlines.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/prom.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 arch/mips/ralink/prom.c
> 
> diff --git a/arch/mips/ralink/prom.c b/arch/mips/ralink/prom.c
> new file mode 100644
> index 0000000..49238d3

<...>

> +void __init prom_init(void)
> +{
> +	int argc;
> +	char **argv;
> +
> +	prom_soc_init(&soc_info);
> +
> +	pr_info("CPU Type: %s\n", get_system_type());

Strictly speaking, this prints the SoC type, so the prefix should be changed.
The CPU revision and its type is already printed by the generic MIPS code.

-Gabor
