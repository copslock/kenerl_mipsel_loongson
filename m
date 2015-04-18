Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2015 09:06:03 +0200 (CEST)
Received: from lb1-smtp-cloud2.xs4all.net ([194.109.24.21]:33080 "EHLO
        lb1-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008877AbbDRHGBIf5ZJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Apr 2015 09:06:01 +0200
Received: from [192.168.10.106] ([83.160.161.190])
        by smtp-cloud2.xs4all.net with ESMTP
        id HK5p1q00746mmVf01K5qbi; Sat, 18 Apr 2015 09:05:54 +0200
Message-ID: <1429340752.16771.120.camel@x220>
Subject: Re: [PATCH 02/14] MIPS: ath79: Add basic device tree support
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 18 Apr 2015 09:05:52 +0200
In-Reply-To: <1429280669-2986-3-git-send-email-albeu@free.fr>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
         <1429280669-2986-3-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Fri, 2015-04-17 at 16:24 +0200, Alban Bedel wrote:

> --- a/arch/mips/ath79/Kconfig
> +++ b/arch/mips/ath79/Kconfig
>  
> +choice
> +	prompt "Builtin devicetree selection"
> +	default DTB_ATH79_NONE
> +	help
> +	  Select the devicetree.
> +
> +	config DTB_ATH79_NONE
> +		bool "None"
> +endchoice

This adds a choice block with one config entry. So what this achieves is
that DTB_ATH79_NONE will always be 'y', right? Besides I didn't notice
on a user of CONFIG_DTB_ATH79_NONE. So as far as I can see this choice
has no effect on the build.

Why was this choice entry added?


Paul Bolle
