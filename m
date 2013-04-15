Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 12:32:40 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:52139 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835117Ab3DOKcjGx4Zf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Apr 2013 12:32:39 +0200
Message-ID: <516BD656.6090709@phrozen.org>
Date:   Mon, 15 Apr 2013 12:28:38 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] owrt: MIPS: ralink: add usb platform support
References: <1366021644-8353-1-git-send-email-matthijs@stdin.nl> <1366021644-8353-3-git-send-email-matthijs@stdin.nl>
In-Reply-To: <1366021644-8353-3-git-send-email-matthijs@stdin.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36168
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
> From: John Crispin<blogic@openwrt.org>
>
> Add code to load the platform ehci/ohci driver on Ralink SoC. For the usb core
> to work we need to populate the platform_data during boot, prior to the usb
> driver being loaded.
>
> Signed-off-by: John Crispin<blogic@openwrt.org>
> [matthijs@stdin.nl: Extracted non-ohci/ehci 3052 code into separate patch]
> Signed-off-by: Matthijs Kooijman<matthijs@stdin.nl>

Hi,

this patch sits ontop of a patch from openwrt that adds a OF binding for 
ohci/ehci so it wont go upstream until the usb people decided how to 
expose ohci-platform and ehci-platform in OF

	John
