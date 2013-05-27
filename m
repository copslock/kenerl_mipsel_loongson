Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 12:42:57 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:44199 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823668Ab3E0Kmwthv-X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 May 2013 12:42:52 +0200
Message-ID: <51A33787.8080301@openwrt.org>
Date:   Mon, 27 May 2013 12:37:59 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] arch: mips: ralink: using strlcpy() instead of strncpy()
References: <51A1C16A.6050808@asianux.com>
In-Reply-To: <51A1C16A.6050808@asianux.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36605
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

On 26/05/13 10:01, Chen Gang wrote:
> 'compatible' is used by strlen() in __of_device_is_compatible().
>
> So for NUL terminated string, need always be sure of ended by zero.
>
> 'of_ids' is not a structure in "include/uapi/*", so not need initialize
> all bytes, just use strlcpy() instead of strncpy().
>
>
> Signed-off-by: Chen Gang<gang.chen@asianux.com>
Acked-by: John Crispin <blogic@openwrt.org>
