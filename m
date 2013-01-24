Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 08:28:09 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:39121 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832187Ab3AXH2Irk2eA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jan 2013 08:28:08 +0100
Message-ID: <5100E1E7.8010409@phrozen.org>
Date:   Thu, 24 Jan 2013 08:25:27 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [RFC 08/11] MIPS: ralink: adds early_printk support
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-9-git-send-email-blogic@openwrt.org> <5100610A.80609@mvista.com> <5100DB68.20903@phrozen.org> <5100E183.5080801@phrozen.org>
In-Reply-To: <5100E183.5080801@phrozen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

brainfart ... its too early :-)


> while our driver needs
>
> +#define UART_REG_LCR 5
>
should read ....

#define UART_REG_LSR            7
