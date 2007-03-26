Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 22:34:54 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:46095 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20022789AbXCZVew convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2007 22:34:52 +0100
Received: from [10.10.64.154] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.1)); Mon, 26 Mar 2007 14:34:13 -0700
X-Server-Uuid: 6B5CFB92-F616-4477-B110-55F967A57302
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 DFB482B0; Mon, 26 Mar 2007 14:34:12 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id E448B2C0; Mon, 26 Mar
 2007 14:34:09 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id FCQ34592; Mon, 26 Mar 2007 14:33:58 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 93EAC20501; Mon, 26 Mar 2007 14:33:58 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] NAPI support for Sibyte MAC
Date:	Mon, 26 Mar 2007 14:33:57 -0700
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D070206E93D@NT-SJCA-0750.brcm.ad.broadcom.com>
In-Reply-To: <460580BF.4040904@ru.mvista.com>
Thread-Topic: [PATCH] NAPI support for Sibyte MAC
Thread-Index: AcduTXKYz5prVHl0TU+OKwVmIK1CZABoKKiQ
From:	"Mark E Mason" <mason@broadcom.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
X-WSS-ID: 6A16E3DF3708907207-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello, 

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com] 
> Sent: Saturday, March 24, 2007 12:49 PM
> To: Mark E Mason
> Cc: linux-mips@linux-mips.org; netdev@vger.kernel.org
> Subject: Re: [PATCH] NAPI support for Sibyte MAC

[snip]
> > @@ -2075,12 +2143,52 @@
> >  		 */
> >  
> >  		if (isr & (M_MAC_INT_CHANNEL << S_MAC_TX_CH0)) {
> > -			sbdma_tx_process(sc,&(sc->sbm_txdma));
> > +			sbdma_tx_process(sc,&(sc->sbm_txdma), 0);
> > +#ifdef CONFIG_NETPOLL_TRAP
> > +		       if (netpoll_trap()) {
> > +			       if 
> (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state)) 
> > +				       __netif_schedule(dev);
> > +		       }
> > +#endif
> >  		}
> 
>     This just doesn't make sense. That option is enabled to 
> *prevent* calls to 
> __netif_schedule() -- you can't override it that way. (Well, 
> how it works 
> currently, doesn't make much sense either since it totally 
> breaks the TX queue 
> control -- I was going to post a patch).

I'll admit - this was just copied over from the non-NAPI version we
started with ;-).

Are you saying that the #ifdef test should simply be an #ifndef here?

[I'm working on a revised patch based on feedback from Ralf and others
which removes the Kconfig option for NAPI - it'll just be on, all the
time.]

Thanks,
Mark
