Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 16:35:08 +0100 (CET)
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:52255 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991965AbdK1Pe5xecwY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 16:34:57 +0100
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 89CFE182CED28;
        Tue, 28 Nov 2017 15:34:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: run83_2a8a272bb1d3e
X-Filterd-Recvd-Size: 1699
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Nov 2017 15:34:52 +0000 (UTC)
Message-ID: <1511883290.19952.20.camel@perches.com>
Subject: Re: [PATCH 13/13] MAINTAINERS: Add entry for Microsemi MIPS SoCs
From:   Joe Perches <joe@perches.com>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Nov 2017 07:34:50 -0800
In-Reply-To: <20171128152643.20463-14-alexandre.belloni@free-electrons.com>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
         <20171128152643.20463-14-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Tue, 2017-11-28 at 16:26 +0100, Alexandre Belloni wrote:
> Add myself as a maintainer for the Microsemi MIPS SoCs.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -9062,6 +9062,13 @@ S:	Maintained
>  F:	drivers/usb/misc/usb251xb.c
>  F:	Documentation/devicetree/bindings/usb/usb251xb.txt
>  
> +MICROSEMI MIPS SOCS
> +M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +L:	linux-mips@linux-mips.org
> +S:	Maintained
> +F:	arch/mips/mscc/*
> +F:	arch/mips/boot/dts/mscc/*

Do any of these directories also contain subdirectories?

This use of * means only the top level directory files
are matched by this pattern.

Using just a trailing / instead makes any file in any
subdirectory also match.

Perhaps:

F:	arch/mips/mscc/
F:	arch/mips/boot/dts/mscc/
