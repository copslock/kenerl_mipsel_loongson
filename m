Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 14:38:01 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:44783 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827432Ab3AaNiA3Plzd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jan 2013 14:38:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 5A38325CD51;
        Thu, 31 Jan 2013 14:37:55 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JCn1+TiT4qH6; Thu, 31 Jan 2013 14:37:55 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 3A5B225CD43;
        Thu, 31 Jan 2013 14:37:55 +0100 (CET)
Message-ID: <510A73B2.4040107@openwrt.org>
Date:   Thu, 31 Jan 2013 14:37:54 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 07/10] MIPS: ralink: adds early_printk support
References: <1359633561-4980-1-git-send-email-blogic@openwrt.org> <1359633561-4980-8-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359633561-4980-8-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-archive-position: 35669
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

2013.01.31. 12:59 keltez�ssel, John Crispin �rta:
> Add the code needed to make early printk work.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
