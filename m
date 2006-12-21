Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2006 04:54:19 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.25]:57235 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S28640040AbWLUEyO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2006 04:54:14 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBL4s72J028514
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Dec 2006 20:54:07 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id kBL4s6Jv016001;
	Wed, 20 Dec 2006 20:54:06 -0800
Date:	Wed, 20 Dec 2006 20:54:06 -0800
From:	Andrew Morton <akpm@osdl.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Antonino Daplas <adaplas@pol.net>,
	James.Bottomley@SteelEye.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 01/10] TURBOchannel update to the driver
 model
Message-Id: <20061220205406.0061081c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0612201139080.11005@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0612201139080.11005@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Wed, 20 Dec 2006 12:01:30 +0000 (GMT)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> +/**
> + * tc_register_driver - register a new TC driver
> + * @drv: the driver structure to register
> + *
> + * Adds the driver structure to the list of registered drivers
> + * Returns a negative value on error, otherwise 0.
> + * If no error occurred, the driver remains registered even if
> + * no device was claimed during registration.
> + */
> +int tc_register_driver(struct tc_driver *tdrv)
> +{
> +	return driver_register(&tdrv->driver);
> +}
> +EXPORT_SYMBOL(tc_register_driver);
> +
> +/**
> + * tc_unregister_driver - unregister a TC driver
> + * @drv: the driver structure to unregister
> + *
> + * Deletes the driver structure from the list of registered TC drivers,
> + * gives it a chance to clean up by calling its remove() function for
> + * each device it was responsible for, and marks those devices as
> + * driverless.
> + */
> +void tc_unregister_driver(struct tc_driver *tdrv)
> +{
> +	driver_unregister(&tdrv->driver);
> +}
> +EXPORT_SYMBOL(tc_unregister_driver);

I spose making these inline would save a bit of code, stack space and 
a couple of exports.
