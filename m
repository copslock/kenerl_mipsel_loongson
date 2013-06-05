Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 22:47:10 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:35465 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823037Ab3FEUrGAeOwv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 22:47:06 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 32A3E5A6F69;
        Wed,  5 Jun 2013 23:47:05 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id 7rtVExgKhPGO; Wed,  5 Jun 2013 23:47:00 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id 2F6E55BC003;
        Wed,  5 Jun 2013 23:46:59 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Wed, 05 Jun 2013 23:46:56 +0300
Date:   Wed, 5 Jun 2013 23:46:56 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/6] staging: octeon-usb: cvmx-usbcx-defs.h: avoid long
 lines in CVMX_USBCX macros
Message-ID: <20130605204656.GA3507@blackmetal.musicnaut.iki.fi>
References: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
 <1370381495-3358-4-git-send-email-aaro.koskinen@iki.fi>
 <20130605083646.GN28112@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130605083646.GN28112@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Wed, Jun 05, 2013 at 11:36:46AM +0300, Dan Carpenter wrote:
> On Wed, Jun 05, 2013 at 12:31:32AM +0300, Aaro Koskinen wrote:
> > -#define CVMX_USBCX_DAINT(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000818ull) + ((block_id) & 1) * 0x100000000000ull)
> 
> There should be a few helper macros.

OK, I'll try to fix this.

A.
