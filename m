Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 17:05:38 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:60639 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827650Ab3BOQFDIPeUd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 17:05:03 +0100
Message-ID: <511E5BF9.9070208@openwrt.org>
Date:   Fri, 15 Feb 2013 17:02:01 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: Re: [PATCH 11/11] MIPS: ath79: add support for the Qualcomm Atheros
 AP136-010 board
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org> <1360939105-23591-12-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1360939105-23591-12-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 15/02/13 15:38, Gabor Juhos wrote:
> +	ATH79_MACH_AP136_010,		/* Atheros AP136-010 reference board */

Hi,

just because i am curious ... why the AP136_010 the rest of the code 
uses AP136 with no suffix

     John
