Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2017 15:55:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39882 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990491AbdLTOy7DawPx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Dec 2017 15:54:59 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vBKEstDv016802;
        Wed, 20 Dec 2017 15:54:55 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vBKEskss016785;
        Wed, 20 Dec 2017 15:54:46 +0100
Date:   Wed, 20 Dec 2017 15:54:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Huacai Chan <chenhc@lemote.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] MAINTAINERS: Add entry for Lemote YeeLoong Extra
 Driver
Message-ID: <20171220145446.GG28538@linux-mips.org>
References: <20171216145751.3486-1-jiaxun.yang@flygoat.com>
 <20171216145751.3486-6-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171216145751.3486-6-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sat, Dec 16, 2017 at 10:57:51PM +0800, Jiaxun Yang wrote:
> Date:   Sat, 16 Dec 2017 22:57:51 +0800
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> To: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Huacai
>  Chan <chenhc@lemote.com>, linux-kernel@vger.kernel.org, Jiaxun Yang
>  <jiaxun.yang@flygoat.com>
> Subject: [PATCH v5 5/5] MAINTAINERS: Add entry for Lemote YeeLoong Extra
>  Driver
> 
> Add myself as a maintainer of Lemote YeeLoong Extra driver
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>  mode change 100644 => 100755 MAINTAINERS
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> old mode 100644
> new mode 100755
> index cdd6365a59d9..d2de627828a0
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7890,6 +7890,12 @@ W:	http://legousb.sourceforge.net/
>  S:	Maintained
>  F:	drivers/usb/misc/legousbtower.c
>  
> +Lemote YeeLoong EXTRAS DRIVER
> +M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
> +S:	Maintained
> +F:	drivers/platform/mips/yeeloong_laptop.c

Hmm...  That's a very short entry.  I think at the very least an entry
for a mailing list should be added.

  Ralf
