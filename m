Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 06:08:41 +0200 (CEST)
Received: from mail-da0-f48.google.com ([209.85.210.48]:51196 "EHLO
        mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825866Ab3DPEIj4Q0Bu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Apr 2013 06:08:39 +0200
Received: by mail-da0-f48.google.com with SMTP id p8so47757dan.7
        for <linux-mips@linux-mips.org>; Mon, 15 Apr 2013 21:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NIAfY6E6J+taeN6w9HuxiTo0Wu8fpAhts7KhL9G/Nko=;
        b=MJuilaAh4pRXnoa2oK8sqyeyYCYGQ/IATbSg41GATvRxxx/7mgNiQ8NH436s5eZ336
         uSZUDLNCTi7u97pNzoNKh5aOIroLU4vDzkqOSyZWr/exSAL6y0M5fi/bABPemL4k873l
         bKDafqLUEbfZsxhPZwODEHzaX2qirarL6COgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=NIAfY6E6J+taeN6w9HuxiTo0Wu8fpAhts7KhL9G/Nko=;
        b=Me8dLSRR4xkV2XgQgypnuxPmTg8gvuR0Eks5hjjPUhT9me+/+HuFLLyt9ACHuErGRO
         H7SHCOe0geJYzr4oYdsEgR8poH15KYbzzNqXHBJvEShbRTSO3ob4n8t1f7V/kgwkPyDv
         cbDCXStWTtogIy/BFb64fvqoEr2r7gMHMhnyhqfM/MN2wKfYtfnQXeYMwtM2rHMQwJoN
         baicxHa2tPrCIZhKB/bGuL0iROAqNGohHVZvr0Ls/VDttfIdRVS7ZarLorBuFE8pJQQr
         EsEA2AhCTGvUl/gPUS+7tBmbRTdDANoxn3Ur9DrYQp4e07b1pMsvBo6CdZwYaymGtOf+
         gMhA==
X-Received: by 10.69.12.37 with SMTP id en5mr739119pbd.93.1366085312207;
        Mon, 15 Apr 2013 21:08:32 -0700 (PDT)
Received: from localhost ([69.38.217.3])
        by mx.google.com with ESMTPS id mt13sm334515pbc.15.2013.04.15.21.08.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 21:08:31 -0700 (PDT)
Date:   Mon, 15 Apr 2013 21:08:30 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: ralink: fix SERIAL_8250_RT288X
 dependency
Message-ID: <20130416040830.GB4907@kroah.com>
References: <1365845973-16164-1-git-send-email-blogic@openwrt.org>
 <20130415181527.GA25341@kroah.com>
 <516CCC26.5000504@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516CCC26.5000504@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQmFR4ot1GZ/wF4JncaAKlG0Z1GskcHAH0LqfLU3fDFC3isNQroxzB0bHqAj8ijR8AXprUXB
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Tue, Apr 16, 2013 at 05:57:26AM +0200, John Crispin wrote:
> On 15/04/13 20:15, Greg Kroah-Hartman wrote:
> >On Sat, Apr 13, 2013 at 11:39:32AM +0200, John Crispin wrote:
> >>With every Ralink SoC that we add, we would need to extend the dependency. In
> >>order to make life easier we make the symbol depend on MIPS&  RALINK and then
> >>select it from within arch/mips/ralink/.
> >>
> >>Signed-off-by: John Crispin<blogic@openwrt.org>
> >>---
> >>
> >>These 2 patches in this series should be merged via the mips tree. Patch 1/2
> >>requires an Ack from the tty maintainer.
> >>
> >>  drivers/tty/serial/8250/Kconfig |    4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> >>index 80fe91e..24ea3c8 100644
> >>--- a/drivers/tty/serial/8250/Kconfig
> >>+++ b/drivers/tty/serial/8250/Kconfig
> >>@@ -295,8 +295,8 @@ config SERIAL_8250_EM
> >>  	  If unsure, say N.
> >>
> >>  config SERIAL_8250_RT288X
> >>-	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
> >>-	depends on SERIAL_8250&&  (SOC_RT288X || SOC_RT305X || SOC_RT3883)
> >>+	bool
> >>+	depends on SERIAL_8250&&  MIPS&&  RALINK
> >
> >This patch doesn't create a select anywhere, so how can a user know what
> >to do here?
> >
> >greg k-h
> 
> Hi Greg,
> 
> The select happens in patch 2/2. i split it up as it touches a
> different subsystem. I can put both changes into the same patch.
> would that be acceptable ?

That would make more sense, don't you think?

greg k-h
