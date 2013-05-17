Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 21:16:01 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:33922 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823900Ab3EQTP5BCDLT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 May 2013 21:15:57 +0200
Message-ID: <519680D1.4020609@openwrt.org>
Date:   Fri, 17 May 2013 21:11:13 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Matthijs Kooijman <matthijs@stdin.nl>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ralink: use the dwc2 driver for the rt305x USB
 controller
References: <1368084729-14183-1-git-send-email-matthijs@stdin.nl>
In-Reply-To: <1368084729-14183-1-git-send-email-matthijs@stdin.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36436
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

On 09/05/13 09:32, Matthijs Kooijman wrote:
> This sets up the devicetree file for the rt3050 chip series and rt3052
> eval board to use the right compatible string for the dwc2 driver.

Signed-off-by: John Crispin <blogic@openwrt.org>
