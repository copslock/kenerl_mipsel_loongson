Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 08:35:08 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:46170 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822585Ab3ILGeoW0JCg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Sep 2013 08:34:44 +0200
Message-ID: <5231607C.6050203@phrozen.org>
Date:   Thu, 12 Sep 2013 08:34:36 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: GIC: Select R4K counter as fallback.
References: <1378929101-7021-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1378929101-7021-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37794
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

On 11/09/13 21:51, Steven J. Hill wrote:
> From: Leonid Yegoshin<Leonid.Yegoshin@imgtec.com>
>
> If CONFIG_CSRC_GIC is selected and the GIC is not found during
> boot, then fallback to the R4K counter gracefully.
>
> Signed-off-by: Leonid Yegoshin<Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Steven J. Hill<Steven.Hill@imgtec.com>
> ---
>   arch/mips/include/asm/time.h |   11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>


Hi Steven,

what has changed in V2 against V1 of this patch ?

I prefer the solution that Daney replied to V1 with

	John
