Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2010 15:50:26 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:48830 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491022Ab0LVOuX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Dec 2010 15:50:23 +0100
Received: by vws5 with SMTP id 5so1975611vws.36
        for <multiple recipients>; Wed, 22 Dec 2010 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=kFuBNt8cU37MG+QfJ8JVaxnecPIh930NClxrReMYnYM=;
        b=F7+YWBlrT79TILqNg7rJhxEMwGcod+q0XiK59ViGdD3EtjyM+rDL8xvEHG8GIn9zg4
         RU2ulQev8u+w12aHhb2hV3/X/oZ2PLvkjJW09HV8VUToh8DuN+XWxBlyYFlmJMaD8SVZ
         UmCkfNI21H8kQE6Sei5I0L6knPr/EqXjl3uIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=HSsJG9OgoKwt1Cp7QZ+N98TlD9sIm4vrFcjZT4jckr43ELseXqpV3mAxiX1n5zmXsL
         tY98sRpIlMbnWv7XyMiwyWMik5pXUciU55OqxXLheRYQJMJXkjA77xY/vLiLhjrDKpY+
         +KuRLApPo1iLdJZSsoWM28Ci9H2V5bH8e83EU=
Received: by 10.220.175.139 with SMTP id ba11mr2248390vcb.58.1293029416496;
        Wed, 22 Dec 2010 06:50:16 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id y4sm1340855vch.11.2010.12.22.06.50.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 06:50:14 -0800 (PST)
Subject: Re: [PATCH V2 1/2] EHCI support for on-chip PMC MSP USB controller.
From:   Anoop P A <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Greg Kroah-Hartman <gregkh@suse.de>,
        Anatolij Gustschin <agust@denx.de>,
        Anand Gadiyar <gadiyar@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
In-Reply-To: <1293028561-22125-1-git-send-email-anoop.pa@gmail.com>
References: <1292929580-5829-1-git-send-email-anoop.pa@gmail.com>
         <1293028561-22125-1-git-send-email-anoop.pa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 22 Dec 2010 20:28:12 +0530
Message-ID: <1293029892.27661.42.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-12-22 at 20:06 +0530, Anoop P.A wrote:
> From: Anoop P A <anoop.pa@gmail.com>
> 
> This patch includes.
> 
> 1. USB host driver for MSP71xx family SoC on-chip USB controller.

>  	ehci_writel(ehci, tmp, reg_ptr);
> +#ifdef CONFIG_USB_EHCI_HCD_PMC_MSP
> +	/* set controller in host mode */
> +	usb_hcd_tdi_set_mode(ehci);
> +#endif

Missed this one while cleaning :( 
>  }
