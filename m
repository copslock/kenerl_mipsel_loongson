Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 16:10:31 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:1685 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827461Ab3FSOK1CU89R (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jun 2013 16:10:27 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 19 Jun 2013 07:10:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,896,1363158000"; 
   d="scan'208";a="356172777"
Received: from kuha.fi.intel.com (HELO hk) ([10.237.72.54])
  by orsmga002.jf.intel.com with SMTP; 19 Jun 2013 07:10:09 -0700
Received: by hk (sSMTP sendmail emulation); Wed, 19 Jun 2013 17:10:09 +0300
Date:   Wed, 19 Jun 2013 17:10:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Message-ID: <20130619141008.GA32331@xps8300>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
 <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <heikki.krogerus@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heikki.krogerus@linux.intel.com
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

On Tue, Jun 18, 2013 at 12:12:53PM -0700, David Daney wrote:
> A few differences needed by OCTEON:
> 
> o These are DWC UARTS, but have USR at a different offset.
> 
> o OCTEON must have 64-bit wide register accesses, so we have OCTEON
>   specific register accessors.
> 
> o No UCV register, so we hard code some properties.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

<snip>

> @@ -270,10 +301,8 @@ static int dw8250_probe(struct platform_device *pdev)
>  	uart.port.serial_out = dw8250_serial_out;
>  	uart.port.private_data = data;
>  
> -	dw8250_setup_port(&uart);
> -
>  	if (pdev->dev.of_node) {
> -		err = dw8250_probe_of(&uart.port);
> +		err = dw8250_probe_of(&uart.port, data);
>  		if (err)
>  			return err;
>  	} else if (ACPI_HANDLE(&pdev->dev)) {
> @@ -284,6 +313,9 @@ static int dw8250_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	if (!data->no_ucv)
> +		dw8250_setup_port(&uart);

Moving the dw8250_setup_port() call here breaks dw8250_probe_acpi(). It
expects values from the CPR register for the DMA burst size calculation.

The DMA support can be moved to a separate function. This way it can
be called after this point, and it will then be available for both DT
and ACPI. I can make a patch tomorrow. That should solve this issue.

Thanks,

-- 
heikki
