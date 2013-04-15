Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 13:08:20 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53449 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835132Ab3DOLITqJED0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Apr 2013 13:08:19 +0200
Message-ID: <516BDEB2.5020908@phrozen.org>
Date:   Mon, 15 Apr 2013 13:04:18 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: ralink: setup dma_mask for the rt305x dwc2
 usb controller
References: <1366021644-8353-1-git-send-email-matthijs@stdin.nl> <1366021644-8353-2-git-send-email-matthijs@stdin.nl>
In-Reply-To: <1366021644-8353-2-git-send-email-matthijs@stdin.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36177
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

On 15/04/13 12:27, Matthijs Kooijman wrote:
> diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
> index 3740826..220dc69 100644
> --- a/arch/mips/ralink/mt7620.c
> +++ b/arch/mips/ralink/mt7620.c
> @@ -137,6 +137,11 @@ struct ralink_pinmux rt_gpio_pinmux = {
>   	.uart_mask = MT7620_GPIO_MODE_GPIO,
>   };
>
> +void ralink_usb_init(void)
> +{
> +
> +}
> +

Hi,

i'll post a different patch later that eliminates the need for these 
empty stubs.

	John
