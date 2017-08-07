Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 17:27:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53440 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993892AbdHGP0xDhHpM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Aug 2017 17:26:53 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v77FQnBL013500;
        Mon, 7 Aug 2017 17:26:49 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v77FQmtN013499;
        Mon, 7 Aug 2017 17:26:48 +0200
Date:   Mon, 7 Aug 2017 17:26:48 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Nathan Sullivan <nathan.sullivan@ni.com>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] MIPS: NI 169445 board support
Message-ID: <20170807152648.GA13214@linux-mips.org>
References: <1500402549-12090-1-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500402549-12090-1-git-send-email-nathan.sullivan@ni.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59392
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

On Tue, Jul 18, 2017 at 01:29:09PM -0500, Nathan Sullivan wrote:

> Support the National Instruments 169445 board.

Thanks, applied with minor changes:

> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -4,6 +4,7 @@ dts-dirs	+= img
>  dts-dirs	+= ingenic
>  dts-dirs	+= lantiq
>  dts-dirs	+= mti
> +dts-dirs	+= ni
>  dts-dirs	+= netlogic
>  dts-dirs	+= pic32
>  dts-dirs	+= qca

Keep things in alphabetical order, so ni should go after netlogic.

> diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
> index f67fbf1..de851f7 100644
> --- a/arch/mips/generic/vmlinux.its.S
> +++ b/arch/mips/generic/vmlinux.its.S
> @@ -29,3 +29,28 @@
>  		};
>  	};
>  };
> +
> +#ifdef CONFIG_FIT_IMAGE_FDT_NI169445
> +/ {
> +	images {
[...]
> +	};
> +};
> +#endif

There's been a reject on this file because of a Boston #ifdefed section.
I've fixed that up but we need a cleaner solution.  Paul, any suggestions?

  Ralf
